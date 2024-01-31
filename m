Return-Path: <linux-kernel+bounces-46394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41021843F17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF29F28903A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1878670;
	Wed, 31 Jan 2024 12:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUBw2mwa"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A77866B;
	Wed, 31 Jan 2024 12:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702595; cv=none; b=DrA2bFbfBjtISHIMFYu/U/L3vnZbroZ05ecKhilm5qKlS8hdcT3RVi9Xadnikao/IaM6UykUHKaCvrtTArnal7ey8iWQ4ge6EWQ8Z3yhvXNY2MmWCEsHMWlyTF9inV20Qd7FbdQzOKQP31j0ULAiyeZs6t+9dSUYSX7QOdZFteM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702595; c=relaxed/simple;
	bh=7aIsZX2srAf0sa63pWe6yXQhUHFM5Loh5VY8dfDgClk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2ZPLHzy2kAx55Lz0WmKNV3zSWsyvQILaMRzKGed1JP579DZxnpxlYAEjE9bh/fjNOsu4PnSyP2tI59LiaMimaJdWNbHZCVJ3vsY2sEuK8NewOd5mpdQ+L1pEosYTzWFLPgiS/wXQUsNvUmBF2vS3IM0gO5HCFwFFLVqsX0C6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUBw2mwa; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso62591611fa.3;
        Wed, 31 Jan 2024 04:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706702592; x=1707307392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQgs8UsGYzxmHZcSyBxn3sZaIrByyjWo7oRX3DRemKM=;
        b=jUBw2mwagB8/zi4s+KGAYWNF8w9h1USttaw+tB+zlRxXTwY7wBQLfZMRfptTWEw5zv
         rHqm0B8S6nEveNrRJUwh5eQ5kUz5VdCBLQ5WQRw/uM+/Cuw4aUcSsl/udthYBVzdZYFM
         gt4cnXQnSNBMU+X0oMgnUIY8n0zik3s3HzfcsPo2fy2619psInJIBtKWbsFzmPVKUt0m
         F8AYvh3v0A+Dsq6VaAuxUeON9WtTMfHQwq/FdyDINJ+I0TyiqkdGlr3gnWuvKxrBDVrY
         eI1jAU2JmJJXCf9hgTuDCLIwSGs/7bZir7ugjxxQCeKuKUhbjhogXpz4Mw6hybR9GjJ8
         KL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706702592; x=1707307392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQgs8UsGYzxmHZcSyBxn3sZaIrByyjWo7oRX3DRemKM=;
        b=B/6t4JdlXi/zenXV3EYn0sHftlUhb/PI3burXwQyPgQVpzv0TDSfbCkQNsFsMtmCTk
         jJ5071V1lWS7BSVeYmBniZxQGGztLWjTYSb+CGw8fxnRkW+CSl/dUHTUfjynTmQ7vqYM
         fulyG/yMQMEH7ZLzuXsVZT3wWmv8+RYhS7t7WLteZDYTyTRvpwYblTShqTwrnxkVtPay
         0botx19pjomJBDgXusXSAEhyeR5RGwA4clnw0hE8GPN+pLdTCCt+0hva+2xAFigSr6do
         tjTu+Z0wFVHUFLVuY7U/QcXfC5FqHvlPqfy/cj5f3C++FkY3oH1fUE4Ln5n7LQBl8BAH
         8aFQ==
X-Gm-Message-State: AOJu0YysKaTL/kEj6fcijghWQvygLaoZJiZjL00EPw+Ztr31Vt7JyMjb
	9tholu8Puwp98Kq+kTdR/MZiIvCj6a+O6iIz2YR2FAd/l6VguminbXhR3yjv
X-Google-Smtp-Source: AGHT+IEH8r9yk3/xjFyaDXOKv4UR8LJdYI3nczJ994qpHsigqYbbxXyuT++m4kClzfhH+Hy1xVSEww==
X-Received: by 2002:a2e:9257:0:b0:2cf:1f0b:5119 with SMTP id v23-20020a2e9257000000b002cf1f0b5119mr1104272ljg.17.1706702591025;
        Wed, 31 Jan 2024 04:03:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVGLjNvGNmxn6n2ONqAu0DiqoG+VC1MAVJTDTnFNpqJTchpfeN/3DRT8ojUhmjhfjx+EsN6k7RsYqN4e2zkiV8Eoz4gFwAMQWaWOCvIRDTt0bfwE/psb2S2H9t3/TtvDfCWtQjr/S3+l47Yk9kb27F8zD29jmBe/jwPKn4bI3CNSes+01+6VqpdfW3D6RJMZuE3GgzhTQNFjtRJNEBTxrekcseIRYKwSunLvFB+O4MQx3wUPqylOydmI00mj6UW+SbMY2FRt37csvJaKBomLz3BF+Hp1TzmDxWDJQw=
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id cc9-20020a5d5c09000000b00339443be964sm12081762wrb.91.2024.01.31.04.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:03:10 -0800 (PST)
Date: Wed, 31 Jan 2024 13:03:08 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net-next 09/13] net: phy: marvell-88q2xxx: add cable
 test support
Message-ID: <20240131120308.GB111590@debian>
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-10-dima.fedrau@gmail.com>
 <Zbi/In/qWrW1qmP0@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbi/In/qWrW1qmP0@shell.armlinux.org.uk>

Am Tue, Jan 30, 2024 at 09:19:30AM +0000 schrieb Russell King (Oracle):
> On Mon, Jan 22, 2024 at 10:28:42PM +0100, Dimitri Fedrau wrote:
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
> > +	/* fault length in meters */
> > +	dist = ((ret & MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK) >>
> > +		MDIO_MMD_PCS_MV_TDR_STATUS_DIST_SHIFT) * 100;
> 
> 	dist = FIELD_GET(MDIO_MMD_PCS_MV_TDR_STATUS_DIST_MASK, ret) * 100;
>
Hi Russell,

sure can fix it. Did you have a chance to review the other patches ? Is
there anything I could do to ease the review process ? I'm new to
submitting patches, maybe I crossed some line without knowing ? Would be
glad to get some feedback. I'm just asking because there was not much
feedback besides your comments.

Best regards,
Dimitri

