Return-Path: <linux-kernel+bounces-36045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D1B839AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40BC128BEFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABAD30E;
	Tue, 23 Jan 2024 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjmNFaHU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D49446AB;
	Tue, 23 Jan 2024 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043477; cv=none; b=u8Vc7esf3sNwYEPDQuF4xcEVBuJTWZtpf62np6SZPb3Jerr0VQQkDwfHFvW6OoU3PfwMvbN8uY6UQlLm0B8lSt8X0iXRFkw9BWLUNcMql7OhLUYQdj1wnkV0ipma/3vadESXDfUU36t5BokDIhyUd0V+zshH3iLwEGIKX7JM4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043477; c=relaxed/simple;
	bh=xP7SSkOeXt2InHYZS3rUjVRyG3uFh+Fq8H4ufGwruSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfmYdCglEg+iJPu9tOcMqqaK3yVQeTDLFkkGGxOvbEQ7gOfwLooi6LNrQfxg7U64daiukMb9qJn5aFLVRmdobBW+paCrnXjtmOlinPKmhwrACpH8or1rMoRT1Oeer8gxSP4WIhzWXiRG1xZbxOEg0AaCj9Q4HIcGAy1dKDA9/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjmNFaHU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e9d4ab5f3so51547625e9.2;
        Tue, 23 Jan 2024 12:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043474; x=1706648274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xP7SSkOeXt2InHYZS3rUjVRyG3uFh+Fq8H4ufGwruSs=;
        b=bjmNFaHUWOgbK9nktTiWS5HIYuld2Wiq5JUjnhq7Bv9IjFSmF7HjfCegI11dS3LjCt
         pjqv1W+L4FoDEZkuUowcd2FEdDvckA4YQ2kNaGX9wAhrNr6bi4PLPY3c3tcpnmSk/sje
         5/RLR8OWgsFML9akj8mnJLG5uiE39g2HYlLZZc0JrB1kWO5eGeywfbeG54xvvIS5y62T
         7M2OI2rWXsJ7HuJuqT24mna4z+8vzwNSi6IRksWRUjT7LZOYM7qtSx0zIGyhe46SvS3w
         N3eca0DGnDA/RWXWKA7pJ4d4FB6f+b4REosYeAfh9KOZS5C6xpGTe9kHxexU7D04E0TP
         PKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043474; x=1706648274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xP7SSkOeXt2InHYZS3rUjVRyG3uFh+Fq8H4ufGwruSs=;
        b=X31KyHCsfz4p/wYmy/wSAIPc6KePML6+P+YEr7sBj/DKeUO5LhKcnwXT7+sKj9PuTV
         8XbZMuD01lBLvm3G3qfKrpmg8u7rhVNAy98c0+W2HuP3XbB/P6yI57ulnvntulTWHDng
         wuCVzvSVGZ/0PdFb2SnIZ4CmQ55TL6AyG+/z8WtRFixJ74tevbGZIoFRhm+BhcTnaj6b
         jzjsmt4XMhneBBFXhYaNQeqRwtKcH2xvW/f9hwNWxuuNIZhwe3STw0jMEax/c2S0HFC+
         eK3l87P8fKojSFO3pakG2cloqi5MMyaz71C4flbUC4CT81lIlO7UNJBIrTE9TL5i8eCG
         SIwg==
X-Gm-Message-State: AOJu0YzUvyMemGCEcI/vnqaWlU9csk0RAkvIgrRLsROGRVIxmGF2Omrp
	lB6ddGBT5AgXOa2lMw1sffoNBzvgaKgFDFrmktpLIf7KpKGjJBDUp7/b8zQZ
X-Google-Smtp-Source: AGHT+IHdEtypFxfaQKT1tvU4PciOYbYUXDQ+utYZl1uyqcrFgM34bxgMjY4g9TnF9xKJhQk8C5Ht4w==
X-Received: by 2002:a05:600c:580c:b0:40e:b257:26ff with SMTP id jz12-20020a05600c580c00b0040eb25726ffmr512843wmb.76.1706043473485;
        Tue, 23 Jan 2024 12:57:53 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id d21-20020adfa355000000b003392a486758sm9521904wrb.99.2024.01.23.12.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:57:53 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: sun9i-cpus: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 21:57:52 +0100
Message-ID: <8366441.NyiUUSuA9g@jernej-laptop>
In-Reply-To: <20240121051845.17603-1-rdunlap@infradead.org>
References: <20240121051845.17603-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:44 CET je Randy Dunlap napisal(a):
> Move the function description kernel-doc comment to immediately above
> the function implementation, correct the function name in the comment,
> then add a function parameter description to prevent these kernel-doc
> warnings:
>=20
> drivers/clk/sunxi/clk-sun9i-cpus.c:25: warning: expecting prototype for s=
un9i_a80_cpus_clk_setup(). Prototype was for SUN9I_CPUS_MAX_PARENTS() inste=
ad
> clk-sun9i-cpus.c:184: warning: Function parameter or struct member 'node'=
 not described in 'sun9i_a80_cpus_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Merged, thanks!

Best regards,
Jernej



