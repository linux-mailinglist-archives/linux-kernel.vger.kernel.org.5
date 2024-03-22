Return-Path: <linux-kernel+bounces-110956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3988663E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D561C236C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B21BE66;
	Fri, 22 Mar 2024 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXkAkenu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DD88C11
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711085530; cv=none; b=DiG1CemcT5jmlxFzIuHIKqE5avke1dSIntayeWkrdh2VDRK/LU5vxxAfM1SaJmShVvjmqU477KQVJH09Litp02wWy0vzQs6CN3nTgTM+VTHW8tHwo2nSGEAMJdNOtbtaaqM+13/MNofmBSuQnMfy+i5h6j5IbWDGP0Hm1dhIE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711085530; c=relaxed/simple;
	bh=gW3fIZf8vN6iEiqmwYK/QLqdMMMGzpIb+vf5nBRh7oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMHVuhXH/YlxV+z54HdK/Bk8yaaKo7Ar2357cLkMw8KqCmxVx+eoOd49FHE3rHjECg+gIaneeNpwXrzx4QheYXg4A1oCO9ROqHaPx4q4wry9M629HgD/GJo5bUHfReJtecQF4PXH36yErzAKozmtOpX4uyBUaECGUuR+mnMzQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXkAkenu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-414775b1cacso7352705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711085527; x=1711690327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+glO5iNDnOJRX1bMlWGx35LFvgqhLSy12w38sJ7h5I=;
        b=DXkAkenuMD7Dq0tSxFGZb9UuWfFh3h4GzTJcEZ+KwSTUI6OBpVtt2i4OILSAvO20wc
         dg9+NhibWifTjbapox5n/gfBfKoIWfBJ8L8mBWlgUoax3768YRVrqRjd25xhjDA1iv7Y
         gqxLn1kRI1iRX1YDDHxuPR2KzqEgjaW8y2PMv12DaypLPyyxUZJqrMsLx212XZ1Q/YKM
         Vbk9eKR2YoMlo6mpnDkNrFiOY0eI2zul2smqOGRwR+t3Dkki63suyfdfiL9EnVxABmdr
         8mZPP+p44X7PX37H5WNPj6+MMa01EcyWuMQAz9TK+6XzG1Xd6N02ABp4R8sIopen9Qke
         WB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711085527; x=1711690327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+glO5iNDnOJRX1bMlWGx35LFvgqhLSy12w38sJ7h5I=;
        b=PcAFC9qhdRQLr+NzDKYoP/vB7O4TEJEVHpPeZTcmD0H5idzkltqp1DTN+2nO1ZSOoR
         IS5NjG/w9X5+2m8ZhmaRjqK7vugW4uYYDYxdP7/QN7bxb1eCSEWJlk5KaKXy0HDqziUj
         mPijhxYve9CcEage/2PdoW7C9zk1Xe1KBw/gSe3U2/U7Jai4CzZdnI8Ecrwfcm7Pyrwi
         Ec29InQvIjbiEF/torRr6Jg4SgYoPt6Dn586Bi0IaW2HxG9xYHs7g66/Fi0EJiJymYVC
         HQEE7vDcpk9VLvBSZdY7Lu/5MwMiWAiq+/J4jR5EGlAIkZj3MXU523qPIdxwJb2l8V50
         zKxA==
X-Forwarded-Encrypted: i=1; AJvYcCX6l992QSHO3JHz/bo05NCN8StuiBg+gbsGFHOn6fH2LKXZLI3Bz24/iGb1GYbPAxkqlKPMt5yjeTghUSYpaFBixb97PDLmMO5KUGfj
X-Gm-Message-State: AOJu0Yy52BQWphPcJn+bw7kILOi2NZiH+9TtYuygWxXSlaRm0wgr9TVv
	eZ/DVJAnJbn6tGAO3AVNiOZnYe7PVGoWGnHLFssfn3uOV4B/9a3WnhLw/zlLLDQ=
X-Google-Smtp-Source: AGHT+IFUrNidyaL2odjdKfD+FtYadw4MHtswbb1LkvUM7SXIPYO/YUG7URif4e21XfDKyIOZxaierw==
X-Received: by 2002:a05:600c:3502:b0:414:7909:6680 with SMTP id h2-20020a05600c350200b0041479096680mr751469wmq.16.1711085527043;
        Thu, 21 Mar 2024 22:32:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4d12000000b0033ec8f3ca9bsm1190810wrt.49.2024.03.21.22.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 22:32:06 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:32:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Laight <David.Laight@aculab.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Kees Cook <keescook@chromium.org>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH v2 net] ice: Fix freeing uninitialized pointers
Message-ID: <7ca4a907-2a9c-4711-a13c-22cbfec15e0e@moroto.mountain>
References: <0efe132b-b343-4438-bb00-5a4b82722ed3@moroto.mountain>
 <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d7062e1-995b-42bc-8a62-d57c8cb588ee@web.de>

Markus please don't do this.  Don't take a controversial opinion and
start trying to force it on everyone via review comments and an
automatic converstion script.

regards,
dan carpenter


