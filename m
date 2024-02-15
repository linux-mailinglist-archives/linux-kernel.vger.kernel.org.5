Return-Path: <linux-kernel+bounces-67680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB01856F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26A831C2231B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611C13B791;
	Thu, 15 Feb 2024 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WagP35sA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF341C61;
	Thu, 15 Feb 2024 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031036; cv=none; b=X/dD+w8W1pFw2+0hr+/37X2ifrCJHI+XwnUuG+Fgz8WZRY2XdtyO06FCE2rWvisImqxoGx41pPTdCU+hULPOtntz6W9icbFMWARHmo6cKoT6ZjrzF2qQDEWJx33/O6StfpDh82hUIhYUm4goUBn6FuacZtC73HGYxYcC+uq3up0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031036; c=relaxed/simple;
	bh=BJNmghe578Dr0q6jJp6nQZwXix12LotZLSHYuCxzj6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l37/zH/H0ho6t8a6K93OiWOXGwvSXPFBJkKkO8l7Ce+z7h4OYH+tgrzmHHWnHhBiGHr4e6EJ70vs9d9VGJn3KyWn6pSG3uyfRqcUHz8BKuywgEB84JvWBdKMWhJboM+LsMz3SUz+gayB/05qkSwBAf6e9EzanmXQUZi2MvsLng8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WagP35sA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-511976c126dso1776335e87.1;
        Thu, 15 Feb 2024 13:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708031033; x=1708635833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ky2ZahidDUXO2cGFTczfagUmFQuczB83RWWZ7vrowF4=;
        b=WagP35sAFLZFY3+tiWomwrXrqwaQTJtU7c6i4H3nT39tQ8hgl7Al3vjVrtrUW7wuwF
         ffysSslhXKSRZqKQhercTGGYdfEgB869FZD0h2z9DEk1aIkncUiLePqOzrntbH5EeJL3
         FipWfq97Bi+tM8y778HjTU2devVQHM1gBbEHTNdlzTUN4GYasFJ34T2pjWWkAWuyJy+W
         EciUsMEZXjUiO4ywEE7+MIArD3Z4RnJzz0t5/kEFprwjqpksQY7Ix4+T6MbyykmIHAK+
         HbRgLcgZIqFo0lW6l7Uk3UoEo6iVP/vvNpizypLLwURKA+yzfb/STQ1EQZS5z9kg8MNt
         dpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708031033; x=1708635833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ky2ZahidDUXO2cGFTczfagUmFQuczB83RWWZ7vrowF4=;
        b=HGkDSkeWmYorRbqZ+hqm3hn5T9/PXpv6Rk6JQVml/FDVewmQiv92+WT9jEQMwlUjms
         oelefI9wzIKKKix/efr/IZkcf9mvA1tIcrOEYd/OfO070KlIdr2uMMOOrwcfV17sOige
         1VnjNNVkvRzDnPQpbRvfqWkup8aTJMksc2gYh7ospuny1uB7CJTzL/161QIb8y7dJ5/p
         yAk23h39KrZI6jvtzvb/DfIuoZiPYqfTYrZv2HWH2NTkSjNeN5dfhmNdGy6uIJhTmfXS
         oY0p7kxWyikLoa2yFtyQ/ohYH+dpLA7LuEZoXInHuKlht3IliC1GXdjvEFL28JKWzW4W
         vd7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjpFjmUHDrpCOnS/BObsmdAR1tgq4IaYsJZ965UTX4Gmkdx7bdFIDVz/phKFDHuzmbaB2wQshFh+GghZml/bwUOciWJHTFEqlH8s2SOVjdRPA4q2885RkivwtYy+2zcDcdXFCP
X-Gm-Message-State: AOJu0Yy5ARX8MglQB/YlaTa5ca89yqmX2Kn5Fco3A6aKLZQcnzNDVCHe
	znZtjjS8EDMErT7ksKTKNWqkVPQuiH23ny7o1nmlcA/4E4CY1Bw+6UGoJYdx
X-Google-Smtp-Source: AGHT+IE0q8c+07du9QdFQWzS1GQSJ3+K8PVrqti7ePCn+9czzhmuN6wNeYywXIJZxS95bQrpPsWi0A==
X-Received: by 2002:a05:6512:1192:b0:512:8aeb:aaa8 with SMTP id g18-20020a056512119200b005128aebaaa8mr1890037lfr.49.1708031033197;
        Thu, 15 Feb 2024 13:03:53 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ps7-20020a170906bf4700b00a3d12d84cffsm903512ejb.167.2024.02.15.13.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 13:03:52 -0800 (PST)
Date: Thu, 15 Feb 2024 22:03:50 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 09/14] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <20240215210350.GB3103@debian>
References: <20240213213955.178762-1-dima.fedrau@gmail.com>
 <20240213213955.178762-10-dima.fedrau@gmail.com>
 <fe604759-d1cd-4a4d-ba64-69936b3e6598@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe604759-d1cd-4a4d-ba64-69936b3e6598@lunn.ch>

Am Wed, Feb 14, 2024 at 06:54:58PM +0100 schrieb Andrew Lunn:
> > +static int mv88q222x_cable_test_get_status(struct phy_device *phydev,
> > +					   bool *finished)
> > +{
> > +	int ret;
> > +	u32 dist;
> > +
> > +	ret = phy_read_mmd(phydev, MDIO_MMD_PCS, MDIO_MMD_PCS_MV_TDR_STATUS);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	*finished = true;
> 
> That looks odd. Is there no status bit which says it has completed? Is
> it guaranteed to complete within a fixed time? How is it guaranteed that
> mv88q222x_cable_test_get_status() is called at the necessary delay after 
> mv88q222x_cable_test_start()?
> 
According to the datasheet and the Marvell API bits(0:1) can be used to
check if the test has completed. Sample code waits 500ms before checking
the bits. If the test is not completed after the delay the corresponding
function returns with an error.

I just used bits(7:4) where 2'b1000 means that the test is in progress,
and setting *finished = false. I didn't introduced any delay, relying
on the reschedule delay of the PHY state machine. I didn't notice any
problems with this approach. Anyway if the test does not complete for
whatever reasons we get stuck here, right ? Don't know if this can
happen. Probably we should take the safer path described in the Marvell
API.

Dimitri

