Return-Path: <linux-kernel+bounces-19415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C128826C9A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A98281031
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3872137D;
	Mon,  8 Jan 2024 11:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMCn/0dh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990112E623;
	Mon,  8 Jan 2024 11:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5537dd673e5so1397223a12.0;
        Mon, 08 Jan 2024 03:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704713062; x=1705317862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LaOxVMHCgTdR4Fyp5Ka+5rLkqURhu2L6n6SimV39BI=;
        b=RMCn/0dhWBzYlLcJAcZLYnOwmHzX7a2bGAZREf9wiSPXlkMlCRSJnfVi8DsLCbQIWf
         z0K/c4NyBCAtSp3FT+5CBiJ8t171JhNpU0tj7AoScHh1NB8Lt4P2DLRXcY6kxGQg1Wc5
         ERbb1KOo0Pn+p5tgydQVu8dkaLDyUyz4wnAjyy/Q37HIeb3a4vUPfgLCL8lKj1bPjRq+
         5wk9TF1Ys8MQ9JJUd+//06ufPIVgKd6eqix2LBU5Ls0aC8Y2e+UCRpd/Sa/oJzozC5Kd
         /H5oJ3hE9iNc4cPcbHYyOYcbTmyQwzYI8XbDqWMWLQIkuu63jda2rlyhZKNhg32ePajy
         Exbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704713062; x=1705317862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LaOxVMHCgTdR4Fyp5Ka+5rLkqURhu2L6n6SimV39BI=;
        b=Re/qmQhlHcwzgnhPFVEsHUYRfTGON3qXM2AQMQXyqAYIXE/wnEqK7mepqrMxNSu+aH
         EOLid5DyzZweVfutLnJbbQx4BD0LeQbaT+726kDrGCI6PXORNrawv7mg2ntaAaqBRr3V
         H4YEEfe11ITJrGAJfpXWeTeEB9goQgkoYJaCCnwwF6FujTBQb2uamzcVEUjQJHRTrJNf
         5vf3kwKSOPQQ8plKjzzCqlEVdURxUqrIBNCfI+oT+W5Ca8cFoQyQAfXjMUl+u4Bgubi3
         +Z8OIElA7W8BgbVQNY8OMV2CkmQsTSkRQ65NfLLW6y6QPoFKgQ8nhthUFQ2my06SmnTL
         s6eA==
X-Gm-Message-State: AOJu0Ywde9PBXAqsELVFh7hrJx6OJ9B84mSujbPWEva/vEbztY8DFJlj
	yX5qb2yqjyrV1nFN7UK4buA=
X-Google-Smtp-Source: AGHT+IFzYV09hGBJFhePsjzgsWlZLQL/MOoO5EgxBtSSRcyLUmkU0eKwQw8HU32LpFpNrK00SFZEIw==
X-Received: by 2002:a50:bb65:0:b0:556:c60c:b20f with SMTP id y92-20020a50bb65000000b00556c60cb20fmr1979341ede.34.1704713061516;
        Mon, 08 Jan 2024 03:24:21 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id g18-20020a056402091200b00557c48abe41sm491347edz.55.2024.01.08.03.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 03:24:21 -0800 (PST)
Date: Mon, 8 Jan 2024 12:24:18 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 0/5] net: phy: marvell-88q2xxx: add driver
 for the Marvell 88Q2220 PHY
Message-ID: <20240108112418.GA30325@debian>
References: <20240108093702.13476-1-dima.fedrau@gmail.com>
 <bb44432d-0cde-47cd-a44c-be5e3f11afab@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb44432d-0cde-47cd-a44c-be5e3f11afab@gmail.com>

Am Mon, Jan 08, 2024 at 12:18:30PM +0100 schrieb Heiner Kallweit:
> On 08.01.2024 10:36, Dimitri Fedrau wrote:
> > Changes in v2:
> > 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
> > 	  in mv88q222x_config_aneg_preinit
> > 	- use genphy_c45_loopback
> > 	- mv88q2xxx_read_status reads speed, master or slave state when
> > 	  autonegotiation is enabled
> > 	- added defines for magic values in mv88q222x_get_sqi
> > 
> > Changes in v3:
> > 	- mv88q2xxx_read_status includes autonegotiation case
> > 	- add support for 100BT1 and 1000BT1 linkmode advertisement
> > 	- use mv88q2xxx_get_sqi and mv88q2xxx_get_sqi_max, remove
> > 	  mv88q222x_get_sqi and mv88q222x_get_sqi_max
> > 	- fix typo: rename mv88q2xxxx_get_sqi and mv88q2xxxx_get_sqi_max to
> > 	  mv88q2xxx_get_sqi and mv88q2xxx_get_sqi
> > 	- add define MDIO_MMD_PCS_MV_RX_STAT for magic value 0x8230, documented
> > 	  in latest datasheets for both PHYs
> > 
> > Changes in V4:
> > 	- clean up init sequence
> > 	- separate patch for fixing typos in upstreamed code
> > 
> > Dimitri Fedrau (5):
> >   net: phy: Add BaseT1 auto-negotiation constants
> >   net: phy: Support 100/1000BT1 linkmode advertisements
> >   net: phy: c45: detect 100/1000BASE-T1 linkmode advertisements
> >   net: phy: marvell-88q2xxx: fix typos
> >   net: phy: marvell-88q2xxx: add driver for the Marvell 88Q2220 PHY
> > 
> >  drivers/net/phy/marvell-88q2xxx.c | 234 +++++++++++++++++++++++++++---
> >  drivers/net/phy/phy-c45.c         |   3 +-
> >  include/linux/marvell_phy.h       |   1 +
> >  include/linux/mdio.h              |   8 +
> >  include/uapi/linux/mdio.h         |   2 +
> >  5 files changed, 230 insertions(+), 18 deletions(-)
> > 
> net-next is closed. Let's see whether the maintainers still accept your series.
> Otherwise you may have to resubmit once net-next opens again.
>
Hi Heiner,

thanks for the information, next time I will check if net-next is
closed.

Best regards,
Dimitri Fedrau

