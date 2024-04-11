Return-Path: <linux-kernel+bounces-139904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE558A08FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0BCCB26A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8E713DDA4;
	Thu, 11 Apr 2024 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="w5NvIG0u"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181213CA9D;
	Thu, 11 Apr 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818785; cv=none; b=MJtdj4v+0g5WK5RcytFSknU3lie+TEmUjIzVHGRSm2AcwsgGJDztGO/L+Qe7sWzKkGkj6g6RGRm/rL7u8O0u1+fIe6oJ+4jTZa1BDVAuGkjjQLCQ7+ONnDr//uEMCpvOwWc6yUFqfps6ktiqwIWwuKQLTRgKQJiZgHCt7iDqD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818785; c=relaxed/simple;
	bh=CLIHvR6i/zyhzt5JI8XylHfPT0OLFLJMBlrvECGG4vQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DGA/uFjNjlZrpCHIDHCvMR+ChBsw5km/k/aEGzzelo2VQtpZ6z914skC2PJwI2MBwZpQVf4tJdmnwVlsz+r6bnF7kscwP/w0CTWNCkUnYY5it/pOYRG9yTPK/dZLcuvwuSoK+QotE8qk4VlZWxMwyBkMwXAP2oFArOtBm+fyfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=w5NvIG0u; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=u+3jXxTlJC/OokZC4T91IlfkrsewPG6txXyqceJ/cZU=; t=1712818784;
	x=1713250784; b=w5NvIG0u8L20U7GXrCR1k+OPt7SDAe/hCO0nKf1KgV0VshKuQDVq6DscSWtxC
	bucTSl5rGuMaGTxKWIZkZFJ7c4nHVf+S7ifYLxA6a20ZTCkrS3E7YhZc1O8gl90xRwAX/zem8Rwpc
	AreFcqALRVMjtM5nSARXbAtb6bPU03xOd+HJd4G+Ms2HlwxgBQrHOZP1Bv4zhfaXPXgdLb0Kssz38
	kHRAlgYDzDxcHCFZ8LRAwUMh5sXnl7ln9VG+6gefIerZDTvcVSje8BqZJFw9ujTt74X73khOJqGRM
	fGT3NvSfiTJDZ6U05zALYsZCxCJtDd69vxOSzQ2VCSuGGeAzvQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruoPM-0001V0-Eq; Thu, 11 Apr 2024 08:59:40 +0200
Message-ID: <3f395eca-fc24-469b-b5fc-de47ab2a6861@leemhuis.info>
Date: Thu, 11 Apr 2024 08:59:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] docs: stable-kernel-rules: mention "no
 semi-automatic backport"
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 stable@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1712812895.git.linux@leemhuis.info>
 <c0a08b160b286e8c98549eedb37404c6e784cf8a.1712812895.git.linux@leemhuis.info>
 <2024041156-backache-dolly-a420@gregkh>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <2024041156-backache-dolly-a420@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712818784;6f43151f;
X-HE-SMSGID: 1ruoPM-0001V0-Eq

On 11.04.24 07:29, Greg Kroah-Hartman wrote:
> On Thu, Apr 11, 2024 at 07:25:04AM +0200, Thorsten Leemhuis wrote:
>> Some developers deliberately steer clear of 'Fixes:' tags to prevent
>> changes from being backported semi-automatically by the stable team.
>> That somewhat undermines the reason for the existence of the Fixes: tag,
>> hence point out there is an alternative to reach the same effect.
>>
>> Link: https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/
>> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
>> ---
>>  Documentation/process/stable-kernel-rules.rst | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
>> index 7bb16d42a51833..ebd57cb9277f7b 100644
>> --- a/Documentation/process/stable-kernel-rules.rst
>> +++ b/Documentation/process/stable-kernel-rules.rst
>> @@ -117,6 +117,12 @@ comment to pass arbitrary or predefined notes:
>>     Note, such tagging is unnecessary if the stable team can derive the
>>     appropriate versions from Fixes: tags.
>>  
>> + * Prevent semi-automatic backporting of changes carrying a 'Fixes:' tag:
>> +
>> +   .. code-block:: none
>> +
>> +     Cc: <stable@vger.kernel.org> # no semi-automatic backport
> 
> I do not understand, why are you saying "cc: stable" here if you do NOT
> want it backported?

Because the only alternative the developers have to make the stable team
not pick a single patch[1] is to deliberately omit a Fixes: tag even if
the patch normally should have one. Like it was done here:
https://lore.kernel.org/all/cover.1712226175.git.antony.antony@secunet.com/

And that somehow felt wrong to me, as discussed earlier in
https://lore.kernel.org/all/dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info/

[1] e.g. if they don't have or want their whole subsystem marked as
'ignore for the AUTOSEL and the "Fixes tag only" tools'
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/ignore_list

> And what do you mean by "semi-automatic"?

E.g. 'ignore for the AUTOSEL and the "Fixes tag only" tools'. That was
the best term I came up with.

Ciao, Thorsten

