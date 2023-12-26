Return-Path: <linux-kernel+bounces-11588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549CD81E8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A44B1F21A29
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612434F89D;
	Tue, 26 Dec 2023 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3HhA8a6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984D4F880;
	Tue, 26 Dec 2023 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2370535060so991161866b.1;
        Tue, 26 Dec 2023 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703610312; x=1704215112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=COhuaSnIAGJCtWBOds7qZex5HBBn0HSMvsViTbnhv0E=;
        b=N3HhA8a6tA9u36WAPko6snk32OizhcW6Gr1sAzVjmyru4F4NIM8PJ4hw/Q6lDRp9KE
         TinOtXBgXkpmTsoAuTS4l0423vJbFRQgqu5zxpNNfj2h3bWFMDzWLvcCE0FLH4o2c79B
         6QdFgIDnejek9MYoWQgxNTiyLYLMBVFp4d2KXZqLjMQg59f7kiRa1rFP1BNDAE5ypJpK
         xL+AUhg8QhCi8sYpNAW+b4SNY2LToKOvQmA7/0G8ufokN/lhpBC3tGGLQVi33gG8A4XF
         C4Fir7TH9gjbC5ntCvi9JyovVnRfiGhRntN0Em1QBQCiCsLcILKrQRC966hUAnqMxHF5
         8k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703610312; x=1704215112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COhuaSnIAGJCtWBOds7qZex5HBBn0HSMvsViTbnhv0E=;
        b=o9ln0qaixPfL4JxC0WiK9xmme85jCV8OqFLtbg/GdSssKN7OXx+9+9v2Oq7xgn0Mtx
         pwKD6Hty6Irn6J2YTJehPQSV9XZ4qCW3bo2C8C6jW/v1ky63ohYxE/n0yfU553gH7AhQ
         5oquGVyuGScQzLKgeCrN/H+DoUHJNXGysYRecf3lz/B3pLqMFDxHOAo4EWizsAFkVbPR
         1WckJdXuJSCgNS8FXUBqNrU1QIvs0+BxUswRkgVTGDaF0JLytLvofhCihp8rzPd8q14a
         GVfA4PBuU8sAdRXMZRLgCZLVx+R/Vf0WFECQTSt8Hr0L7/x6GzmO9Xc2whUwwlAit9/e
         7xCQ==
X-Gm-Message-State: AOJu0Yy5Jt/OCnd421DeximpOnQJAIQ88v0xVJL1GNx7wZ9y+7zhQaVt
	qeNSQ5wG68Ig5u+k7yEBrisarWMltxA=
X-Google-Smtp-Source: AGHT+IHCnYr/oKelM3fbBjtgXRroiTOhdkKQ01PSERrVoviHPoOEbYtCDr/ucndouUf4+I9wIPLXwA==
X-Received: by 2002:a17:906:57c1:b0:a23:54aa:311b with SMTP id u1-20020a17090657c100b00a2354aa311bmr8174950ejr.34.1703610312230;
        Tue, 26 Dec 2023 09:05:12 -0800 (PST)
Received: from skbuf ([188.25.255.53])
        by smtp.gmail.com with ESMTPSA id h22-20020a17090791d600b00a22fb8901c4sm5950374ejz.12.2023.12.26.09.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 09:05:12 -0800 (PST)
Date: Tue, 26 Dec 2023 19:05:09 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: PHY issue with SJA1105Q/DP84849I Design
Message-ID: <20231226170509.vysmvg6soz54xekb@skbuf>
References: <CAMty3ZCn+yGr2MG3WYg+i4DsZWk5b-xEw0SDvNbeGzs6pMwjfQ@mail.gmail.com>
 <20231222145100.sfcuux7ayxtxgogo@skbuf>
 <CAMty3ZBZNugYmKMjDdZnY0kFMeEb86uzSg2XL9Tn6Yb4t-TXKQ@mail.gmail.com>
 <20231226153055.4yihsmu6kiak6hkf@skbuf>
 <f7b894d0-9378-4c4d-8a3e-e35bb9593c72@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b894d0-9378-4c4d-8a3e-e35bb9593c72@lunn.ch>

On Tue, Dec 26, 2023 at 06:00:17PM +0100, Andrew Lunn wrote:
> > The code which should have prevented this from happening is in
> > phy_attach_direct():
> > 
> > 	if (phydev->attached_dev) {
> > 		dev_err(&dev->dev, "PHY already attached\n");
> > 		err = -EBUSY;
> > 		goto error;
> > 	}
> 
> The problem might be dsa_shared_port_phylink_register():
> 
>         err = phylink_of_phy_connect(dp->pl, port_dn, 0);
>         if (err && err != -ENODEV) {
>                 pr_err("could not attach to PHY: %d\n", err);
>                 goto err_phy_connect;
>         }
> 
>         return 0;
> 
> Since it is not -ENODEV, it just keep going.
> 
>       Andrew

"Shared" ports are DSA and CPU ports, the report is on a user port.
There, if phylink_of_phy_connect() fails, we try dsa_user_phy_connect(),
but only if the driver provides a ds->user_mii_bus, which sja1105 does not.
So the failure should be nice and clean. It might be worth posting a
full boot log though, since this is really strange.

