Return-Path: <linux-kernel+bounces-118683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E69E88BDFE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64280B25B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32F71B45;
	Tue, 26 Mar 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFzhlxFE"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359671B30
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711445162; cv=none; b=XVTph2Vbf/430/Ad+Nq5o0KGubeoK4QxlOCPYyvLEKRoNK690L6yASC/M88Bs36ZvMpzCcEaNpwvXrsiKzytZQRj9ZPGX0n3v6iy2wGiSIznYFHOeKE8XcaERGWPynJysYoJHdil0lCoTNeUkh0WynBhvyd1pYphKtxOif7sZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711445162; c=relaxed/simple;
	bh=CAzD3ud50Rz8+/Q35q7whOrrwkhsZRBKyop/gmKryWE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwKBmUgA0qmVnHx4FIVARb4YKXbrpL/n8nMbTXT0KjeGPmj2HIR557QjpswsNYWNARKPk/pHUwblKLUNyt9A85LuDCNtg5yQgLUUEa4D39HBoklz0UyOgdu58o3gLxxVDT7xALpREP4D4Aba2DNpeCHVklZ8BqLTbkoE5q4w9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFzhlxFE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-515a86daf09so3120482e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711445158; x=1712049958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/s/izCv8l/CUU3NLEYu5XonJ7bd0ulz2Xx91aG/m8c=;
        b=lFzhlxFEWTtfmMBjSol2v32e/t+VNK+mCAWdOIxwqT+lb5/HD5tpQA3gC+GCODSoB1
         D7351TAgSHkeFc3OE7iSn2CsPqqtamwEzZmrg2FPpbCeaxhpwor31C3aGkmEzjZkdsWg
         +9F+nzR1VWQz/2wI7m6RLvDTVsCs0Yx8+NOg6LfOGFskSYLCeizkddc3d+5l8LI3ndEz
         Ew23HlcNHsX7KKf/Vw3D2dl9Zjs0WQOu/iXzvIC0Hc3/4KRxwXgRTpodv4YpDMEpF0N9
         YLSoEINZ81GV2PQP9ybnngYC1fo8fP+wxrUKKNuh0HW3HWHqytGeLB67GL6xzvMtphBN
         Qpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711445158; x=1712049958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/s/izCv8l/CUU3NLEYu5XonJ7bd0ulz2Xx91aG/m8c=;
        b=ouVURq+u4tWYTCTZc5P74p5ZP7cee8qMWLySpVJTBW2iiJFqL5jk7oyX0O9Fo0cR4E
         s05XooLbSIEWrYcNokC+rf/IXLuy9TN88i02f5NwOE+u74cQuMl+xzM53TCGx6ESsL1p
         mS/CvCVC6aEawwFP3wkp4XFQpNfguyxnAx9ynOYR0oleagA5hOdBbkqAUPTS80S02eOQ
         aKEpyi+s0T67cdTC8ecIrN8H3pkDlHdlWyrVxFd4g+o9pmHyO1/jNb0OoR0ucTh6NWLA
         1+gfPhNvgo6VLPMVDadj/pv0+AA2jyAj9EtQFW4srIprSt9votES6ix3Y9z9j0oTBqNV
         WDrg==
X-Forwarded-Encrypted: i=1; AJvYcCWXOBRtO9gpYd0fbZL64QoOqWEbI2Y376RCn818qIjDluefEMa8UfJlyejpbdpDKYBqEnqHHRS7d0dCxFHcJUEX7ZiE4b0cBFG9LT0j
X-Gm-Message-State: AOJu0Yw3ivFWN6I/U450WSHnM7KVPjMEgXzFO6YSukyUjUEsFN0plasv
	YhTWeMfU4N4WLdpUGhUxaH/LYosRwMDjU+Or3wqgZ12JEua1JYwg
X-Google-Smtp-Source: AGHT+IF87zu4brJ+5iAZbQaWGSBNze4R4O/ksvb/NmXpkbjbP5nWtRpN/HYTqcHB+naRpQ9l0V+qDA==
X-Received: by 2002:ac2:5b44:0:b0:515:8bde:56c3 with SMTP id i4-20020ac25b44000000b005158bde56c3mr7000385lfp.26.1711445158261;
        Tue, 26 Mar 2024 02:25:58 -0700 (PDT)
Received: from pc636 (host-90-235-28-241.mobileonline.telia.com. [90.235.28.241])
        by smtp.gmail.com with ESMTPSA id i1-20020a0565123e0100b00515ba4e47b7sm64694lfv.188.2024.03.26.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:25:57 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 26 Mar 2024 10:25:54 +0100
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dave Chinner <david@fromorbit.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/1] mm: vmalloc: Bail out early in find_vmap_area() if
 vmap is not init
Message-ID: <ZgKUor3XFJI6JcZm@pc636>
References: <20240323141544.4150-1-urezki@gmail.com>
 <20240326074846.6078-D-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326074846.6078-D-hca@linux.ibm.com>

On Tue, Mar 26, 2024 at 08:48:46AM +0100, Heiko Carstens wrote:
> On Sat, Mar 23, 2024 at 03:15:44PM +0100, Uladzislau Rezki (Sony) wrote:
> > During the boot the s390 system triggers "spinlock bad magic" messages
> > if the spinlock debugging is enabled:
> ...
> > Some background. It worked before because the lock that is in question
> > was statically defined and initialized. As of now, the locks and data
> > structures are initialized in the vmalloc_init() function.
> > 
> > To address that issue add the check whether the "vmap_initialized"
> > variable is set, if not find_vmap_area() bails out on entry returning NULL.
> > 
> > Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 3 +++
> >  1 file changed, 3 insertions(+)
> 
> Thanks for fixing this, and FWIW:
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>
You are welcome and thank you!

--
Uladzislau Rezki

