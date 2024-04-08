Return-Path: <linux-kernel+bounces-135613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45B89C885
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF8D41C23D9D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696631411E4;
	Mon,  8 Apr 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OC7odqCB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C47tX4Hg"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79F1411D9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590727; cv=none; b=qZyHNa1IobfdxVzVmBRjcFOb5nOvQ6T1E0+jI4QmmPD4GofeNJdEEcNGtt/GUgrGBObBd6bCUDC1PWBSG8vNhkjzQoG1rLUGxAfvox5K9iTkAtShoocC0e3GrBDaBnsZAU0hx6514yI51fQ/CAB59I/UNCXWXVhP0D8neyvURDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590727; c=relaxed/simple;
	bh=jx3y8iEl1cgfFLMkQCZpKjXlaeo9PvLQB2ZrWLHu41M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qpsXuiQQ0fUWxp4jTHYLGCqEUdDJLTrat8cxxOs6x0d83ILs8jOFcBPYnQ3xQY2qhMb1BeqiSwKc+HG+33LWmq0TCBbKM+7zZQBNmA75hDiC3AycKt4zQP0G2XoaNMPhWjxTJ96CNR8dm+zU6df3LJmJRZfmar8CdqHbu/u0oOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OC7odqCB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C47tX4Hg; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A618311400D2;
	Mon,  8 Apr 2024 11:38:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 11:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712590724; x=1712677124; bh=YkKaVO0IWt
	dVzEW+2plhy7Zqx1cBB2gS0olKYWW7LKQ=; b=OC7odqCBVt/WFdzPITh/Mc/Eb/
	QcatPQBwhPLVHSu3aq13S81qoRzyNcY3y9r6HWvGxxCJLLRC8ft+XOTIQAeP8eHM
	OeC4N3/W6VpuE3FzVQjPFHr5MNaFDMn0UxwcT8GbkWGRojg1wuL9+ia0ZImqhg0t
	ZNdMzp70HiXTzXe5GXPrXQHwS+8tHRe02jA/omtQks8l49cwTr2jhsE4kA+Xi4z/
	kWcmHGbuV2dZQtPOvgxFe5UDH0poRZIwxHii4mHZbl/xIvseZngFLT2LeaqHms8x
	9cfZLQ48gXQL3WDppq2ej/W6qzArURvr+Qn7zygJRUrWRgzj01+LfAVfXBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712590724; x=1712677124; bh=YkKaVO0IWtdVzEW+2plhy7Zqx1cB
	B2gS0olKYWW7LKQ=; b=C47tX4HgZOnyz3n9E0BSTu0YOcvE5xeqeedN7xnmjxFF
	S12Xd416VXzjib/qo3mtV51HFcrtXfbIdlKHtMzrttJ1jLJBot4WfkRP/6eNXJxD
	KQBPckkBdH4Mend66QZBYMXsVfA/AowtM/T7LYc+AlSB9gDUfsbCWQhvtx7t18Sd
	N+fDiq2gKGXiN5fIpUK19oFCcBzjGRpeHFC/iSSbPhlt8eLa0ExO/M90y1iR4kH1
	cNh9u0jpXJGkv2C0jJFlmcL/yauhAPemaNcKGsZIFOOQlPB2EtHDi8xhh4Z0Z2H5
	wch3zpery2RnbZ16VTVYje7jCQvDNECO7NGBDu3Kyw==
X-ME-Sender: <xms:hA8UZvV-xnLytfpYH_f9fsrr9WJ6N9zWbT5LbShygSXnVLNMn34w2g>
    <xme:hA8UZnlIZvyamac4WlQXccsZOcgOIsEJo31f8NbnqMwQyOomNQZ0CFgOgVVL-RJ2G
    zyFguTonucvSYKwrR0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hA8UZrbplRF6bY6kRuGIshIcSGFt9otSyoDtdUvIZ2DDu2uCOqiQWw>
    <xmx:hA8UZqVyebmMI7vfpMqmqC5kB_n588i_ZYRpmAz1zCCfXh61RgqX_A>
    <xmx:hA8UZpnSFRiemBQhZQAEMPZ7eO01V05gFtYpl6T_FP09d058X9RVPw>
    <xmx:hA8UZne9cjCQ3QF5GQEOU0ALDCIEC-Uqr3sBrOAVcomKSut9Jd5RRw>
    <xmx:hA8UZvi6UrNA5r8RCIo3stPYX5APqxVLZB5saNLHKIIVnJ_3sRDCy_7y>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4CFD0B60089; Mon,  8 Apr 2024 11:38:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8b771062-7ce9-4b00-a488-91b231a1476e@app.fastmail.com>
In-Reply-To: 
 <u7hc4tkkwr5eua2p4bdetox2lqtawzb6dwimuipejhoiitbzhh@yu3e4sljhgxg>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-6-arnd@kernel.org>
 <u7hc4tkkwr5eua2p4bdetox2lqtawzb6dwimuipejhoiitbzhh@yu3e4sljhgxg>
Date: Mon, 08 Apr 2024 17:38:24 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/11] test_hexdump: avoid string truncation warning
Content-Type: text/plain

On Fri, Mar 29, 2024, at 00:54, Justin Stitt wrote:
> On Thu, Mar 28, 2024 at 03:04:49PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> gcc can warn when a string is too long to fit into the strncpy()
>> destination buffer, as it is here depending on the function
>> arguments:
>> 
>>     inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
>> include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
>>   108 | #define __underlying_strncpy    __builtin_strncpy
>>       |                                 ^
>> include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
>>   187 |         return __underlying_strncpy(p, q, size);
>>       |                ^~~~~~~~~~~~~~~~~~~~
>> 
>> As far as I can tell, this is harmless here because the truncation is
>> intentional, but using strscpy_pad() will avoid the warning since gcc
>> does not (yet) know about it.
>>
>
> We need to be careful. strscpy() or strscpy_pad() are not drop-in
> replacements for strncpy().

[cut useful explanation]
> It is possible I haven't fully considered the context of this change but
> I think using strscpy_pad() will cause these tests to fail, if they
> aren't failing I think we're getting lucky.

You are correct. I do understand the nuances between strncpy()
and strscpy(), but I failed to read this file properly.

I'm still not entirely sure, but from my current reading, I think
we can just use memcpy() to replace the strncpy() here, as both
the input string data_b[] and the output real[TEST_HEXDUMP_BUF_SIZE]
are sized to cover every possible 'len' value. This also follows
what Linus did for the other original strncpy in b1286ed7158e
("test_hexdump: use memcpy instead of strncpy()").

I've reworked the patch based on that assumption now and rewritten
the changelog text accordingly.

     Arnd

