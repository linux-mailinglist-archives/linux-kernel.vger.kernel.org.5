Return-Path: <linux-kernel+bounces-46497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083AB8440A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0D7CB303A3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FFE7BB16;
	Wed, 31 Jan 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhfw2EJv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B67BAE5;
	Wed, 31 Jan 2024 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706707721; cv=none; b=DrT/OFYDSMl/hPWi8anPQ1gXSpGnBkODd5F4qBqsQrvTRTftZVHeOD0Qbplj5c8YnqGwmd8SMNVJR+/sxzEdjTfky7Cxh2t48wDA/awVJ5hCIOIMDkGSOXNRClECCAYRi2D3Mry/J1lVwXV3nsI9u8zif+1Q4MPMk8BIrHZyDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706707721; c=relaxed/simple;
	bh=hkrpHEcQf+TZiFzNMNM4XgtUiZ4+ysmYORrH/bHSRIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5c1VHejNBrMOOyK3256QfbRmvjpuYiEQ1ES9Ksm21ssqBoYV2+alPzgEpTfo1MPMY5DVUvd6GYWTC0D7c953p3idNijNVfwoR98RZkJEkv2j7sVDtQ9r019D4hGNjNG/i4oVl2reFAKcKNrtKRvoDE1hkoQugEbmbhw56qyCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhfw2EJv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d7858a469aso30272985ad.2;
        Wed, 31 Jan 2024 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706707719; x=1707312519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vw4Pa1aSCj4JJ6Af9YRWdhnPQg5k2t6xiKlvAoQnHXc=;
        b=Nhfw2EJvW05NzTTwLpZdk81mJXNRT0VOBTt8O5uGmrO1VkGEZL0E1rSZ+jsvG7lgey
         1Ril6qU/R1YI99JxWxNokjR4niLBxkWS4dlLgkR40fLWOs6mvJo+UId8VElFCA0qXSAk
         Ckbfl6QM0PlyJmIvZsJcS12m4C/3KPtQeiGryMly+Vnsv/+Nm8ZKtvevBUljbddMx3L4
         B47Y4zIR43iWVDvHQ/XIfmJ/DjWfxyMCzHvIC9B3pwQEq0vJz36BrjrGymqRwsfPTJDF
         5NvNidNVHpupxiQ7u/rOlfJxOYLHcok4t+2+TcZciQxFW2tfgCjJf3TtAG7Fjs5qqbt1
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706707719; x=1707312519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw4Pa1aSCj4JJ6Af9YRWdhnPQg5k2t6xiKlvAoQnHXc=;
        b=Z+RF0Mgzgn9xepuOZ+6klu6yGY+FZ3p9i+3r4GPC0fF46sKmAE5waCcfUqUty3zULg
         ya03Q0xAib9k4n5aIIK8e7UihhnOef+KFg2v82a3kSggTQ3gDeJ6drq+j0SQGf12tIKb
         rGBYsDrneYG/3o8yCvuHEsX/nsngJVsf5ZA8bUzsj3tPLqBLlgeUozbDOptG2vYlbfGX
         dKKodm9f+TJ1PLlhUXAtYG0LZU31LKzdjJ36P4Tww1mNEfcydSCoIkuZ5E+i01wGVo6D
         WpkGQUQhVwSq12yhze+G5M+U3BfTgOE8f2X50NkaQ4ZIxX0Z8fS18zBOqHFamrSk8k+C
         gvFA==
X-Gm-Message-State: AOJu0YxJUQXh9HG7boAS94uTHLe5S/vzO0mm6whG+5ILBxeXXkWTT6wJ
	L5/bc20kvCnMdYJGNyW1yXFjgwhYQQghKUpjv+DVAtnyVqmYnxeQigf7UHgL
X-Google-Smtp-Source: AGHT+IFlrwme4G//lNWpf2xme2mKYSFYILl4zuerc80suaE7vm0GxpIJ3PpPpLLoWyhNW7uO/7SsHQ==
X-Received: by 2002:a17:902:ecc1:b0:1d8:da36:d084 with SMTP id a1-20020a170902ecc100b001d8da36d084mr2137989plh.66.1706707718797;
        Wed, 31 Jan 2024 05:28:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w7-20020a1709029a8700b001d755acec64sm9049951plp.189.2024.01.31.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:28:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 31 Jan 2024 05:28:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Stefan Gloor <code@stefan-gloor.ch>
Cc: jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] hwmon: (sht3x) read out sensor serial number
Message-ID: <6513564d-6cdb-4442-8142-ca5763b5b351@roeck-us.net>
References: <20240131111512.25321-1-code@stefan-gloor.ch>
 <20240131111512.25321-2-code@stefan-gloor.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131111512.25321-2-code@stefan-gloor.ch>

On Wed, Jan 31, 2024 at 12:15:12PM +0100, Stefan Gloor wrote:
> The temperature/humidity sensors of the STS3x/SHT3x family are
> calibrated and factory-programmed with a unique serial number.
> For some sensors, this serial number can be used to obtain a calibration
> certificate via an API provided by the manufacturer (Sensirion).
> Expose the serial number via debugfs.
> 
> Tested with: 2x STS31, 1x STS32, 1x SHT31
> 
> Signed-off-by: Stefan Gloor <code@stefan-gloor.ch>

Applied.

Thanks,
Guenter

