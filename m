Return-Path: <linux-kernel+bounces-135284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527B289BE63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E0CB226A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760AC6A014;
	Mon,  8 Apr 2024 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaKOiWZw"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D92669DF5;
	Mon,  8 Apr 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712576988; cv=none; b=AxeC4ElZjxOsgRqXZD/+oz8aFHaLf0+fBNfdgrPcOKoQM0Q3K4hHriVfu3U2GuawEtODjWBDoDT2g7Z5rGvHHcABbTxSGI+yuPPhDdu3uq9ksTyKuDkCcEPpL6eFj7bbD8Picbjz+uHrX91MD69XJ6HnAkJHuQnq1Z7C+z3evpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712576988; c=relaxed/simple;
	bh=t/PziARB1DDQE+QkAYx3JX2/jBRkYdtjisvnQqQaxO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb2asdzueIA8+DiRQMiJuT97qmYaWR/HzDsxFQ6nLZvkveFUuiL2vEBfrIiZDgWQDMWpmTJCxtDZJyGcXn1bxkuMWarl0TCaD+n+I48A0YdEKhJ37/O2EqEQ+Bslh/N+UEnnxURVlx4kr3aI5bAdwnmNdI3tzq84HwZ11BW5Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaKOiWZw; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5aa26990d5aso928578eaf.1;
        Mon, 08 Apr 2024 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712576985; x=1713181785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMyACkH/7gkijJXbfsrdkRAuYsDQYSZJdsM+qnK7di8=;
        b=FaKOiWZw7sHCxVFQwnzayexd4GVpu9M7qLPDnUIMEOh7ENXrvDKBneRHHpwNgeRMeE
         7QADzb/6CnBsKNYwddMNWkTH6lCIJNdZujF2ojbOwGjsCMXitpWyRaQY2skS9f8YqgX0
         b4Le7CZ2zPOHnbBYkseseetRIYlJSd67gf8DOgJlBZIAKXVlP8/ckd8vrcNfmqYqpNju
         VzxNq/fyA4HeHGi96UKi2+YcUbJsOgmpJhj6dTzo7WDQ19fqkpgkuMm/9W/jMu36rY6d
         rgO8JFxoBaqYbFRZZCjmTdYcelo1qwqpZJy+x/VlGqI/1WGEUtK9ln/AJVQGHenl99nH
         7fXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712576985; x=1713181785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMyACkH/7gkijJXbfsrdkRAuYsDQYSZJdsM+qnK7di8=;
        b=Vo6zJWW7n24N7rbEB0b6N746WBqKGC9xbI2C+z4YvWaMrObgKrDEzRbV54K9JdK7Oo
         xZsuI8FTsXzp7AK3iIfWxCr6SYSGvKGNgy6M+wJitvQTyaNVrHu9+2ORHy1vGbO4g1iv
         j/BiS2VH3GSNn+v676bm5KnsUy2F5g5uaQuqXvpB+l+4Mo7/Nw7MRXPP+Nw6E5TZkPGR
         LnbmPJcgu2hNnrRIPBTi+mcjGvvbJb2bdW2Szkx/e8JGAlnKI2zZ0Yf2nOVnltcWa3uj
         G3w9HsxYYR0TGWSHmZnOeQaT4HNgDAHwxGLBf3ALyynaKGb/UqgjW9qXfE0i2URwbrae
         8OXg==
X-Forwarded-Encrypted: i=1; AJvYcCVAg4xsfovIA+XFkycBDuVudHYhm7LppFiNrQBr+9b63el3F4wmkmt0v2vRo5N/k6usWWkg91bxXKyY6LyIzAwY4V9MMYkZyySCZbwtCHAY1RkUQD5ezcUBU4HgK7/vZdV2nsDKAHxERI4=
X-Gm-Message-State: AOJu0Yx3aLvudTndp94PN4CrgQk7lPm7JIFSvUh1DJy6c5wGnA1LXcwT
	PA7zmhMbnYfwixSPR+nLT1UsGR0ZNwzE+m6vR6Rd22Oe1e2UleuD
