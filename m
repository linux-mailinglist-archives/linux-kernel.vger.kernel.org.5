Return-Path: <linux-kernel+bounces-138823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB489FAC9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19167286943
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F6A16DECE;
	Wed, 10 Apr 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMnnVlob"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7915F408;
	Wed, 10 Apr 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761031; cv=none; b=qmlKBwFUPpAhW3PG7YokFdv4sL0o+lTL1MnyYN0cWxytb7xriR+CBjCbvA4lNw1N3Vzx8EDQGH+h4Dxob1okxR+v/kVavS4TKB0oJnhEOXaP1hrf8x8A3BYFPV95NID7n4Y2oT/I20i+GYrDL8mLD3tuQ6C1N5jvUW2uUmBm3a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761031; c=relaxed/simple;
	bh=t7IzyfQ0z66QoEoGzJDJlFIDnvILKbDF0xKc8/CwM2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i35JN0syc0ku5mHsh2LynZAl7VcQt1bsC5IkX5RAJ9mIJ3FGPUKM/JYSdTy7edk0ECNPni3XEz/mcDbeQrKRX5JhzqgN6saG58aC0Ksg9VYUYgmvGM5D+Qd2GDz2JED+iW4KKN3aXtOHfEWFiABfp19ZTjMVanPebeFaZuThWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMnnVlob; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so4657488b3a.0;
        Wed, 10 Apr 2024 07:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712761028; x=1713365828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKZlsiGSmj1oAmOorazlme/SpRibHSzFq4Lypt1FiW4=;
        b=lMnnVlob8IJ0SRLnjuWaT6MqrreuQNCXbQCJOQvJIQoplMP+jBN7ObcXmV2O/HeDnN
         mWyTtEPukNd368MEAJQoLsDGu4kBLHTvCTGtKvsWvdaiVQp6N1n+ZdDMa9ZqdOThueb5
         tWPfGCl14Zpm7Bj1umKR96M1KVf9Mby1tn8OWKI+zP1zWS3Wi7NGlNrbrbhTD1bQ0i6x
         hWloqgzTAdOa2VH0fyHCA7I2QZAUe+fkH/Oio9vTX8vVY3cYZJ/BMaODtMT3DjGtEQ3v
         P2B03s4X/N5ILf03K/dkaavqnDHudHxkgAZpQozQ9TmLxcC0T2K5KYEvkVqlQEGjWKh9
         XX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761028; x=1713365828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKZlsiGSmj1oAmOorazlme/SpRibHSzFq4Lypt1FiW4=;
        b=jEiv99HGf5x/ompfROkLEMZp8b25fE/geFZ4cfU6AZVm+ZeuEGUKaD1J/vzIxeARcU
         Yq2Rssk7QxquhQmGQz0iwrJrhCYV9ao5dhBOxBZYp0UewS8my2336l9KiRIblHybvAO3
         HyxwyRwCOavN0j7xtOhiLEMexr4Az4TooHY2ZZ9tx7FFkxh+zeysLSkr8zybX/9qAJE6
         ZACehbexm2vyUA8VEhchEpH/OFDKeGrdAwGwfTAyEHZz2MYBrfttdtKANqRNNZ2Ub9FN
         JBVUXoZiOSHHVrCoam84yFdNHN6q9Y+eYMRC60GJM+RNTONcu3Ld68P9QYT3q/CLSUlj
         SuMw==
X-Forwarded-Encrypted: i=1; AJvYcCVlNRjJw9tYpNtsvgbPAASTFHvPdBmsmE1aRLeae8C4GEYVxqDbd37Z6+EbPfFk6bYEi2sbcb1WZhixtQvVKgLgFiXVUpwwtg/NIbAY/mo3Th/+EPfZlz6BU6zQfmKiQsxwR6B7FalNjhY=
X-Gm-Message-State: AOJu0YzYSOL7NpnTHogax5wCWob3l41CD/55PU8+usubCds8IcL1Vl7/
	baFVIipAkWHbHsBbDZ221AljqCG9WL6d2Very8q/uHgxTArLxlWs
X-Google-Smtp-Source: AGHT+IHjkI+mrqX8qdjgWtvycBe8GnW3NGYClqb8Gq07Es6IUFHrdNgyWrkVqdHTqVfDlpVz92eGGg==
X-Received: by 2002:a05:6a00:8907:b0:6ed:cd4c:cc11 with SMTP id hw7-20020a056a00890700b006edcd4ccc11mr1351552pfb.25.1712761028554;
        Wed, 10 Apr 2024 07:57:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020aa79dc4000000b006e8f75d3b07sm10200788pfq.181.2024.04.10.07.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 07:57:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 10 Apr 2024 07:57:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] hwmon: add HAS_IOPORT dependencies
Message-ID: <832781c8-cebf-4d4e-936a-67cbeac8bf4d@roeck-us.net>
References: <20240404124700.3807842-1-schnelle@linux.ibm.com>
 <20240404124700.3807842-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404124700.3807842-2-schnelle@linux.ibm.com>

On Thu, Apr 04, 2024 at 02:47:00PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to add HAS_IOPORT as dependency for those
> drivers using them.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Applied.

Guenter

