Return-Path: <linux-kernel+bounces-30888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A08832591
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C1A1F215C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6F208D5;
	Fri, 19 Jan 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFFVflYW"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98417DDAE;
	Fri, 19 Jan 2024 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652308; cv=none; b=OwrDcJxstp/mw/U3V3yg2NdUJTwub/3xDk8FM1vE2zGzTnp22NSku5dc2Oeb26dlcYxwaMV6YY0XIC7wB1Zlm4qbUXuLMK36/73WPrS8o+vc3P0ytNKlOT1O6FgzVGRtSuHkw2qXSgY/jnpbk1PuElvXhpIdejJjp5xwUooxV6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652308; c=relaxed/simple;
	bh=6CTE6LAnrQB+0P2CP0p6TXSTq8etgVJFCRPwsyZxmac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2XGxUdtmxroMDqmYGo2d9pZJZwI43tHaavbj4zI6fQ1hJSL4Aoi11KY5DnL+Zwo7aNb225Ap7kKqeCy50I/RA2y6Ia/f6wOC45VOy1dL82ogAil357V7X2IwubN2YlHGb2YezjE0e/cdLh5P9N/drPogJqzqMLfFM7p7+MEKuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFFVflYW; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d70c3c2212so3979985ad.1;
        Fri, 19 Jan 2024 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705652307; x=1706257107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NbCRz2cw6/zLDH7CifVtlTehng6egnWg+bUjhT6zIbI=;
        b=ZFFVflYWRWqvodh6Bb7EzVmhOu6xQAtxXL8ISdoPmq2oDKRz1JQGc7riYzbo6KIKfc
         +GVo5ZS6In4w4zNNg6ru9yp1H74jRNX4R6wZqk0geq3DL9pUUnmhdAi8yihUjP8sSrhm
         2gfYFABwgh4tPnOq/F4LBvkZaiPyWe60ZSpTjnuhDGFt3qoYI1BXl2wnriA/figjvR3i
         qSKzF5DHoOqZ6DNeZ072uFHksS7G5LM3AIHkqk5X3ofgOu6u+9k+ORH2mxbhcSt7spgg
         4izu+5tW5AKzZc2Fe3iJwUnhIS/3IvUhSOrclrmNvCdX+KkAHEJ6djS5qnLQyoG2bEEt
         R2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705652307; x=1706257107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbCRz2cw6/zLDH7CifVtlTehng6egnWg+bUjhT6zIbI=;
        b=BCIfNaTcCO2TJSFXZ37wP6Da+bJYuC24TC150nzI+O6gU/0dLpy113JwH8AvYFlxIN
         e2SLBWCUhze0K0DE4g5mfJxDuELfi6kA4u2l2/cpcJMcCVcmJ8DZjtzU0m5ZVtBAjMHf
         7804taD0BJRqMuls7NmPvasFDcbJOoVEZSYggv1jwAnlWPS+4JWajtlFc9OyEnLMflvc
         gHAp/Ei7OheRSkC900hVGQuGY8esFrwPhfaFqap8EC10C8aRtxCyFNEx9640fzlhcrzv
         9jRfbcLw6TM0jZSJs9VsrNeYYEdqwsUm8Q57PIpr3h3Thn+2gKjBqYBkqdemEDR5bguY
         0/Hg==
X-Gm-Message-State: AOJu0YwC5P/1+rfaGTxf2rAKlXBNxDHGw4TeCrM4fR87cqgjgocwiVgs
	rgdMWP667PXPFNIKZe/cYZbI9A+yzeEcXwKOTBfUclkXOZi0o0ufa07hA3rD
X-Google-Smtp-Source: AGHT+IH0PK6h5IreGNnXp0U5KwwEXv/ewykeeZsJ3s7KAH+gXuCVNkGXaf22sVKIlOW/l+jlZ2ZXAA==
X-Received: by 2002:a17:902:9309:b0:1d5:da9e:1f60 with SMTP id bc9-20020a170902930900b001d5da9e1f60mr829195plb.58.1705652306782;
        Fri, 19 Jan 2024 00:18:26 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:f04f:73f4:b79:a70c])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902f74800b001d5f2483893sm2504936plw.270.2024.01.19.00.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 00:18:26 -0800 (PST)
Date: Fri, 19 Jan 2024 00:18:24 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: Remove usage of the deprecated ida_simple_xx() API
Message-ID: <ZaowUOXG6zSnZXAb@google.com>
References: <a885de14beead2cc3c1c946f192b8b178dac696a.1705349930.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a885de14beead2cc3c1c946f192b8b178dac696a.1705349930.git.christophe.jaillet@wanadoo.fr>

On Mon, Jan 15, 2024 at 09:19:04PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry

