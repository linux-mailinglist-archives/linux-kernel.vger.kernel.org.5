Return-Path: <linux-kernel+bounces-30639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1883225B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F171F22E42
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442991EB42;
	Thu, 18 Jan 2024 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG3I0Zaq"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E028E03;
	Thu, 18 Jan 2024 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705621463; cv=none; b=XWGKl/o/h1v056euQPPzmkRe6zsXZkhYLJzJkscF10DQzofO0yEaRt0CFGkZZy9qijWDAsPHvQUXlmGhyz0yUR8a+cI/xUhq05LZWfVZjgGJDXS8H3MEW/ujbctBRj4ldQZo5RPmvXBljPV8ZyGLQJncBRwg1qZZopuY47Hk3vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705621463; c=relaxed/simple;
	bh=7ZgPhNITkfgbDK68em6bRmyJKs8QJgGsG7pSQQQNzj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qko1PoHMdQDLxN7WQxIotVPi9Q04xYMs+4oOckiLWKHQ9u/gopSXdl5Z57EtseCXzefJhwfOBCLwAqZ651O0yIs8YPoYwnnaziUhjB4zz1XMHCP5NObO2LDbzTSdh0CuZgT1NEr0Lz5yrZAO8DAum4Yc8pZX1+QKko98cLrZ3RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG3I0Zaq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9f94b9186so277176b3a.0;
        Thu, 18 Jan 2024 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705621461; x=1706226261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lACEUpNy9A2kCgeWPShuuF2qxk8Eoy5GtulP85mIp+w=;
        b=GG3I0Zaq0dMOBKu3CJX/PjoXcD4hLqMiM6k2293HAnsltDGpL0isvyCzlF8LzPzBjc
         j4FkfqrFf8AKxi6GMTX/Hc/q7CcnF0QsIG9cMxtWIAFNmjlXv/945cnSkFYeedMjs7+t
         aZdrKNBoMW9EButR4EfFOClxzgPKymq8N+w5/m0WnAYCVgQ4YORbuYSjOU0Z2Z7zuu+e
         yan7+Bot9REfp0yfI5bgh/HhW3XALpO7IUVizVLDkRjLbGYi4zphJWD2+ai3IsXB/ioH
         QsdLRCJTsOBS0D3YtwRzLtKpkyrfv9XtymHB7ESa9BApJM+zb7sGqeX9spNklhmoiYhS
         Xwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705621461; x=1706226261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lACEUpNy9A2kCgeWPShuuF2qxk8Eoy5GtulP85mIp+w=;
        b=nm6jQfDUH29gO7SoIJlB5SNhm1bbaa6c9lfQKmmwRBsEVGEg/XtKPKm5Am/vJwShy/
         +eMCzJr1SpjFq7ucdDC7DD7GhMDKIpU6soYvfNsgbLv7TbNFzvcM4N9XAdGBqBU6gqW9
         GNNnHTHkmQ/qUZ+BFkRC9x7Ujw06KPFDpsFByh5lClXoTh9fJpHL7KJ0tEzbLP6qFf/s
         1M3OXyGZl2ZLh1/ufpkzNnaOAEuLu+IS+bhQxsZAp/nDRTZxRNj5Wc2sprJpKlYJxRNL
         4WZk7IEMxEJEQPSVXM2l3wtooUFQBrAI+VvGn5CjYcSaVpswaPFPOm1mUPCf+H6FpkzG
         E9KA==
X-Gm-Message-State: AOJu0Ywfrbrp+j6lUcf4D8cCgixD12W0Vh6cM4apH5VhANj890T3xc21
	vk7xIKhrRFxsS0o8bn/00d/ds2jN1vPsgMVMZsV59LIcr89z7emM
X-Google-Smtp-Source: AGHT+IHXJ7ppLDLXd2sOeyEQK/6dSiGQuHOEUdpeiegA8mJM/QX/+xlpuCVLDldQjd+BFQ+vpTJpJQ==
X-Received: by 2002:a05:6a20:7292:b0:19a:411a:89bb with SMTP id o18-20020a056a20729200b0019a411a89bbmr2002708pzk.50.1705621461696;
        Thu, 18 Jan 2024 15:44:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k38-20020a635626000000b005c661a432d7sm2112285pgb.75.2024.01.18.15.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 15:44:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 18 Jan 2024 15:44:20 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Lukasz Majczak <lma@chromium.org>
Cc: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 2/3] watchdog: Add ChromeOS EC-based watchdog driver
Message-ID: <851f2eae-55d3-4f98-8051-139064630fb6@roeck-us.net>
References: <20240118195325.2964918-1-lma@chromium.org>
 <20240118195325.2964918-3-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118195325.2964918-3-lma@chromium.org>

On Thu, Jan 18, 2024 at 07:53:23PM +0000, Lukasz Majczak wrote:
> Embedded Controller (EC) present on Chromebook devices
> can be used as a watchdog.
> Implement a driver to support it.
> 
> Signed-off-by: Lukasz Majczak <lma@chromium.org>

Nits:

> +#define CROS_EC_WATCHDOG_DEFAULT_TIME 30 /* seconds */
> +#define DRV_NAME "cros-ec-wdt-drv"

#define<space>NAME<tab>value

please, and "-drv" in the driver name is really unnecessary.

With that changed,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

