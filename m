Return-Path: <linux-kernel+bounces-160933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8718B44BE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BB71C215B7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C916433C8;
	Sat, 27 Apr 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8SSWuAY"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286063BB22;
	Sat, 27 Apr 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202257; cv=none; b=lSx0gstTx/wZ5IeuFCxplLkzlHGkNNn75UqzP+TWZFfNSzwiEaGiwjHQ4+hWgqdWKlRmx5lwe4sqtB+MffnMCNO2bF7M/LCLJT+Klpo+F0E2DJrtmSwO2iKRtigyQBtWacumf+BaRtPo3FQS2OhrifPXA4Egmwgbvg0uysXXJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202257; c=relaxed/simple;
	bh=KsZOuxYIuzP2B3Mk5ljXHJfuM1664KIpR3QMseySPms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVO21Opim6vnE1gn16Yt2ef73dtCUJ5CylG44Npe/kVyCoqdhKriuouLos0Br+cWmnLc5kncYUw3cB1JGbHqXpGfzuAaC3JcNGsI1z2pAlOTjK4B/YIHZhg7JzfPyhdPnTfIN48Yvm4ho+d88W1JiTeKh0rSetVOAbs01ksZAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8SSWuAY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2021906a12.3;
        Sat, 27 Apr 2024 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714202255; x=1714807055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8kCB3I1nqc74i13dcnZcbSCBOzeY8bK9si08l2dEgE=;
        b=a8SSWuAYqRuXEx22RhpRtfrvlHQaZvbzdtq3Mkma6aOnzk5K3Ylxrgv/+DK2A9vfYi
         vDLYLNbtDMYCVE9cbOWkflf2k/0N5Nw7pWme4XctuWDIrKZA9sOja0WSK2Ac9jzlHHbK
         2qod/aivwscMbfFLonW0QbxxJ+JN/jCl0KdtqzqrLmOEMufBV4kW2lnLQSLmBvY0q16x
         LG4ZYKVEZD2Icaz22+SLqTKuygEjORYo7ZiGq1FIhRuPj6+CIAz3fZ+AIr2Ql8ZRaDhj
         VdDYt75pR5ZDOjgdNhp6FmNZ0fPgZQ84l85xdKNQFssnCkMFFpKtDnofldiefoC4sf4G
         DHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714202255; x=1714807055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8kCB3I1nqc74i13dcnZcbSCBOzeY8bK9si08l2dEgE=;
        b=VpuD5QQjTQtMJEFBb6Qmxl45HiyzCPPXRMPIn1ghWfVJZBfTz/9QcCr/IlEa2rqdae
         aUnR3wPhxXxiis346o5DOr0SAtgSI96ghbg4Y3gjkS6DOMnD9tSwsidx8xfx+oV7o22/
         v7EZFGcdT7ge+4foQODTho9Mcta2O6ksMNcyTCvWIhXc/VArT2ZcVfNko/wYW+HCM7Au
         Gl8GpdZehGhiFTj2gxS8uIqqnMMNRGaAt+gxzVEHRSGyF29fYo/qZCZanmG/dcxWE2WV
         1p/ZP/INShiIkeNcgnmavhf90WhYUiMI7rfG9YqwfY16vI9ZY36nWwYk5VUzK1xJn7d8
         g5VA==
X-Forwarded-Encrypted: i=1; AJvYcCUzNyMjWs/ZYESzTLoJbAWcPz/FJej7d5JoOPk4znQ4b+pxNTQGOmyQMnRbveCp0N/wIFXnRtEUJV8HA2/ENDR3GYBpOTOMCiKNhqGIlJzKHRX6yyNJb75HBAl1Srx6quLyao5diA3TPEholykHeQ8hr74FNaWdBA0QCp9xXFyOAZc1Wk2y
X-Gm-Message-State: AOJu0Ywhb1JW9JfuVE79gnwUsdkzifL21v/WR4fSTHnP+ydKuLbbJta3
	LGt9i/jfLD0smjoL2M8IpBPADJYyTbiq8LQdDJY/BvCnMCpjr+8O
X-Google-Smtp-Source: AGHT+IHWfWgdcQqxoTVmFJIu2SLzNm3A0qQRERzEXLa7neH1QrNrTJ0T8DF6bh4XJ6eY6mQO553c/Q==
X-Received: by 2002:a17:90b:1d01:b0:2a2:bd4b:764f with SMTP id on1-20020a17090b1d0100b002a2bd4b764fmr4481541pjb.3.1714202255374;
        Sat, 27 Apr 2024 00:17:35 -0700 (PDT)
Received: from toyko-2.5 ([45.32.55.39])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090ab38e00b002a03456ccabsm17233086pjr.30.2024.04.27.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:17:34 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linkmauve@linkmauve.fr
Cc: andy.yan@rock-chips.com,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	devicetree@vger.kernel.org,
	dsimic@manjaro.org,
	ezequiel@vanguardiasur.com.ar,
	frattaroli.nicolas@gmail.com,
	heiko@sntech.de,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	macromorgan@hotmail.com,
	mchehab@kernel.org,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	robin.murphy@arm.com,
	sebastian.reichel@collabora.com,
	shreeya.patel@collabora.com,
	will@kernel.org,
	sigmaris@gmail.com,
	nicolas@ndufresne.ca
Subject: Re: [PATCH v4 0/2] Enable JPEG encoding on rk3588
Date: Sat, 27 Apr 2024 15:16:38 +0800
Message-Id: <20240427071638.79915-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
References: <20240418141509.2485053-1-linkmauve@linkmauve.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Emmanuel,

On Thu, 18 Apr 2024 16:15:04 +0200, Emmanuel Gil Peyrot wrote:
>- Only expose a single VEPU121, since the driver doesn’t yet support
>  exposing them all as a single video node to userspace.
I'm also doing work with the hantro node on rk3588 which has both vdpu
and vepu. Discussions can be found here[1]. If I enable the jpeg encoder
at feb50000, would it cause any side effects if other jpeg encoders in
your patch are enabled? And what's the disadvantage of enabling multi
jpeg endoers in devicetree?

[1] https://patchwork.kernel.org/project/linux-rockchip/patch/20240418111002.83015-3-liujianfeng1994@gmail.com/

Best regards,
Jianfeng

