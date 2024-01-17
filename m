Return-Path: <linux-kernel+bounces-29355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C8830D34
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E4911C21BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADB6249F2;
	Wed, 17 Jan 2024 19:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="r6ve5zD7"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3524212
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 19:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518988; cv=none; b=gmjVp/uozAa9mkwU+/DEKj9Jray0NN+7C32Qj3uBR4vzll9cMHTF0OhyMh0v7DqC9x/UmEss9rTEuQryMY/Q8gta4HEusqBW2ZcRQGHpVgQr+BvVRZQ23QX81ue3zNjNiXvx0IrdEb9P37k4oVaunMAeALe8f+w6Ny3+DbS3v4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518988; c=relaxed/simple;
	bh=onTL7TdnsjCvGHXrMKju4hSwOmvPGySD2hbEt0TfeAk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Autocrypt:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version; b=e/dOGbm9EysUHV343rZwZn4zvxBMYK7LScmWju6+6/xKz9tRylVcXA6whX1Y/ZhY8Q4CmnStqtdXBo7lnjtHeSiRzR/SVU9m2mdWbQW28TskoD4iGBI92jajHLm/4M1KJtVUZ9Wzkm2ZBGASRJmVLrmPhHZVWVkXFfDikt02T6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=r6ve5zD7; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7831aacdaffso1086267885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1705518985; x=1706123785; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ogRg9OKr3TtBbn27PlJROK+uQ9hsjKmTfDTYT7Icesk=;
        b=r6ve5zD7XL5lGTrFPgUoYMrgUUsSu46MDsPFnbxGIUbhBKTeKucgvcZoDNm5EGquxD
         e5WZn+tgw0v0gHy1F3u+eIR7SUVHxXpcxvSgOBcesiazMT7MpZEmRvahJNFyXw139Yl1
         wpln0KIj9+gjPVPMPOiITGViltvWEKmUM5dmmwHSvX02O+/Z0DCUdykP+aYOXH+fURUE
         tuHfGE8xmELy77KFNSXyvFcwaKMu8Skd1jVVDg6SZCELA3/iSQd6Metl/3SDf3zW0IKO
         By59lQtbAUHL+U6xDFZi7CKnmWgBFseW6+MJURIV42aylBAX/qYuzan0PBw/QCdjzllP
         u/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705518985; x=1706123785;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogRg9OKr3TtBbn27PlJROK+uQ9hsjKmTfDTYT7Icesk=;
        b=HWYOe5/MSvA8Sq9/7kWG31k+3XzVnsgJnvlnhHFRnhvgpIS2wFKEYscAscRSk0E8Xo
         N26P3HncKpx/WmeHhMWXA3IVtDplgeiXB+QKW9RXvSEpePYcEMcQBeNvjQNNZw4biWL6
         GyHJCVJPq6Ayeij7CQf4sEigG0NZswbgJICoiL+PNx34WtoN3tx9RmWV4iaLIDgpUAld
         X8FWNJ04NxlU453caUsqq6CdPnmBVHHNmJlg0qz0K8PjgaplWT5JAJ49JZXj6PkHgx6p
         REzN1ZPu5e60Y7lT44krFaSjfwF2+ugPxrjU/u6SnUG0Eb+NP2KOVFEDpreT3ww376uw
         Gi7g==
X-Gm-Message-State: AOJu0YzRLrHS3iECsGJCEaC8zn6akwYrSWnW8PBLNxxDel3Axv22u63x
	LtZKQtp1yVVWDqN73Jw3BQp9ztPcdVeT1g==
X-Google-Smtp-Source: AGHT+IExD4ARxCYdtDNLXXKK3wVBqruhp2TE7y6AV1ldpW1kqPOB4yyOE9by3LE6Xo8IHL6TwnwP5g==
X-Received: by 2002:a05:620a:4551:b0:783:3423:c76d with SMTP id u17-20020a05620a455100b007833423c76dmr12230144qkp.1.1705518985398;
        Wed, 17 Jan 2024 11:16:25 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id w9-20020a05620a148900b0078322355fb7sm4715898qkj.20.2024.01.17.11.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:16:25 -0800 (PST)
Message-ID: <5490507acc121113e52a8cdddb155fddf6dbb374.camel@ndufresne.ca>
Subject: Re: [PATCH v3 0/2] [v3]Add hantro g1 video decoder support for
 RK3588
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jianfeng Liu <liujianfeng1994@gmail.com>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, heiko@sntech.de, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org
Cc: sfr@canb.auug.org.au, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 sigmaris@gmail.com,  knaerzche@gmail.com, Ezequiel Garcia
 <elezegarcia@gmail.com>
Date: Wed, 17 Jan 2024 14:16:24 -0500
In-Reply-To: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
References: <20231231151112.3994194-1-liujianfeng1994@gmail.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le dimanche 31 d=C3=A9cembre 2023 =C3=A0 23:11 +0800, Jianfeng Liu a =C3=A9=
crit=C2=A0:
> This is the v3 version of this series adding hantro g1 video decoder
> support for rk3588.
>=20
> RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 whic=
h
> is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
> found in RK3568.

The only concern I have is that we rejected enabling this VPU on RK3399, si=
nce
having two H.264 decoders was confusing userspace softwares at the time, ca=
using
the slow one to be picked sometimes. I know the selection is not fully
implemented in GStreamer either, not sure for LibreELEC ffmpeg fork, Chromi=
um or
Cros-codec.

Of course, its not a problem now, but only when someone provides an rkvdec2
driver that enables the much more capable HW decoder. Shall we hold on H.26=
4
mainline for now ?

Nicolas

>=20
> Test results from fluster can be found from thread of v2[1][2].
>=20
> [1] https://lore.kernel.org/all/CAAXNxMT3f68-ptM7Crhrfmn7iwTyJc9pwz4Beob+=
5beVODaSHQ@mail.gmail.com
> [2] https://lore.kernel.org/all/20231230153159.3748580-1-liujianfeng1994@=
gmail.com
>=20
>=20
> Changes in v3:
>  - Drop code in hantro_drv.c because hantro g1 vpu in rk3588 is compatibl=
e
> with the one in rk3568, only adding devicetree node should work.
>  - Change devicetree node name to video-codec@fdb50000 to match the reg
> address.
>  - Add dt-bindings rockchip,rk3588-vpu compatible with rockchip,rk3568-vp=
u
>  - Link to v2: https://lore.kernel.org/all/20231228131617.3411561-1-liuji=
anfeng1994@gmail.com
>=20
> Jianfeng Liu (2):
>   arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588
>   dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible string
>=20
>  .../bindings/media/rockchip-vpu.yaml          |  3 +++
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 20 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20


