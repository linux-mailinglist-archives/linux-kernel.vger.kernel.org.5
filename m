Return-Path: <linux-kernel+bounces-65412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DF3854C96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1E41F2138A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860A5C913;
	Wed, 14 Feb 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBSRxlAw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8A45380F;
	Wed, 14 Feb 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924270; cv=none; b=O0CjL1lESstF7qoGihiDPLFlUMAVuZ4tO4vxkqfyu1G9F/v4+I7+aPAQQAQkw9uGjXoRxoOfIwMMRM3lCD9SGQ3HMdFKDs+dQ/ZWTuvbb7TZ8UZZnqgmnqi9AWP8At6Sa3VHDlYMnZjnbrsplUC52W2RaB7wewE16atIocSKNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924270; c=relaxed/simple;
	bh=hrS+7D98aI8qXwRGWlzZjL30Thwo9vI5kQtILtRmP90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsB+YrIBoV4GpYfIMp17S1pvI33mb2SOVjxN0lj4ui5QooLKg7xNKTK5thLFoAA4Qvn1O3TdX95K93kgD98KxyjVv/N9gCR/8Z4RW+zi9XWS8SOO4GHMLF3Dbm6xvB3WBQDE2HaDPfEHPfTpO2OlyIpxBqHdSa6crOOeZ6fNDqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBSRxlAw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-411a5b8765bso5599115e9.1;
        Wed, 14 Feb 2024 07:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707924267; x=1708529067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OFkureVTXD1x1XtiO0hHaV62fHL9a0D+FDxieJ45iM=;
        b=kBSRxlAw6kI09zLSMhdyTdb1GWDkn//1e/W/SNcozs87CksUT97oYJSKdkINH7FEqy
         y4kNOnVgz8bXginkc1aSzbhuf5Mq0j6ieqCevp7AMmjD8v/g1Gi1SLj4Rv9L9MhlPWgL
         RXk4doZ0k2ISVhzfQhYvp8zP3BMRBNJRoIxIKMJZkj/QsmdKgZd/SGW/7ImBlKnqWaIT
         xd0IKMIeNRf/19Z4HblK6xhkmpBgJLguEbu4+qWk82bO6KbpT0iz7vQmSF/+BMrrhfuO
         Wrw2ev7JPdBkEKym7/A1cDUcmWo4mGWrzb9B+/NBA3iynDQ2odrR/Q+joWstZ2i8xcEw
         9gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924267; x=1708529067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OFkureVTXD1x1XtiO0hHaV62fHL9a0D+FDxieJ45iM=;
        b=hTP/mYfNf2G9c2zk1r153kNPFdLvSfZa6IEE2MGDUB8bBeKUAeYaHNL3HqFAIeiPWI
         +WY1gcmAAY7WJkcak2A7JEzZIn2kuArU508zlaBV/FV4KqAWzj93VGOavmUNCKLwFNnN
         cn6X9diJTc1AOvJWqLxe/v+FZJwd5QHKwn02O3Qd/xcjRHK2NljliB2BqDrq+rwn/emA
         oRZy4iaqF/8ISkuTu+uFtkLKyMqNLgSAZVk+xKYHeJ0nB50YT2nvQK39V0QBS6Syf2dO
         BemJduq2mJw284UIilXzQnfVRLxXuVydOzNV1dGfXSb+qZnZxMPS2R2tUwPZZOk0q34C
         RjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6cnOzdADbTCiYzKVUKZlgnrpGMsiDCtMcAxr/2cSMwur333pURbXLCiRoF8KXX0nSOuZ4COI5VTf/qpUU8chbRZ85wcbLNgYmiUFO9qiwq30gczuAtV08IpCeUHOqmWRIl8r+UJuTiZ0=
X-Gm-Message-State: AOJu0YwvN32D02nC0JZF7vlzS4Ckpp7KocTITT5nrw/xFp+OJTfe1Ur1
	2Onqrdxlwk+qM4PPd+OEYOXhoKUBc13ZZZosCo2lWLSwpB+oB0hzXvlWHXVk
