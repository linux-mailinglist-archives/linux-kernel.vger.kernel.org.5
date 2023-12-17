Return-Path: <linux-kernel+bounces-2541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E60815EA9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C07C283033
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DC8134AE;
	Sun, 17 Dec 2023 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uco6LgQT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9271E12B82;
	Sun, 17 Dec 2023 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3365f09de18so869615f8f.2;
        Sun, 17 Dec 2023 03:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702811741; x=1703416541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hym40JBSXDRDZKvtqXj9BJbXV0r9zW1DhVziIQP7ja8=;
        b=Uco6LgQTFZihkBT2OyTucySrjqR/Z/DVAWMvYS5VS7HSXeS2EJu/LufzuqX9r3wRrK
         EVFZTfKVkzWawCUSP2AVw3GIzXbU857eSJZvfBJAEDyStSHfqHZSAScf5tBHm0gZ17tv
         5Y9LW1d11VpsWPCT/aE1FDLIfhpldUK9BlHiDYBLkLk5ZVCVYqTw2ni5D6DqjRjfFHGl
         opJHapta7Lv0U9RxbxAZdj5idNnorYnyIW8JBGq52mezRmAokSKa5sEmuTRXGriLIrPp
         ODPUm4uhK97A0NzDqV/FXI+QUaJniV8Pl4SpEbtPfMkqrBvNvayMwi4/17D8KvS8siO+
         bQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702811741; x=1703416541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hym40JBSXDRDZKvtqXj9BJbXV0r9zW1DhVziIQP7ja8=;
        b=f7J3vubXJeZbNNXdH7lUNU718yoE39O0LJRV4YXAtEybNxnfy6/f/GTVl4AYxmjWbx
         vVfmhlPmM/0RZK0ritcVJCbNC0+U2Pa6jfaAS51z4nAjGictXhQQruVTXYw0oES3NiA/
         5OKDxR669qjWpKTUkYzkew9MTEUdvdyi0jVDUpX7sJpaw/5UzEQnTLzYmPLCqvMm0azS
         rpwM37Vsf7wM6icL38TC9UrwGeIvSxtyKX5LXdYf6rwVSDKLK8PVSpQc3gJR9O3yvOro
         QK+wm6Bx2PGcMjeGexJfBclLQShZWgcSeWOKmJs82UaNiNeLH+EJhkzwPvq6vwVU/LJI
         q+Eg==
X-Gm-Message-State: AOJu0YwSCcxdMlwfrWiLrSu+0w5ntYVAAbVwwVdmtTRfuPsaCLLSBgKp
	ylbHpVtcOSNfMVkywzt3VC0=
X-Google-Smtp-Source: AGHT+IFcVTOq0dk+RIY2YcinV8e+kO0/lef/P3+a23oj8Hh0ayCAA+Y8CpyfLapvr/pXvatjuf9BVA==
X-Received: by 2002:a5d:6e89:0:b0:333:2fd2:2f05 with SMTP id k9-20020a5d6e89000000b003332fd22f05mr6176871wrz.126.1702811740576;
        Sun, 17 Dec 2023 03:15:40 -0800 (PST)
Received: from debian ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id t3-20020adff603000000b003364c0aadebsm7840775wrp.15.2023.12.17.03.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 03:15:40 -0800 (PST)
Date: Sun, 17 Dec 2023 12:15:38 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: marvell-88q2xxx: add driver for the Marvell
 88Q2220 PHY
Message-ID: <20231217111538.GA3591@debian>
References: <20231215213102.35994-1-dima.fedrau@gmail.com>
 <74d4b8f9-700e-45bc-af59-95a40a777b00@lunn.ch>
 <20231216221151.GA143483@debian>
 <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28cc73bf-ed6d-49d8-b80b-4fbf5fa0442f@lunn.ch>

Am Sun, Dec 17, 2023 at 10:22:54AM +0100 schrieb Andrew Lunn:
> > > > +	/* Set IEEE power down */
> > > > +	ret = phy_write_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1, 0x840);
> > > 
> > > 0x800 is MDIO_CTRL1_LPOWER. What is the other? It seems like a speed
> > > selection bit?
> > >
> > The other is MDIO_PMA_CTRL1_SPEED1000. Will fix this in V2.
> 
> It seems odd to set a speed, and power it down. But i guess you have
> blindly copied the reference code, so have no idea why?
>
I agree, absolutely no idea. I already asked the Marvell support for
any document describing the init sequence, but they couldn't help me.
So I have to stick to the reference code. At least I copied the comments
that were part of the init sequence, trying to give some meaning to it.

> 	Andrew

	Dimitri

