Return-Path: <linux-kernel+bounces-17814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B95825312
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 12:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE91B282A26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2A02D048;
	Fri,  5 Jan 2024 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="YCGtUSwX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170892C857
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 11:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso14334985e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 03:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1704455089; x=1705059889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=etXjTKhrSMNmHo1mq6MDLBdcw2n25mPs2Y1ZJz2pFZg=;
        b=YCGtUSwXB3ywnBR4L/WfQ3WWtvFE8FpmXSOfssWAj3NcIusCJkHPR59E5Nr2FxtUWR
         eaaJiE1T42W5mW2Ccd2kNgdXFthbm1FF1y/xf08pwO4fdBPN/O62bT9C/9jcPYeTJvr9
         n1t2/dyMumZRanJKVChBQ/0fak3hW2a4jBhS25vQdTHjiyHsPKuhSyraBbFCoxIMLOxn
         yPlgA+J15Drsl0+QZYKoGlULRDge8ulrNe8gdNwoSPBeGJS/RY+KueLkXIX9iYuCmK/p
         gXgGBWEJw6hkU+oLYZ6x04U2K72RG0iq0xOOgnP2yi3f+8XVzQP+0QuszuxGnPmLOVoh
         jkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704455089; x=1705059889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etXjTKhrSMNmHo1mq6MDLBdcw2n25mPs2Y1ZJz2pFZg=;
        b=lIjkrPsbQDCqQM8JGMA025uK4pSsam53SweFwJxgvnxY53RHd7qkIpbhZdYxtfBA5F
         AMZBiH72sWx6B8V/h2bGspAoubSf8ZpOvYFOApMgS00GkusXbAG8+RnD4Q+6Xo1e6drC
         NnbXKkwk0z4kJTzRrpX2e9iChyXAWJcDDrxlHYqWQjDspp84XS6Dj0P2BsG1eCwZF3y6
         cihfhhf14O0Zq51Sy0wGsGX73CIauZMURCkr8bXhu1FN5L1ce13cxxDWBZc4maL7jSX8
         B40P6pBdbEG9684vhXvP/XIMjskSoL0xrN1e3Ye1KZmOYWBXuIJDk6/sQl4BoNXydObv
         1eWQ==
X-Gm-Message-State: AOJu0YwEfVuI3bCkNwqJfXmt8ZAW63aj20ghcVuSwda0CdBcdFILaEw3
	A0S5EtKUJ8f0SVkARKpET2ddjSpae0qXIA==
X-Google-Smtp-Source: AGHT+IFpFiq7esnVsQDvz1IQYGhGCa3Q8sIvasiyhEOmg6g/AWNlZbOlKvoSZZS2QZm66U3FuGpCFQ==
X-Received: by 2002:a7b:c381:0:b0:40d:5f55:3297 with SMTP id s1-20020a7bc381000000b0040d5f553297mr1034295wmj.22.1704455089342;
        Fri, 05 Jan 2024 03:44:49 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b0033674734a58sm1241453wrv.79.2024.01.05.03.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 03:44:48 -0800 (PST)
Date: Fri, 5 Jan 2024 12:44:47 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, andrew@lunn.ch, pkshih@realtek.com,
	larry.chiu@realtek.com
Subject: Re: [PATCH net-next v16 01/13] rtase: Add pci table supported in
 this module
Message-ID: <ZZfrr8GFWqLs6-A3@nanopsycho>
References: <20240105112811.380952-1-justinlai0215@realtek.com>
 <20240105112811.380952-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105112811.380952-2-justinlai0215@realtek.com>

Fri, Jan 05, 2024 at 12:27:59PM CET, justinlai0215@realtek.com wrote:
>Add pci table supported in this module, and implement pci_driver function
>to initialize this driver, remove this driver, or shutdown this driver.
>
>Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>---
> drivers/net/ethernet/realtek/rtase/rtase.h    | 336 ++++++++++

Hmm, you missed to address my feedback to v14

pw-bot: cr

