Return-Path: <linux-kernel+bounces-8586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1DF81B9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540A12818C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD3D36097;
	Thu, 21 Dec 2023 14:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVLeW797"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC71A1D6BD;
	Thu, 21 Dec 2023 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so104881166b.1;
        Thu, 21 Dec 2023 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703169945; x=1703774745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrwv3J31Qk9UonkvLPYM6smDy/xDXM7xflFYKfVBtBA=;
        b=mVLeW7977tPTu1qck7qfNaYi6fNZNtr0adCbkZ2hYn6ek4L6ya5+EjE1bNkWDBbZWN
         +Lp9S/3yqPHUb/RvG5o2WSDricYZa44TpLQWf/UbX0i3SkFM0rh9zg9f+6FORBGg4Uu9
         jBZKjikbj2Mp4/47s47zZSu84CFrclrZbntDPn4eKRCOhbD1grrVnA0Vxi41Edvd/q2o
         V+S6V5w0HpuZqqErNa7zfABo6+aiHmPTm5NniKfD1e4oP+TdPRVI4f+Yehuqy2zUc5xj
         qs3U3kSOw7VVSWh+32tmxjglch45j0eTjLp8bvAnbdMvwIH4MCYnRJzzChU/xldIMY+Z
         vZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703169945; x=1703774745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrwv3J31Qk9UonkvLPYM6smDy/xDXM7xflFYKfVBtBA=;
        b=AwbUWe7Y1YdUJA0EDIp2JlBS360V8GDetx431vHFP6x/rqmmoeG0TI3qDgCYeepfNu
         xxlnACtMtnm5pI9tfPk2En9N+3c/SIc1AdzVcFh0YKtZ0Ws/qsLhSMeL17ELE77zj8us
         8TzF5BXECYc33Ru/0q0unH6lWUw4kNSURThdwI+yBVM+Wl2RCg9sxlMkNXMNZwDy3O5v
         29DUcsc80q5q5HXonoXV3yeKHSh1NTdJazm0KeayO701EXplj8hwoY72D/pKVUxgdjmV
         IM7f2AD7teSKcYXqtjZEsfoy9eoOx9bQHrCxJD1VXkR6QAUZWGGInmuJAZ66t2HozIK4
         MJvQ==
X-Gm-Message-State: AOJu0YzjIHShNGjDZtWqmEfOXsiQbRzZ0LoExGZI4k5JxwbPhKaiazIA
	gyVTXNJHohqMTjMkJHTQMMM=
X-Google-Smtp-Source: AGHT+IEKcKQfIa5EKtsdTp84TcmMedo4p6ScCtWLgcaDPVjwDofCkKt7udmqLFHMDFjjZlXQGJSvNg==
X-Received: by 2002:a17:906:221a:b0:a22:dca3:4190 with SMTP id s26-20020a170906221a00b00a22dca34190mr3882533ejs.109.1703169944887;
        Thu, 21 Dec 2023 06:45:44 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id h15-20020a17090791cf00b00a1db76f99c8sm1030441ejz.93.2023.12.21.06.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:45:44 -0800 (PST)
Date: Thu, 21 Dec 2023 15:45:42 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Stefan Eichenberger <eichest@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <20231221144542.GA122328@debian>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
 <ZYRCDTWgHbM2qAom@eichest-laptop>
 <20231221141636.GA122124@debian>
 <59fed161-6c08-4537-b02d-19e67e342dd8@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59fed161-6c08-4537-b02d-19e67e342dd8@lunn.ch>

Am Thu, Dec 21, 2023 at 03:25:56PM +0100 schrieb Andrew Lunn:
> > Without setting the master-slave option it didn't work. I think its
> > mandatory.
> 
> I don't think it is. The PHY should have a default setting for
> master-slave. Often its based on the typical use case. If its
> typically inside a switch, then it should default to prefer-master. If
> its typically in an end system, then it should be prefer-slave.
> 
That would be the case if you use a forced configuration. I think this
is already implemented by reading out the MDIO_PMA_PMD_BT1_CTRL in        
genphy_c45_pma_baset1_read_master_slave. Probably the problem arises    
with following lines which prevents an inital read of the configuration:

static int mv88q2xxx_config_init(struct phy_device *phydev)
{
        int ret;
                                                                        
        /* The 88Q2XXX PHYs do have the extended ability register available, but
         * register MDIO_PMA_EXTABLE where they should signalize it does not
         * work according to specification. Therefore, we force it here.
         */
        phydev->pma_extable = MDIO_PMA_EXTABLE_BT1;

        if (phydev->drv->phy_id == MARVELL_PHY_ID_88Q2220)
                return 0;

        /* Read the current PHY configuration */
        ret = genphy_c45_read_pma(phydev);
        if (ret)
                return ret;

        return mv88q2xxx_config_aneg(phydev);
}

If I type in "ethtool -s eth0 autoneg on" I don't have to set the 
master-slave option. Is the assumption here that we always start with a 
forced configuration ? If yes, then I have to fix it.

>     Andrew

	Dimitri

