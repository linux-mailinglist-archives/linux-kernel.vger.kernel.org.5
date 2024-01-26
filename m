Return-Path: <linux-kernel+bounces-40520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41383E1D5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADB911C228F5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408E121A19;
	Fri, 26 Jan 2024 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpGwVar0"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B232261A;
	Fri, 26 Jan 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294415; cv=none; b=I4RcYD40XixkPEMJdoJYBRNlQxic+xTfB5MSS74PkumVMu6AIaKEvxghw3YIetO+w6ZiABk2NNwrT/X4xwP5fGJgKfLRim4q6TaNtLV/Wm7lK/CrWSqVsTfOt9fqHtpCNX4fsuK6gVM0Ts1XfYaD5fWuu/a3NpvNiVVR4hgQGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294415; c=relaxed/simple;
	bh=jLgekl3yQVxGw+Ct5lZL1+5C6JplkMps6ta53/Zk744=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVUtDN0ANv4CY5t7+BD6lYgL8pKYi5UNDwEflLK7Ao2ktrpR/5C3I91SMsSjyuJA2mjb/GnEiYe5W8cTPlYOdetfwpStSoUkTHEWC3xHlTeQEcaslH/NBDfmIcWeu3lMB342nhpwuRTvAgxh0AjAJeAr9aWOUUNJd14dvQJ65os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpGwVar0; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d731b1a038so527253a12.2;
        Fri, 26 Jan 2024 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706294411; x=1706899211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPCkKiNLdTqNBcOwGgsF/YyrV3PFnjUV6tr462aVDKY=;
        b=lpGwVar0tbYRsS8Bar+H/0t6wDvT7Iw6c3w1T8jKqnA3vekdbHLQ4x8q8uMJmgUX+z
         O3oEHt5hTj1Cr2RuOANj+lKj8IYTR+F8H3DOZ8tRqIGNFn3d2QzB/pEED8oXYWrUeNtc
         P7WRMpopBZjd0d4rKMGQEXZrHSFX/BG66pCKo9/jx67sXZ7H5ZE7phGunE3G9A595c45
         +oltM4MAQf0QUkI84DLSiOf+IbWwIJPxKHIst1oUkp2EX31r9LwnrMxo2mCRveE+PUhU
         nPUZY4uHRI+cic6Y3O3tAaGDo4AN5k2jWrtRpF5cJ2qEqkmCM77LI/2G9s05dbMxvKB4
         uC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294411; x=1706899211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPCkKiNLdTqNBcOwGgsF/YyrV3PFnjUV6tr462aVDKY=;
        b=Tqk9FFchYxRbbboBYzcLyu77FELip/tytY/kN0f8F6pv+nu6jFwZO8vaQB5tHPvARO
         PCXtA61i4IHtlQa2tiwvvI6B2YCrtdZacFMzOWo8HborNbSotT3UUIEnFmmjA7lRPP9j
         hGIUwkqJcCxSpDu1mibaWUEUq2MOdTkOMplNOQRjkhHmUg7AhyXWcSAvJwx338cpQdcl
         V6iuAxe1fSX99+94Q85Aazzjq/aXh/ZTdKPXjK+6WVvdx7v/NTtzHlh1zJXYPnrYLmCT
         La1qTvb6HPDuMZc3w99ThCY3waBphjLDGK0x04RRAbk0lgTEgPYSeGhSXm8n9QJ7I2/M
         T1HA==
X-Gm-Message-State: AOJu0YyV3wupRxygAGvVmp8Q+ox+XDW41wcKIDKNXdLeAX8BM17eZHWl
	FJBR4pQre3YV4m+cxLJBcPR/YzuN4ylLAk5xamC9rE6lvCQRElgD8ktjCRgc
X-Google-Smtp-Source: AGHT+IHwh8KZKZ3D2S8qR5ojP0WULEKMOVaSCyCf519juZbmJ/h8mdKHMGzdtUVuEOxt8VoOIHNF6A==
X-Received: by 2002:a05:6a20:ce83:b0:19c:8fc6:caff with SMTP id if3-20020a056a20ce8300b0019c8fc6caffmr159895pzb.60.1706294410924;
        Fri, 26 Jan 2024 10:40:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l18-20020a656812000000b005d0796e779bsm1223175pgt.12.2024.01.26.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 10:40:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 26 Jan 2024 10:40:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Aleksa Savic <savicaleksa83@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] hwmon: gigabyte_waterforce: Fix locking bug in
 waterforce_get_status()
Message-ID: <6fc50bf8-c213-4b0b-9fdd-70caa31b9630@roeck-us.net>
References: <20240122154952.2851934-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122154952.2851934-1-harshit.m.mogalapalli@oracle.com>

On Mon, Jan 22, 2024 at 07:49:52AM -0800, Harshit Mogalapalli wrote:
> Goto 'unlock_and_return' for unlocking before returning on the error
> path.
> 
> Fixes: d5939a793693 ("hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> Reviewed-by: Aleksa Savic <savicaleksa83@gmail.com>

Applied.

Thanks,
Guenter

