Return-Path: <linux-kernel+bounces-27307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6141C82ED96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73A021C20DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143D1B80B;
	Tue, 16 Jan 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAAAm80K"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C61B7F2;
	Tue, 16 Jan 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c6910e93e3so1311060a12.1;
        Tue, 16 Jan 2024 03:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705404087; x=1706008887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2frdD80csrQQUHGsaueDexralzHnoTFsGiRETYFj+P8=;
        b=SAAAm80Ktvql/9N2c0PBTPSM1dK6+Z7WG4GSJ+R56Z4d0z7lPmkxG4iZ8u24k3i0SS
         kQHHqQweCBTfjEP18ZmbLqLaoLIpHhc5JJ00gU5nGOZ9nmB7ItQJFZAOlkxjPDrE6ytZ
         gXWWeAw4a7nB+WjY/EAEc1SONMwEGXxwZXNQlAfWO63/Ss/91bkzHIFIk6RD+eo5/ewg
         HHoTvdKR6bD0CkxejOtvatnczOg41wHKBqBEzw/O7fVoSwalli2wrMifJoE6QSfc1tov
         ZOdrhlza4g9rMtmQWAZlS+LI7lLvnVL9AiUXTvbS0lET5yOqWR+s+rHucg+Uwc/hm66Z
         E4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705404087; x=1706008887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2frdD80csrQQUHGsaueDexralzHnoTFsGiRETYFj+P8=;
        b=Eo6ojdNm3UUWDg6EdZDKxgtaAQS1xe/9vj358K4dE5+GzqdDhZBiqYmG+TfOg6qY2J
         jobu/bJxVENpWyjvhL+NQun5MQ+UJy5reaCxykswJPjvt2x0N/7AIPN+4UmC9GmKSy4f
         dcvms3M790AdIPD4JG1yK3XClsAtFqtHTdoWLR3ugSMKt1Qi0mIPXYBATAItZXk/6XX7
         gcGqYco9mT05oReEx+H5Helqvqn/kiYvM1RYaZmLSp1iA98BEcZ1LQUeJca+sye3ZFcN
         QlOMwjBE7JPMEUpyS6X9zSetEC6K40Q1vRC9fD8OuJ2Dn/PcTE3tfGXxdv/YlbNPIyPR
         UQ4Q==
X-Gm-Message-State: AOJu0Yymn9RTppmqVihyA71yT8hdv+/suk0qtNIYeFJyG3ClkMEg8snB
	Pf8UVMFkovYeMx6Qh+853TeodZqXxhWYNslXCPM=
X-Google-Smtp-Source: AGHT+IE9fyCX5XxM744+q1T3mzQxH5LsqLALOlIAytz20SCY3uCcOSDSx1KLO7eSCKJWzlsheKRM3B1TBv+GewOLKtw=
X-Received: by 2002:a05:6a21:9218:b0:19b:20e9:90da with SMTP id
 tl24-20020a056a21921800b0019b20e990damr3250632pzb.5.1705404087498; Tue, 16
 Jan 2024 03:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116105317.267525-1-frieder@fris.de> <20240116105317.267525-4-frieder@fris.de>
In-Reply-To: <20240116105317.267525-4-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 16 Jan 2024 08:21:16 -0300
Message-ID: <CAOMZO5DONvb8GpH0PrBaa_EW+br6jWeMC=Jx_y_Etz1EUg11mw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: imx6dl: Add support for Sielaff i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Frieder Schrempf <frieder.schrempf@kontron.de>, Andre Przywara <andre.przywara@arm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	James Hilliard <james.hilliard1@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, NXP Linux Team <linux-imx@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 7:54=E2=80=AFAM Frieder Schrempf <frieder@fris.de> =
wrote:

> +&i2c3 {
> +       pinctrl-names =3D "default";
> +       pinctrl-0 =3D <&pinctrl_i2c3>;
> +       clock-frequency =3D <100000>;
> +       status =3D "okay";
> +
> +       st1633@55 {

Please use a generic node name.

> +       gt911@5d {

Ditto.

