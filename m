Return-Path: <linux-kernel+bounces-129647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 860ED896DC2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272C21F230DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093591420A5;
	Wed,  3 Apr 2024 11:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SleascXF"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF1139581;
	Wed,  3 Apr 2024 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712142692; cv=none; b=vCn5QdiObECxnKydJiyqMu1EHlR3fYb7ECf/LWOtnpWbapKfqBdWp1BCjHK+9CSuSyTNt7E4N2x+HcpsG49FukyLVx9cw/oCJCRGt9gX1oYkMTa0KEzWDoOf/9B7UxbJucnIH48Sw5miMboM6CWzPp1Upj4Rfb6p/0+luDawCMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712142692; c=relaxed/simple;
	bh=HYrEwCsTKUUPSTMstPgXVXggHLkZU1WHZaifX4qzm8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhiNvoIFq4ne36qTPMom3tbqLNyLaZagRnOaSZhZWWgHGODXvy5KFfu/rZPk8Qr4cH0Z6oAcxQhmpoFh8dyf5MVUqWGETPWRH8JW1aOLkpd7d64EiTXi2goMY0W/2kvjR7qpo1ua6Ms4ubHc5kOx/aQpqVBQRMm/G9Tsfd4QpTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SleascXF; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e0c29ad5dso381578a12.1;
        Wed, 03 Apr 2024 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712142689; x=1712747489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PPWyL/8K/BY0S344zl7ViimO1GnRHFRzJH9oqU0Xwvk=;
        b=SleascXFCtUAGBz7yQf2atGKREWWsySjBxhdqpwDKc1YLyoedJf/RKz6AKBQ2px8PA
         wpYRFa729pyVxx45CFw3Hi8vhRb42ctjUslBOT/4y2qsAYWBgepjJTYWz7xBINRPmKk9
         EmD/AEw/AIHYPmanyaAS7UqmpkjxCRRo2Ypy8K4+fRC2qQYO0YmwUNncZWYfRtYBwp1q
         HmFuTxSu0gfvSvoUl831B+JbqIWfo/FWbw22z3CSXTN9Dn/4vFZTHuf3bIWSLrI3Nfw7
         1g+75rXbvR1XkRro+h1xAVr3wNdOIIsuTr3fhw0sHqS9u+/HP4F83DoCms3JuE3LR8rG
         FnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712142689; x=1712747489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPWyL/8K/BY0S344zl7ViimO1GnRHFRzJH9oqU0Xwvk=;
        b=pUA3Flh4QA/K+9PFcRCDnms9Toq/SkglvfB8lvHHGxlwNxapkjOG0dwJNttNP0ys3M
         9qpmVXJ30o7l6aPM3NOEBtjgTyL2e+OZilUsLmpFlQWMgehv2tXwgG8vtyJJgMYDDxW/
         r8fakGWeveJSZUbqDnAJXgLQpg1rLeDLiptvjWy5btIC9b4bOD62wKh7CYzCevIYetSk
         JCr+Hi3SgwuD/DFV/33sjQzJNdoiawIDPINN/nspYvREC3YzcYQqyoqAQpJNtDn4tsu8
         WE1DQOVNV60rBjMEjKqJRdo0wqVWBsIg5TYuYAYPVLbmBKmZwpBqk5E80W81CMZR57gB
         5oNg==
X-Forwarded-Encrypted: i=1; AJvYcCVqYN6fsY6k9Z4ByMI536cgcq7eeaabUnh1UBcfO3L/MNNIysN79hVY2gDWG48BARFglh5bCIHfKonGFIstQL7pzoN8rMrJX9OF5sfbfJMDheeyABe/+A5OEejSqwoOrSJb9G6wTsr4aGLQgONu04lxocjZ9IL+sJhCS8QF31wZMiepv1pV
X-Gm-Message-State: AOJu0YwC8CWLS3MrCZJN1zxCKeJ14ubhN8DhVP5+IVY3x/o3Ih4KC6o4
	EDwXmXrlKyAT+6Ou1BaVAIRWKT4a/lPZbq7T22jdCVqctpaFJfJH
X-Google-Smtp-Source: AGHT+IFIdt/DeMggzvMvrxB3pr3IO4m0+qNSS0nfMS174yFpcTL7KqTIPP/ygiguKGBWPIAP+FAGzg==
X-Received: by 2002:a17:906:ce30:b0:a4e:8044:231e with SMTP id sd16-20020a170906ce3000b00a4e8044231emr1640424ejb.42.1712142688679;
        Wed, 03 Apr 2024 04:11:28 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d700:2000::b2c])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906285700b00a4e7d03e995sm2519191ejc.45.2024.04.03.04.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 04:11:27 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:11:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: sja1105: Fix parameters order in
 sja1110_pcs_mdio_write_c45()
Message-ID: <20240403111125.ef2jxiq2am4bbtmf@skbuf>
References: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
 <D0AC0465UQUJ.26171T9KETMCW@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0AC0465UQUJ.26171T9KETMCW@kernel.org>

On Wed, Apr 03, 2024 at 10:06:51AM +0200, Michael Walle wrote:
> Vladimir, do you happen to know if some of your boards will use this
> function? Just wondering because it was never noticed.
> 
> -michael

The SJA1110 uses the XPCS only for SGMII and 2500Base-X links. On the
Bluebox3 I have (which is currently in a cardboard box for the time
being, so I will have to rely on static analysis just like everybody
else), these links are the cascade ports between switches. However,
those cascade ports are only used for autonomous traffic bridging (the
board has a weird "H" topology). Traffic terminated on the CPU doesn't
go through the SGMII links, so this is why I haven't noticed it during
casual testing.

However, there are other NXP systems using downstream device trees which
are likely impacted, but they are on older kernels and probably haven't
seen the regression just yet. So the fix is welcome.

