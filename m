Return-Path: <linux-kernel+bounces-8523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5681B902
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044A7286578
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721D64AA9;
	Thu, 21 Dec 2023 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0oS8v+e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894C759929;
	Thu, 21 Dec 2023 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a236456fee1so97080566b.1;
        Thu, 21 Dec 2023 05:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703166480; x=1703771280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3bECvggky9Gr1iMkQbFegJ4kp/uXj9cku7pm8F83ADI=;
        b=E0oS8v+et+bT3EgmtjWYQRFsDJjOwwtv5kNjhQ1vfYKBVz/493kOMi+WnirBED+8/t
         n6L1IOIJ+FrLZxxG2k3aXfrq5dCIX8XuBftvuZyy4v9YKPTJTDZKWxCVgQxQ6NRyM+aY
         ochZZGHU/oKB9BuU0Ee5P491NVN1bh4cpw4ZnKkLB83qa1H92NGRWYu24SMc9Y/YydfC
         RydD4rIkq0uNJU5235b1ziTonI2xiakfXA7aiG70JeTZnply6CcOkgNP+LPgW1hXwvuy
         zuC1DQZOtFYi4jD8pqrLszfCZw7ltUslMygWZSxgPl9AxUKNTDtAiaGMxQYy4n4wXwVT
         pjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703166480; x=1703771280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bECvggky9Gr1iMkQbFegJ4kp/uXj9cku7pm8F83ADI=;
        b=vfU+Iw1jstG1nXRXZioZ2wgC3zFEjufxzk2T8as+a/+aSeDGBkuHUNP0YQ5pHgwf0Q
         ENwC8OTCq6u0uucKz8SZ6zWSSUyAmXRcUDnOMAeC+NzojqLXqu3vxZatfKsBFiQTL6ve
         HaeLHRNW3LyDifXiqx+yHAM+Wx3azepXxUuBUqSWj5Dgvid95qCrtvZ6ISDF+FxjUL0/
         0ykU57HW/5shBoOdU2ZE29cHPo0yuuIaMx+CxQYeSHBli4JLCbUWNRBP//zrpwY5ljci
         4xTyMyluwe8vGJfvbeK3/cPu8O2stOfTitZkz0cCiUL9t+1LyIJym1fJec321zKJurH2
         HV7A==
X-Gm-Message-State: AOJu0YyZzxzmRxDEYE3fYtswLhqxebpkAZgx1oYKBWIkEOd7J8MF8fcp
	JuHCfCEINb+oF3NkMg2G/zc=
X-Google-Smtp-Source: AGHT+IHldRfP0gErmbkSPhRzjjSGbZhxxQhXQycsWrhetXjzpXTaM2Cpzbqyd6nXrsMl/+7AuoBJkQ==
X-Received: by 2002:a17:906:c50a:b0:a23:5905:1521 with SMTP id bf10-20020a170906c50a00b00a2359051521mr3011817ejb.100.1703166479788;
        Thu, 21 Dec 2023 05:47:59 -0800 (PST)
Received: from eichest-laptop ([2a02:168:af72:0:fcc7:6bc:8973:63f3])
        by smtp.gmail.com with ESMTPSA id ez24-20020a1709070bd800b00a250c28ef83sm972149ejc.75.2023.12.21.05.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 05:47:59 -0800 (PST)
Date: Thu, 21 Dec 2023 14:47:57 +0100
From: Stefan Eichenberger <eichest@gmail.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] net: phy: marvell-88q2xxx: add driver for the
 Marvell 88Q2220 PHY
Message-ID: <ZYRCDTWgHbM2qAom@eichest-laptop>
References: <20231219093554.GA6393@debian>
 <20231221072853.107678-1-dima.fedrau@gmail.com>
 <20231221072853.107678-5-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221072853.107678-5-dima.fedrau@gmail.com>

Hi Dimitri,

On Thu, Dec 21, 2023 at 08:28:51AM +0100, Dimitri Fedrau wrote:
> Add a driver for the Marvell 88Q2220. This driver allows to detect the
> link, switch between 100BASE-T1 and 1000BASE-T1 and switch between
> master and slave mode and autonegotiation.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>

I tried to make your patch work in my setup but I'm unable to force a
link speed. Were you able to force a different link speed with the
following command?
ethtool -s eth0 speed 100 autoneg off

Regards,
Stefan

