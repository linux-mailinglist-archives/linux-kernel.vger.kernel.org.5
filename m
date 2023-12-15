Return-Path: <linux-kernel+bounces-1820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3B81547D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7C41F24947
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8F1DDEB;
	Fri, 15 Dec 2023 23:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFy7ZrvP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23766AA6;
	Fri, 15 Dec 2023 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d39afa1eecso316705ad.2;
        Fri, 15 Dec 2023 15:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702682846; x=1703287646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUijnMG3eQXM+CVKamx2ToNpricn5q+qhrLr2Z8uHac=;
        b=HFy7ZrvPnH/oHGRrRduk4JtNmCwXzSrT4FeqiTK6R/tDnaXXINCavimCTf8a1QMF+n
         0cRPTU2xvnumnyFMZJDFyHDN76exXL03cd/11xS/Bz/rt99Fg87fUJ9qX/yYDpeZcqlA
         VXOV/RuveMQjU0jv+5GiqIW/cJwoUQBtnrR+4pwcAftFjyd8vM2F2TC1SgzK3fGBXvZv
         ws1SPYqKf79aFRngIADq52IimG4N0FTf9N1xnoH7tDZXXiZoX6qnPTBk3Ak2QlGViaJW
         IjCxEc4ZlOwJPnymJvtqHxrt13uxZoiA2G66ViC2l/nARR/tiNjFcNktksxs3H124Qiq
         ez5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702682846; x=1703287646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUijnMG3eQXM+CVKamx2ToNpricn5q+qhrLr2Z8uHac=;
        b=OBqTm5/vc29IHslUUok3ZJoR+Ynna9HHj6/EZTUSBDhwKeCkWYugTTtb4ST7h4KG5k
         QJSw2Xk2Mqfz6B9YL+EMpnhGA+fL3dcc1XmLdvI7hVFtnCrw5eTHgDPR+hArPDVjMOvL
         lp1SPPiS+po31uuZyMxi6A5v0aRB5WgKTlvro81BwuHccyfdI5bIfWnJ2xnfgdK6MAX1
         8qJOpV1voU8BvTeDJ590M8QJMhiQsGmT2MyGkrixlBieRBCLQ0yAOo4o+aTNjWQ5pXz2
         brij5c/BvyWg9wha4TLws90K0pXdQf/CjHtCFp/R68A92VuvQkW+WlbMkC/xUNOilmMC
         fl0g==
X-Gm-Message-State: AOJu0YwmM6OGQEz6OR7mpGZ5ossA1W2vu0fm1fzZRU6dYm8vDsUEhLr+
	REjZy+sqQ0s/UrmRlGPHjoE=
X-Google-Smtp-Source: AGHT+IESSr8LJWu5eM7SL9dIxxkhfdU1ZWd3ocqekNNBxYjPFqYts+ArRbeNWJoNint/5zU1NXbjHQ==
X-Received: by 2002:a17:902:7d8e:b0:1d3:45b7:bc09 with SMTP id a14-20020a1709027d8e00b001d345b7bc09mr5647033plm.55.1702682845703;
        Fri, 15 Dec 2023 15:27:25 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id y24-20020a17090aa41800b00287731b0ceasm7756536pjp.13.2023.12.15.15.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 15:27:25 -0800 (PST)
Date: Sat, 16 Dec 2023 07:27:20 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH v3 3/5] gpiolib: cdev: reduce locking in
 gpio_desc_to_lineinfo()
Message-ID: <ZXzg2DkAPPQV8vft@rigel>
References: <20231215023805.63289-1-warthog618@gmail.com>
 <20231215023805.63289-4-warthog618@gmail.com>
 <ZXyAh2hfhb3l5ogO@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyAh2hfhb3l5ogO@smile.fi.intel.com>

On Fri, Dec 15, 2023 at 06:36:23PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 15, 2023 at 10:38:03AM +0800, Kent Gibson wrote:
> > Reduce the time holding the gpio_lock by snapshotting the desc flags,
> > rather than testing them individually while holding the lock.
> >
> > Accept that the calculation of the used field is inherently racy, and
> > only check the availability of the line from pinctrl if other checks
> > pass, so avoiding the check for lines that are otherwise in use.
>
> Just wondering if you are using --histogram (diff algo) when preparing
> the patches...
>

Was just using the default myers.
Only changes patch 4, which it does make slightly more readable, so
will use it for v4.

Cheers,
Kent.

