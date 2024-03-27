Return-Path: <linux-kernel+bounces-121436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FC888E7DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E208B1F326BE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B1112F5B9;
	Wed, 27 Mar 2024 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b="J26IBcLP"
Received: from mail.cybernetics.com (mail.cybernetics.com [72.215.153.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB46148FE2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.215.153.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549632; cv=none; b=aSaxPCDwL/cWFtLF5cwLRf6tcUNIAEGeJcb/Ar1dJSK1K8CxFf2P3yzqRk2irbPLC63lnytgJjnB/j6fGy2LVJ5bb5IebQZgEVVP9VFGUKZaOaXE1NeOUub4O57GYmrwqI4oorLKB1hJYrknHC32i4F1xOJNh8uV/pdbS/eBSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549632; c=relaxed/simple;
	bh=x6PxAa5ZVZWjP6xCYO2J744lJgOyCSGeKhHH3KX3svQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VG/Vcgu43zw0yxMe13PlEenHHxNRksbiMJ0EMAl0HgWYAiv2Z899DU9ioLG07mIpRzMVwbwm9vHk457lou0ta+ymzOfKyddQIOQF0Y08WJJrihajQpBidICQDOSLHW6Nc+WOSm+nL+h9Rdo3h+7fQwPrDlkidlgZlVzU4sAyWUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com; spf=pass smtp.mailfrom=cybernetics.com; dkim=pass (1024-bit key) header.d=cybernetics.com header.i=@cybernetics.com header.b=J26IBcLP; arc=none smtp.client-ip=72.215.153.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cybernetics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cybernetics.com
X-ASG-Debug-ID: 1711547641-1cf4391b1c11fc0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id JgvhKPqniD8w60fx; Wed, 27 Mar 2024 09:54:24 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-Barracuda-RBL-Trusted-Forwarder: 10.10.4.126
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
	bh=x6PxAa5ZVZWjP6xCYO2J744lJgOyCSGeKhHH3KX3svQ=;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Content-Language:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID; b=J26IBcLPfnIsTxmoBkyo
	iOb3zgZp/wymAwuWuQ8k4KWEn42h/uEuJ1IgFu2IALsQWGNDCD8xcuOfrueizMEwoFSzu2rp+YjVE
	thSU7E6XWG9IhsOjYaJvDg+0IQluGugak86DefUGL0CCYETo9IB36vdT9R26csfYcVHZio7suQ=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 13149216; Wed, 27 Mar 2024 09:54:01 -0400
Message-ID: <45ea3c6a-18d3-469a-b368-d657b739edd2@cybernetics.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.157.2.224
Date: Wed, 27 Mar 2024 09:54:01 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: Patch "block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
X-ASG-Orig-Subj: Re: FAILED: Patch "block: Fix page refcounts for unaligned buffers in
 __bio_release_pages()" failed to apply to 6.1-stable tree
Cc: Greg Edwards <gedwards@ddn.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327121329.2830355-1-sashal@kernel.org>
Content-Language: en-US
From: Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <20240327121329.2830355-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1711547664
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 497
X-Barracuda-BRTS-Status: 1

On 3/27/24 08:13, Sasha Levin wrote:
> The patch below does not apply to the 6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> Thanks,
> Sasha

I already sent a backport for 6.1 on March 13.  5.15 and older kernels
do not need the patch.

https://lore.kernel.org/stable/a764cc80-5b7c-4186-a66d-5957de5beee4@cybernetics.com/

Tony

