Return-Path: <linux-kernel+bounces-8295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED91981B511
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C31F1C24198
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B6F6DCF9;
	Thu, 21 Dec 2023 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6FQjRuz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94709E54D;
	Thu, 21 Dec 2023 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-552d39ac3ccso3300553a12.0;
        Thu, 21 Dec 2023 03:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703158818; x=1703763618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bJViXlN43+iRsc7tQtP7onxHtkm7MD4wbNdvp5+uNq0=;
        b=L6FQjRuzG2z56YRznS4CdjT6BnAQEpk0hrVKcPVIUpON/r7a0IwdDGAmzSVzqJzr9f
         hJkzvHVxcbu3thDDqjFbOnc4Fa8XqOK+sClTuXSsLuOtJFccZUIVEhslpVTpbUpDw0MJ
         CmS4uyzm4XhzDtRkjir5ltE6MfFmZUCGVKr4xd2cotL/oyk2qYSRyA6RNklFpyW3P6Ct
         LwtELTNXpYckLhBB/VF0eoWXnXPXN6JVfCMhmPX6OnZ5UkEMNisKvoeU5z0ce7cDRTit
         aZZvtdZK0x/o/kCeLHiMpwBhtiy+NecZIm1he/5poMDYlklNVRIJJdZThU2lOfJqnvrD
         rMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703158818; x=1703763618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJViXlN43+iRsc7tQtP7onxHtkm7MD4wbNdvp5+uNq0=;
        b=UdXAWjyVY1zka5WNeSFqVFS8nXfyNFz8rlZ5v9XlWmc3SGbcyCl1HP+IK/MHRnn0dq
         vruR6/kGf/Ura+LwiGSFJg7z77v53bCpFTan6Qbpyhci7pDuU3Gz8NI3RJ3qOsH3ZMzo
         umtZ1JXldO7qG3bUaqFKnrxl5W8YjTaHXX8do7XTSljGldXse2xdDka75II75mXqs2xT
         JQsTQ5pJlw3UszFVEOFtDk97qdu8eIrsPgtuMq1/yMbf7Zl4TCPTL37M1gwyIpU/Kh1N
         oWOMzx7VW2vCj7dONUbs38A4JGToA+cUVnXUuNNf737aMcxiAE3AKoJMvBk/pOaoQWx/
         fSnw==
X-Gm-Message-State: AOJu0Yxkg8+firhke8HUjghDmO2ko8ptAPkblROpBNSxn+bGhBYiZkJv
	xwgVeNiWWZvkTKgaB1QETPA=
X-Google-Smtp-Source: AGHT+IEDP4KlQfXb97OTp6b1RY5N4TnRaYKKc8FDlEs3gNJ8KxokH95ou0MoSVqWAdcmuBYFXdvanw==
X-Received: by 2002:a17:906:5350:b0:a23:8949:66f4 with SMTP id j16-20020a170906535000b00a23894966f4mr645571ejo.59.1703158817606;
        Thu, 21 Dec 2023 03:40:17 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id fr1-20020a170906890100b00a236193fe3esm862124ejc.96.2023.12.21.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:40:17 -0800 (PST)
Date: Thu, 21 Dec 2023 12:40:15 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <20231221114015.GA109788@debian>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
 <c2433183-7893-43b1-8de8-9ed847f8a721@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2433183-7893-43b1-8de8-9ed847f8a721@lunn.ch>

Am Thu, Dec 21, 2023 at 10:53:27AM +0100 schrieb Andrew Lunn:
> > -static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> > +static int mv88q2xxx_get_sqi(struct phy_device *phydev)
> >  {
> >  	int ret;
> >  
> > @@ -208,7 +283,8 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> >  		/* Read the SQI from the vendor specific receiver status
> >  		 * register
> >  		 */
> > -		ret = phy_read_mmd(phydev, MDIO_MMD_PCS, 0x8230);
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > +				   MDIO_MMD_PCS_MV_RX_STAT);
> >  		if (ret < 0)
> >  			return ret;
> >  
> > @@ -230,11 +306,208 @@ static int mv88q2xxxx_get_sqi(struct phy_device *phydev)
> >  	return ret & 0x0F;
> >  }
> >  
> > -static int mv88q2xxxx_get_sqi_max(struct phy_device *phydev)
> > +static int mv88q2xxx_get_sqi_max(struct phy_device *phydev)
> >  {
> >  	return 15;
> >  }
> 
> This could be a patch of its own.
>
Will fix this in V4.

>      Andrew

Best regards,
Dimitri

