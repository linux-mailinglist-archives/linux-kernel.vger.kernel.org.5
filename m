Return-Path: <linux-kernel+bounces-11698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCF481EA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7471C22079
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390DB523E;
	Tue, 26 Dec 2023 21:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGbWAaOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3255224
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-35d82fb7e86so15299625ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703626564; x=1704231364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ECOmvaeUorv1py7vq0hkE8T1yjRXAE2xTX+cDTjGIXg=;
        b=CGbWAaOX/LZOryc9Lt8CFhTIxtf03S+ahotOSPucTcj3lDpc7UGr7IJBGXTcCl+uiC
         P2Go+IY3Qb6YoCSalgk3aLj7aHCZOBU/wN7pdk8HNrmu2O2LZQvfhYpHGl3uHL0w/1NH
         StaRxmTh3890FSReqixOpzV/NQ86V+fEVIBRcPan4y1GmbOfj9pG2sWtiZZIhmOX1KG2
         +SENnwgjUuvx+V23i62ovZz0TNNF1xZR7fwQbUAFNmftHKlA/ZvRr9oOQnfvKxlctPju
         jvhcejw7Mp/1R2QIhuMyrf/1fZOzjJCvXqMQL3DbDNpYM2ZHBQYBwHoIitqvZ4N5rL5a
         uBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703626564; x=1704231364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECOmvaeUorv1py7vq0hkE8T1yjRXAE2xTX+cDTjGIXg=;
        b=mU5G1OVA2SEiJ+f0JUPmR7uqxxWW+9NKW7EZviMiAAN4f58/7a7CYC5WX7AftanJ93
         gXkTZyMTybByQ1eNT3aHk4jUjj/kahTMY/qtIUfTPCqM1kbHxQjiQCkps6NMKgdDMIAS
         ggCVkLuKvRXwzV8oZqrrCmdG4XGg04TP8iMywAW6ieP14b0eqjIOQmR8LNZ980re+BLZ
         a7fNdRN42XY/zkI8YUaUXOl/JjB9rMQhjpSrcFnmOiXKRsv4RYhn17KrVtgglmFjZOY5
         ZVrQ4eqFWrJ9bxwJAQlLfxZ2OOSj1vHhHYDKh5Bi/oOzUq5GYH7QnRvXYNssc3+Vn3nO
         n94w==
X-Gm-Message-State: AOJu0YwsHSluvCuLACQL8kmbJzj7o5/9EkmKGMfDoIgaosa5v/Ir6gp5
	iHlE8TAEoh9ET88BcWgsh6w=
X-Google-Smtp-Source: AGHT+IGkacSWHePokd6l49s1MPk9CQ9SGmZgBidJWW/DBejHjqY5FdTV7bNQj7QMUKM64BQp2opeBg==
X-Received: by 2002:a05:6e02:2490:b0:35f:e8c5:2d0b with SMTP id bt16-20020a056e02249000b0035fe8c52d0bmr8342978ilb.40.1703626564252;
        Tue, 26 Dec 2023 13:36:04 -0800 (PST)
Received: from localhost ([121.174.67.130])
        by smtp.gmail.com with ESMTPSA id jv11-20020a170903058b00b001d08bbcf78bsm10563474plb.74.2023.12.26.13.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 13:36:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 27 Dec 2023 06:36:01 +0900
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH 01/10] workqueue: Move pwq->max_active to wq->max_active
Message-ID: <ZYtHQc6pahtAUiJ8@mtj.duckdns.org>
References: <20231220072529.1036099-1-tj@kernel.org>
 <20231220072529.1036099-2-tj@kernel.org>
 <CAJhGHyB-8hU7W9HV1ctD67Q9d9o+tmhesYqtBcMEmO1+taF=cw@mail.gmail.com>
 <ZYsyHZg6tMAtMp4Q@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYsyHZg6tMAtMp4Q@mtj.duckdns.org>

On Wed, Dec 27, 2023 at 05:05:49AM +0900, Tejun Heo wrote:
> Is that a problem tho? There's no execution order guarantee except for
> ordered workqueues which is not affected by this. In a later change, we
> switch to list of pending pwqs instead of work items and the issue ordering
> is lost anyway. This isn't a significant departure from previous behaviors
> either given that there has never been ordering across pwq boundaries.

Thought more about it and I was wrong. This introduces reordering within pwq
which is new and can break ordered workqueues. Will fix.

Thanks.

-- 
tejun

