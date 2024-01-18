Return-Path: <linux-kernel+bounces-30240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2350D831C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574701C221C2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB561E87F;
	Thu, 18 Jan 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKPJI/Nz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6347E1DDD4;
	Thu, 18 Jan 2024 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590616; cv=none; b=BSGmiVtfB1THnjmSZHoB/dgeQ6kJ56dDIcmpm3JF48WzLsq9QFuGmXNT66l9nyVAxrdw3JFzCuPRwmQ9PkbTNakrjsyXWuz5XIov6ZpF7Cq+YuMorKUyIMhgW9727LG+X+kPWs351iWIYZoV8dj3F+YmoENG1aRnkrWPWJjYopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590616; c=relaxed/simple;
	bh=JegE1xbt2O1pAQCKD1b14IUP9aNDD4bXI2N+pkFsx88=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Kyvux8gSEY15iodqWzY8yRfG9nl1VqyhVlRouos7vqcCgtybc9FB1NkGrfw+iquFGodWzTspyTbTwd8KbGAyoTWXA5dpMnHyQSgjpCRRcayj1F9xP/norNIZaBfZAfc4TyBAnzz7JKpPlVQtCCoIbFDWcxc/yDdcPpUteCVb6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKPJI/Nz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d51bf8a7dcso26492965ad.1;
        Thu, 18 Jan 2024 07:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705590614; x=1706195414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JegE1xbt2O1pAQCKD1b14IUP9aNDD4bXI2N+pkFsx88=;
        b=YKPJI/NzAQeFQOB+NourzaY3GTIv8pMUpoLv7mUZi2186z8E0ri6S0bSUnQ5TmZH3/
         Dp8K12B4QpGxDP1FtQmswC3H5ZUDqbLgt8d3FOocFRZSu3X7n41Nscc7PcMXZrXQ7onb
         kktNizOgs9YOSFcBvKcQF+rn1y2tET+ICv4HKeGH9KZvkz3pUM/zREaeGJxWQussIqOG
         86yolsfNNs2Pyd7eX/mMakfIVsGCdlzHMG/uMgij0SXi9yjAOt+Pa9GRckpCsZGK4+ln
         SL9sMFmI5Q/OjrJwt4Xd6zMHgdo3lljn2NYbp5zMeZJ2VzTA5F/YyNBfe70FHg8oGgLD
         tVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590614; x=1706195414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JegE1xbt2O1pAQCKD1b14IUP9aNDD4bXI2N+pkFsx88=;
        b=uFH7+mkG/ueCsRagBa+GX4WCYik2tsswbMBixxSzNEUirJRV3GdNhdZ/PYzLJFtBAB
         r9r27FIwPjvgsX8FDQczcFsi58jxOb4Ne8pVBl2YiTT7aOjMkelS7xfmZdb2qrRlPUeO
         khFvHTmOVRevuVoJ37puuHJKtGNBWbCHamJ6PLkPPw1SkvzsOflbiO5UaS74W3Mddb2a
         5rFIDLzVZ9Jb6KrxwVOaA1wMg1LoezAn5Nc69Xu1CzrgyJFTLUP2Yc4/9gyHmwLcgbal
         QSwzr/zFpJgskqpBD2D40y810y7EQ9wdJZvaDsoOxWnpeuPkOWpGxAjBP6h+DGPbHxFv
         l4bg==
X-Gm-Message-State: AOJu0YxvFNcGTI//TWfIGsOsU2twWfdOr33ohPSnbYnsUJIKviNNulXl
	dR5Izst9Sx+ISuS+l7PR3lwQloZlzi70Rn/UKJOcjLT8f8cd0cNYbZW8KI9cKBFw5uoHbDlMSE4
	+Y3S0up/5zG5kizeEMNtv2FgXZt4=
X-Google-Smtp-Source: AGHT+IGum+DDK3wqggIEwxSLjWS1eM/y84CuQs8yVytuweEpnHlu/zYdaKiimkLMf3VNyc2Tfx2KUoZvGsdcSqkN+Zo=
X-Received: by 2002:a17:90a:e913:b0:290:172f:3b1a with SMTP id
 ki19-20020a17090ae91300b00290172f3b1amr1768675pjb.3.1705590614575; Thu, 18
 Jan 2024 07:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
In-Reply-To: <20240118-imx6-hb-primary-rtc-v1-1-81b87935c557@solid-run.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 18 Jan 2024 12:10:02 -0300
Message-ID: <CAOMZO5ACbROrTXTe=7jEXyCJ7tpHNjhPKZqRWnz-RQJNz4MrwQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6qdl-hummingboard: Add rtc0 and rtc1 aliases
 to fix hctosys
To: Josua Mayer <josua@solid-run.com>
Cc: Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 12:01=E2=80=AFPM Josua Mayer <josua@solid-run.com> =
wrote:
>
> HummingBoard has two RTCs, first integrated within SoC that can be used t=
o
> wake up from sleep - and a second on the carrier board including back-up
> battery which is intended for keeping time during power-off.
>
> Add aliases for both, ensuring that the battery-backed clock is primary
> rtc and used by default during boot for restoring system time.
>
> Fixes keeping time across power-cycle observed on Debian,
> which sets RTC_HCTOSYS_DEVICE=3D"rtc0".
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

