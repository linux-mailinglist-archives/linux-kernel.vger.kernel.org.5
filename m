Return-Path: <linux-kernel+bounces-51729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6D848EA6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7701C21C79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB27A225D4;
	Sun,  4 Feb 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBzPIHvb"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89A81EA7C;
	Sun,  4 Feb 2024 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707058242; cv=none; b=h8FqTqvCoT17H4dPctZSyxKfsDcmFskJTeZSavvXobkIBur58eFCgPUcOjjeddoXqHUxCl0QtPaHRIlFqimJimmFYgoSuf9eiufViGc9o37G4+uqjarze10NGui0kQ0GcKQIduzik4HpAYU6Z1BPrZYwpKBAzHortVOQIxswiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707058242; c=relaxed/simple;
	bh=HT/Bk8494dHlbDrMAhPx2xWwp8+JW/84uYVqbVQcuiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8DqNyWQcxTwCSIrzLXMxO+ttb8aAeb49f45cggE+Qoixi13Dksh5YY8UHGhat+PyuvtB7Xym/HVo8cIIXmz2xnz8PiLpC9XAeU0F38fYEEXmNSnu+RvE8R5mzwLBCF1Zqbq72Y33fc5pNEG2s5q4XefSilAeTie+dCbD54cHgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBzPIHvb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-295f9a4a656so2971147a91.1;
        Sun, 04 Feb 2024 06:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707058240; x=1707663040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsZuRdx+Nr70AwdSYjYahltey3ukyaLl20XdZHsUDt8=;
        b=FBzPIHvbOsJZs/3np3EonRdl3JRgtzdP5YuLUiNgR/0UZmjBCFP3p+GZ1WYqMKxuYo
         WcP0tZnzTSqV1FfjNAZykw5h33AyXTwh3pXMPBIIZffdK/cHHMCZLyIN5Radn2F1np/v
         nN1C6Ffp6jGmb13V68Xcv4OgiDf4a3kO5WPTmWtmgV0o65VKyzEjsTkOdtUv77HeHqZf
         qbVrSTHRvyJtfBZgAJPtz2D0AV/3AcsxCApNaptqfM2PCTAYlwD4/8OE/YMeBXsw8haJ
         cqKaG+G/HS0hkUQpqW1paSmKeEmRk+jqbmgFMNBdfVFi+l4etB8mPal7/SvP+ajVRDYy
         +Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707058240; x=1707663040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsZuRdx+Nr70AwdSYjYahltey3ukyaLl20XdZHsUDt8=;
        b=mv2ImX7wPZg+WL3Hq/4TfhJ9Uu+5Cmp34LRtZh74enycAIwsmwfpsgMe+EeYW6J6eH
         Jj6q9JrDW033stTVDKavlxYwyCthbtpBftZxu2pCSKPsIoO/5DfdomyVkXvbRGG9uU8g
         20M/e7cJ4ZSSD1/n4YoL08NNMzZ0Aesor1sDCDOMEl0RVvym/gQYovG4Apb/6DGBPVm9
         vtaVQeXiAyF1KJJY3KdvGxt9UcGI/EWtUPh8pMUHQ/3bklMDWPqgGecaJKxN+6Ld3yXx
         dZ+BKvJt+jL22hinGNcNXwxRzeWley+mozMcfu5PwGw/KiihOQRWXVFaJEJM+Frn5z/n
         iwCg==
X-Gm-Message-State: AOJu0YwTqHnpsXXzMsFndW5/I8M9Djk6EQP04rRXUaZcEIhVlE6qnC2w
	BUMTyRLd+cvlA36HOfdJiDIevwk7R8bM08JD/A9RSRsDlMFI/H/B
X-Google-Smtp-Source: AGHT+IGXO2+mrrmOGCIZfuWVbIndTisfRXSAQ1WVjfWOplg0/Uh1Xhu6NqnyOuzxXOtB+3W6CqxS+g==
X-Received: by 2002:a17:90a:e554:b0:296:69a:34c4 with SMTP id ei20-20020a17090ae55400b00296069a34c4mr11108671pjb.21.1707058240057;
        Sun, 04 Feb 2024 06:50:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW0/LJd5X3BlHuK5yonX7BtQSb0cG3HichPBu2V9IZ46pUiGYleeDdm/ej+wPkfxtXREwotDD4HNKXFpyqxgjZyIZM24/9v0KqqnHKiLRwX8AXdqacefvvpVPt23mLqu0v0j2vk3mzhC7oU9Altj2KF2wQ+8TR++rEvkYSCAej5
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090a854100b002964ce7d420sm3189614pjw.42.2024.02.04.06.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:50:39 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 4 Feb 2024 06:50:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 11/11] hwmon: (coretemp) Use dynamic allocated memory
 for core temp_data
Message-ID: <c9589909-5c24-418b-96fd-f0fcb2be6a8f@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-12-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-12-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:44PM +0800, Zhang Rui wrote:
> The total memory needed for saving per core temperature data depends on
> the number of cores in a package. Using static allocated memory wastes
> memories on systems with low per package core count.
> 
> Improve the code to use dynamic allocated memory so that it can be
> improved further when per package core count information becomes
> available.
> 
> No functional change intended.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

