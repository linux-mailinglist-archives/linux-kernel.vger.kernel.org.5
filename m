Return-Path: <linux-kernel+bounces-107381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50287FBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE11C2193B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D25A7E111;
	Tue, 19 Mar 2024 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VXhS4Gkv"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1517D419
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843928; cv=none; b=jZ5VpJRHUd04UVO1+FXh8Ut0i6MpbZTnEOmCn/k7yvF7UowSB6KJRiT/epQDwd8X46wxw3ugpo4yO491MZKM89vEDOwX8ndFkDUuw56GjgJJF6MEyhdXwLg4Fnp8qkEYriI+t9nhMkAcCkDbrXquzsTGl21pbiuCwcdix4tYlNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843928; c=relaxed/simple;
	bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg6NHi4UW28oG/oFBzFZK5DX8rpHU30uHtijJthhLHnfC41s7wWu2AR7QJdSpvDWmNV6ZV3I9Fu76l1WjSxh77r0/vgugQsIhMctdWc9mRBnihgfNEwki6k1xIE8wQ8tjbNlCQHo+1DtHOvqy3AY58l0ILjvwLiKyQFTkuCZvJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VXhS4Gkv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41466e01965so2043005e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843924; x=1711448724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=VXhS4Gkv3JpVyE0Jn3EMieo4GTcl8/33vRiFMufkr0q4oyPW/uxeH/AMhHNYYhpRLn
         40+WYzrxLHPL62UpHmVgTulielRsx/vdEIbuhbSa3ZZmCNqNKYuUQ/BJTnsLS0LpU0Mt
         vgfZBJ6Sch90t9/DMEzA7/vmuyA3S0zWmBGOEGphGLZkZg7NLlbG+6YTzf1ky/HIiumZ
         nT8lj6BjT+sojDywhI87dz0gFg4dHJ7bZqbfOWZ9BUexvOjAwFF48jRVEs65wvwCEN+Q
         f+AqgvwrBwnh5r7ImVDkRHoEfzPA3uNfZb7o8LLaN43kCqN3UAUz6oe3hWrFt/i6cJqi
         Ckaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843924; x=1711448724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnBNIG4DWvyES4WjoqSTtsh1i7tgE0uwjYJgRmeTR+M=;
        b=ulQl/MpWgw6FkLzitBnMkQIUZ8vuwoG1qNF888eGkaoj7KTsFobb3fzfEb9SZSvGGT
         DpgXTJIfJmD7Tq+mv9ziAap1aGxGJZAXvHPNmxQ8Dn4c9p1bhTzUoAm0bIakhOkrCpcX
         GYHLSyRwQQXXgDSVCmOLILSw+0iU6hvCemr1HCqTXV3T/4uKaHPtcPmqm7Ng1nlRq08E
         Zy3Y+kvt9YEZkmob+bNnH+yUGIv0pRWArz7lpL7EA/u5CwKRnxgD41mxkKTuFlAvAj5V
         e1FSPwBOD2wOVwQMik9Gp+DtgXvVIyXQUFUH6hWi2J1XoIKzmcwV2nTalzWWM3j8gkJk
         YOBw==
X-Forwarded-Encrypted: i=1; AJvYcCVeYDDt6g9Vrl3A9EQQK45qDQ++RYL+/zBDu7LWRFVEmIat/jXqQ/8r8o2fIhs/Yo4lwrXaiyLSWwhLsmhhTIbATnc/qaUxVfb095vF
X-Gm-Message-State: AOJu0YysjDHYBjBClcPLIJ0mzXu7bHvTS2o0WFFuSP41gwOG5RMFFQKP
	YAFVkhxh5mgCN66eC9TVWMJ5kSWlpnOaHYwjAhbOvHKWQUqcJNjuu03VEpnbonw=
X-Google-Smtp-Source: AGHT+IHotenhFWM7P6vIUURB0jw7q6bTdPsEpzEoM54hT5u8Tjrs6OMB9+Q8kc7xsi832O6gONs24w==
X-Received: by 2002:a05:600c:4e89:b0:414:1fc:1081 with SMTP id f9-20020a05600c4e8900b0041401fc1081mr7799276wmq.36.1710843923987;
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm17626214wmb.46.2024.03.19.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:25:23 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:25:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] can: mcp251x: Fix up includes
Message-ID: <ZfloDwb0XMI7KryR@nanopsycho>
References: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318193410.178163-1-andriy.shevchenko@linux.intel.com>

Mon, Mar 18, 2024 at 08:34:10PM CET, andriy.shevchenko@linux.intel.com wrote:
>This driver is including the legacy GPIO header <linux/gpio.h>
>but the only thing it is using from that header is the wrong
>define for GPIOF_DIR_OUT.
>
>Fix it up by using GPIO_LINE_DIRECTION_* macros respectively.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

net-next is closed, send again next week.

