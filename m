Return-Path: <linux-kernel+bounces-160305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D28B3BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68291C238B0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440E314C5BF;
	Fri, 26 Apr 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf13icI6"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1331314901A;
	Fri, 26 Apr 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145617; cv=none; b=Qk3WEdA2qtdRiePqCOnHEUXHGLruymSXexhJC4ErvU5QdWHKNd1unc4+l1JrVLJeTEekVOr0Gn/HuuWxcuNKuUW3wh0639BCtxxjGnk/5V4pf/+O6ZyRl6trYvvY5k2J2wfYWR0ubeRaPoS3kFALEQoUZArUCsAyb8CRNF+5f70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145617; c=relaxed/simple;
	bh=QFRwxMg7frEbNFDwjKYIBUVZgUsQLuyynI1skXq82W8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SnPeNJqY+nSDbauyNyPeGdwUIvBghsp+j1iDMvHrr8ImwOQCRHiWnq6w0AHsPOGUblzom/cl5arTUHspepHlplcD1d2Lzc5UbNJMUXnz3JehmwNRKgvzN2X0YEtmNhz/WPqXIiiw3lLq4+vjl+mhsD8h2yWfEkZd2sIDixcmxl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf13icI6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2def8e58471so31421591fa.0;
        Fri, 26 Apr 2024 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145614; x=1714750414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmSvZsYuxSbHXQQ8UGWfhMWdiN9uCl4v3V31oMHoCWA=;
        b=jf13icI6SxHnOhX+aFYln5AGzn/W3XNiLsvbkEI1+A2ukE2ux11OXE5ACpiCNtGAgY
         zPENQk8YiXjcqCFJ7xG1/Jy1ZSkdOm2KfDK9zLBDSVJPDzzHsaHsUG/SLpNpfNFBGdxy
         qpyH50zIQusZ+YFzibR9rkipUfvpqJ4CJHVIyrOMXMozFOFiUasm4KYnZIZQB2YPbjiK
         4jOX7u4gaWnZQ3Ks7H8YSvRPSIeCu7SqIRTqwv+TB7MHp34I1FxkQc+wU6cDnJablV/r
         3DSS5xUogEL3LTyuQfXgi5GtXlu1nKnAh92gDJwgs25HbGVGNS/WgjuTICprjMST+ybb
         n+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145614; x=1714750414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmSvZsYuxSbHXQQ8UGWfhMWdiN9uCl4v3V31oMHoCWA=;
        b=YQCp140kY5XMH9eOw6p4zmQhWdwY5VKYHQDW1HAwwHPOGFdrwc95aEq+d/+2mA27W8
         Pdr+F3lOHiQXR7unKgQVOYHY6nlAkmnUciOl2kyrDQKellU2eyan5bvZvoVEwJiE5kJA
         wrjeKb96nxTfheC+qpa16xQfv2oKc78ByQtJum4Atf+Mg/ATNwTCnxRuHaXtypKOZ9g1
         zw6/sriQ/AlfTBRKdt6+DVyZszDJnVYvitSsFKTTgSDDRbrWTcvgxjWxZP8DBIKCKdUh
         aLzcpm1NySHCA116W8Yz+izsZQiAMhw6w2EFDgjvuwWuzQ8ab7wsZ0y0AdmfkPQ+z2T6
         KDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUGEV9wxMs9dUTtMI5S30iXSU+T1Ly6ciOfLG5GhI12t1k6zKxxUSkht64kwRongMc1m387Q1m+MsDbN23gVpDAP2cEL1EkqT51waeuWOjZkQ6gbUdHzHZGk9GTYs6BFk5Ti8dkuOYIVr6YRkZQ9epg8OAwgiBZD0hE0ZCj4tweTrGtZfxT
X-Gm-Message-State: AOJu0YzuLxgDOWoC+oHp7565J83hAx+dIxskrl0xKYJyBmvCkZsLZXkC
	Au390F0+bdS7NWfI/AyPZBtS8IUqoA/nWC0QvuFHYHNln12WXvKa
X-Google-Smtp-Source: AGHT+IGYO3LNHjAx3ZhjcpProOx5Njxc6bvdlaBa/MDs4MpbVRPuvd/qE2go3bO7nU7WPG3Ywv530A==
X-Received: by 2002:a05:651c:211b:b0:2d8:d972:67e3 with SMTP id a27-20020a05651c211b00b002d8d97267e3mr2911193ljq.5.1714145613836;
        Fri, 26 Apr 2024 08:33:33 -0700 (PDT)
Received: from localhost (p200300e41f162000f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f16:2000:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gc24-20020a170906c8d800b00a55ac217235sm7000671ejb.90.2024.04.26.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:33:33 -0700 (PDT)
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: correct Tegra132 I2C alias
Date: Fri, 26 Apr 2024 17:33:32 +0200
Message-ID: <171414557704.2298486.5241450837257963145.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401140854.97107-1-krzk@kernel.org>
References: <20240401140854.97107-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Thierry Reding <treding@nvidia.com>


On Mon, 01 Apr 2024 16:08:54 +0200, Krzysztof Kozlowski wrote:
> There is no such device as "as3722@40", because its name is "pmic".  Use
> phandles for aliases to fix relying on full node path.  This corrects
> aliases for RTC devices and also fixes dtc W=1 warning:
> 
>   tegra132-norrin.dts:12.3-36: Warning (alias_paths): /aliases:rtc0: aliases property is not a valid node (/i2c@7000d000/as3722@40)
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: tegra: correct Tegra132 I2C alias
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>

