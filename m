Return-Path: <linux-kernel+bounces-165387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1865A8B8C1F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4990D1C22FC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FE12DD93;
	Wed,  1 May 2024 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8o4rYL/"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D44D4F898;
	Wed,  1 May 2024 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574807; cv=none; b=bW7qQ8VenFuow2EjVseImxc54/07ZDQdA7WHhurXptvDthxO+2XwQFzx6M11yuPvyglrsNG+jRYuOEMZobvkjnSJAsPILAc4BAuJFaqayk1S60fXaNaVmD5QTctrhdTvC9ueTCyfzHPvu+dY5iPAHkf/vsgT43WZVP13yHSPVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574807; c=relaxed/simple;
	bh=U4Elu2Dr0p9XYFIpvjh8viSrDg6WtNKfI/0tT2Qj0so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qB2ijTebOsoWvIF2B7JhRFcdGw5cYr/mgN4oDuXu0adKvki1fl/T8zk+wFL8xU8415gwgzL+g/ruznZG5Il/0RqIdVkCI9WxicPRaNf7HerjKqWuMRzkBqQsDIIZAtygd2K6HRL1T8w+6H142+SseBxheDHMQ+y6QG0Wvj0UXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8o4rYL/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed112c64beso6333324b3a.1;
        Wed, 01 May 2024 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714574805; x=1715179605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03NAVWyPVCkux7RYgQXQ7gWtPHfhHO2R0JOSbz8EmHg=;
        b=H8o4rYL/UedXOBgog1NH/CfuXhgPyI4Ncn3AAp2cgRyUVAO0iP/blKFAXDU05pHyCs
         bBGvyIvcHVrHbmPphWUVwPGrUlrPYjvsVM5cP/aw9hbuC5DEDswN1Jj6f09qAUarDAqL
         5ieg6Et5lyYx7tVr2fxb9OXl8ElQNBv+qS40lvFra8gEyadUDD1wfXEbC03b8YtRzMlo
         CKEBCqvLXJbe3Bwo0OrlpRp9WrVrcV47a/AMxGJ1xkgTFZroHO6cGakfZYq4v+Cnctx5
         mjjnomcG26M33f+yRY3OxlcGxwBTZHNBD4Q2keg/QzkzmIqTBNn6TsIVco7QS479VB5m
         eyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714574805; x=1715179605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03NAVWyPVCkux7RYgQXQ7gWtPHfhHO2R0JOSbz8EmHg=;
        b=ThSH4bzVZUQtWPsW7IDY7kQaEB1ku99svlh9LPRrOcE3R7lHedE+q56Sao4VuP6CMS
         VP7qszuNidvIYSZmRM4lpTVQKPBOmgTM21tw2F5EsMAoqwy++SCCYZJlOWL4oW+dbxDg
         V/dyEAa5cgVp81og2eFaqJJr4wRHhQvoA6IuqTYr29YG23p0iI5ZAiSqn/4uJnDbxSfL
         ldmyNnLPBbo10HRGK07xvcoN2aynnlo24diXqQMK/A4lqFWJkn7DyJtAVezBY9xuXeny
         P3Pq1sg/30bT6VVMol5sPZLkA997Bw8e2sA+uWv7/tOYD4cJkeio5LwptXJ3Zs/4mn+7
         Qz8g==
X-Forwarded-Encrypted: i=1; AJvYcCUXcmJcfxw+9a53Oq7wXml92q6QrU7+akB282ZZQ3bhuczdSmtClId+14K3PmGgwudbOpljWU5Wl/QJz3TtxVO62Rpje7EIVLFIVPT76wlQn1P5/5pRzvYk7328+qaNorj/ChW8ubk5iVc6hxxafMUpmb4ftYm50AFKRqlj/bYJ92qvsk5X4SZNF+8=
X-Gm-Message-State: AOJu0Yw8gjWoAPtGFaexkrHxT0b6GFPxL+yE5RGxa2exnxvNn+DBJU0x
	LH7a+ueryQyi5aUUKPvej5JVulNYItnQF/gdvsaGDk7Gk4PtvKo1
X-Google-Smtp-Source: AGHT+IH58OM+dBAGypaVzMmT5xY2jQd7+OPRGG5/JnBc3ubz05DICGoArY0l/LmVqdn8E51edt07tg==
X-Received: by 2002:a17:902:ced0:b0:1e4:cb0e:2988 with SMTP id d16-20020a170902ced000b001e4cb0e2988mr2778248plg.2.1714574805328;
        Wed, 01 May 2024 07:46:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e5c6c399d7sm24704940plb.180.2024.05.01.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:46:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 1 May 2024 07:46:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, openbmc@lists.ozlabs.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (npcm750-pwm-fan) Remove an unused field in
 struct npcm7xx_cooling_device
Message-ID: <22c662b4-14f9-4aab-9bea-64c03fca648c@roeck-us.net>
References: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74eee8aa739f94b8c6425ce3e37a427ca92243ea.1714505655.git.christophe.jaillet@wanadoo.fr>

On Tue, Apr 30, 2024 at 09:35:37PM +0200, Christophe JAILLET wrote:
> In "struct npcm7xx_cooling_device", the 'fan_clk_freq' field is unused.
> Remove it.
> 
> Found with cppcheck, unusedStructMember.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied.

Thanks,
Guenter