X-Google-Smtp-Source: AGHT+IHsTk2XQQSOsBCCV3Cm0qaZ5654TP3rnPCF174U4Rd1l53ugWvYsg0ga5Zmp8Ouu/7FUjTwpQ==
X-Received: by 2002:a05:6358:5c16:b0:183:e337:8eb8 with SMTP id x22-20020a0563585c1600b00183e3378eb8mr10155239rwe.13.1712576985067;
        Mon, 08 Apr 2024 04:49:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l23-20020a635717000000b005cd835182c5sm6341216pgb.79.2024.04.08.04.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 04:49:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 8 Apr 2024 04:49:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Davis <afd@ti.com>
Cc: Jean Delvare <jdelvare@suse.com>, Juerg Haefliger <juergh@proton.me>,
	Riku Voipio <riku.voipio@iki.fi>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/31] Remove use of i2c_match_id in HWMON
Message-ID: <fcafe904-383c-49c0-b576-81cbcde045c5@roeck-us.net>
References: <20240403203633.914389-1-afd@ti.com>
 <0e43aa83-2e02-49e2-96b8-24cac0362a7b@roeck-us.net>
 <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b2f8ce-0b71-4a7a-81bc-a64a1af3566d@ti.com>

On Wed, Apr 03, 2024 at 05:06:43PM -0500, Andrew Davis wrote:
> On 4/3/24 4:30 PM, Guenter Roeck wrote:
> > On Wed, Apr 03, 2024 at 03:36:02PM -0500, Andrew Davis wrote:
> > > Hello all,
> > > 
> > > Goal here is to remove the i2c_match_id() function from all drivers.
> > > Using i2c_get_match_data() can simplify code and has some other
> > > benefits described in the patches.
> > > 
> > 
> > The return value from i2c_match_id() is typically an integer (chip ID)
> > starting with 0. Previously it has been claimed that this would be
> > unacceptable for i2c_get_match_data(), and chip IDs were changed to start
> > with 1. Commit ac0c26bae662 ("hwmon: (lm25066) Use i2c_get_match_data()")
> > is an example. Either this series is wrong, or the previous claim that
> > chip IDs (i.e., the content of .driver_data or .data) must not be 0 was
> > wrong. Which one is it ? I find it very confusing that the chip type for
> > some drivers now starts with 1 and for others with 0. Given that, I am not
> > inclined to accept this series unless it is explained in detail why the
> > chip type enum in, for example, drivers/hwmon/pmbus/lm25066.c has to start
> > with one but is ok to start with 0 for all drivers affected by this
> > series. Quite frankly, even if there is some kind of explanation, I am not
> > sure if I am going to accept it because future driver developers won't
> > know if they have to start chip types with 0 or 1.
> > 
> 
> i2c_get_match_data() has no issue with returning 0 when the driver_data
> for the match is also 0 (as it will be when the chip type is 0 here).
> 
> The confusion might be that returning 0 is also considered a failure code.
> This is a problem in general with returning errors in-band with data, and
> that is nothing new as i2c_match_id() does the same thing.
> 
> Actually, i2c_match_id() is worse as most of these drivers take the result
> from that and immediately dereference it. Meaning if i2c_match_id() ever did
> failed to find a match, they would crash before this series. Luckily i2c_match_id()
> can't fail to find a match as far as I can tell, and so for the same reason
> neither can i2c_get_match_data(), which means if 0 is returned it is always
> because the chip ID was actually 0.
> 
> At some point we should switch all the *_get_match_data() functions to
> return an error code and put the match if found as a argument pointer.
> Forcing everyone to changing the chip type to avoid 0 as done in
> ac0c26bae662 is the wrong way to fix an issue like that.
> 

That doesn't really answer my question. It does not explain why it was
necessary to change the chip ID base for other drivers from 0 to 1,
but not for the drivers in this series. I fail to see the difference,
and I have to assume that others looking into the code will have the
same problem.

Guenter

