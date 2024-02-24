Return-Path: <linux-kernel+bounces-79758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186186264C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977271C21392
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6647A40;
	Sat, 24 Feb 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePDxcQG7"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E33D97D;
	Sat, 24 Feb 2024 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708795558; cv=none; b=Lpagb/XKcpJ+CgL65NW7sKD6VA+opobU0Snrty+MCYKpwc8PNPhMrq+kg/wnyaMxWxRDQFwS+CmiX4fsix+aIfmjuzlWcJHTOxStvG35S27Oeiph0s+FXVI57gn8u7EugIUx1qQ5CN1le68WLuWqmkPMjOAoIDWDJt51wPs+nWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708795558; c=relaxed/simple;
	bh=LKdxKMRX99gZWFFua9mb0elqag115969gvdZU7QCa4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUWb5ish6muy1iGCgz5PNbSOz2b52hLze+NXn3AKdRFUdiLR10iW6cop3WIKPUE6IO7DQQYL/HPXB8lLTLcyn/z3yYqjgnG+7Ikvu3fcsi9RBOZGnMWPjkvqEDpoXgG+xFvmhMBjFJVUYQR0OmvB6XRydBeLq+qfk3Ji5RKbxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePDxcQG7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e4670921a4so890562b3a.0;
        Sat, 24 Feb 2024 09:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708795556; x=1709400356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAeCo/AcYCYLlxx+rUC55TzelkJiG1qBUO3+Q6Qt12M=;
        b=ePDxcQG7upTVkbX2vitIODqgA0a4V5Z219yFaRVoiyRX3jycb8DMlC7IuuF31WDcs+
         RhipKKiMjySCkeAaDOGPXolKRGQ2sf0U+g/TePGN6Ss2nK8ra8EHlMB6YSLjF/EZVZtw
         d/bEulWwP1QzFoiCNrj4S1tjxlH6TD5Oo1ETbALppGFiRdeFwOaN+UEkhPbBVQiy+2WC
         jV9oYIdMFrLlNRxl7Tmt6zcZhVo5drKzifIej37coyTy5qEQ09oJP5Rw8wfRHeqjGZ32
         4q/dAa4HT+h6C+S7qBjl0XAli/oozijDxJr3lnQ4iizyz/fyv9hH0arFC9HsPRyALgr1
         Z9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708795556; x=1709400356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAeCo/AcYCYLlxx+rUC55TzelkJiG1qBUO3+Q6Qt12M=;
        b=gzXQx3Uw06l3Z53BE4GzoIJLYStZKyELb2MYCx8OAy4fRHWiArw/n2YOmERl76A5/S
         YKEkfB76XrK6HrNtKse5VjkmDnJE6z1kAwO936WgqQiloJY2lcBHiwE3V6ZCw8Tiktug
         RKXIi1XlX/fPozkctlIF1KOrmGqE785mMzcRZSiMnGTXH3zAeD2QPcm8vk3/mKVmfmzC
         XSWSJMLgOasWeP7Ys2pVP++gymAvruO+JOwG5vd2zl+g7iOtn8hg5y97IOOk8NyyBzfx
         ufPOK32ZdOtw59Ld+MAJ4bl/2ffB1gCJkr0gKmynDWZdr0FgQ0+Ow9AyV+jWj8BfEtu1
         U46Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfhhmWGv7oQmYtO2VGGKnikevzmfSReZoTam+sQ/kNtGnfBLTGA818YlQ+opuvhu8W98dVjNQNE2f5XtsfOHZ2aAWT5Hsx3i/AahOkXYvRVd1PLQHbUlgQQAtDFkrgWmM43+8sjTqEHw2kVdU=
X-Gm-Message-State: AOJu0YzlocIji6U6NZ2CWo1AH059h/I+1S1/Hi70blW4lo0BijQnq+xg
	5prcKhu5kj2I21gmvv1yvEvzRn5tyTPy2r55rXzyl0PXXelyBDx2BAlIx43E
X-Google-Smtp-Source: AGHT+IFHAZ6Onc4/jz06fLhmV7F5y4tSzKDk0ZvOW3DZTlJYxFVdIJvW2CRUWn9iUEj173ih0xR5MA==
X-Received: by 2002:a05:6a00:290c:b0:6e4:8ffc:e31f with SMTP id cg12-20020a056a00290c00b006e48ffce31fmr4024068pfb.20.1708795555765;
        Sat, 24 Feb 2024 09:25:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ks1-20020a056a004b8100b006e471ade144sm1324264pfb.188.2024.02.24.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 09:25:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 24 Feb 2024 09:25:54 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Ober <dober@lenovo.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
	David Ober <dober6023@gmail.com>,
	"wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2] watchdog: add in watchdog for nct6686
Message-ID: <9d670c24-4897-4a02-87c1-98e366075e83@roeck-us.net>
References: <20230912112747.285393-1-dober6023@gmail.com>
 <78da7ad0-cc11-4e6f-bf25-12bd5ec247a0@app.fastmail.com>
 <8458d626-8862-44ed-8966-2f60852c92bb@app.fastmail.com>
 <e6d0fda7-09db-4955-92dd-def2df768da6@roeck-us.net>
 <SEYPR03MB7192ED993D9A15244EF22D9FDA542@SEYPR03MB7192.apcprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR03MB7192ED993D9A15244EF22D9FDA542@SEYPR03MB7192.apcprd03.prod.outlook.com>

On Sat, Feb 24, 2024 at 05:00:04PM +0000, David Ober wrote:
> Hi
> 
>    I understand the issue of the first come first grab but when I attempted to add this to the hwmon you insisted that that was not the correct place and to create a watchdog module so if both can not be loaded then would it have not been better to add it to the hwmon like some of the other chips.
> 

Two options:

- Add it to the hwmon driver. Not a preferred solution.
- Implement a mfd driver which controls access to the chip
  (preferrably through regmap) and instantiates both the hwmon
  driver and the watchdog driver.

Guenter

