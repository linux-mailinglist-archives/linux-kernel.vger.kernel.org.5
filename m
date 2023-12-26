Return-Path: <linux-kernel+bounces-11518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2112381E79A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2AFA28308E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F94EB4C;
	Tue, 26 Dec 2023 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrZeq+wg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD5D4EB35;
	Tue, 26 Dec 2023 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9b41a3cb7so193858b3a.0;
        Tue, 26 Dec 2023 05:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703597084; x=1704201884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhmNUrx6xW83LPxxivxeZj4Rp8VE6nSPPB0YAqdFSLQ=;
        b=QrZeq+wgI0IWxx4dfAxF1BFSIOsha/YDPDK41u1EA9NxU1b+s3p6x2ljVhVI6M0Acd
         JmcNpdrDeejqkMIBP0qMQZPCthMpgoUrPmNgnWp49o6v/kZzSVaPDQJQI24EdK6BbDx3
         Zg+vOBa31Jblrrs/F6LAzl97FZUfh23kLXopck+clfZ8JRlpwmpjMYFK1p55dCrE89f6
         8ks6DHmSdyftTawa3tJws4yNFDV2cGCut3TN9AGGiok84nDwANZTtbQsNcweXHk1YlG4
         wADd3lgS1k7kNCBH1KIfs6rSxHtcnOKiYyNwak+r4UdEAHAskgCxJtea5IM2iaMVD4Og
         MtwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703597084; x=1704201884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhmNUrx6xW83LPxxivxeZj4Rp8VE6nSPPB0YAqdFSLQ=;
        b=bWRS69OdbV83CZd81c97zyB8+2myiZK+NbsRhlv+upj2qmfnVQkewHvTnV1plAtNEh
         4QMNxHfGyoQ24QWxTqgzXOe14gGB6dvaDtWQzhnauxYZINsyBknBHfrQdcZ1SVDeYmC8
         vcSTW8XScfPg6xubquHWcDjRKqQwxpI1Sv2By4UeyKsUhhm/Ayntp+9OmYnsP0gIK/LD
         eb6Vr3MZ/o68Me3EWHF/ccZhHnQiVGs5DhZPeiwNTCsbEWSYcz0hJxbk2jOG+FN+NDh9
         4ryoWHDwE1GhVgpffA0KtzzEI7ZHrxCtJBLbodzGdpRXJSMZKlDAFH7iEuG4YLMjLaKz
         Fesw==
X-Gm-Message-State: AOJu0YwPGH+fxfiB5z6Qn6fpFxXzUcx+KmALKLtjhyIKMHS3mB1+N+QV
	rS4COmOZPrrpffq/rjEqUKrJ6lhaaoz4XDJdF7g=
X-Google-Smtp-Source: AGHT+IG3D8HkCkDlPJdTtU4X4rKFuoW9fpWtEWLgbv5/5Wx45jC2hn/8snSWmfQYdfKEWSd0gqgbmd7VkBphOJobeSs=
X-Received: by 2002:a05:6a20:5152:b0:195:5a8e:cac8 with SMTP id
 b18-20020a056a20515200b001955a8ecac8mr10085803pzc.6.1703597084416; Tue, 26
 Dec 2023 05:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224124114.31119-1-othacehe@gnu.org> <20231224124114.31119-3-othacehe@gnu.org>
In-Reply-To: <20231224124114.31119-3-othacehe@gnu.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 26 Dec 2023 10:24:32 -0300
Message-ID: <CAOMZO5AmpdE2uMgx8+P-zXf8mYRvsJDBUf7xeRpaHC3jN-7_ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: imx93-var-som: Add Variscite VAR-SOM-MX93
To: Mathieu Othacehe <othacehe@gnu.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, Li Yang <leoyang.li@nxp.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 9:41=E2=80=AFAM Mathieu Othacehe <othacehe@gnu.org>=
 wrote:

> +/{
> +       model =3D "Variscite VAR-SOM-MX93 on Symphony evaluation board";
> +       compatible =3D "variscite,var-som-mx93-symphony",
> +                    "variscite,var-som-mx93", "fsl,imx93";
> +
> +       aliases {
> +               ethernet1 =3D &fec;

You could pass ethernet0 here as well.


> +&lpi2c1 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;

These are present in imx93.dtsi. You can drop them from here.

> +&lpi2c5 {
> +       #address-cells =3D <1>;
> +       #size-cells =3D <0>;

Ditto.

Reviewed-by: Fabio Estevam <festevam@gmail.com>

