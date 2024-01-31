Return-Path: <linux-kernel+bounces-46384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AF5843ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84751F2FCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0077F2C;
	Wed, 31 Jan 2024 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLPqnYep"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81476040;
	Wed, 31 Jan 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706701937; cv=none; b=GTlWqDTNe3XTcUfnskhdLIrBNdSIIMABa975En7xvFapSRx4A9a7gQh5nxFL4/Lj0X3yQlW80Php+TmQ2JrgFpy8vIXsoAHRMcf8ncHZe8xJh2mW2mKtrwL9F5lclYP4NII53QwVGdlsmzxa5GBirNMZD4EtA1kstcmDQ/bGxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706701937; c=relaxed/simple;
	bh=pysEqJSi12OgIxziInUigUCVr98LVwHAqnVaGuYDmmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8yU4w0dkwguYN1DPYRews/4uDwvz7TEq+EBeDlpA7YUgdoi+XsUPa/EsY6sdm9p2lWrbl1P7N8pWKHa66Ule9VhZsv3zYZV2FAK3zGurxH2r3GMfKq7/lpFRv1oTzmmspoToQidj6mNA63ObC4LdLZ4HymMao6dqXgw63v8l3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLPqnYep; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5102a877d50so5735365e87.0;
        Wed, 31 Jan 2024 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706701934; x=1707306734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SDlah67sh5gJ9ynKDz3ysjr2o7CYUk88hIiX0azAyyc=;
        b=cLPqnYep/jVY5WhVhBjgRJDbFZuFGyoLkPhP2RlaLMlyHLQKcwxVAU2OvLzT61xobD
         BggAs2CeXMw+NgiEL2C1ozuROSrjQeTo4O3HyeGqDdJnbMxebusc/bOtkY6zL+aZBQPv
         3+NXzCIVNuOOC3hAzNey00Y3Vpt9N6yYNJVaOBl7047c80eqaMgfioR7n0bulWF0Q0a5
         N6PeSzJYW+cW61JlY2XzxBZCfKAHLUW3pqzBpt8US4TqvR5TKpZkESBVuNbJLYeLx2wH
         z9YAWT0TEb3HQA7U3OMUjZRv6ASviG4ir+rM20jbyqrOnTiRURgXzOKRlHvUY9i34SNf
         s4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706701934; x=1707306734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDlah67sh5gJ9ynKDz3ysjr2o7CYUk88hIiX0azAyyc=;
        b=grla9Ot6qFDmkZKDYLF8G37+8ZuFgQV+ON62Qaf/okJx51KMuQZVDfsObHlDiSA/Dl
         WDiMzYWHMGC8dgq6dFU78fgdwsoxLXd3+VBuahyApS7qaWEoCKdgWVPvXnf/FfHlkiKc
         vqOIerF2M4ym+fh8YjM+xacGgeYRmFA+ac+cN642/+taDwcvRW+5gG5a+yI12slLb2Fx
         AQpqrD8IJxHYeZX//h3xQZsKLGYIPjcs0RWf+V04VbH4Om4TfSUxA8qGtOzPEunh3bK9
         FcYEFLdoTQHX8FqvlXq8K4qROtsN+hXqYI5FUdyxlQYb0z5U/7foIn8ltqvcgpCPh+YF
         uQLA==
X-Gm-Message-State: AOJu0YxOpeLvFU6CS5tBJ0Cunpq4japTqA8ZPxKVCiDFKglu31hS3LzR
	t+2dqIwRTb7Ml8p8sFJOJR2GbnOZWFi+hUckReMofBfYqzJ7zFCN
X-Google-Smtp-Source: AGHT+IGT/GhBNY8zNxq8qrY/QrJrCfHAKHa2GeBrruLDDuJpKfIDSnvo8RECdhAB5l3rhzcE/mHJag==
X-Received: by 2002:a05:6512:1095:b0:50e:a9c0:70a6 with SMTP id j21-20020a056512109500b0050ea9c070a6mr1132993lfg.43.1706701933731;
        Wed, 31 Jan 2024 03:52:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXgxSyJMXOvbCIDB0wzyLHpsYcK4/T9b5Q6W/hyvfAmUa/6cSdxDzdOolPJg5uzFBHRg4i9xC44AzQHm/Qspd2E7peB3o2PhnSnP6vZ776CrE6rJIyj7OmI2t9rAyfGN0BFUAhHXEXj6ujBvSGfMnlwfQOfOnL87du0FxciZU2T3FpJ4TQ74pXT32kWocurP4eH4jBPvr7xzkHzpy4blqOq4wrGKphewAf5X7mxq7P9OtjY9HEXjD027KFbvTWop6vvMwYGFd0nUxqEubJs7EV/P6lQj8WEukj5IDv+2H3TeN3QiDVbTBg7h1kKd7BM0LzYz66Mdg5u6HBIbyYMZIZ5wOlHx8g4vZkseq1faX49F1Zan54fI3sg1J6Tbgz86A==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id d15-20020adfa34f000000b0033ae9f1fb82sm8946992wrb.48.2024.01.31.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 03:52:13 -0800 (PST)
Date: Wed, 31 Jan 2024 12:52:11 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240131115211.GA111590@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <Zbi+5ymzbL9sckdi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbi+5ymzbL9sckdi@shell.armlinux.org.uk>

Am Tue, Jan 30, 2024 at 09:18:31AM +0000 schrieb Russell King (Oracle):
> On Mon, Jan 22, 2024 at 10:28:41PM +0100, Dimitri Fedrau wrote:
> 
> 	int tmp;
> 
> > +	switch (attr) {
> > +	case hwmon_temp_input:
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > +				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = ((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK) - 75) * 1000;
> 
> 		tmp = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK, ret);
> 		*val = (tmp - 75) * 1000;
> 
> > +		return 0;
> > +	case hwmon_temp_max:
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > +				   MDIO_MMD_PCS_MV_TEMP_SENSOR3);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = (((ret & MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK) >>
> > +			MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT) - 75) *
> > +			1000;
> 
> 		tmp = FIELD_GET(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
> 				ret);
> 		*val = (tmp - 75) * 1000;
> 
> > +		return 0;
> > +	case hwmon_temp_alarm:
> > +		ret = phy_read_mmd(phydev, MDIO_MMD_PCS,
> > +				   MDIO_MMD_PCS_MV_TEMP_SENSOR1);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = !!(ret & MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT);
> > +		return 0;
> > +	default:
> > +		return -EOPNOTSUPP;
> > +	}
> > +}
> > +
> > +static int mv88q2xxx_hwmon_write(struct device *dev,
> > +				 enum hwmon_sensor_types type, u32 attr,
> > +				 int channel, long val)
> > +{
> > +	struct phy_device *phydev = dev_get_drvdata(dev);
> > +
> > +	switch (attr) {
> > +	case hwmon_temp_max:
> > +		if (val < -75000 || val > 180000)
> > +			return -EINVAL;
> > +
> > +		val = ((val / 1000) + 75) <<
> > +		       MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT;
> 
> 		val = (val / 1000) + 75;
> 		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
> 				 val);
> 
> ... and therefore no need for the _SHIFT constants.
>
Will fix it.
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

