Return-Path: <linux-kernel+bounces-43712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A484183D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470372858E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2A34CFF;
	Tue, 30 Jan 2024 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFgcvbx8"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9A2E40E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577757; cv=none; b=HqoI3e7QfJF6VlwAqUUyeiAAV6xUtAf3cK6Hq31Fw0EjrXVzTMgHTZeXcRpB7YULOiMfS7HaECIAb8c1VuvIConRe7Hlgt27/CKCqXWHrs9OtBb6syF2n5/bFd4VQ2Zoek98oYeRheCJpSYvFRFuhDQGkcvlDcdDqbNNHT7SiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577757; c=relaxed/simple;
	bh=bIJb+jgCgGliZshmoei+sz4nV6oBQLlhMTwPO0A/Nuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwIX/P17tzDEm3uv0D27ZhuwVrzYeOfIQ8YY+oSlYYD1SfwJWXZptmqvYTJ0WmGLf9LNMUyoMmNaFIA5PSAYekgPlrF0eWeqpp92LRcjAAYyTAvsnNATABmcUNX+DvP6zdMmnt9gLkH0Epw++ZjyxeQKrI2PX2Vl7/t7N0eUeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFgcvbx8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so3048577b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706577755; x=1707182555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wMqd69DzckDwNLFqdbiaLgONDOqgBjB7CTh3HmI3dKY=;
        b=kFgcvbx8+paa2yKimA2Jp50X5a6whisgtiKy7JICf/L9w715WdwB95F4TMxTvFIUK3
         7o4c0UCPRBuK08trAKfDUgKu9eHe+w7YPf/mE2XWoNUiRPr3sykVAdXtzr2xJVCIPNX5
         Kiqd2NGC3/gB58Mq5h23KPAbXF2ibIHhMmb9wapYYbEH7dO5436ERU/6JAkXtk74hFzy
         sl9II7RgMZDbAWfAr7kllSDWSSj76Ug2PbHmWMrbQBH3gHpebSknsjfgguAYV0EA6bb9
         ufEC5KVN+6LKNiqlAY7C/DQFnGChpKZZ9K/8OOGXxplw/WMqMkFPpLGqAu8SsQf8Y4B/
         uTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706577755; x=1707182555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wMqd69DzckDwNLFqdbiaLgONDOqgBjB7CTh3HmI3dKY=;
        b=dPxByqLVNu9VYkQtsK0/uarlqDQCi2LynvsfnZzsGlIdGIcoCEvya1faVBibkKxuMx
         PKUdL7rdZojYekBi5OY3RLSrrCNSHJJNjpZwc5Mw9K21HJ+IyJJ7ZM4NpnZIQVN7ZEsu
         Kqg0IO2UmzggIbj3sQnvFi6YlTpepHnp2yfciPpQfiuQkSYEH5jcC5LDPDoKO8Fh0Xgp
         WoOR41+LUUk4vju1epXZITZa2JxuAz2v3vgzpTB1zKCcqb/fvNJkh56YnzPhco+496PU
         GuLzOZi9Ow5r3GXnB5ThvcfJiIQPzFuyin+0itL5ASqjBoYUqbGb0gjak7v7ekt+e4dW
         h4zw==
X-Gm-Message-State: AOJu0YxYP1AKXLlTGyVkrL+BD9Oz3/eODqUUHmqBIJy9It3CMitvJJ+M
	GVBAxHs/D0N0NDkxpc0kVzd5B/PTu2dnVmSdNKsvmKYgSXhQyQOH
X-Google-Smtp-Source: AGHT+IEqgtQKTycPCPiPnX6aN2K5nqtfZP3rkWSgwwwniuC9C6qnH7a6CcC72HRgKWbYO2WbmFp8Og==
X-Received: by 2002:a05:6a00:26c8:b0:6db:7038:fc04 with SMTP id p8-20020a056a0026c800b006db7038fc04mr237282pfw.10.1706577754726;
        Mon, 29 Jan 2024 17:22:34 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a001ad000b006de09d94723sm5813995pfv.17.2024.01.29.17.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 17:22:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 29 Jan 2024 15:22:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Junyao Zhao <junzhao@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <ZbhPWSWAZZo8gk-a@slm.duckdns.org>
References: <20240130010046.2730139-2-leobras@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130010046.2730139-2-leobras@redhat.com>

On Mon, Jan 29, 2024 at 10:00:46PM -0300, Leonardo Bras wrote:
> When __queue_delayed_work() is called, it chooses a cpu for handling the
> timer interrupt. As of today, it will pick either the cpu passed as
> parameter or the last cpu used for this.
> 
> This is not good if a system does use CPU isolation, because it can take
> away some valuable cpu time to:
> 1 - deal with the timer interrupt,
> 2 - schedule-out the desired task,
> 3 - queue work on a random workqueue, and
> 4 - schedule the desired task back to the cpu.
> 
> So to fix this, during __queue_delayed_work(), if cpu isolation is in
> place, pick a random non-isolated cpu to handle the timer interrupt.
> 
> As an optimization, if the current cpu is not isolated, use it instead
> of looking for another candidate.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

