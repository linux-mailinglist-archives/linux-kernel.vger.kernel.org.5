Return-Path: <linux-kernel+bounces-87664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E9086D788
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69ACFB22093
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B955E76;
	Thu, 29 Feb 2024 23:07:59 +0000 (UTC)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FB316FF21
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.18.0.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709248079; cv=none; b=GDDQ6rz7CwknQTG1a39Ot3efxt3EWDbA5f9nlNs+yOoP506oQu4YU4ftVR63cNcm9BO/uGePJDbtCSJSTn/NCpY45IA9HBlYDpyxBB23SMiq3aA4fWqxUqjD6pGKqy71mgaDUWDA/LmGlKWT2FxeXuJdJpGmp0EzEifVRFolrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709248079; c=relaxed/simple;
	bh=uwE3qinU29HK8e2RgqhGzA+W9OmNW5zKCwr4ho/GjVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cCHMJv0oV9kTww2pEVNoHJPio5p2KutVULtaxOdZEUIsjxorVcoLeOaS8k1E0D2sDEQPv/uxfuMhJJ3haG3Fq+bhCkZ2dPVbP9xhroHmPwhWsVb0+H5iHn2AXW3NumZXwJzXx/a2mo+Xja0D1Wu/wyotNfgfQEfcmbvVG06V1K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=nefkom.net; arc=none smtp.client-ip=212.18.0.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nefkom.net
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 4Tm6M80V3fz1qsP8;
	Fri,  1 Mar 2024 00:07:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 4Tm6M767qtz1qqlS;
	Fri,  1 Mar 2024 00:07:47 +0100 (CET)
X-Virus-Scanned: amavis at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id SQwoWJyaYmti; Fri,  1 Mar 2024 00:07:46 +0100 (CET)
X-Auth-Info: 0rf1pMZMaomnnOVa7F8O7s3fTttPJcBoMnGsi6T23JBpz/xoMlnPhCvkNDopI+pr
Received: from igel.home (aftr-62-216-202-139.dynamic.mnet-online.de [62.216.202.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mnet-online.de (Postfix) with ESMTPSA;
	Fri,  1 Mar 2024 00:07:46 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 904FE2C1A2A; Fri,  1 Mar 2024 00:07:46 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Guenter Roeck' <linux@roeck-us.net>,  Geert Uytterhoeven
 <geert@linux-m68k.org>,  Linus Torvalds <torvalds@linux-foundation.org>,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,  Kees Cook
 <keescook@chromium.org>,  linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: Linux 6.8-rc6
In-Reply-To: <b4fa177d6fcc42deb7db0dc0f9d36fe2@AcuMS.aculab.com> (David
	Laight's message of "Thu, 29 Feb 2024 22:19:20 +0000")
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
	<6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
	<CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
	<8403d8e3-c8ac-476b-8b8e-2c8b6ed8f464@roeck-us.net>
	<b4fa177d6fcc42deb7db0dc0f9d36fe2@AcuMS.aculab.com>
X-Yow: Yes, but will I see the EASTER BUNNY in skintight leather
 at an IRON MAIDEN concert?
Date: Fri, 01 Mar 2024 00:07:46 +0100
Message-ID: <87o7byeunx.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Feb 29 2024, David Laight wrote:

> Maybe because m68k only has 2 byte alignment for 32 bit items.

Nope.  Its simply undefined behavior.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."

