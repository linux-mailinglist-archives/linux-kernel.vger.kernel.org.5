Return-Path: <linux-kernel+bounces-117606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0F88AD14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AF81F62D91
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B65473A;
	Mon, 25 Mar 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4TStqLJ"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0F748D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387880; cv=none; b=c0Y7jMgmgpv8ycDI2CdeNb4BALpu4a7ajV7mGCJhS5xLZIlmad2gby/DMszo4SUggbZ4JJJeoLQyl1DxvqaDQaL1JdHBuKHeJWnj+H7Sim38Qc/Cy19A19FWJ+zQbdIbNxUyH3N/JQEdMMxui/3budB/ZalRRDXLjUb6cblhPnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387880; c=relaxed/simple;
	bh=ZmBBlj92ew+4dyJE9QDYVvWB1ntdnFoURuEq8j98kjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvYjV0JVn4nIZ8iQ60+slaxg2h/XAO7wstfwYG0Z1j8eE4vknlrUc5gnKBDqQYrnIpDTgvpBMyHpE1MO4FtGYNcaj0R1Kwh6XW+c5rCCOv5HYAfxnIjspkVVUDEANj3F+bx/4M7eDj2aAJcQZsUHbSAZs3b+Ko2pYQwnOE9nNh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4TStqLJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e695b7391dso2311827a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711387878; x=1711992678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mkvp09FYq+PAaWvbx7V36zt+kReluiBN0d7Gn3PKdvA=;
        b=l4TStqLJn0JSf82+hdFWKs/Kboe+fZI0spxlB4ToMqHULdtQvQq315dmtWn0X9Gei4
         bglsI9ZObMc/naPMjRfsOX1yaC0Swr10ElfEuWI8LqV7LPxbcZppADL8qwoQPZ0EzZDb
         EHlMhuneLDDW0NvFEex2/QwGsqdldcOsRck0P69NsAI4DemnTYVwH68g7K6MrMXYl5KG
         poPS9yjp/OslQ6aX8TVg8eoVzEYM2BB3OEi2OPCfubY/Pa/FzF4UYNy/4cbnhXci+B71
         DmS5+hfLtzYjZgso3LFFQUJqwWZvPbYno7OQuRbXJHh9EGecMQv4/XsGKt/CSbxjRUYe
         q9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711387878; x=1711992678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkvp09FYq+PAaWvbx7V36zt+kReluiBN0d7Gn3PKdvA=;
        b=AQWQGGNNE1snBToCjcQtVsj0LTsduMloZWY5Ggp1KE63GC1LigxCJ5CZQDxIRyrwTc
         394RHAhmgp6NFInfr5P44MOeRC/EpjeDdugRPSRiWu/gIla+o5BbnnuyKBc2gpbgXkyU
         SCvthJRD4LGqp+ulwhTw4aFAid/9xksPZzvEwVO+5FPUJq2f/0n8PDzyPBZuuFd4OISG
         6PrLmQ16309gOS4D+R0vxzty6TL2p5k4i1Z5G2sz1HrzxLbOxe85iQWisZgZoC3uscLe
         pEixx3EbxZxiQJPXnbsEYh/B0ZHYgtBdaDYYl6UwQ3/of8cpP4/dETVwNgmwSiWaYPot
         1zMg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyXMfp9pz/eFUFBUg1C+c6C4byb1B8VbSkaXYBZhM9bLm76Y1dHf0fBqzwj7UGtAmY/ON+8jrO/2/bDbXesQAY8RMzXH8iU5YSgkS
X-Gm-Message-State: AOJu0YyI77jHbk5LrHOohKe1LTB6OHbGAiM60sAiTmaAXfoL521hnlX2
	x/3vEJlNJpFImJItFs/iq9GIHqRXmPsVLD0aS6c27plVXTRNdLrN7vwgpJdn
X-Google-Smtp-Source: AGHT+IFnQjWzGzMVjfN9Ns9RnTRLqc/CPBB+4KSqCMZT2j8LhlKmRYZXrjZIE1F8jFqBAzCX4odeIA==
X-Received: by 2002:a05:6870:5250:b0:221:cdf9:2453 with SMTP id o16-20020a056870525000b00221cdf92453mr9131894oai.27.1711387878101;
        Mon, 25 Mar 2024 10:31:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id h3-20020a655183000000b005e83b3ce8d9sm5220205pgq.8.2024.03.25.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:31:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 07:31:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com, boqun.feng@gmail.com,
	tglx@linutronix.de, peterz@infradead.org, romain.perier@gmail.com,
	mingo@kernel.org
Subject: Re: [PATCHSET v3 wq/6.10] workqueue: Implement disable/enable_work()
Message-ID: <ZgG05HtCWZvLPtDA@slm.duckdns.org>
References: <20240227172852.2386358-1-tj@kernel.org>
 <CAJhGHyDrhsgBcFyqdJ1w3mHmSGaJXErRppcWy7muHWjnL8q=sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyDrhsgBcFyqdJ1w3mHmSGaJXErRppcWy7muHWjnL8q=sg@mail.gmail.com>

On Wed, Feb 28, 2024 at 06:00:22PM +0800, Lai Jiangshan wrote:
> Hello
> 
> For patch 1-5:
> 
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Applied 1-5 to wq/for-6.10.

Thanks.

-- 
tejun

