Return-Path: <linux-kernel+bounces-14220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632B821956
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A58F0282E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D3BD268;
	Tue,  2 Jan 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exA+CwDS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F53FDDBA;
	Tue,  2 Jan 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40b5155e154so122356065e9.3;
        Tue, 02 Jan 2024 02:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704189643; x=1704794443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mqai+rY/ffESeUg8fMMeDJCZIul5tupdu5IdhMlAw8I=;
        b=exA+CwDSishrsiQ/uKG0aly3opSB5ngS4ovNxiyUm0oStLob0XozaH/c23PXzTEyQG
         JUtg5qOqek9h1/E+IsiHrfJmFQb+NwyyERP9yDcqb/FZvnc5S9KPnreWd9hZPJpCtaHw
         p7GWs0eXIUmm5mFKQk0qvCttr3ZSAUHuiTKWzS9Zpl2YdUpbqjKrzZQH8Tbpdo5Pjxwe
         S1H1YZt4+zaF5tRR5RGVLpNw7gtZxrI14MQVaUs1JbQHSwoHSc9kCF5B/ovXvw2zWiDh
         bxjrfK0iIAzsPQ3gwWZwdPqVteNtnH0lVjfx6ax3hWWLxvyyLsRqI0JWw63VeLh2QQdX
         1pAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704189643; x=1704794443;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqai+rY/ffESeUg8fMMeDJCZIul5tupdu5IdhMlAw8I=;
        b=WFNKfdIsGSdkrhvUOiJ9KLkNiMlNaqtIAo9onW3GfQo3AD9o9Az+5Zq1tjoVIcDmjq
         qi6WAh9DMFWUEvl79vVoAP1cLuoEHCBxCa9RaZrzsKCjZwZfKFEKhgt401z+1zNB7XIB
         WFdcHiyZ41X9jk0qjm0ZoY8RxXhWj+anv0lDSPFB6rK8XIJrplIvKoRlvMSw/CunsUxR
         lmCLQm+/8vAd+d3Woqu31dECH0vTPUOZ3rwlpvPQH65l3vpTDW9IeDIAYdzPpciVy0Ji
         WYog/lcJ3P00Oujmiuham6GcVCB0Aj3ZaSmFJRDGpZ6KG2HLi+VcNcMx5Lp5iGBVA7AM
         hqaQ==
X-Gm-Message-State: AOJu0YylVMNmq0SvC+fjbyEX1Y9RMFRQx74NDoO6JfnNFuIW33STB4aa
	yNafbQkHrgdcPk5CDygMSMM=
X-Google-Smtp-Source: AGHT+IHB3QijJnFdFA6sKxwyTuGYHXtQ8LTwNQ6t3x3hGyYt1/zZqhqxMJt9ihEyCrXf9GQhagxgow==
X-Received: by 2002:a05:600c:1e8e:b0:40d:88a1:1e68 with SMTP id be14-20020a05600c1e8e00b0040d88a11e68mr1371596wmb.229.1704189643289;
        Tue, 02 Jan 2024 02:00:43 -0800 (PST)
Received: from Ansuel-xps. (host-87-21-250-146.retail.telecomitalia.it. [87.21.250.146])
        by smtp.gmail.com with ESMTPSA id p17-20020a5d48d1000000b00336e15fbc85sm17005465wrs.82.2024.01.02.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 02:00:42 -0800 (PST)
Message-ID: <6593deca.5d0a0220.416f0.a39a@mx.google.com>
X-Google-Original-Message-ID: <ZZPeytckeEiBEWQu@Ansuel-xps.>
Date: Tue, 2 Jan 2024 11:00:42 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: at803x: better align function
 varibles to open parenthesis
References: <20231217235011.2070-1-ansuelsmth@gmail.com>
 <ZZPdGnJQ1V/E8zBP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZPdGnJQ1V/E8zBP@shell.armlinux.org.uk>

On Tue, Jan 02, 2024 at 09:53:30AM +0000, Russell King (Oracle) wrote:
> On Mon, Dec 18, 2023 at 12:50:11AM +0100, Christian Marangi wrote:
> > -	if (qca808x_cdt_fault_length_valid(pair_a))
> > -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A,
> > -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A));
> > -	if (qca808x_cdt_fault_length_valid(pair_b))
> > -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B,
> > -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B));
> > -	if (qca808x_cdt_fault_length_valid(pair_c))
> > -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C,
> > -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C));
> > -	if (qca808x_cdt_fault_length_valid(pair_d))
> > -		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D,
> > -				qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D));
> > +	if (qca808x_cdt_fault_length_valid(pair_a)) {
> > +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A);
> > +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_A, val);
> > +	}
> > +	if (qca808x_cdt_fault_length_valid(pair_b)) {
> > +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B);
> > +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_B, val);
> > +	}
> > +	if (qca808x_cdt_fault_length_valid(pair_c)) {
> > +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C);
> > +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_C, val);
> > +	}
> > +	if (qca808x_cdt_fault_length_valid(pair_d)) {
> > +		val = qca808x_cdt_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D);
> > +		ethnl_cable_test_fault_length(phydev, ETHTOOL_A_CABLE_PAIR_D, val);
> > +	}
> 
> Maybe a static function for these?
> 
> static void qca808x_get_cdt_length(struct phy_device *phydev, u8 pair)
> {
> 	ethnl_cable_test_fault_length(phydev, pair,
> 				      qca808x_cdt_fault_length(phydev, pair));
> }
> 
> or going via 'val'. Either way, repeating the same two lines multiple
> times seems a bit suboptimal.
> 
> Whether or not you do this:
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
>

Hi, this has been merged, I will send a followup patch to address this!
(the function has to be touched anyway as it's used by another PHY
Family)

-- 
	Ansuel

