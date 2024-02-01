Return-Path: <linux-kernel+bounces-48511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 441B9845D1C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EFF28D7CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293FB163AA3;
	Thu,  1 Feb 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQf1BBrm"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCD3626BE;
	Thu,  1 Feb 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804275; cv=none; b=DfR99a2HHHi/usBAWBcLV0OmrHkRsjlK8CRJqv66csydikVXjyho28t3v7dq6tTn0cB35qx80zTYYDpJs4iIwqRGgKndMirhI1vxtD1bgJt8CvMiCe7XXzeZgX8NlisuYcIQnYTtuIXSNoLTMsI9xu7s6bFNsXsaVwJSr9VwWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804275; c=relaxed/simple;
	bh=jVgPnk47a0kmMu1SnTVlETox5FpEracdHmxLPBBbb0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTuv//Ga7CACy722Qzi/8kRXUMJdK6Z9hj+GTMhTEiZARTX70jR2dPYeFHElhD6OBEK4lFPhMxb4fMgoTIWVfPObHF6oN6Rmjn5ICHz09x5MfR9P0XQkQ38kebPtxbgfGew5iHsT4ZDVuhSk90y2cONJiGP1Y5KNK2GNaKL6ZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQf1BBrm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso10125725e9.0;
        Thu, 01 Feb 2024 08:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706804272; x=1707409072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2bm7C4zBaRxEHtHnijKpshODpaBuCUwJZ3uIJhW1Zwk=;
        b=iQf1BBrmfdqvtScJCM+3XPt85nxA8yryNFY3y+M0Wt7NnAuCfFk2L3PyB0XyT58S/i
         H/oMtneaE3lqB5o8LEiaajb6EkE9Nt5AzlKqWEYA2wueCMf+m1zNBPizOKP//OmsQss9
         4EJkQ2lGKstyg+cBqeAOmA6PRI2ZRW7CGSuDKgPUZPz7URIvdp/dKVYtEwtp8Sk6oBk9
         2i1w6hJZS/MYqpVhHFzfUQvyfcW06vVtYvGWBbTcyYjB2hDgfKXNN5GzcoDRHfKJDhE9
         FFpigdvmS8ixqjvw4Zpdx+gxqgioAAEy7X8eCE0/wIdY5AN/y+KasZ1rHpJpLNfOd8NB
         SMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706804272; x=1707409072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bm7C4zBaRxEHtHnijKpshODpaBuCUwJZ3uIJhW1Zwk=;
        b=oBwnRCK+us97KG/VdKE88O/FxNG5U4+0nZ4wASVS0Jr+Smc/1zhvScSP0TdD45q+mc
         AuQ9LfH1EBIJ1lmohb6+R9M6gRiokZlgyGByRhnLWVkohbk1mkDAFJk4M3wgkto+zO4j
         elQRP4TRZ1srisxlnWX5nmIV/uRm7oM2vewx2fAUEvvUsnMcY2rjtSRKOfWxfKJSY0t1
         Nn16CIOV+SRxVZbfnWpcuHof59AtVx7e/9orkidmmpwZQxngY9jDCuOVrovecJlb3ciC
         afBJZGcC/IGMJ2MF1eGTd6ogfvYlTU4DCw+nJB6y2Ki/A71HHpcIM0Ry2Ho7BRmbAU6C
         MvKQ==
X-Gm-Message-State: AOJu0YzRxqq3auGKoZjh2yH6T0ZlLjUY9dBOKh0yX5SBQLFBKxPpdoIE
	Bu/OO4XK7O7PQ1tqP+T2thMq0Dn8duLHukJFw78VsiFywUuw4OsO
X-Google-Smtp-Source: AGHT+IE5JBsOUNO+M24oDIwSLbHf3lrV+nWcnPe3JATfJ8sR9G8Ui48KTiv0utw5fmmtYSapTfuRjA==
X-Received: by 2002:a05:600c:190b:b0:40f:bef8:2c87 with SMTP id j11-20020a05600c190b00b0040fbef82c87mr1447351wmq.39.1706804271957;
        Thu, 01 Feb 2024 08:17:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXKr4L2sAmDkLE2iJ0MDwJlxLRc/8Q5Nz7mXGkv6l4wWI20MmjGuAZTPPz4K2T3EnY2zttITtp4Jr+1lkaQxhPvZSVgzJOFCDug/Tk6JxUfX40t2Iyjr5AiFK5cw8WV5Ds4uZH+3N7bKs9tHIAJNpaRZBu6udF+RWUNwm84kHc3LpALPUPw7f98MpBeM+xPDbrXmbcoRzpFNslE0S+xm5Me6TRunYhPOH6UfKpCN3WbTC7sK6sVnfYcHmsye81G9+DFQ+GWZrIuXymsl9UUmlUyit7m4dOcjfS+M2DwJ9JObuYiGyiWRjmog0SwrHnAwaMD2buzMDOgSUz1pKsCU7gO8fI3AeLeTfZ+5Pzx9on/Jw8CQgh38O7K2IJprIMqZYqyNg==
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm12463234wrb.111.2024.02.01.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 08:17:51 -0800 (PST)
Date: Thu, 1 Feb 2024 17:17:49 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jean Delvare <jdelvare@suse.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Message-ID: <20240201161749.GB48964@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>

Am Thu, Feb 01, 2024 at 05:18:23AM -0800 schrieb Guenter Roeck:
[...]
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
> 
> Not that it matters much, but we typically use clamp_val() to limit
> the range of temperature limits because the valid range differs for
> each chip and is otherwise difficult to determine for the user.
>

Will fix it.

Dimitri

