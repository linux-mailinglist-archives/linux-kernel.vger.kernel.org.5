Return-Path: <linux-kernel+bounces-90489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F214870002
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AD6B24A59
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7ED39FCC;
	Mon,  4 Mar 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="yvc3lv5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MGCCBcZG"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690C38DFC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550722; cv=none; b=lDQBrHpLZ9cRFfMzn9mzza/UVtmwQHJoqKnDzTcLPJe2ee5h/yUiqNnS3xO5NJIM3CRrXdx0Bs1+evrDHEsiLHWKzbMQSD96F056nxmdqi0ArfmanNGbfagoLYJ4q+P5EJtF1FOicIWsZuZbCQXOBOn7SVIILGzuEe1C+RRs42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550722; c=relaxed/simple;
	bh=MEL+STZkSdrfFnSSKd7mM5mtjXp9ebWCru/BPk1xE8o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=oUyJpUuR1dLSvVACHlVZ2DZUFCyesKLcurECt7ikavNgDIRyWrz+JZX0gpRwUrQQ55kZ5Cr1cEB8ClXumhGyCf0V05ia2iQFyzP1nm/PCUk4Caf3YbxqHTdJQln+9VuJ+XRZanH8UP35x8EfExoGqE7C3bminKtKFWTK105HAoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=yvc3lv5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MGCCBcZG; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id E81031800071;
	Mon,  4 Mar 2024 06:11:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 06:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709550718; x=1709637118; bh=EdyAyreUFv
	IgIM6ctI+YdhHOhoypCpmrpuxvB1wsxPs=; b=yvc3lv5Wisgl69XprFcP5LoTvy
	xOnR8ClrH2/ISMMCpe99Rj5lDH/mge/sdO8Q75eVh6ydyXO57A8YdnKv0uzyNUpx
	7PG4TgXn9G9Me+kcKeAg/kPyZr20lkoE8Ge2PDZ0m0vvsssQX1uqCDBCVnQs4W3N
	+wgnEzVauN3lLU7jf3CzxfNawof7guszJvZe02DYntMXlHpJG/yx1gvxsW0MT+bi
	pFCPkfYc/KicROYhNZTnDHnP0uSUmy0/PfwLLpfzUh7P2YlatkXUsXudhqlkpChJ
	NJjNqcyyoT6eqOCj46xFzfMY95lfa2hGbbCYGgVdNFVwICTdfRAsOEXX3fow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709550718; x=1709637118; bh=EdyAyreUFvIgIM6ctI+YdhHOhoyp
	CpmrpuxvB1wsxPs=; b=MGCCBcZGWn6rAsXfzV4j1gaxH0Y2kffQfmDiJk8KF2GP
	EoRo+xLTsXklU/QyL43TRHXVU3SdQGqau0Rw5/qC119H4DCDVvVHLYeAd2gXEYLR
	XrJ067icxcSWRPBom4IlHWcjm0D5NawrA6H95J7ayq2qt/IK0YGlIMhvAaZhEmvL
	zH2SsDruheTp8pljRm3f5HlFGH2k+U/Ah83zjcr6TA/mTqfE4wAMl+K3gjLf5Qo8
	Jjdn9wlSnOZnr4M4Nr2lwIPZV4uOzRYDpvz/AbTEHtD1q0Unu6kzTPS4Q+bnc29k
	+C4K8CTyxFoPau/lJun7a4c9COVbpR7XBoxJUJWQkQ==
X-ME-Sender: <xms:fqzlZbfowZCDDY1dEYxarEK4eXUh520wbI7RsI0tgztE-LKszHYnjg>
    <xme:fqzlZROcTlyFsKnY4Oe0qUgjVmAB4bGWwtOBURj2kXAH0jeLOiBQuPDmMk9KgGQNq
    fOW2xDm8LEhcmu7iak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fqzlZUjelUD9zaEr8nSDoJCtK559fTWiBiqAimb_sOoBNtSNx2EMMQ>
    <xmx:fqzlZc_Ax8RVY9-c2Kpg8k8WwgUcknhXfOiVo-pP0vFyJP5vh7iZ-w>
    <xmx:fqzlZXvWXr15D_PiaqiRY-ISbFDDa9D67Fx5YAbYK89hWhvycAn8Pw>
    <xmx:fqzlZVKzGqHIXK_nBLwwCS2YB7JRMTnXAT0BKwWflGbNWy2SnBXzsdZsHwE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1DB36B6008D; Mon,  4 Mar 2024 06:11:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
References: 
 <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
Date: Mon, 04 Mar 2024 12:11:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 lkft-triage@lists.linaro.org
Cc: "Maxime Ripard" <mripard@kernel.org>, "Dave Airlie" <airlied@redhat.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Content-Type: text/plain

On Mon, Mar 4, 2024, at 09:07, Naresh Kamboju wrote:
> The arm defconfig builds failed on today's Linux next tag next-20240304.
>
> Build log:
> ---------
> ERROR: modpost: "__aeabi_uldivmod"
> [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
>

Apparently caused by the 64-bit division in 358e76fd613a
("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid"):


+static enum drm_mode_status
+sun4i_hdmi_connector_clock_valid(const struct drm_connector *connector,
+                                const struct drm_display_mode *mode,
+                                unsigned long long clock)
 {
-       struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
-       unsigned long rate = mode->clock * 1000;
-       unsigned long diff = rate / 200; /* +-0.5% allowed by HDMI spec */
+       const struct sun4i_hdmi *hdmi = drm_connector_to_sun4i_hdmi(connector);
+       unsigned long diff = clock / 200; /* +-0.5% allowed by HDMI spec */
        long rounded_rate;

This used to be a 32-bit division. If the rate is never more than
4.2GHz, clock could be turned back into 'unsigned long' to avoid
the expensive div_u64().

      Arnd