X-Google-Smtp-Source: AGHT+IHOl034acDN9oYiI5bWCOeRpm/6dehVlHu7Srqmx1Xr/lSZvYEaRV7yEa6OLBKmnHkH82sXPw==
X-Received: by 2002:a05:600c:1c08:b0:40f:db22:728 with SMTP id j8-20020a05600c1c0800b0040fdb220728mr2153291wms.1.1707924267256;
        Wed, 14 Feb 2024 07:24:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6eLjCaqpDR/W1pHfY2V7q6gY/k6DAWdQQWOvBvSb4KSiBrm6pD74ja3INBLNJNY3KITqvPIXSusPV13a1j1t+fpqIedYKBwlSBTDIN4aHlxCIKArKhjtrrdvT0EPvEydBVu4Z5jTK0eZZIA2IFd4ZOXDDSHzW+b3hGWyhyPEe2qFsSdx6K1cLiZOkwkbZi4LGyt+Pt4NJmg075zxQX/w3WW5/LXHrN1hM/u8I5Rl1MNY=
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-49-42.cust.vodafonedsl.it. [188.217.49.42])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05600c3d0700b00411ab6dad65sm2314394wmb.29.2024.02.14.07.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:24:26 -0800 (PST)
Date: Wed, 14 Feb 2024 16:24:24 +0100
From: Tommaso Merciai <tomm.merciai@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linuxfancy@googlegroups.com, martin.hecht@avnet.eu,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] media: i2c: alvium: fix req_fr check into
 alvium_s_frame_interval()
Message-ID: <ZczbKDGXF1PXaBXr@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231220124023.2801417-1-tomm.merciai@gmail.com>
 <20231220124023.2801417-6-tomm.merciai@gmail.com>
 <20231220130236.GN29638@pendragon.ideasonboard.com>
 <ZYLxtTRQF0sWJLiu@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZcygmyT1ZaKsbSxX@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcygmyT1ZaKsbSxX@kekkonen.localdomain>

Hi Sakari,
Sorry for delay.

On Wed, Feb 14, 2024 at 11:14:35AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Wed, Dec 20, 2023 at 02:52:53PM +0100, Tommaso Merciai wrote:
> > Hi Laurent,
> > 
> > On Wed, Dec 20, 2023 at 03:02:36PM +0200, Laurent Pinchart wrote:
> > > Hi Tommaso,
> > > 
> > > Thank you for the patch.
> > > 
> > > On Wed, Dec 20, 2023 at 01:40:23PM +0100, Tommaso Merciai wrote:
> > > > Actually req_fr check into alvium_s_frame_interval() is wrong.
> > > > In particular req_fr can't be >=max and <= min at the same time.
> > > > Fix this using clamp and remove dft_fr parameter from
> > > > alvium_get_frame_interval() not more used.
> > > 
> > > The commit message should have explained why clamping is better than
> > > picking a default value, as that's a functional change. If you propose
> > > an updated commit message in a reply, I think Sakari can update the
> > > patch when applying the series to his tree, there's no need for a v4.
> > 
> > What about:
> > 
> > Actually req_fr check into alvium_s_frame_interval() is wrong.
> > In particular req_fr can't be >=max and <= min at the same time.
> > Fix this using clamp and remove dft_fr parameter from
> > alvium_get_frame_interval() not more used.
> > 
> > Clamp function make sure that if the setted value exceeds the limits is
> > replaced with min_fr/max_fr instead of setting the value readed back
> > from the hw.
> > 
> > What do you think?
> 
> I used this, hopefully it's ok:
> 
> media: i2c: alvium: fix req_fr check in alvium_s_frame_interval()
> 
> req_fr check in alvium_s_frame_interval() is incorrect. In particular
> req_fr can't be >=max and <= min at the same time. Ensure the requested
> frame rate remains within the supported range between min_fr and max_fr by
> clamping it.
> 
> Also remove the unused dft_fr argument of alvium_get_frame_interval().

Looks good to me! :)
Thanks for this.

Regards,
Tommaso


> 
> -- 
> Kind regards,
> 
> Sakari Ailus

