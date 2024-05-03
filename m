Return-Path: <linux-kernel+bounces-167664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7A38BACF0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90F8FB22267
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71B2153575;
	Fri,  3 May 2024 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="S9xoFgyU"
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2558495
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741292; cv=none; b=h8ySjDoA5Uv8XYr2EDiHOi7jGXYUfhFvVM0DsmWrmnvjPSkw5YZ5/bXqlv58KeY1M3uAg7boXvb99QnBd9H7FQGurLxcP/IxQSSLvWq7PJKn9usEYYk+KS0W92tQfPjpyRK2AaZUEeSCy/3DKPhoXTi1svUBalXGh8OHgXsvZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741292; c=relaxed/simple;
	bh=BPmr4NyPZSzsqJmgL40VjcbOoVTmGpoNIqNJe+trfyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D9QAf6S0S0YCKSKjiCXZQh3FVB7tXPcld0hWYo6BlC83gmiqWyvH5yQc4+bEFUiz/AQe48sPnYVrcGxlB98Z9Ne/nvXZlZuKlkm101tMSJQRmdd4A9BzCSOBgiRmCMKUQGKZSY731Ntg0sS9dDXfvDhV9EBaCQLULzgX4N/tKTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.co.uk; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=S9xoFgyU; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.co.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nrKtj6pAhuqpN++t5oFkqusThl46U1xzi7qk6r4wSuM=; b=S9xoFgyUSJE2p/2JBqE0YpGBpJ
	QwckRrBl9cBYy++fD+wFfHSF0GCtxPDsRg4xnpytbcvoe516loFGg7raYIKeXvDuM1EQgUw3qrqe8
	EfWtriskAQF3S74PnEmsfAxleewBbxj8Iz7NbuMysAaplmm8VnYDJYJNBiLp0hqsb1oJSdyY0XQWg
	jVlqTxSh6An7dE8fpUpMRcaR6r5Lb9TMNhpZt1Z2mXW/nTGyA1jaRgw9ivWAhFudkbe7nPQ4sZFa1
	ToiFSN9VqVjPIW0W/y1HxEgPmICmwLXTUznruhbxW+cjpx0o6iDMJPz9qBdKAISACcXcVsWqGPG1L
	We43Catw==;
Received: from [167.98.27.226] (helo=[10.35.6.244])
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1s2rtE-004KaJ-2W; Fri, 03 May 2024 13:19:48 +0100
Message-ID: <4bc238eb-410b-46b1-98e1-4aaa35e34404@codethink.co.uk>
Date: Fri, 3 May 2024 13:19:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: uaccess: Allow the last potential unrolled copy
Content-Language: en-GB
To: Alexandre Ghiti <alex@ghiti.fr>, Xiao Wang <xiao.w.wang@intel.com>,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: jerry.shih@sifive.com, nick.knight@sifive.com, ajones@ventanamicro.com,
 bjorn@rivosinc.com, andy.chiu@sifive.com, viro@zeniv.linux.org.uk,
 cleger@rivosinc.com, alexghiti@rivosinc.com, haicheng.li@intel.com,
 akira.tsukamoto@gmail.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240313103334.4036554-1-xiao.w.wang@intel.com>
 <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <7ebc5b28-7115-494f-a607-e46c71214cce@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: ben.dooks@codethink.co.uk

On 03/05/2024 13:16, Alexandre Ghiti wrote:
> Hi Xiao,
> 
> On 13/03/2024 11:33, Xiao Wang wrote:
>> When the dst buffer pointer points to the last accessible aligned 
>> addr, we
>> could still run another iteration of unrolled copy.
>>
>> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
>> ---
>>   arch/riscv/lib/uaccess.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
>> index 2e665f8f8fcc..1399d797d81b 100644
>> --- a/arch/riscv/lib/uaccess.S
>> +++ b/arch/riscv/lib/uaccess.S
>> @@ -103,7 +103,7 @@ SYM_FUNC_START(fallback_scalar_usercopy)
>>       fixup REG_S   t4,  7*SZREG(a0), 10f
>>       addi    a0, a0, 8*SZREG
>>       addi    a1, a1, 8*SZREG
>> -    bltu    a0, t0, 2b
>> +    bleu    a0, t0, 2b
>>       addi    t0, t0, 8*SZREG /* revert to original value */
>>       j    .Lbyte_copy_tail
> 
> 
> I agree it is still safe to continue for another word_copy here.
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Out of interest, has anyone checked if causing a schedule event during
this code breaks like the last time we had issues with the upstream
testing?

I did propose saving the state of the user-access flag in the task
struct but we mostly solved it by making sleeping functions stay
away from the address calculation. This of course may have been done
already or need to be done if three's long areas where the user-access
flags can be disabled (generally only a few drivers did this, so we
may not have come across the problem)

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html


