Return-Path: <linux-kernel+bounces-161536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E08B4D61
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3765FB20D7D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9874400;
	Sun, 28 Apr 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYIfMnxF"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D174262;
	Sun, 28 Apr 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714328260; cv=none; b=VNcO6TAGbNuuN4nU/aj+jw/7pFJETrVBjpwVk76XSJw2M1NkpeyUFvd0PyLYtkNRV+7J1Uio9Rl9JheajuJttverdREAWfq6TVwi7FRkQABslVYu68Jhy4WLPQJEXWSGL7QlcLb4WYx1TMqw9uCzlcYwelo4YibmGsUj5+Myj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714328260; c=relaxed/simple;
	bh=UVHtFJ/YLzJZqlr1CdOlX1Mp4BvDtjYj4671q+kZsmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFwvkzKxZ2qw/W9fDoI87jZ1gz7dhQUXH1rjmxAawrgJo63UuJtCzB2qG92uO+gPuyOiMt0oX3BH6BQ0CgccuGETlaIMV+/DbohzlfPZ9SccbOEwqPLSShz8hxA5LIwQZ2l3GInBkF8dr1f+6W0jIRO7Hq/UeSqeAYXG0odCXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYIfMnxF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e2b1cd446fso31086605ad.3;
        Sun, 28 Apr 2024 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714328258; x=1714933058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qEw/3s/ESlxm595U0RC+WfqKIuULBZxcesFMjXWYGY=;
        b=FYIfMnxFPyo/9XzXccs0bOaVTIYrMcEVSQwpkLp4gbd73CeNr+wDWMwT5jzYubrTZK
         t3ck9b9vpqBCUyqPcJMKx90fMIMPNCpwBIvs8SAvAeYXZ17pVRIRudNKV8hzYPWOo5OC
         xIgmOGHwpN4uusSHPlzE3L29LV4u0+iGrUgUAGBBHak+LvrONolIG7ys5M2RyeZ2LZai
         NAsPPMf2USIrApda2tVYVRLLWoGnkf13yjmzFlQiJ2jCOrwnaX3BMssd1mweXRF+zJkM
         kIQmYurQMeraw/PjaSkhz99/ZiKgyRvzamOv6QVRKGm/0tAF6/ypdw5R9aJ7wTqTwQev
         lCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714328258; x=1714933058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qEw/3s/ESlxm595U0RC+WfqKIuULBZxcesFMjXWYGY=;
        b=N01FuvRS71zLka3b2Bra/jnzadj3h/8rNsKM9ULiLB21IY1n8OvpyV6L70g2vPIhtn
         ZVbndde50BzocJ6Ot5VgZ8mCzIAHDfhBp8zUFg6znk7Nd4txnICohnh7CXZ++TDWIul0
         QN1la7Gwcho/5t6wj16l9LxdYF3F0FEd9VgTs6VMw4kxduOhqj7AAjKHwCbye5lUG55b
         fhvr9CRsro2aGQ95y0PJdSmgz9nLEAPYREcURnwIWlg9GnDWRY6j0lG2yfC+MPNXQ/Av
         gVMIXYVbeiepmZK1jjKijB77NtSzDrGHsshUgp+ynR7TG0tKwWruHSKTFGHU1G2BKDHW
         0u4w==
X-Forwarded-Encrypted: i=1; AJvYcCUeQV/3YeEaV3E/fDdycqcCQzCqq6yiUi8c7n4Idzbtp4IJfHuilDrLNDA88StleNCvBY1fJPJMnxVCeK6AdiaqT8AHdyvUIHCaE/lMAiQmPNTfMSb5227GRfmkMnZ8hKraGdeHNLtM
X-Gm-Message-State: AOJu0YxswSAiT/3jZWRZ2I6sowk+77Fyd92hA0K+hVdrKLTeaj9HghkV
	r7lxNRDd9aJecevkDmLynJ8FWYbgi7qXOI4/Bl1nOR/e1t+u6xBf
X-Google-Smtp-Source: AGHT+IGfxJyPzHUSQGzL65qsWAnRT4dYNxniZrUzL7w0yEG6LaiqTgUFXvB+jasCo243ZL0xEt1G6w==
X-Received: by 2002:a17:902:a603:b0:1e2:1805:52c5 with SMTP id u3-20020a170902a60300b001e2180552c5mr7615996plq.16.1714328258315;
        Sun, 28 Apr 2024 11:17:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z88-20020a17090a6d6100b002a2dbbbb36asm21233862pjj.37.2024.04.28.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 11:17:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 28 Apr 2024 11:17:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aleksa Savic <savicaleksa83@gmail.com>
Cc: linux-hwmon@vger.kernel.org, Jonas Malaco <jonas@protocubo.io>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (nzxt-kraken3) Add support for NZXT Kraken
 2023 (standard and Elite) models
Message-ID: <b796dc35-db06-4825-acb1-1389c50234ab@roeck-us.net>
References: <20240428104812.14037-1-savicaleksa83@gmail.com>
 <20240428104812.14037-3-savicaleksa83@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428104812.14037-3-savicaleksa83@gmail.com>

On Sun, Apr 28, 2024 at 12:48:11PM +0200, Aleksa Savic wrote:
> Add support for NZXT Kraken 2023 (standard) and NZXT Kraken 2023 Elite
> all-in-one CPU coolers. These models communicate identically to the NZXT
> Kraken Z-series (Z53 code paths) in all cases except when writing the
> fan curve, where setting additional bits in the report is needed.
> 
> Reviewed-by: Jonas Malaco <jonas@protocubo.io>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied,

Thanks,
Guenter

