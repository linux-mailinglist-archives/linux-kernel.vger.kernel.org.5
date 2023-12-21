Return-Path: <linux-kernel+bounces-8302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D5C81B526
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65CD1C2452A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8296E2B0;
	Thu, 21 Dec 2023 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+5QWSzc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894D1DA3B;
	Thu, 21 Dec 2023 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2335d81693so127148866b.0;
        Thu, 21 Dec 2023 03:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703159113; x=1703763913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv3qX1FhzTLBhx/de5Ik2+RkLdw2EvpPJKlWc4zn7Zg=;
        b=P+5QWSzc5h99Gmipp0HHLbW0SCNW1MzY7ng70Mp7URkTFGsna8vcj1YO52458PQlu3
         OdosLVAcasjV1vxHj8OAwsCGqwjIeDHF0myw6SnxzdYLQL3dAqvch8MyUGKw72gzHN+m
         7WRnBXl54l8eFPAx+n2+yGnSWLFZ/xbNk5w/XJsHtNUcCT6eckyNG24c206JFymZmHpb
         +1frOl92W+pFhZDZ1EooWEMZcxNigTGbi6VYND3x2SFJBtMIvBXABj6P+s/zl5to4IuM
         cQCbc1rDTyrpGntgk9nm0gLc1hdbCu/cz+9SXUj5BP6DcyEOEF6XZl4IUcx8W2TKMBDJ
         ayJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703159113; x=1703763913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv3qX1FhzTLBhx/de5Ik2+RkLdw2EvpPJKlWc4zn7Zg=;
        b=PFnVaqIRkGTokD7N83E0ZTsP1gHZqowNbtUQRIxpN8PH+K3sxSTz7IBoaSultZZG5h
         +QxDihHELKmoHQrDEpdBgfTiSerR0JMpj1KI3STDPwC2a2N5nLgX38YQh3FoNHn6WRIQ
         wlRkF0xA8M2AVLJ6ymDhzBMoeQXI0hXWxCQjIbuQase+Fr6/lCn1KndISJLkvwNWnT73
         EftHfMNWjdVef5S4X2Pe9Ds9QZAZqdg/m3YJOhHxOOcI5Xx8BnukLpB789nNja2/2wuE
         KKYSpHFXiYCRMaMzEEqiy6Yb/GcsTiPpCejKarqXMh5P7iR41uXeI7l9pDMyhesNfRRQ
         3lUw==
X-Gm-Message-State: AOJu0YzIFFlI+4S+/IWNa8444v7GX3j85vDyE6Fe4o/avzbjysORUds0
	i7yhRToRvR8wGxk68jrZ2Lg=
X-Google-Smtp-Source: AGHT+IE0IRYr9V+lQg47qf/RXmlrFTPiUy4YqmUsACwvpuKKYqrlXke3x5A4mm+32jZQ20iRgcqOwg==
X-Received: by 2002:a17:906:f2c8:b0:a23:62fd:e2f6 with SMTP id gz8-20020a170906f2c800b00a2362fde2f6mr711558ejb.30.1703159112231;
        Thu, 21 Dec 2023 03:45:12 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id ad21-20020a170907259500b00a2686968ee8sm861454ejc.58.2023.12.21.03.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 03:45:11 -0800 (PST)
Date: Thu, 21 Dec 2023 12:45:09 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <20231221114509.GB109788@debian>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <c3addf0d-3693-41ef-9f8f-b9f28487c88d@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3addf0d-3693-41ef-9f8f-b9f28487c88d@lunn.ch>

Am Thu, Dec 21, 2023 at 10:44:39AM +0100 schrieb Andrew Lunn:
> On Thu, Dec 21, 2023 at 08:28:47AM +0100, Dimitri Fedrau wrote:
> > Changes in v2:
> > 	- used defines MDIO_CTRL1_LPOWER and MDIO_PMA_CTRL1_SPEED1000
> > 	  in mv88q222x_config_aneg_preinit
> > 	- use genphy_c45_loopback
> > 	- mv88q2xxx_read_status reads speed, master or slave state when
> > 	  autonegotiation is enabled
> > 	- added defines for magic values in mv88q222x_get_sqi
> 
> Please create a new thread for each version of the patch. The
> automation does not like new versions appended onto old versions, so
> this might not of been build tested.
>
Ok. Thanks for reviewing my code and your patience.
>      Andrew

Best regards,
Dimitri

