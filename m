Return-Path: <linux-kernel+bounces-16697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A2A824295
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CFA1C23EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB222333;
	Thu,  4 Jan 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NT6ajKdb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAD224C6;
	Thu,  4 Jan 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so425013f8f.2;
        Thu, 04 Jan 2024 05:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704374160; x=1704978960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kWojNCo1dQUH3XLkmW/tyezRJ83aZaGYWSmb6/rILt8=;
        b=NT6ajKdbu2cF2Yte3+LOcNk5l53G690JVXx5xAgIYYtpvuCD7d5qBX8NKMV288fVWN
         wHX6udtuQhieIFaZ3WgF0IvInsUP/nKTHTxGDZwkYHfPiyKvtfbaQckJsQjlMZ05ilk5
         raEJva5h0tdHHf1UXpKKe/XzD3H4nILjcL27xRSkm2aGzbRj49H103wH8o6wto/KUj2b
         Yh0fu8AC/n5cjmF+B5z6xj+8M9dY/n1IbCD3wJZ+xLSokJQs/7MMugwyrJMWE9ChXqkP
         nFjsBtK1Uf6PNbe64LVUvcsO1ganwQTudk6VxnQ03aK6bxLQC6yySrAJovqYQ/4K7I8N
         3imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704374160; x=1704978960;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWojNCo1dQUH3XLkmW/tyezRJ83aZaGYWSmb6/rILt8=;
        b=h7ZabqSmc0szsLJl5ofpynBbprmrLCN3Qq6nwQ8PUv7B4ybynvLGB+vvR5cm+QKnEg
         KmJS2c/b4vtjTA7MsdY3LE4Nn6R/Z27D3cKhXHvEpqXX+aVsjYHBpERBtZQVFj0FIsMt
         TXZxYpYn6qaYlnDf7xGdTsVaSJpJpAXjuCfVPN/a4rWA2DnYEacAzypl4vfiXYcto4HO
         dxBf7txgQgTFlRmlb2Ibi2pmsKwji1Pim6uIv1Yad1X0gAUPQuO2sPjBd2Q9NFpsra59
         xPATc04rqkmfm6aZNTLSY4B/9yA8SKGhO+hNGYAAiwYhnck13MeAXeZPYuxI4/0UMjXU
         +kmg==
X-Gm-Message-State: AOJu0YwGb5mkT8k3+7lGptNenm0dsA5JK98XcPtxQ+RseSxc+W1egwEo
	+Jq7PH+uvaEU3uJb78Bak1Q=
X-Google-Smtp-Source: AGHT+IE8jUkcYnOjmr3yAczvJ+m3RLkNe7orX41ZA9IfLh/6YX9haGUm5h3v+m8NVCC1iLbE7qmw3g==
X-Received: by 2002:adf:f544:0:b0:336:e161:5a with SMTP id j4-20020adff544000000b00336e161005amr189251wrp.137.1704374159874;
        Thu, 04 Jan 2024 05:15:59 -0800 (PST)
Received: from Ansuel-xps. (host-80-116-159-187.retail.telecomitalia.it. [80.116.159.187])
        by smtp.gmail.com with ESMTPSA id c18-20020a5d4152000000b0033609b71825sm32777460wrq.35.2024.01.04.05.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:15:59 -0800 (PST)
Message-ID: <6596af8f.5d0a0220.1b372.4858@mx.google.com>
X-Google-Original-Message-ID: <ZZavj5TnPo9RitdF@Ansuel-xps.>
Date: Thu, 4 Jan 2024 14:15:59 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 2/4] net: phy: at803x: refactor qca808x cable
 test get status function
References: <20240103124637.3078-1-ansuelsmth@gmail.com>
 <20240103124637.3078-3-ansuelsmth@gmail.com>
 <20240104130337.GG31813@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104130337.GG31813@kernel.org>

On Thu, Jan 04, 2024 at 01:03:37PM +0000, Simon Horman wrote:
> On Wed, Jan 03, 2024 at 01:46:33PM +0100, Christian Marangi wrote:
> > Refactor qca808x cable test get status function to remove code
> > duplication and clean things up.
> > 
> > The same logic is applied to each pair hence it can be generalized and
> > moved to a common function.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/phy/at803x.c | 65 +++++++++++++++++++++-------------------
> >  1 file changed, 34 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
> > index acf483fa0887..b87293ee736c 100644
> > --- a/drivers/net/phy/at803x.c
> > +++ b/drivers/net/phy/at803x.c
> > @@ -2037,10 +2037,39 @@ static int qca808x_cable_test_start(struct phy_device *phydev)
> >  	return 0;
> >  }
> >  
> > +static void qca808x_cable_test_get_pair_status(struct phy_device *phydev, u8 pair,
> > +					       u16 status)
> > +{
> > +	u16 pair_code;
> > +	int length;
> > +
> > +	switch (pair) {
> > +	case ETHTOOL_A_CABLE_PAIR_A:
> > +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_A, status);
> > +		break;
> > +	case ETHTOOL_A_CABLE_PAIR_B:
> > +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_B, status);
> > +		break;
> > +	case ETHTOOL_A_CABLE_PAIR_C:
> > +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_C, status);
> > +		break;
> > +	case ETHTOOL_A_CABLE_PAIR_D:
> > +		pair_code = FIELD_GET(QCA808X_CDT_CODE_PAIR_D, status);
> > +		break;
> > +	}
> 
> Hi Christian,
> 
> I don't think this can actually happen given current usage,
> but if pair doesn't match one of the cases above,
> then pair_code is used uninitialised below.
> 
> Flagged by Smatch.
>

In theory it would trigger a warning for the switch case not handled?

But yes I will add a default case.

> > +
> > +	ethnl_cable_test_result(phydev, pair,
> > +				qca808x_cable_test_result_trans(pair_code));
> > +
> > +	if (qca808x_cdt_fault_length_valid(pair_code)) {
> > +		length = qca808x_cdt_fault_length(phydev, pair);
> > +		ethnl_cable_test_fault_length(phydev, pair, length);
> > +	}
> > +}
> > +
> >  static int qca808x_cable_test_get_status(struct phy_device *phydev, bool *finished)
> >  {
> >  	int ret, val;
> > -	int pair_a, pair_b, pair_c, pair_d;
> >  
> >  	*finished = false;
> >  
> 
> ...

-- 
	Ansuel

