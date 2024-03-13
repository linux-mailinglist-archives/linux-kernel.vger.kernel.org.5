Return-Path: <linux-kernel+bounces-101216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BC87A420
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7301C213CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94141A286;
	Wed, 13 Mar 2024 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmAoZyXR"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB9818E12
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710318975; cv=none; b=DcauJ0NmBy3xa44dyr+tMriC5Ehnb24sgVn/+KpYLTc1KMqLeLsiwv+NL1xVrTH1W6gCZiz+LNLOuxdzx8VoydzIZlDaNi1auAYqv1NA8futocYh0FiscPoFQzj93xfQJ5i5w169xXTdN0/tUgPw7tH0J2rRuehwS8jzcHBmlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710318975; c=relaxed/simple;
	bh=ZKFTwo1Q9pWn1usBlfixETaA1dMjEZjsNIV8Y37bvfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taXLjc7AVPPuFE0F8Q1hclSrKAZTF+tCydPVubA/ZZ8pH+MZpoEPP/g5+L5uhRUL2yF4MH6I26yDqX6SspEgf2BLIy5Fdzq14HlG0VG0s1dQzxDQqVbVLj0DyDsJtqrXm6Osm0+myeY2iFBEkZHp4uacBglCR9o0oNS3GVcyJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dmAoZyXR; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so5147220a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710318971; x=1710923771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q56Iw2eMUPFwWk7xMQEduN6A9eWGEu2bI8Z2BeWf0vw=;
        b=dmAoZyXROOPc4pjK8ucjMf/p1bo1ghKCA4u1KFsrl112sfkhnPJrNybDz4/pE37Tc2
         55Jmw2GC+pjUKFqQrPiRCuLu/OoR5/fyirBMhRjLx3cxEaPVpcKPfpmXTVKz1BgisZMp
         xvcNNYP3SiNR2VKfLJf/FL/4idCR53XsBD3zOPo7o3Wy8tlib0Ni8WUCjaYjPRzjsJtg
         IN1qGTlUq/GaTNe6hzNdKCqFueh1DentHAj21sA3AZhbV+weuiYCxBf+3zDyOGPt7tFT
         KpjYpKDXRc85D13hE315uk5oKe7jQ99Fd88drbAzkgyYCrT2BUbiBZBBchZJI0Oohpzd
         wvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710318971; x=1710923771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q56Iw2eMUPFwWk7xMQEduN6A9eWGEu2bI8Z2BeWf0vw=;
        b=rHbItVKiKoDMJrn3Q2NtvtVZW+xrV/gNH57TQ8kK71Me2Ji4yXDbz3NCvQRkFkVuEV
         Ycj/A9hJG6nMTEwMGNUktFcR0bqrcHXBjpbS9lOINVCCCr1/8ds7MGINMMsBfRldCYvv
         VIGJ5IyXzN+705VSXtOxR4pkGtHYs+/8PyNtYoiWzSHght4JIkCQchxcv2027zCYy4B8
         CeI9koWY9tB55z9Zl5Tlg6MAtZP71Y+JLTEsykJQpvTXGHzZEeseYey4a7gwR8zIoNb0
         l1+isFSENNcfPNqUO0xbhq+3jHY5+bLv1hYJd4X0U2W7DpXrz0y21xUVi37PGn63Dkhr
         kL2g==
X-Forwarded-Encrypted: i=1; AJvYcCUSoyVmGhQqr8+IuafVYa0H2sPj8E9w8YcBLdSaqyGfElb3VzWYHUcVJgAYEiTG2t4LvqnnO09Uf5usiiMQMNuOYTDjRfkwG5pCA/ZX
X-Gm-Message-State: AOJu0YyDBGB8tyx9qp8odWLRDMZ2bd9G/c8zPVGVrmKLMvcdA1fcna0X
	+OpMxFpR9EoerDe1aX9QlgSYBC35/RslPfn3K6M2MfsPCteVr5pZvHMwRWzN3ig=
X-Google-Smtp-Source: AGHT+IEWn6PnNJ4T6kFZ+BtXapbyNPTHkaA6jOJ7GecTTFtWOnLDtr8Pz7YoarT+gwdewJTDsNurCw==
X-Received: by 2002:a50:d498:0:b0:568:797a:f2d with SMTP id s24-20020a50d498000000b00568797a0f2dmr1701644edi.27.1710318970930;
        Wed, 13 Mar 2024 01:36:10 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cq15-20020a056402220f00b0056761c83bdesm4774222edb.93.2024.03.13.01.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 01:36:10 -0700 (PDT)
Date: Wed, 13 Mar 2024 11:36:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Ayush Tiwari <ayushtiw0110@gmail.com>, Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v4] staging: rtl8712: rename tmpVal to pct_val
Message-ID: <f4b889c8-9816-47e9-88e1-2acc9c169b8a@moroto.mountain>
References: <ZfFfW/Flrlzb0+UI@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
 <2c63a094-6966-7679-2b23-58c057b451d8@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c63a094-6966-7679-2b23-58c057b451d8@inria.fr>

On Wed, Mar 13, 2024 at 09:18:08AM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 13 Mar 2024, Ayush Tiwari wrote:
> 
> > Rename local variable tmpVal to pct_val in function process_link_qual
> > to give intuitive meaning to variable and match the common kernel
> > coding style.
> 
> I don't think that the patch with the name avg_val was accepted, so this
> patch has to replace tmpVal by pct_val, as you say in the subject line.
> 
> Also, the comment says:
> 
> /* <1> Showed on UI for user, in percentage. */
> 
> I still have the impression that the value calculated here is an average.
> Total num is just incremented:
> 
> if (sqd->total_num++ >= PHY_LINKQUALITY_SLID_WIN_MAX)
> 
> while total_val is updated with a new value.

Oh, yeah.  My bad.  I misunderstood the comment.  The original value is
in percent.  prframe->u.hdr.attrib.signal_qual.  It's set in
query_rx_phy_status().

Sorry about that.

regards,
dan carpenter


