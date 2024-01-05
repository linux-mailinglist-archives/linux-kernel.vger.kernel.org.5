Return-Path: <linux-kernel+bounces-17836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103F82536A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99084B23622
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3C2D05B;
	Fri,  5 Jan 2024 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn0ez182"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B372D602;
	Fri,  5 Jan 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d60c49ee7so15597475e9.0;
        Fri, 05 Jan 2024 04:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704458544; x=1705063344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHfQJekuu4Rqw+ArKcUUY0Lwd5dJazKZX1eaX6xy6Tg=;
        b=Jn0ez1828xfBqJDCJvgxfVOY2+Lp63vlUfILN9rI+Fb/qeCyUPzRdyS1CBoZ59UiFW
         SGuzukJ/2m4tyktO8Vhs8w0dHJrWgMcUR2erixwl+5EfarIheOmZmsnIlWey1xCk2VIi
         U3Kzrwl384HOJtVjUNwXjk9sS5zAzdyHy7yzm/AIs95L8lVxnbW4Ri/UEYjsO1qJmK5i
         I2Fhdbu1ZYVaLLkPf1LL3FBqU09L0BfkQWN0OqyjWtCkj1vq/H3CY2bgVPtiKHTBdF8/
         p2Nh1HWqatFF37glSkd+jfY7+bYVZGgJcEiGqYS0m0bym1JboHuF5M7fzhEFB8oB7oxz
         P7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704458544; x=1705063344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHfQJekuu4Rqw+ArKcUUY0Lwd5dJazKZX1eaX6xy6Tg=;
        b=HXekpbISl9dv3f6CNKEbeLhVzjp0KsbVi6Am79LBb9ABkc6jhGL8IsUCHjRuGBUrid
         QfmM0yq66Zb1pXzbEk4b3wMPQct2DN1HnmawPLgAEQBHn2wymeMr/zDgKV70NISvWjPs
         wYK0k8+X06iBwFVFH+7pFf5iJOyXiy1TqJBNwOwROoutPOa7W/IbdiLEssgEcNggcgId
         54IlZycQ64179DVLO9X95RnXbQevjWIuo9VqpKXBUZIswpA5ixz7xAW10vkid1+fdvbA
         PYHNEVC3RkSaOEKzz9NT3fSsIAaCaqxsG83FiowCt6LIBc6CgYoYecGsM6u6ZWEk3Ooj
         Go8Q==
X-Gm-Message-State: AOJu0YyhWyCn9iavfCCeRZFZ+YS53HgLfmwE2+fHDhT7sKw4+Ykc0jth
	KQ8S+RjbsyaRLJuIoaDYSLM=
X-Google-Smtp-Source: AGHT+IFV3hK9icrAOXuX/rCJ/JH14sy8qoCgjiZo+BhHk3LoaQ5nuPc9SKGOfXNgMA8wQVvV3GjLYw==
X-Received: by 2002:a05:600c:2901:b0:40d:f4bf:f0cd with SMTP id i1-20020a05600c290100b0040df4bff0cdmr1019896wmd.174.1704458544116;
        Fri, 05 Jan 2024 04:42:24 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0040d887fda00sm1470441wmq.26.2024.01.05.04.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 04:42:23 -0800 (PST)
Date: Fri, 5 Jan 2024 13:42:21 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20240105124221.GA30964@debian>
References: <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
 <20231217111538.GA3591@debian>
 <ZX78ucHcNyEatXLD@eichest-laptop>
 <20231218090932.GA4319@debian>
 <ZYAqxPZHICtZO15O@eichest-laptop>
 <20231219081117.GA3479@debian>
 <ZYFfzei3SJSts5E/@eichest-laptop>
 <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d545a9b-feda-4908-8f74-9218806451c1@lunn.ch>

Am Tue, Dec 19, 2023 at 04:57:50PM +0100 schrieb Andrew Lunn:
> > I am not sure that it will be accepted by the maintainers if you use a
> > lot of registers that are not documented.
> 
> Sometimes there is no choice, there is no documentation except the
> vendor crap driver which we try to clean up as much as possible, but
> we still end up with lots of magic numbers.
>

Hi Andrew, hi Stefan,

tried to reduce the init sequence. This worked for me:

static int mv88q222x_config_init(struct phy_device *phydev)
{
	int ret;

	/* send_s detection threshold, slave and master */
	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8032, 0x2020);
	if (ret < 0)
		return ret;

	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xa28);
	if (ret < 0)
		return ret;

	ret = phy_write_mmd(phydev, MDIO_MMD_AN, 0x8031, 0xc28);
	if (ret < 0)
		return ret;

	ret = phy_write_mmd(phydev, MDIO_MMD_PCS, 0xffe4, 0xc);
	if (ret < 0)
		return ret;

	return mv88q2xxx_config_init(phydev);
}

The four register writes were required to make the PHY work in 1000Mbit forced
mode. When using autonegotiation or 100Mbit forced mode they weren't needed.
It was enough to write them once in mv88q222x_config_init as you can
see. Thanks Stefan for the hint with the first three register writes, it
helped a lot.

> 	Andrew

Best regards,
Dimitri

