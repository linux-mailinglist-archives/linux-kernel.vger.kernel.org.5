Return-Path: <linux-kernel+bounces-76109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B46185F306
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A18F1F265C0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F352511F;
	Thu, 22 Feb 2024 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ8wZRqx"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9FB7469
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590741; cv=none; b=AwAL3WQenE5UpZUcj1QVEzPHtc+6D6kP8wtDQMrrYbWDUG0nbD0nJ/CLQztPgN4yJ7N6GMw1jNFwWzfC6gDdhMa/1HeayQCY9CtBfaW2W0x96v0n/LbPLKVfxUYsiByCjPuoosdFtbNUvA76y38EDKbOsl7zsT9obRxJJPu4hZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590741; c=relaxed/simple;
	bh=L9L8UdAHgkw3u3z3JRXM7P1REEFXeO0sAapccYOXKUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMBFkcY//x4RUBORy1sX+wKBlCjhloQBvq1h0roUeVM1R86zey3+Buq1N15dju9wrdyV3pK4MQlCSWQl1VsPVyS0hwRRF1QKeDUJ95AdWu2/uKOtz1PtRtf81WXpggzQ652rP7PWCmoGjCIbp+x9SIogaN4G9xiSCCmiDlvuRTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQ8wZRqx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e46b5e7c43so2315591b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590740; x=1709195540; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMWItRQLuK9R7O/ER6wnV+LzSM/KkJ/vGjp2HMnJ18k=;
        b=WQ8wZRqxM5kOKcn3nMUBzQx5zGzQ6siOsRnPgJwlEymUcDtb7vpPVencdf3ZIzem7m
         nnS7JvViIv/na0ToqrfZR6yBrUHYaZEECKRBcLWwq/JS1I4Qkuu2TXpNVoaiO58N9GV1
         jO9wXpa5S622BQVccHOLqJhssKltvJSqLueuqmiefPlSXktLxi887n5KqdlHAvMXJ303
         TzFc/JFxZin2Zpoky+CUqkymp0Izz+khCsCOTcHD9cTNY/aDTU+Cjqcr4av8/4HES1Xg
         tbIrK4DoIPUpL9xe3/s6QarmxeQoV5USgr/RDDOIFaw9EWrl7SIgTTaai0lQcQkjxOXj
         kEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590740; x=1709195540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMWItRQLuK9R7O/ER6wnV+LzSM/KkJ/vGjp2HMnJ18k=;
        b=QZbAjMEjoaB/kokDP1pbyeZlGBry/WBRo/HZ1StuwbR73QV/K8X0xCLBwX1HpM9Ggq
         /qUmTX43cI/9sAdlnZpExpLgDYvAV0pzVqoQsUMo4HPlnjjxubCJEj9IGhxt88XSR1by
         Raa5gHxDpKWlE5Dg4N2UoP9IdPbJY7kj93tEbOqKUMNgYLrSUIOT7voL6667raULucbV
         i4cjeuSjDDmo2gjGuLXYcstmxrV2FJCGr6g6fh6CyBqSL3ump1N4u1+b18l7SKUZkHPH
         m5YzoEHqgO3WWQP+2vuIm2YjqFDrXH8RjWQVJ2UG6O0cvlC2XVJKn5TboWBEPd/i6Vwu
         cn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyAJT8GR6q23KBPC0qe+VnYkVGNOE1xDHN/6JxYuOAw8QPG1Dq5eq4tb1njs+d8Q3f/UwijDAIvoz1k6lZv/U2DjnjgbuVilYRaaHy
X-Gm-Message-State: AOJu0Yxm5vH1J6k/F6N7/EjlERvIX9NCbMVEF/y33fnLLO7fIqsmFTQU
	8eF1HU8RrFZQRD2fIfAnn0virl49n74KeMH3Lv0IBaLryAbaJr9m+gU6cpT53gs=
X-Google-Smtp-Source: AGHT+IEJ/ErXfRjDfnw+40qm4JkSBBudXUJ46+gZtyp3W2miWkvvqHN+J0Ed76vt6iRVz4gD9BMQbQ==
X-Received: by 2002:a05:6a21:9207:b0:19e:9c32:6073 with SMTP id tl7-20020a056a21920700b0019e9c326073mr23295694pzb.12.1708590739628;
        Thu, 22 Feb 2024 00:32:19 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001d9aa663282sm9360917plg.266.2024.02.22.00.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:32:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 21 Feb 2024 22:32:17 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 6/7] workqueue: Allow cancel_work_sync() and
 disable_work() from atomic contexts on BH work items
Message-ID: <ZdcGkd3u190NzCw8@slm.duckdns.org>
References: <20240221174333.700197-1-tj@kernel.org>
 <20240221174333.700197-7-tj@kernel.org>
 <CAJhGHyAOzXVwGy5T-KXpwXgcWp6jLaTGGzspPqQU4Dw+x1GqUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJhGHyAOzXVwGy5T-KXpwXgcWp6jLaTGGzspPqQU4Dw+x1GqUg@mail.gmail.com>

Hello,

On Thu, Feb 22, 2024 at 12:36:29PM +0800, Lai Jiangshan wrote:
> On Thu, Feb 22, 2024 at 1:43 AM Tejun Heo <tj@kernel.org> wrote:
> 
> > @@ -4077,11 +4076,37 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
> >
> >         rcu_read_lock();
> >         pool = start_flush_work(work, &barr, from_cancel);
> > +       is_bh = pool && (pool->flags & POOL_BH);
> >         rcu_read_unlock();
> >         if (!pool)
> >                 return false;
> >
> > -       wait_for_completion(&barr.done);
> > +       if (is_bh && from_cancel) {
> 
> Can "*work_data_bits(work) & WORK_OFFQ_BH" be used here?
> If so, the previous patch will not be needed.

Hmm... yeah, if we test from_cancel first, we should know that the work item
is offq and then can depend on OFFQ_BH. Maybe I'm missing something. Will
try that.

Thanks.

-- 
tejun

