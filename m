Return-Path: <linux-kernel+bounces-32672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1A5835EC3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424CCB2A475
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DF3A1C0;
	Mon, 22 Jan 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VWGHCJKZ"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57CA3A8CD;
	Mon, 22 Jan 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917099; cv=none; b=nmXtm5HR/aNx0xEEhBisvEQsddEECfZCALZ5ercQGMUJ8+E9c20l5ysODetWqPYGnchZ3N5171mF2nt9aXmKDM6SC0+WUGN1Ifc0AujqxMCbAExh1djEWb+Wfc507yQjOXlXHsTFU0bMh0Yy8ZjvthkAEDh/612TQfdvhcK6yBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917099; c=relaxed/simple;
	bh=+nGU7Loi1Do4zrvl/0l3JM9LGLlkYeGwWtlVmkNopIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uF93udTBiJNZL0WmoGN7uT6/z/ceofz7pBaQQ/zFedhcv/6VBqnqsyMEoW3jYW00lzS6WPw/hUKkyDF1GD3IOoT5TY26sDxoBdFrhRTnFYHHTLFk38lqcXM9ka6J/F1aPA7wgT8SWbodphI2DToXfdTX5JI15o9y+IXLp5U7YtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VWGHCJKZ; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705917029; x=1706521829; i=markus.elfring@web.de;
	bh=+nGU7Loi1Do4zrvl/0l3JM9LGLlkYeGwWtlVmkNopIo=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=VWGHCJKZ5HKy2AH+oYWepCu+OuIY6blJAyg/bPpK6HLRSvSs5yxnPOamVrbshYt3
	 uFDRo42NOZQlpWOEVUirGYt63kEPx3Jwf8edReMYZn5S2yrqwHxGCGAEqCUjJ+eGh
	 7HmMcdbfbS7l1C8VpYrGCyqnWjEUe62hkessfmc7JGr7xXBraVh+sskyFcbuCod+/
	 WxpA3XARTvBuVJsVhnHl2ZHDSegqGJTIkI2mg7wEArOFO76vkxglOnvP5V57CvPHj
	 6vixEG8r7EyF0sPjk2YdlOKZdtix2xxslEHjJbPVuf564UoxRCYp60L4i1wnmz93N
	 tWb8kf9WBed/7ntMCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MSIJA-1rYThF27UO-00Sh0e; Mon, 22
 Jan 2024 10:50:29 +0100
Message-ID: <6d40b95e-2ed7-4f32-895e-a2174236ee65@web.de>
Date: Mon, 22 Jan 2024 10:50:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] x86/xen: Add some null pointer checking to smp.c
Content-Language: en-GB
To: Kunwu Chan <chentao@kylinos.cn>, xen-devel@lists.xenproject.org,
 kernel-janitors@vger.kernel.org, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?=
 <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: kernel test robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Jean Delvare <jdelvare@suse.de>,
 Jonathan Corbet <corbet@lwn.net>
References: <20240119094948.275390-1-chentao@kylinos.cn>
 <26ef811d-214c-4ce4-a9f8-4fa4cfdefe29@web.de>
 <6f25f54f-eecc-4765-bdc4-248674836e77@kylinos.cn>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6f25f54f-eecc-4765-bdc4-248674836e77@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7PuQIQ+STP1HEpxBb1F71REntJZh+zhVfsHo3QNQ2Y97EaG7Chu
 YZg+NMHWD7a8cWoCqPBaqIuW/1RiZ95h0IExGFidpRCIOSY9cJLbrYPImqSSO+d8zBIdfye
 9szF1wZYZ/itaJHlMQ6w4DJUIsyBBuQ9qZ0nDe2Vb4wVFQ4MwNGbMZ4YvY1TmWAZaA+dkWA
 +S8b9V2h+w2RuVKyoIqlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yEsnbDcYv3s=;ZPb2Mu+H2XGola6RbrIcyQWyz/T
 ok93+jBiDKnY1DDXbD0Zifx5nXuoctjgIftPZMgZIr6+J0Ok/V4IQWfIX3rww8eDuhSWmqlvK
 9qJflq3k1x97bT/azeoHOkoWJzI8tXhkHDYdN+ev96ILzZ9EL/wY5GeaUIcQHlekUDOjpfyTR
 OrGxEC3jyfaeGjdDH8Gn9CeDy27YGgHXSOrT+eHHQj77p6Gp0wzaPxB2+rW8TJ2ff2aRsw6aY
 pXIS+5vkwsSPVKxG5GjojJuUvcZl5XVGkNMAQgqX6BqSFIo/GXB/kqFgNwSgNbMM/p0DNdoun
 iaqRQcsiwb/XbIrR7D6zSTkMayqKL86oxZSEbdlX3qNfUOfYRF2wgoQhOxv0lHiPEm/itrbso
 tB7NEyziFnGFmr93Zee7Z9dOaTLbAGuZ/IIHTnsRhvShgIoqHO1fEo4Z5FolxJahE+tmdfxP3
 1opwbsVgSPUTIONZ5Zmwx62rBUYhcvY/vd2w1paAXsD9dE9qBA8O4E4+TLxuUFrUVwpSf63tT
 RKyImNKQvIJMqAmltIcOcrgQpf/85/YxZCnfNsleS1TWANHUv87awcKOhicDB+6uzzTABEHaX
 V9ikk5FvhrtGe6B5f/8qrrzmW/rqFlbbIEk/T3zgJvWuLVL4Hm39kHppviwwcqh3hQAwRSuNW
 Q7B6/h7M+ykbB2NgaxDQKF6DqccJHP1nGAgz4J/5dqXsHJA7/VR4g/gVk+U1eJbX+A6hhlNeH
 h+XVBcSG7JPULvFvS99MaPwQK038pKGKeS8Fzu030ExOECSB2qT8UcQCnl3MwgRb/TWfU+pJu
 V8GAGqQuivpqsX0lj4ceZ5RV8s9BC1V4i1m/BNBYbwiddhzLYE//O2Hp0ptm32iebTaCGkpWr
 qBBVRgCm3h4iXgOrInS6rrAS/SDpbOsiCBz/oZkvu8TtRs9zrtkFfHsozotb0ujHHHsj9xzs1
 GH3CTA==

>> How do you think about to refer to the function name
>> instead of the file name in the patch subject?
>>
> The main goal is to assign a errno to rc. So use 'fail_mem is good to understand.

You responded with information which can fit to the patch body.

How do you think about consequences for a subject variant like the following?

x86/xen: Add some null pointer checks in xen_smp_intr_init()

Regards,
Markus

