Return-Path: <linux-kernel+bounces-159997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BF8B3776
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82762282FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9527C146D42;
	Fri, 26 Apr 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="2UJtP4Ks"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E958143C67
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714135797; cv=none; b=JRj7WvgCsZFlLZT1wInr+01oUh4/EyCcNtg6+Qtv0+ozozE0muYQ1LTYudNLq0RPIsjnNHgoyWj0b+DfgaSsJUXdXIbCAnFuUPsg+zQuaOHV4tV98iIOgup+WJ0i8LiPe0zV4uxFtTIUfO/N6VxEPhy2S00vgJFVv2QgjCTANpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714135797; c=relaxed/simple;
	bh=/jIk24UTvp2YUpiHzdbLKk/FlYgOG8sPlEgyK+NwXnc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FsV9UBmZjZ5ulsWNEBDtG7oPXsgCm4yNOQjsN/E4jZCHJO59qsFnYqe7G7CPXbR4GZ6rpumSyUOQAIde7veaI3m8qi5PtzHcMoAaLHxT2G9Bm5bVQGp82tGy9s+T1Hphuxu+Bq0ISdOIduKoUHFUTSEwZ2260foexg/+dSCh1jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=2UJtP4Ks; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43692353718so12748181cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1714135795; x=1714740595; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/jIk24UTvp2YUpiHzdbLKk/FlYgOG8sPlEgyK+NwXnc=;
        b=2UJtP4KsfvVD+25hq0L4p/d5xDopSWXxvvU8AzT7XCkmvC4wV29plp11C9FT/MZIra
         vNn1z6/tkfQDMUD4P5MG1cAtOmHCTBDA6/7tjctBz9ZjE4uPQPLZRm+9GH2RgUTGxvV/
         zBuPLo0TKYCfZLJdQPG4IID1srIg/xfR6Nc+ZsIVrIRqTBGAJ4CqNZT8PQxPdg2X7+0/
         MY6nX8VN1giQdXhPGkIrf94D5Ych8B25Fv3j1O5vnOEVLwfk9dbHNSvyuWutv707zf4O
         RV/JIENLwRvsvdVBk8gxkbakLasASElyYyxUrfn8oRKr9ce2fi6nc/y2lQ4sN82vyx0X
         JSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714135795; x=1714740595;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jIk24UTvp2YUpiHzdbLKk/FlYgOG8sPlEgyK+NwXnc=;
        b=PIU2TCzt5Fiij95V/IDQeWa6dslNOnif/JJ0M+Bu3wJIskGUzj+71vRVDW0wa/KHUi
         /BkJG+f0gtJArXKDAzdPlrnBdacXtYYjCv5xcoXShIfbcYEuGxXzH+f6De4spOSNJDFd
         R5J0hQXGB6GtdegoajfnhXvFxETGlJNgnrDnyAg6Zd5ZEOdyi1tP5UFJ1tfaIGoiFnt8
         EIOYV45tLS/8blWHDgOuhD9EXNFajoiRCuBdRmgQpY/lKQbU1u5+qN0K7Lpnl+C0xO7a
         G5Ajokn4EUpQmdXZuzrGp8k1QDkZlqyhT09rWvs5NsL8CdtJMcWjODeggSk6SbhkeX9U
         maKg==
X-Forwarded-Encrypted: i=1; AJvYcCXNts39MqJ6A9wzrg4P38wLr8CZrjwLj07RwSwg1tp6SZj2AJWIteEcwE7EuMFd/+ZilVBRPFC7Qv6K5kmZag2SB4HZ5iSMKa8Jc0qT
X-Gm-Message-State: AOJu0Yx+priTZXMu0GUrbGYW3AUmcP0LC7T9zxXyXx2AA7lXCns+2Xvb
	+PSPV1Jpl7Jtsnl89EOeaUbZqUnjS89IzSn/sPcTZuecHIDrwQyUN74J7UF+NZg=
X-Google-Smtp-Source: AGHT+IF3o9M5pM6FFfsh7nJLZ72rsCnOVet38b7n9U0dFsxRLAADFOG1ZYyP9LGChYQIw3BAigPKMw==
X-Received: by 2002:a05:622a:5e87:b0:439:a519:7ceb with SMTP id er7-20020a05622a5e8700b00439a5197cebmr2681743qtb.25.1714135795330;
        Fri, 26 Apr 2024 05:49:55 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::580])
        by smtp.gmail.com with ESMTPSA id c3-20020ac85183000000b00436e193f408sm7853597qtn.28.2024.04.26.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:49:55 -0700 (PDT)
