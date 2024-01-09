Return-Path: <linux-kernel+bounces-21291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA1828D1F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B11C24C64
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1827B3D0BC;
	Tue,  9 Jan 2024 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxwLKX2O"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37839FC5;
	Tue,  9 Jan 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbc648bed4so3140314b6e.3;
        Tue, 09 Jan 2024 11:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704827256; x=1705432056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vktayxzef92MMwztklBgwneA0iC/Pngrp/gUTyKh1oo=;
        b=PxwLKX2OAtegdREnedq01DCxdcW3gKX6q26Fi2X0IiFpyCjg7YkPPRHwH0HTYF4GyQ
         yMTU3DsfQt+nzXi/XWRG/fjeex5PnBsRIonmSDkt3A80GAtad/UI/TM3PvCYsap5u5Qx
         otKGrn4Wi91cGbHo0uzQMTz4wzsg5x4GeQOXbDEA/ansuQbkjAY0qz7sMXrUpZRb66zq
         HUPfmgtwjLuJzxJMgPrYbqwQPorKXtdMYzVEfjrbETKSyRwecdUsGQ3qG7bSZ2oXpp0V
         YZt3IPo8HQGwTORz6YRrBTEcIEBqi8aKJpXPClQ0DWwI+z589LtjKlh9CWDBHfy7BXDS
         cPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704827256; x=1705432056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vktayxzef92MMwztklBgwneA0iC/Pngrp/gUTyKh1oo=;
        b=SdKtZOm0SehSboxY0p7J/kmDJkkszKe3dMKJJK/X3JEWMSm3u0wDtF4TMN7rRibo0B
         6Z2ZsrvisUrWY1f+xKHDrNkt/Usrjw3ny/ob4G8WyN8gHIfvuFu27xtwgizRKeuexFsR
         Ry2fYLtJR6IIKEISu/WI/7Tx/UXL+UpuujRx8NEtJAxQrfxapAhwXgvBpNj2y3x0jC39
         CCSr2DL9S4voRen8uBNnwWB8f/nYDyE8JnHTeO5jGptnNearRCmdTns9I0cwP4x2sHjT
         JVsVZKnGb7D/VD7P08fL8dU4lL/ZAXwzbmABfBci4aOt9/Jqa1kyUXo+9E1yYHjTGssn
         RcKw==
X-Gm-Message-State: AOJu0YzVIEaZJdp6Zl8vu9NDqAoZamU3qh5SWa3T1COIEc0yu2eV/p5S
	rFpQFBZLp/vHGbHBSJgu8GY=
X-Google-Smtp-Source: AGHT+IHQlFtLZgqEtXiyXC9fL4944RHvq6x/EWWSrBmG2PNh8QZPc/OYPEt6CGMDNrGj179jx6Vl9g==
X-Received: by 2002:a05:6358:71c3:b0:175:7748:bf65 with SMTP id u3-20020a05635871c300b001757748bf65mr5486553rwu.37.1704827255977;
        Tue, 09 Jan 2024 11:07:35 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:fd50])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b006d9c1fb00c3sm2037702pfv.9.2024.01.09.11.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:07:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jan 2024 09:07:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@canonical.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] kernfs: convert kernfs_idr_lock to an irq safe raw
 spinlock
Message-ID: <ZZ2ZdoNyBhR7o83I@slm.duckdns.org>
References: <20231229074916.53547-1-andrea.righi@canonical.com>
 <CAMuHMdV=AKt+mwY7svEq5gFPx41LoSQZ_USME5_MEdWQze13ww@mail.gmail.com>
 <ZZ18xVq4GtQsTC8Z@gpd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ18xVq4GtQsTC8Z@gpd>

On Tue, Jan 09, 2024 at 06:05:09PM +0100, Andrea Righi wrote:
> On Tue, Jan 09, 2024 at 05:35:36PM +0100, Geert Uytterhoeven wrote:
> > Reverting commit c312828c37a72fe2 fixes that.
> > I have seen this issue on several Renesas arm32 and arm64 platforms.
> > 
> > Also, I am wondering if the issue fixed by commit c312828c37a72fe2
> > can still be reproduced on v6.7-rc5 or later?
> 
> Yep, I can still reproduce it (this is with v6.7):
..
> I'm wondering if using a regular spinlock instead of a raw spinlock
> could be a reasonable compromise.

I don't think that'd work on RT as we can end up nesting mutex inside a raw
spinlock.

> We have a GFP_ATOMIC allocation in __kernfs_new_node():
> 
> 	raw_spin_lock_irqsave(&kernfs_idr_lock, irqflags);
> 	ret = idr_alloc_cyclic(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
> 	...
>         raw_spin_unlock_irqrestore(&kernfs_idr_lock, irqflags);
> 
> That should become valid using a
> spin_lock_irqsave/spin_unlock_irqrestore(), right?

Yeah, this part should be fine. I think the right thing to do here is making
the idr RCU safe so that lookup path doesn't depend on the lock.

Greg, can you please revert c312828c37a72fe2 for now?

Thanks.

-- 
tejun

