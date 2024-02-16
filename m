Return-Path: <linux-kernel+bounces-68509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AD2857B71
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D49B01F21A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A8C60DEB;
	Fri, 16 Feb 2024 11:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdR48MJr"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EA15C90F;
	Fri, 16 Feb 2024 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082412; cv=none; b=VRknWWnQZrGJjrsizwRPLnKJA5E+5YY6hj/oUCY/qyc7zH8OxmpOMQaq4LDp9qxN6gEGYcdDo9orn18gvtdyXokQ2y/Fr60k8JXN0DTRTBjF9vU0lZ29l79CqVPZX/rmoNacxzSR/WqWei2fYdqg9IgbfxmHILeJ4t78MJkW8VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082412; c=relaxed/simple;
	bh=nkaCE6eCvGlgX7kiyuhw3auFPcpQnseOvbNalEBXKM0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A4j4tu6ZP20n8YugdqMk8OLqSUoAco7WnGA3/osjHxSwQTA0llk3dUUlFOiGq76ct56BkJ2eelF8t4N4fS/jhSFRU5mjBXsPv9+gL2sag1JEu6SnDOqPunno4cnU7UXGnIptunyE3zUk9RWOvyh/WwOaKj+savu8waH3uIAxWGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdR48MJr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d484a58f6so241698266b.3;
        Fri, 16 Feb 2024 03:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708082409; x=1708687209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCznbNgmC/uH8itI3jd4dc5ZdCgsBJRraVYhNu+kzY4=;
        b=TdR48MJraT6KcWbrFIIlguA5RJGkAEie1G1uhrtzUGIWplkIK8e5HOzoxXmkG0sVxc
         Efkmc9PBaILzxGcYD6cHA/BN03Da/8edr2n8fh5eJ5R1Lf6Wzg8QLI6EMbkT/7nhKtF1
         w44cniUGSMG2I0q6QTYo37lcoHx4I0NGD/vLxAAG6huQtghKX/gE0abx5Cw3xyZBANVF
         AVSxD5G0Voh57FT7k5U90OfZcFgX14aieTLDgV1/CofeHk5Edz5DHcojPJVLqh7XkN9U
         y6emThfK1/XueffGJWii3YYUMMH8D5z6NJRwXhXA4aWiXCljNUHW4JvJcqvGnzDMpzUD
         WFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082409; x=1708687209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCznbNgmC/uH8itI3jd4dc5ZdCgsBJRraVYhNu+kzY4=;
        b=ZmyATvp8K6dW9dKzfOF2kURi1pO24bcL20ZyYEw8rDta6fPDgb44NsJzLBzSoffwic
         7eFZJ3BROuJ6Q2vAymX/iHEahcYBl5clbDWEl3GrpTFz6h2OVIoRcJ+TKHqlRxjSaMo7
         YYeQndbz3rXzqbTlfoIKJgqcBtlUPiNugTrF00BNlrv/Y/nXZd3s1BnYcViVO/tcrmM6
         FeTPx9rmlKLUuCf2StP+95sWs4xX5xh3b4hK3GJ2groPqWQrE3RPUY4ENCecs/PwId5K
         7P2GXkktBfCw2G5knn0uPRlsDTVEcTRs8VDmK2QVi0U3Bk4EkJcMwRRDYB2JCZDJcESJ
         Kbmw==
X-Forwarded-Encrypted: i=1; AJvYcCVaU2hCUuMumx/UXCtfke0HMBPnP9orwq370KyalGcwK2exnAUZeyZqnI0ewqLHCMBns8PJjSbBkHIbVqLATE083p4+HTCYsOaXyca/JKnLySv7VR2zA6wmRg96Jx8JGFrFXClqiLas3fTtZ7ED5KXuKedV/nJpQeKHrzBOLpIUxZnNbHdu
X-Gm-Message-State: AOJu0Yzpz9zDug3GICYuUQ6HqO/C+XoDolWdSzxJRbRbC3Rkt/FRUgaB
	bwUIEPBgZiZSYfHD8WUmIKB5s5pk+ayB9F5F2M7seb62iMaKCBcw
X-Google-Smtp-Source: AGHT+IHPHegJqbyoyL1SyH5aHZfiqfe2a8Kk/Xmi79pqAV50OjKgbAr67Gj29oOtjPgW56iENz3wwg==
X-Received: by 2002:a17:906:f250:b0:a3d:51c4:812c with SMTP id gy16-20020a170906f25000b00a3d51c4812cmr3302801ejb.11.1708082409050;
        Fri, 16 Feb 2024 03:20:09 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i11-20020a1709063c4b00b00a3dae5dc653sm1097417ejg.157.2024.02.16.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:20:08 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	dmitry.osipenko@collabora.com,
	ulf.hansson@linaro.org,
	kkartik@nvidia.com,
	cai.huoqing@linux.dev,
	spatra@nvidia.com,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Petlozu Pravareshwar <petlozup@nvidia.com>
Subject: Re: [PATCH V3 1/3] soc/tegra: pmc: Update address mapping sequence for PMC apertures
Date: Fri, 16 Feb 2024 12:20:07 +0100
Message-ID: <170808233530.197509.809812872766738307.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240211171727.914595-1-petlozup@nvidia.com>
References: <20240211171727.914595-1-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Sun, 11 Feb 2024 17:17:25 +0000, Petlozu Pravareshwar wrote:
> On Tegra SoCs prior to Tegra186, PMC has single address range only.
> Starting from and after Tegra186, PMC has additional address ranges
> apart from base address range. Currently in PMC driver, we try to
> map these additional address ranges on all SoCs and if we fail then
> we assume that the range is not valid for an SoC. This change makes
> it more explicit on which address ranges are expected to be present
> on which SoCs and maps the additional address ranges only on SoCs
> from and after Tegra186.
> 
> [...]

Applied, thanks!

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