Message-ID: <bb59b9582e100420ef5ab9fc9a089f91a3d49883.camel@ndufresne.ca>
Subject: Re: Re: [PATCH v6 2/2] arm64: dts: rockchip: Add Hantro G1 VPU
 support for RK3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, sigmaris@gmail.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, didi.debian@cknow.org, 
 ezequiel@vanguardiasur.com.ar, heiko@sntech.de, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 mchehab@kernel.org, p.zabel@pengutronix.de, robh@kernel.org, 
 sebastian.reichel@collabora.com, sfr@canb.auug.org.au,
 linkmauve@linkmauve.fr
Date: Fri, 26 Apr 2024 08:49:53 -0400
In-Reply-To: <20240420050913.182225-1-liujianfeng1994@gmail.com>
References: <B9F108CF-4BC5-41A0-A28A-1CA1F4D2CD3C@gmail.com>
	 <20240420050913.182225-1-liujianfeng1994@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le samedi 20 avril 2024 =C3=A0 13:09 +0800, Jianfeng Liu a =C3=A9crit=C2=A0=
:
> Hi Hugh,
>=20
> Fri, 19 Apr 2024 18:28:01 +0100, Hugh Cole-Baker wrote:
> > The register range at 0xfdb50000 length 0x800 includes "VEPU121 core0" =
encoder
> > regs at offset 0 and "VDPU121" decoder regs at offset 0x400 (referring =
to the
> > TRM v1.0 Part 1, section 5.5.1). So I think the "rockchip,rk3588-vdpu12=
1"
> > compatible isn't exactly correct to use for this entire device.
>=20
> There are five vepu121 cores for jpeg encoding. And Emmanuel is doing wor=
k on
> them[1]. And at the moment the driver doesn=E2=80=99t yet support exposin=
g these cores
> all as a single video node to userspace, so Emmanuel only exposes one sin=
gle
> core.
>=20
> > IMO "rockchip,rk3588-vpu121" would be more appropriate if including bot=
h the
> > decoder and encoder. It also raises the question of whether the decoder=
 and
> > encoder should be modeled in DT as one device like on RK3399, or separa=
te
> > devices. In the vendor DT [0] they are modeled as two devices but they =
share
> > clocks, resets, IOMMU, and a "rockchip,taskqueue-node" value.
>=20
> Now we have 5 jpeg enc cores, one from 0xfdb50000 and other four from
> 0xfdba00000. I tried to add a decoding only core 0xfb50400, but that does=
 not
> work. So the vpu should be defined as one node in devicetree for both enc=
oder
> and decoder like rk3399.
>=20
> This vpu121 should be exactly the same as the one in rk3399 which support=
s both
> encoding and decoding. But the current hantro driver has disabled h264 de=
coding

If its exactly the same combo as on rk3399, it have to be combined as they =
share
the same internal memory. You'll notice this strange thing about both being
60fps FHD seperately and 30fps FHD concurrently, this is why.

This leaves me with a feeling our understanding the of HW is far from perfe=
ct,
we should be extra careful and circle back to Rockchip (ping Kever, he'll
translate and CC the right person I suppose). Though, just exposing the dec=
oder,
and ignoring the encoder seems fine in the short term. Userspace will miss-
behave though when we introduce the rkvdec2 decoder.

As we'd like to change from trivial time multiplexing to proper core schedu=
ling
in the long term (for identical cores only), we have to keep in mind of the
possible grouping, which will need to be something deducible from DT. Pleas=
e
keep that in mind when designing DT for this chip.

> since there is anthoer decoder rkvdec on rk3399. This vpu121 is the only
> decoder which supports h254 decoding on rk3588, so we can't just use the
> vpu_variant from rk3399. Maybe we can use rk3399_vpu_variant back when rk=
vdec2
> on rk3588 is supported by mainline kernel.
>=20
> At the moment we can keep the compatible string same as the one from rk35=
6x.
> Since there are already jpeg enc cores at 0xfdba0000, we can ignore the o=
ne at
> 0xfdb50000. When rkvdec2 is supported, I will change "rockchip,rk3588-vpu=
121"
> same as "rockchip,rk3399-vpu".
>=20
> And I think changing "rockchip,rk3588-vdpu121" to "rockchip,rk3588-vpu121=
"
> should match the hardware correctly.
>=20
> [1] https://lore.kernel.org/all/20240418141509.2485053-1-linkmauve@linkma=
uve.fr/
>=20
> Best regards,
> Jianfeng


