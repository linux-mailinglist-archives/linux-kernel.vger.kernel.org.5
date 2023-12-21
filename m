Return-Path: <linux-kernel+bounces-8560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA081B968
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A656282EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2026D6D6E8;
	Thu, 21 Dec 2023 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd9y6upk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA866D6D7;
	Thu, 21 Dec 2023 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so1029532a12.3;
        Thu, 21 Dec 2023 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703168199; x=1703772999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIEY4iCG9As6cQdv6wbONXBVAHgbPQaouukGekCBLE8=;
        b=hd9y6upkbIssdtp6skphS4rLlh/m/mv9v/tNdXXJfAfZTJZNv/MwH6J0JcePDXArsa
         KXHxQ3tu32w/8CJlvizVcrdHqDhH8fvct/vQqqQpdz/kxxMaE0zZdD1SI4N9zczB/ut1
         v1SzRusSCa5v87gsIt5PxqZONby1YkZfQHZ/yIGgzNNCPAdLhRMfN4nVjelGVK2tmEXg
         XrqrRcpLptljg+TLfyudsbBdTdfEQ+VtL19oCYZxFMpSlzFJu5K0S26BLCuc7J8vUQRX
         92Z5CRaBqd1L+8MtHIJZ44NTTlzodO2RKHmMCzwZX1S/mNSDpBYh9GZKPGapUF4rLUk+
         vC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168199; x=1703772999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIEY4iCG9As6cQdv6wbONXBVAHgbPQaouukGekCBLE8=;
        b=dzceUa7sKFbS4NnyEfQy+BdaQyC++rbdin4WQZ7a25UQWUcdhIwLiynY/ZS6sRWOX2
         ll/t8nrIlbMOgALuSW+jDTJZ3EjtuiJDufOa6eXQ4rpDnLqU+3zB35qRzr1WAGR79298
         CNQJGwvBMMfMVQ573UIm0hd5mmoNgmaVsidZVswX00xJgWVzPq2XNWUnG2oXtxuWpcPf
         AimphVijrXKpQg0iajYlnvBT+EiDTGNPYp+CpaEfJ+QpnwwPkCG6ndDj0iNvJD+4l013
         B7LKeypR+AfR0tZjr+Vl1fZecgGiewu5MFbXPJZjdhCXCLnN+LhKcavilb5uaYlE1GRk
         jjPA==
X-Gm-Message-State: AOJu0Yw6AxQ4JX6SiVqNtjkefRWMEXRWN/NwrWbFpJexnuU6EUdtZM9v
	7P03eVqtOfeM2ttzQbyGiYc=
X-Google-Smtp-Source: AGHT+IFRIdfRI8THjDslvYwU3U7ujKzlabDcX+NozESRFAg62HS2QVAClRNzJDoYXL7uUgYwZbK2Uw==
X-Received: by 2002:a17:907:9703:b0:a26:97dd:2110 with SMTP id jg3-20020a170907970300b00a2697dd2110mr1421320ejc.62.1703168199344;
        Thu, 21 Dec 2023 06:16:39 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ie17-20020a170906df1100b00a26ac1363c8sm374892ejc.94.2023.12.21.06.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 06:16:38 -0800 (PST)
Date: Thu, 21 Dec 2023 15:16:36 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <20231221141636.GA122124@debian>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
 <ZYRCDTWgHbM2qAom@eichest-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYRCDTWgHbM2qAom@eichest-laptop>

Am Thu, Dec 21, 2023 at 02:47:57PM +0100 schrieb Stefan Eichenberger:
> Hi Dimitri,
>
Hi Stefan,

> On Thu, Dec 21, 2023 at 08:28:51AM +0100, Dimitri Fedrau wrote:
> > Add a driver for the Marvell 88Q2220. This driver allows to detect the
> > link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
> > master and slave mode and autonegotiation.
> > 
> > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> 
> I tried to make your patch work in my setup but I'm unable to force a
> link speed. Were you able to force a different link speed with the
> following command?
> ethtool -s eth0 speed 100 autoneg off
>

I tested following modes, which all worked:

ethtool -s eth0 autoneg on master-slave forced-master
ethtool -s eth0 autoneg on master-slave preferred-master
ethtool -s eth0 autoneg on master-slave preferred-slave
ethtool -s eth0 autoneg on master-slave forced-slave

ethtool -s eth0 autoneg on master-slave forced-master speed 100
ethtool -s eth0 autoneg on master-slave preferred-master speed 100
ethtool -s eth0 autoneg on master-slave preferred-slave	speed 100
ethtool -s eth0 autoneg on master-slave forced-slave speed 100

ethtool -s eth0 autoneg off master-slave forced-master speed 1000
ethtool -s eth0 autoneg off master-slave preferred-master speed 1000
ethtool -s eth0 autoneg off master-slave preferred-slave speed 1000
ethtool -s eth0 autoneg off master-slave forced-slave speed 1000

ethtool -s eth0 autoneg off master-slave forced-master speed 100
ethtool -s eth0 autoneg off master-slave preferred-master speed 100
ethtool -s eth0 autoneg off master-slave preferred-slave speed 100
ethtool -s eth0 autoneg off master-slave forced-slave speed 100

Without setting the master-slave option it didn't work. I think its
mandatory.

> Regards,
> Stefan

Best regards,
Stefan

