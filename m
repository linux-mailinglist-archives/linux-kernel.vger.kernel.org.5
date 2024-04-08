Return-Path: <linux-kernel+bounces-135716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D681289CA2B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40991B291B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45D142E80;
	Mon,  8 Apr 2024 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbI0WAGv"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C44642D;
	Mon,  8 Apr 2024 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712595504; cv=none; b=UeVp+9oCnCJk8WyMkDt9gBqfRohqAV1NvVQdxPyzurYaTSa2fMCofRSfwB+8Fkj28GWyMg6DWymhrPsZoVpr58TH0diLVMVjh+McUc+LrdrB4uBXrXoi0z6gFXQ34YyWiKipSpAM3w0kuuxGsuzAomzBjRBRKSZvczSAGppFpwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712595504; c=relaxed/simple;
	bh=2mpYaM2tfVauCSeEat8zUBHKTSVbf0NpD7/aepH7HXE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvBRtvK/QL+Ct7ebTyCFtbwZDylT4v4FNPkYYHksNV45Lq1EILNCfHlVhdcK5atARx7B0k/U5BJMaNMpe7ffu9lpEl54ajH77ccPcZcT9Mu3fFU1yogdS/TnjNBt/Ki0bTj8floBsvgxGvn3ak9nSbh/9/y684j+nE23YLfMCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbI0WAGv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516dc51bb72so2639389e87.1;
        Mon, 08 Apr 2024 09:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712595500; x=1713200300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Wc9viR696ZI19kXAelRwb6zKJ1jpvFavY5x4ls6Ezhk=;
        b=gbI0WAGvSxxgr6Yf5b96sCAyyDQ4cCgqgc3O6MsTgS9AIQAiJoeXcc/ft8aTtXOE6s
         SgOw5H3SzwygtD2Xz4rMC2Ub2eUBx7L4wnPGdGUL1M8G0dhpWGCSikR/90gv2/uNs/Mk
         NavuV9O1cH/YGsV2m52AEdvBbQD9CRwzls9glslSct62kPv5UAbNXLyDBpUzTyEBDC27
         /jhJGxCgbCQCydxXMC8ouW0TTBAuJ70ZK4C050/XJ4Kb3nfhTbPGdlPwYjdduZP5tMXZ
         BOleECWjyF/FBADu/Q96wuFnIDHk5B5TAbV2RXSCPpugzp6wWyThCT4WfURSqCOUxDcZ
         1a5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712595500; x=1713200300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc9viR696ZI19kXAelRwb6zKJ1jpvFavY5x4ls6Ezhk=;
        b=Tpur1nE1J1xL/VHu4LiHI3vT4r/BWvXyFhlO1ggpfGr+CHDjTCGmM9ClrNFqMqFzTO
         9wJEE9zdEGoMDcWQg5+EAyq/dryWyjBGsesP/FHeL1GlPVmr0dwR0qXymd36tYWT3Frd
         T8OeUrJC2Ntr1gPbtoUhwJJ11+uRxXosJJ1uZRACEGWi1xjyPYmlPHanzp7639ZP3d2X
         W52e07Jw7zFfaCaE57ZjAkpTU3YZShbBYZzZYAINW6hokLljxOVSYSx3PZ1ZWuWScQ4j
         mj87BsscT/z7blYE7gzgcFgy6x/EQxxwOU468eMgpQYcD+BMq4WN+45+Qg7q+mYCJnE8
         M47Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOLkt/wJOXKQChCAtGx+jiM8AgBtIiKB9p61HTp03ogXtnrBzmDo1yPdh+zdKHeAD44n8dqbFtp29CRmKRt4kxy8O9QVXWv0cfbC/qEeSWM7CyhS7khdKEB3wm88aigeLK/C/g5wiF
X-Gm-Message-State: AOJu0Yz0HZP7U4UbpSV2iUTeRknx81Wu/Fe7End7TA1ivJBvUQa8Z9Gf
	u1RhcNQtGS9pUHF3Rsiamd5tr4D12A94hzJ3wOv6w6n7GoypU0aT
X-Google-Smtp-Source: AGHT+IGFOBmY3+FLdBVIEJTXWo+YdncGJhky7kJVomz6BuHWIydeZZp+5jYQGfOoGVKcFpC6V2nyIg==
X-Received: by 2002:a05:651c:a06:b0:2d8:45ff:d606 with SMTP id k6-20020a05651c0a0600b002d845ffd606mr8454085ljq.50.1712595500212;
        Mon, 08 Apr 2024 09:58:20 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:10c1:3571:11ad:946])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0041649f850e7sm7742385wmo.32.2024.04.08.09.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:58:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 8 Apr 2024 18:58:17 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Angel Iglesias <ang.iglesiasg@gmail.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	u.kleine-koenig@pengutronix.de, biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Driver cleanup and series to add triggered buffer
Message-ID: <20240408165817.GA4576@vamoiridPC>
References: <20240407172920.264282-1-vassilisamir@gmail.com>
 <57fe9ec305efff58a2ef1e2ba6e334f042a2ad77.camel@gmail.com>
 <ZhQG41ZhHprOvgsH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQG41ZhHprOvgsH@smile.fi.intel.com>

On Mon, Apr 08, 2024 at 06:01:55PM +0300, Andy Shevchenko wrote:
> On Sun, Apr 07, 2024 at 11:51:22PM +0200, Angel Iglesias wrote:
> > On Sun, 2024-04-07 at 19:29 +0200, Vasileios Amoiridis wrote:
> > > Based on next-20240405.
> > 
> > Hi there! Small tip, with git's format-patch, you can include this information
> > for the people applying the patches with the argument --base=<commit or branch>.
> > This will point to git the base commit from which the series build the
> > changeset.
> 
> Moreover, CIs will be able to properly test it.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Hi guys!

Thank you very much for the info, I will use it for the next version!

Cheers,
Vasilis

