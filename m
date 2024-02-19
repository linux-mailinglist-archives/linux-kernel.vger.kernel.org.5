Return-Path: <linux-kernel+bounces-71698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C9A85A92B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC351C21A1B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A05B41C80;
	Mon, 19 Feb 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFPsNiOP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B44040BE4;
	Mon, 19 Feb 2024 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360880; cv=none; b=dLuAbYUtizydBdFUuI2DKK9da4Vs7E6BypOoxBCq+As3TNnR5csJZv5eglA8jWOUMLacB912WE1SXY7o4izZlhHoV9H6LmQL2ntHddK2UYkH3MdfM19gQ7MPKqRNcrPAxSseuN4d7Y3wlniXpfZwTYnZEyVvJ5gV/KsDxzHiT7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360880; c=relaxed/simple;
	bh=ulGeX0PWqjlbuuzrErJ/p8v6kpkw8SQPxm11W1ozGbM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKFeu18ds5bmglWYO8Ls5irMr2MP0pOTiqG7oIqWlYW43ATqxIUlDhXGRzQ6fyUFpbAo1dTg2xI3/urKK/hoahzPMUkZ6L4KeNOQSOvs2P7QQKUiHAkgCodqpVUijCbvn9G01Hn1yaliaKygYivSCwEKGl2tlTD+EBBqxcpjJfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFPsNiOP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41261233e61so8618215e9.0;
        Mon, 19 Feb 2024 08:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708360876; x=1708965676; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KT2kmDlZDFvoaZHP2a6wxZ/Yk0wqC7BnKMaiueQOHJc=;
        b=KFPsNiOPAV35ffyaUGTaR4OyxDEKEhtBFAMmZLr5jhbZCEHrrFzELKHxhIOxCB5rzE
         t7ObQs/G6NC/ZEuMI/b1DI/KNt2aLUB1J/QTUXW8TubIB6D6XKzt2Cu+uvyVfq5uNCBC
         Xd4y4TQGiX70/gMQIOaS/QWyQ/stdu3E+mRqj59duvnP5PM2vE+duhMjTxdIR1oCnmN1
         6q6AOak2+ahE9KsKw7DSO8flSVCDO1cKfBk9TQK9EMUG5EYhZyPjvFeIbIMa6eaWFvgE
         0QRqSx7GYHN66L9CvKxdfbtaNE4gQvRcBKFJRbrsz5PDOgImel3TJdnbMSiC9baYQO5G
         tWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360876; x=1708965676;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT2kmDlZDFvoaZHP2a6wxZ/Yk0wqC7BnKMaiueQOHJc=;
        b=GSA1EGSye9NU1YNLeeaKs6znxRCjBULS0iTqOIzms00PdjgAZx58q/hvBlBQBHuHXN
         jwwsv9150Rl+Tf1+cQZoRodziLUoElKcovuaaaPmJt/ViLXJi/+X4QLiaLFVoYpm4iC8
         EDVaUQv8Vw5EBPZdgkoxs7W9WOGYFRjfFAvk2vpp+P7D7o5eg6ujWyv2xOeyduN0FrGf
         WfFwzCIjXnGOAiNuKleR7prd+0yW9YA91HhFWAZ7ofaQv4piy68otiov4M0n5cJs6uHk
         YfFTlRefRcWcwMbKM/i7SuQeZ+daSV7PFgaliDzqA0BtVlUDOgw4Hdw6+flV9+RzRfSh
         60bw==
X-Forwarded-Encrypted: i=1; AJvYcCVf2JDiuO+4gLhge2MdpzamAkJak83oNGlkg1exp3b5NP15mxT9sKLxJUGszhAw6QrvEiCPSAfpWfcd3UVEjWh1/sNTfIqwF2fW7y/rNyVpJgvDnWN6VJ+9dR9hMehy92s/0jVy
X-Gm-Message-State: AOJu0YyIDU/eUwy204reJUh+KwryHtB4z8pG/0Gty6Qu1o/HMHqf8Mya
	59bZNkGI4FHn+kUkbUrPMIRXHGj6f+CoJvRUn591xaKtm7VOXHzJ
X-Google-Smtp-Source: AGHT+IGROfI8r3VYmRi0MS1nfajmPHmuX8p/Rs3wvyPcFOd70ecjjfs7y+gxxGPMK25b9SQQiT00rA==
X-Received: by 2002:a05:600c:154f:b0:411:de5c:8023 with SMTP id f15-20020a05600c154f00b00411de5c8023mr11106288wmg.4.1708360876306;
        Mon, 19 Feb 2024 08:41:16 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id l14-20020a7bc44e000000b00411d1ce4f9dsm11665446wmi.34.2024.02.19.08.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:41:15 -0800 (PST)
Message-ID: <65d384ab.7b0a0220.15279.bf48@mx.google.com>
X-Google-Original-Message-ID: <ZdOEqm5E7Bnhy5wQ@Ansuel-XPS.>
Date: Mon, 19 Feb 2024 17:41:14 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Puneet Gupta <puneet.gupta@amd.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next RFC PATCH 6/6] net: phy: bcm7xxx: rework phy_driver
 table to new multiple PHY ID format
References: <20240218190034.15447-1-ansuelsmth@gmail.com>
 <20240218190034.15447-7-ansuelsmth@gmail.com>
 <6146eb3b-720a-4523-bcc7-8e2656aeafef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6146eb3b-720a-4523-bcc7-8e2656aeafef@gmail.com>

On Sun, Feb 18, 2024 at 08:26:29PM -0800, Florian Fainelli wrote:
> 
> 
> On 2/18/2024 11:00 AM, Christian Marangi wrote:
> > Rework bcm7xxx PHY driver table to new multiple PHY format
> > implementation to reduce code duplication and final size of the compiled
> > module.
> 
> I like the idea of sharing as much code as possible and creating a smaller
> module, however by changing the name, you are creating an user-space ABI
> change, we rely upon the exact PHY name being shown under
> /sys/class/mdio_bus/*/* and this change will break that.
>

Thanks for putting this concern on the table but isn't that generated by
dev_set_name and PHY_ID_FMT? from bus->id and addr?

Can't find reference of the name entry in sysfs. Am I missing something?
The name seems to be used only by logging to print info/err/warn.

-- 
	Ansuel

