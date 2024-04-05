Return-Path: <linux-kernel+bounces-133217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD6C89A0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DB92852A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C33216F8F4;
	Fri,  5 Apr 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4Ua375V"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926D16F832;
	Fri,  5 Apr 2024 15:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329590; cv=none; b=YwXmTNYZYiNsRz1aCo8VwRwcy0y9zA8Gci6W57rp4eU+PM/Fp43g3+EvYW+MdMeLuDat6Rc7QPDtp3gU6/xB27qOzjygTLIL/le+JIwH59E+jRRppV+pgoN4gohvMidFMAX5PQsZeUWYWV7XNSuf1tgUFHT5MOueJr8tAfRVcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329590; c=relaxed/simple;
	bh=nDClXF3j4lc22O9XFA6Ptr+e7CswgCu/KhRNNcL/s2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RF2MewbJzX7d7B4uWFCa/JrJyBHsYLrKa2R1GTHVdibgkMEx03QFn6PcogXfxgQs5IuiTd5QbjhmZOuTl4CYSLOy7xkD3hKxPRoKVN9hM61gTOli+Zg8zj8qSnHUuhGuRTEo/1muas0S6RVCJoxeKKMNnT4crIW9ZKQ2odaTKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4Ua375V; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-343d88460cdso859204f8f.2;
        Fri, 05 Apr 2024 08:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712329587; x=1712934387; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cBcaVMbSMZkgJPIkV9Rq48dY7hxQJkftAGqxOYcj3jc=;
        b=I4Ua375Vu2cxCySRVctA7MQy4P5adUzw7E+o75qNtSljM9hKQIMmgJ/wnrNMoiyOIl
         6jmi/v9OcZ5HNfTRNiMC1AndJvcm9wuI8g/jorGcsF6hDOuGdhDBcNOypOzzZ3XWHqcm
         aKpcnP5hvodyTfRnrE+C2ZZsA89fG+ViRCMDKdZ98juUIAiGWnJPlafN8WzE0Efo0ErU
         41TbNJULb0TNBf+al/hqJfqQowR9s9MafT5idLwqwVtC5zHAdsc5/SQCt43tvccI6L1E
         Ot1PNSPdxOcAHH3o2wOEyHXMnOOg7qlw7ZJrlIKw00PygWYxb4CkFm9l3MbNfHwhWGa2
         kPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712329587; x=1712934387;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBcaVMbSMZkgJPIkV9Rq48dY7hxQJkftAGqxOYcj3jc=;
        b=s4ng1CbWbD5h6ZyMm7SCsV4sTK6B9T2kde3dqiWjtoz0d01INsDGWs4EI07VNBHDWA
         cS4Pl5xbkJVJe4MsFgX1r0cgsJU4aEWrE2gk6qDmnt9jnBGhUh0Wt1a0cBBk/9f+KTdQ
         5nPDM2xxu5BFRh3KMz0rEJ6AeurtmiuZVWTAQgh+yx1gqHC5NHn0Tib6jkzfX8PnjyWQ
         g/ePcuXMdQ8kGY0VtLTG4hgkRZ0A1CcmIsGly9XUB8ACwzdqjybVFJ7vApY2UI5BRMdt
         +3YaB7YSebWhg+4dfSX95n8FUROJ/k0QbujLltHEHtB9V7c2gwl9LqJ7PVLCpkw+Yu2S
         VfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTgpIKn0xYKXPgWnqYzLNy4NXXa+/mFcRPIRGNcbrZCP09dEgWoq6h3cJzUHFLi0R6I5zZtcTO+jCkIstuDG2vZbyppejJzRDx0UmD
X-Gm-Message-State: AOJu0Yz7K2TcvADG2hXUl4qvXv6JbxroMzKUokfMsUGm2OQnAtNKFR71
	QoQcBRX+lIFNh63y3/ZQyIddAmwR0xUfkCRUaiJuQ5EzY//HBFqeSNDmz3QojzE=
X-Google-Smtp-Source: AGHT+IGup9KuT3bGcXDYshgualkO8wp4iqLuiaYwB3pv/mfMPLTy4X+Az68C+QLsBtuAw65y5iqOgg==
X-Received: by 2002:adf:e510:0:b0:33e:8aba:cd0a with SMTP id j16-20020adfe510000000b0033e8abacd0amr1267736wrm.9.1712329586904;
        Fri, 05 Apr 2024 08:06:26 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:b890:c074:f63d:508d? ([2001:8a0:e622:f700:b890:c074:f63d:508d])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b00341ba91c1f5sm2210015wrt.102.2024.04.05.08.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:06:26 -0700 (PDT)
Message-ID: <4e781d80fbec0db13555456ab8af6bdae6dee168.camel@gmail.com>
Subject: Re: iMX8M Mini suspend/resume hanging on imx8m_blk_ctrl_power_on()
From: vitor <ivitro@gmail.com>
To: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: vitor.soares@toradex.com, ulf.hansson@linaro.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	rafael@kernel.org, geert+renesas@glider.be, peng.fan@nxp.com, 
	linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de, marex@denx.de
Date: Fri, 05 Apr 2024 16:06:25 +0100
In-Reply-To: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com>
References: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Thu, 2024-04-04 at 16:53 +0100, vitor wrote:
> Greetings,
>=20
> I'm trying to suspend/resume our Verdin iMX8M Mini with VPU IP using
> the latest 6.9.0-rc2 Kernel. While the system can suspend without
> issues, it hangs on the resume routine. After some investigation, I
> can
> see the Kernel hanging on imx8m_blk_ctrl_power_on()[1] while resuming
> the hantro-vpu power domain.
>=20
> Any hint about that?
>=20
> [1]
> https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/pmdomain/imx
> /imx8m-blk-ctrl.c#L101
>=20

Looking at other child nodes of the pgc node, pgc_vpu_[g1|g2|h1] seems
to be nested into pgc_vpumix.

After applying the following changes to imx8mm.dtsi, the suspend/resume
is working.


@@ -739,16 +739,19 @@ pgc_vpumix: power-domain@6 {
	pgc_vpu_g1: power-domain@7 {
		#power-domain-cells =3D <0>;
		reg =3D <IMX8MM_POWER_DOMAIN_VPUG1>;
+		power-domains =3D <&pgc_vpumix>;
	};

	pgc_vpu_g2: power-domain@8 {
		#power-domain-cells =3D <0>;
		reg =3D <IMX8MM_POWER_DOMAIN_VPUG2>;
+		power-domains =3D <&pgc_vpumix>;
	};

	pgc_vpu_h1: power-domain@9 {
		#power-domain-cells =3D <0>;
		reg =3D <IMX8MM_POWER_DOMAIN_VPUH1>;
+		power-domains =3D <&pgc_vpumix>;
	};


I will prepare the patch to send in the next couple of days.

Regards,
Vitor Soares

