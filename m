Return-Path: <linux-kernel+bounces-51143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0784870D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E429DB251F5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0A5F476;
	Sat,  3 Feb 2024 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSUtSZeQ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2AB5EE93;
	Sat,  3 Feb 2024 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973373; cv=none; b=VfPKhoqt4SWX3rt60clcTfW3ZdDsKi4/D8JGkD6vvHKYNcJIAqWCHlgo1JX0J7pkKzMAAhBAwD9S6ldL/yh5QwRTzbllGtTte/ySL7zVHexkSthegXGMv6ibKuckMiv6AqyOd/xkD04KoTkRTtxPybzwSuxDAgvIbnPBemA7nCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973373; c=relaxed/simple;
	bh=Y0q9/BQilvm3qYeRJi9h02bjPq7cF5O9ZLn2i+Sr48g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqU18mJyD1dS46o/90dAFyaumr1ancn9dm1I8udguSWd2so18iH0zWfxSzeCGPoEoO42dILy0C/8uW1o1TeTwi06fftTRbahbHcD97P72KYRY4MgGCHmHaSQ6zGTIl6Z8YrVtiiQkWhuWz91tG/gCLjfIc4OnkWB64Rs1cbNS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSUtSZeQ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-296717ccc2aso119165a91.1;
        Sat, 03 Feb 2024 07:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973371; x=1707578171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tVhvYY6kizem2jusRDH+xBHd2AR0/XmV6/6BdruY08=;
        b=TSUtSZeQ3NDCKLkOI0WFaEej7ImXV7jNCvIFLKZCrEDOP/FDqGL5hCGNANwKPlyU2/
         hBFeaLMREaNTY/dWo7AU0Lh8IVKE7h0XcDY1IqIDMdEIFETkduF61qDgHZbdfGWKR32V
         9ge3V8qEd/LlO38liczbulxXRj/PyDR8VGegGIV729JZk7exUjmw4W+iK7FyHrb88rd0
         u8S7+lb58HenlgyIG2WLpVlzgvDekbT+iOl+meKD+Xc11fdbX+0O8VAyGS8r/FYZx9XL
         SPxQTR9jo3CZK47Dmd5cg7wNHHz3B8tp2Q8G5gtkESOXxQ0XBGRfPo6kwhQiczWylAv9
         rW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973371; x=1707578171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3tVhvYY6kizem2jusRDH+xBHd2AR0/XmV6/6BdruY08=;
        b=C1pimUbfO1TV+5UX1857FuWQxwck9DMDYQF7zGmy46mhxZEsRvmUV0Vpzifr7yFDsM
         lllYGKkimkTbv+2sw566X5ZTVEOqN3p3syJRdkPd52gtbyni3SEAYFfj3b/XXhvdoQb0
         +FgN7jiVlmsGKUYm3hS/SQ49ffEHQf0FIigP2acy1YJCjQCaBG5MDoZpYZU783uwwRwM
         2PfzY57qfUZAwfzReHSq5eybBu2IE7+86yq5Z/xJ0Tidf6Ku+OASijborUOaVzuI4ZK4
         qOYnWpxofaMlfGYux6TtMuSdKL/cHx20QohSXPsdqsTqintinc4G5GfFIefFMp3zLgGF
         ps/Q==
X-Gm-Message-State: AOJu0YxlscFLt1P3/dKi7IFJuWxA6SY2ZEUtQ7yZXAhjn+73DstuARak
	lCf3GPkSkiwPklBJKjyRqFN6Y2gwtzJRbnV9h1FL9MGWuBHyvJ6q
X-Google-Smtp-Source: AGHT+IHBg+EvyAG1D+NXF4TgyWh+/02KCWKJcmTiPN2FfktiA0vJ7l6K0PtGqeadK4crfJrTU0vGSw==
X-Received: by 2002:a17:90a:ea0a:b0:296:530:996e with SMTP id w10-20020a17090aea0a00b002960530996emr2188683pjy.20.1706973371035;
        Sat, 03 Feb 2024 07:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVOgmgxQbKRgo2co3+WpKAKHvuTkXIuvATrV9GqQeKY6uheKMTFzjqfyiimUWpJzEdWtEHLi6FTz4llQ739W9vx2r+zJ2UR2TMzk5gw8cJImL0cLzfpZ3tbtqGl6/zxDMgWP+FCg8JKHoCA82NkQvJTXXL+cerVpDGbcSo+96az
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fu15-20020a17090ad18f00b002967bc2c852sm177227pjb.43.2024.02.03.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:16:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:16:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 01/11] hwmon: (coretemp) Fix out-of-bounds memory
 access
Message-ID: <882c6e80-0282-4c94-8f3c-084ba107f007@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-2-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-2-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:34PM +0800, Zhang Rui wrote:
> Fix a bug that pdata->cpu_map[] is set before out-of-bounds check.
> The problem might be triggered on systems with more than 128 cores per
> package.
> 
> Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Cc: <stable@vger.kernel.org>

Applied.

Thanks,
Guenter

