Return-Path: <linux-kernel+bounces-34870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5BA838893
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D705EB22F13
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5865647E;
	Tue, 23 Jan 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="kb9tyox9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ikD6gGQq"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A88C04;
	Tue, 23 Jan 2024 08:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997466; cv=none; b=GbQPPWo9mDNAd4aFTLvL4VZMOOpJsFTPgNZyA20QmZNQ1Puvl2fkkwpLWs0IM7C6fn3aM2ZMyTs09fngI7bJ0+1DLX5CfWAt/vwFYeeIEpdQPYmZeOCY5zIyT+2x4UAOEvQ25WH/O8jkCjKe0USXdvX1F6viwOqs+qQhl9DtdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997466; c=relaxed/simple;
	bh=bPCy7tEnsrV1/R4RxhVq/TTlUTKFwD4Yndpfv5J8heY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SwnmK8jG/f4Pgq2WmZIkcPpTNwosod6ofreJhQluBrecPkQKHsLZzp3B9RH+dUtB3TRMxKBdn0ZnZqapFay/IUa0juUpfi7zQKt486cwWx/02YGbsn+GGkR9hYrbUfq0ndAmeYLHcF41O+7+qk5jcXkQP0b2abftkpC/Lv7UbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=kb9tyox9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ikD6gGQq; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id E7E053200AC7;
	Tue, 23 Jan 2024 03:10:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 23 Jan 2024 03:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705997458; x=1706083858; bh=8GW7Ys4hJn
	ST61kBAZS3rGpqnAP7hlhrw5R1Bh3T8ww=; b=kb9tyox9sC8LX4vvUW6Cl3tie5
	GEjSeraUi+YDFtWxtzz1dBB49Q7snKx7PRapGHnK559ubVuRf+diSA3Fcxjwwofy
	rL67E17qTnu8kSkyE/1e2wubWQtNHWPvO3utGUGRB9N830o5EVYv/j51C+4WzhHV
	+PMSADJ5M5qeMIrC+1EF9NWx+tE8+3O0KCXPWW/hPKHbjVloSoHWcDwzezmghDIW
	KK+qnjoMW0zNOc8lFmTMYW9Xuu4rhiBDwPJHH9iHU5KjapShGBbCjOm0zEzkhYMw
	KlLEWBcgflzfCdvv7diRxCR0HQNq6VbywNA1/VIhYHGg4jmMLdDvdTNfEIBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705997458; x=1706083858; bh=8GW7Ys4hJnST61kBAZS3rGpqnAP7
	hlhrw5R1Bh3T8ww=; b=ikD6gGQqdQQJgaZWnkOFLIu9nGcs8/pDgiQd4NCc0cx6
	qvYTCMhGlRUm72OQo1KFjzQBa8QHWi/vQm1bBHW3mSfVDrDslDAH0BVB8sedNQSe
	y9mKr8t6lOc9a/rvxFEkD2z3jtT2orFeZtmCvGO5cnBFZ4V3+fqgNyRUHqsUSFMJ
	KvU+zPtA1R9AgGtVOIFJbKnzfnqTn8dLDw5Gmr46d6JpMe3CZSRtlzjxz962PVS8
	h9VRcL2wJ4ISaPX1xGEWiiYEOTwkvcAqXh1qZzjLGqg4Hk6BS+E1rIgm+tYTD882
	0v798k4YNR+UNv74FNPurqeb93NW+JFHhRMQAUfLzg==
X-ME-Sender: <xms:knSvZePcH4JgvX9k-cJ9tI41EuG6ee5eNwMt7mF0cvxRBBQeXTdlvg>
    <xme:knSvZc8aP8vVIbDKZKdWvrTpCPJvU4gCDPEcPgjkZd7ApeDUcXETPg4yDNm_uGcF-
    UBxkLNYIIgkLDI1gFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekjedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:knSvZVS8KGzEADrrHfFT_wlfw5OYuTbaf89tuySLNIwM4X-1fATWpQ>
    <xmx:knSvZesT32AOqITVP8J6Ym-UoB2W3vyvyoRH_ubIOXmV3cWhZuFw8Q>
    <xmx:knSvZWdhyA0vc3SZH-Dz39ckd3oPpeihZpxhn6deDveDKoZOwPDmaw>
    <xmx:knSvZZUmNfn7ZkduDwUNZsN58HMFGk43W7hVZKZxQ8lj293vkdh3WQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E487FB6008D; Tue, 23 Jan 2024 03:10:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dd8402e7-f8cc-4ddd-a748-e176b6b534a9@app.fastmail.com>
In-Reply-To: <20240122225710.1952066-3-peter.griffin@linaro.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-3-peter.griffin@linaro.org>
Date: Tue, 23 Jan 2024 09:10:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peter Griffin" <peter.griffin@linaro.org>,
 "Rob Herring" <robh+dt@kernel.org>, krzysztof.kozlowski+dt@linaro.org,
 "Guenter Roeck" <linux@roeck-us.net>,
 "Wim Van Sebroeck" <wim@linux-watchdog.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>, jaewon02.kim@samsung.com,
 chanho61.park@samsung.com, "Sam Protsenko" <semen.protsenko@linaro.org>
Cc: kernel-team@android.com, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 saravanak@google.com, "William McVicker" <willmcvicker@google.com>,
 linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 2/9] soc: samsung: exynos-pmu: Add exynos_pmu_update/read/write
 APIs and SoC quirks
Content-Type: text/plain

On Mon, Jan 22, 2024, at 23:57, Peter Griffin wrote:

> --- a/include/linux/soc/samsung/exynos-pmu.h
> +++ b/include/linux/soc/samsung/exynos-pmu.h
> @@ -21,11 +21,39 @@ enum sys_powerdown {
>  extern void exynos_sys_powerdown_conf(enum sys_powerdown mode);
>  #ifdef CONFIG_EXYNOS_PMU
>  extern struct regmap *exynos_get_pmu_regmap(void);
> +extern int exynos_pmu_update_bits(unsigned int offset, unsigned int 
> mask,
> +				  unsigned int val);
> +extern int exynos_pmu_update(unsigned int offset, unsigned int mask,
> +			     unsigned int val);
> +extern int exynos_pmu_write(unsigned int offset, unsigned int val);
> +extern int exynos_pmu_read(unsigned int offset, unsigned int *val);
>  #else
>  static inline struct regmap *exynos_get_pmu_regmap(void)
>  {
>  	return ERR_PTR(-ENODEV);
>  }
> +
> +static inline int exynos_pmu_update_bits(unsigned int offset, unsigned 
> int mask,
> +					 unsigned int val);
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline int exynos_pmu_update(unsigned int offset, unsigned int 
> mask,
> +				    unsigned int val);
> +{
> +	return ERR_PTR(-ENODEV);
> +}

This won't build since you have the wrong return type.
I would suggest you just remove the #ifdef check entirely
and instead require drivers using this to have correct
dependencies.

    Arnd

