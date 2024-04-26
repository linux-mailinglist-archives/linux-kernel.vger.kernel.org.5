Return-Path: <linux-kernel+bounces-160337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F08B3C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F76B255CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6884114AD26;
	Fri, 26 Apr 2024 15:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/yXnJo/"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C415149C44;
	Fri, 26 Apr 2024 15:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714146986; cv=none; b=TfC574br5vZ8C/960g6SmvI6ASvq0+0ezBIPJydLXtAvzC6HwxWxp5CC7H9JeLYNTSRdoX5gcRKkpREk106nMJmaCidpIXd6oS2WtnOHIxNL1+ZaDN0+Jb3PmA/QLXSi+7Z7qt09FHsYxE5TDw8pysd6AQyJUYMeXh6qlz10WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714146986; c=relaxed/simple;
	bh=SPm23R+pERREX2KPb30REziWklWi/jFqJN/iR+KD6AM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpF0Ns1Wt1CM0NV1gKgg8XIKpaF4je74yk+e4lD0pghosIPVFRa3ujF6ZhjxZFpOw8wC+3GeAwfsDLNOqUZPNbHHhyKDn2ndA57a3AWCjQMD0KIQJSbi/sq/U5lgZN7P6Zg4VF/U52NXX+NwyDasjXIiAu0JaIv1R49hMzXIUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/yXnJo/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ab6f586602so596696a91.2;
        Fri, 26 Apr 2024 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714146984; x=1714751784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt6fM2J/0v9iVwGVtQ/PZn4/j4BB6la6XibiFvi9sc4=;
        b=f/yXnJo/P8QVCLFUTTLz9K6ehCWsn1j5C5Q4cPylzw+J89dyYHkI26SwtHeGhf2pZu
         rDyGabphJ80EGQK5HHWygHCr10VG8GZXLGzVhlw0H6o1kAKvJQav+q7S03pjr/Xegiil
         4Wt71x41EiUQkluD00/4gxjfEAB2ue1wp+KHuw+E7EwLRDkqmMHz4Fp2Iu+oXyHjkboS
         bUTE5Q2IyFBUMsPDNNeoMYG0ux5k+JDnAHls9xEFHSUDURkFLHFtl2K0Si6wN8we0+kE
         Gifrb/w38oU9xQsCMY2pPQp3BZtNXwHGt81WszCO++N6JKv83WtnARqCpk3c0Me4oqS1
         0wgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714146984; x=1714751784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lt6fM2J/0v9iVwGVtQ/PZn4/j4BB6la6XibiFvi9sc4=;
        b=fmBoSgNg2W5hTOzztMsDVVTz3mJW3pQ4GlCL2KeVRcfD+70YeFfvm17UMoAC1qRXLo
         0Ck3v7nkBeAcCEY4a+JmUEtvdiU3PAxakj6iup/G7zkd0AeCFJvprlBrtbTI+wdBahMg
         Aq4F4j7AnIOB+h7LxdvQBtjTJKQVUyzF6W3s6uM6qTsHImr9p/x3nbP/JIytOgN7ghM8
         Uf2t3r0pk0zjTu47/pH9oBCEa8hoycQJt83MJaJtMbMvoCfdTFRhEuAubNdAmbSHvJKE
         2QJZs6rlGDBiT6hIcNS/ubFVj+0gQPfWDRpXRkWWgrqQtnUhOnU9oWSC39D35ZjmzFlZ
         maNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYsWWljw3E/u6/XXZqUsF6CBEv3cHM8iGdo67UO8Z85VGkN78vzCWXKRRXbv3lwLt5pJE1F8+V1VsibYcCxcTiisZdmHUrrLGAn5kAfZhAZCiiH8mjyx2v9p8tTcStJjUnUmXgeYAcPw==
X-Gm-Message-State: AOJu0Yz7Ete6kylj2TpOt2a5ZT/eJmI/FpGeFaGU0/CAsM4yhywSS/BB
	brmuTcG7cIVkqWaYcM/JmtJ2/A7PUzheghQmZk8/NX/lymujy5adQaa4QzIMPr6UIGfpXebL30z
	/6KIjq76ROo63RwmbsDhlCYdRoaE=
X-Google-Smtp-Source: AGHT+IFSQ5Fxh0ege+N4YAigDlp6nqTb/tmi6pOaqlOwOkNXKsPEQwESVg1WwYcIZJqtiWEX3bEe4M/hrS22PvVApa0=
X-Received: by 2002:a05:6a20:1f88:b0:1a7:91b0:9ba3 with SMTP id
 dm8-20020a056a201f8800b001a791b09ba3mr3074443pzb.4.1714146983761; Fri, 26 Apr
 2024 08:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426152730.9806-1-fabio.aiuto@engicam.com> <20240426152730.9806-4-fabio.aiuto@engicam.com>
In-Reply-To: <20240426152730.9806-4-fabio.aiuto@engicam.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 26 Apr 2024 12:56:11 -0300
Message-ID: <CAOMZO5D=Ens3f-FnjEf8SDSTCChdzKW3m7LH+t6y6qUtWsSRZg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: imx93: Add Engicam i.Core MX93 EDIMM
 2.0 Starter Kit
To: Fabio Aiuto <fabio.aiuto@engicam.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Matteo Lisi <matteo.lisi@engicam.com>, Mirko Ardinghi <mirko.ardinghi@engicam.com>, 
	Peng Fan <peng.fan@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

On Fri, Apr 26, 2024 at 12:31=E2=80=AFPM Fabio Aiuto <fabio.aiuto@engicam.c=
om> wrote:

> +&usdhc3 { /* WiFi */
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;
> +       pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 =3D <&pinctrl_usdhc3>;
> +       pinctrl-1 =3D <&pinctrl_usdhc3>;
> +       pinctrl-2 =3D <&pinctrl_usdhc3>;
> +       mmc-pwrseq =3D <&usdhc3_pwrseq>;
> +       bus-width =3D <4>;
> +       no-1-8-v;
> +       non-removable;
> +       max-frequency =3D <25000000>;

Is this 25MHz limitation correct?

