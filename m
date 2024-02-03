Return-Path: <linux-kernel+bounces-51145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98FE848712
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E64B23156
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777845F47F;
	Sat,  3 Feb 2024 15:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmviKh0M"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B255F479;
	Sat,  3 Feb 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706973473; cv=none; b=DlgAbUS3ZIj3+1r31fNcPLUm6YuFm7IKgwE+7Tn3xMlZVdpV/0KN+Ev9DRHN/qs6XgX4aRnkia0bbHFkbO7eJucmccbnkswcsXgi5U+n9zWDhZQtC9xi2UOmqVZ72ymnB0qWxpD4vd1udcMn7RcT/aZgl3iMStl4liI0sV+TYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706973473; c=relaxed/simple;
	bh=IUlOK6oOP99wQKuMhpqLYRYSvzT4AufyHCIUW8c1v2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0AMhY1o1e5lUQWwvrQPT0ZzqSDLgZ2REL2gzXd48Rxh6Y4nnANL1D6laIpSjA1tHw1VoGy52SODg/U4L/VMBt+SJU67rJOTw/vRhZj/UgE4SFZxEEsLqxa54LdrlwgyJ2BNpiUMmPrOtAnvpNq2zFoSWbuPaZIam6njHGh4e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmviKh0M; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso731325ad.1;
        Sat, 03 Feb 2024 07:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706973472; x=1707578272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lUzUF2MBNp5VCtXVAH46rRo9sIQAjaiGzL0rWPuBxk=;
        b=VmviKh0MkzbJHp1wgSWX2HESFAWf5e2qYLz7e7ytDtXfE9Nde8T9xU9g5UgqwHsafU
         M2FJDCudvcrYZf4V1hU9HRPbvDRjdQtjNSPDB/PGG5nsw4B4Ke3jNe5oMhS18xU/GxT7
         Vjp2rDTW1eHNSgAgkYtpAnSpnvt1msV3bAKOzUWA7t187yy567zZpdgsCuCf3wJ0gZqu
         UMMpFewEI28ZuMw9N9+DoMGz9TouGXG+i581CVT1wXJAhNGtd2iTIva1aLGKNCU3rvYe
         vXTFQUNGr+bvWjuTnhcRSvUKYfxF6Gg8STL4BQrBcGYymgb4TPg2CfrY/FcEOQHmGFvR
         esAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706973472; x=1707578272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lUzUF2MBNp5VCtXVAH46rRo9sIQAjaiGzL0rWPuBxk=;
        b=S9LvfN++dwVlvo/mJ9OAULVMoLI6khlolOHikyQO/KlLLM0iwk0vIN/0kKtl4a4nI7
         XmcpLIkIwUJDwff/NVduc9dPQl/CjzbOvJh06xvjYBzyAootwzEww1KJt/2ri1gC9xpX
         v5KErNRmnhfSfulETv1aFP04rz4SgVhUvVtKDAPhBX5JIMAs/QbqKFicQkD5OoQzTzE1
         mAVLCkEwIFjXZ3k4fGdZA1Dy7t1JJ+NlSj4pgcjFgvsxR6WTh1R9I+IJ0tOXpSDnex4R
         wjIWptjutO1On99acMpsEApheRN0geAVZGl88kZPyeQD0HA2C9SLt5PZTwbfOBldPEAB
         /W8g==
X-Gm-Message-State: AOJu0Yw9WkKjgd+bpOwK+vFm0wdhhTkUQ16UvvEclIO2eEe3WdCFP1qr
	zL2cwxOtAHMKT6GDrizoNtkRLpyM+BQhwwCXr7isVigdfs2ygzM+WNB7DKo0
X-Google-Smtp-Source: AGHT+IEW2KW4nZwiBGgCcsLxy1SbfBczTtO90qzrOeBfw49XVDCt9jvVTCQDPSOdHa1RIJKxcy+6Mg==
X-Received: by 2002:a17:902:d2ca:b0:1d9:7814:ae3b with SMTP id n10-20020a170902d2ca00b001d97814ae3bmr2211332plc.21.1706973471785;
        Sat, 03 Feb 2024 07:17:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVF5Uh70ChZOG4rsDfNklgJXQDzdlL9/0NlTFDpm5MfSMYT9sOWuAHLoLZowXJMYfVtkN0Ib+xybTYMOl3zbDBFDfkAZOI3O0986UASbkaNDWA9OpX6skL9nt5Mc6lpyMhkWJjVwZHpsS0AhtAkAWc5eZxAEWfPvcu3ArSbYjFg
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g24-20020a1709029f9800b001d8e671e24asm3352806plq.254.2024.02.03.07.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 07:17:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 3 Feb 2024 07:17:50 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zhang Rui <rui.zhang@intel.com>
Cc: jdelvare@suse.com, fenghua.yu@intel.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 03/11] hwmon: (coretemp) Enlarge per package core
 count limit
Message-ID: <93654683-90b5-43b5-9bef-0427d0042c03@roeck-us.net>
References: <20240202092144.71180-1-rui.zhang@intel.com>
 <20240202092144.71180-4-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202092144.71180-4-rui.zhang@intel.com>

On Fri, Feb 02, 2024 at 05:21:36PM +0800, Zhang Rui wrote:
> Currently, coretemp driver supports only 128 cores per package.
> This loses some core temperature information on systems that have more
> than 128 cores per package.
>  [   58.685033] coretemp coretemp.0: Adding Core 128 failed
>  [   58.692009] coretemp coretemp.0: Adding Core 129 failed
>  ...
> 
> Enlarge the limitation to 512 because there are platforms with more than
> 256 cores per package.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Applied.

Thanks,
Guenter

