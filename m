Return-Path: <linux-kernel+bounces-55230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D939384B961
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B69E1C21BC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091D133424;
	Tue,  6 Feb 2024 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zCXgcw54"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894E7134744
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232860; cv=none; b=Cx3fYCRmo3sDA1kmBbeCWb3/lR92H8reD4+qLnbdHoTFbbLMy+oDiO/8coi9KjMRsUosK2jJGZRs17sHYiL1G8QTCh4y6GsFk0ASI4MH3d9FaLmeRJDvK59yifkHuWlnxRXTDN2GnLNKGq6ibKt7eSybM9jwXjvQM8s/MtRwzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232860; c=relaxed/simple;
	bh=UyBRH6b+s9zezdw+JREl6GMUR9UqmHODgFXwNQ9ZHBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7jyJE0MeEOLraa0AVsz1xGn1ygyRcJxTQ3S4HPF/6v2ZzkcFOlMQZ1+CNs7UPqd1gBBJo9pT4W8sljBhKKwrBUSuSDdglLmHEJ4Uk6LynAqlOoU8c1ZXiJwOWuWkzSOJ5vgXK5z1oU/trBSZQmPcyuOr01Pd5oFudkmsDuL/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zCXgcw54; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso1349266f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707232856; x=1707837656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UyBRH6b+s9zezdw+JREl6GMUR9UqmHODgFXwNQ9ZHBk=;
        b=zCXgcw54nsnXzeh2C4txonQQ1MkTLgdziIUC10KCXoKela5RJ/PBtGxy8+ocpyrOYP
         PHvlVJWnoH7lZ6xRTmnB/otqcbwisjysuD81LKXUbRzPyysHRAjekPTLkP1ufq7KH9HU
         H6IVFeyd2DMSJyfefCc4fzIgkEvaSuEzVI0/U7MftCnNyquCAwqKdQcucYwkAkDwT0wY
         ZVxbJharwpPEQJSo9Rzb90d/HkoNrnWFQ4AnuuMnj7ylYx/PRARv34DPxjdUkcLUif8h
         w5wULAwJyQPuOfEAru4YHC+PZ2skt+hCBwjszyjJYqlFcFcOrVraPMw4i87jd9aJl+P7
         oeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707232856; x=1707837656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyBRH6b+s9zezdw+JREl6GMUR9UqmHODgFXwNQ9ZHBk=;
        b=R0x/e7MHcloxBPN7pYHFBcQQjaZkVYpbkGq0pIW6uON544aOnCRdBlBVXFnxlcWRjW
         vVApUTlMtpmbnwDBtsE/w5/svBdONb2P9Prq4iD1BQLhRG6IUaFnJpEdVHpno2oyLbyF
         NdQMrizk+CoLP0ZzlqncMBggonG0PNkr4O56zGna7PSQWIoIMTLxrEZK7+n7IDX0BqN1
         D6RWExbe3Tq8F5QnCebK80Aze7RQHjOwjpJ5gKIEFGC7OlM3DLDyE90+T99t7bzgzLV7
         3MBNvqEwVg3ZLs5QJzyCc+8YI9V+cEiQTj45qvsDM5gP+vWoHLDu8ua3yITKvGK+lZfc
         Yi4w==
X-Gm-Message-State: AOJu0YzqgXhLBBfnzjrtxCAOKfDeKjo1rDcw2Iftn2d1/uKNMQxnuKT2
	xhz3IEubbn2T335xKSrRJOPtvvWdStgzmc0i0rEa8KDw45QUn+Ctme+vFR7HHA4=
X-Google-Smtp-Source: AGHT+IETC9K4BY0LvgXvnAMs/kcNBePR4S9v0fvJY7nz8LwktjV2CHGQGD/x7Hjg2pcZBys5tBQgzw==
X-Received: by 2002:a5d:640d:0:b0:33a:fe6a:482 with SMTP id z13-20020a5d640d000000b0033afe6a0482mr1381263wru.32.1707232856692;
        Tue, 06 Feb 2024 07:20:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWtbE6ZkmDggMqXVQvY802TfAHqqyxciZqsxLo6biTlglLcKXt+Kmc8IweM1XkfGyoW59kGv3Zt8BUl/0d/drY4Fsb9TkSbqaasyRagi0Qcav5rsoENTZs74Y8S6wlwPzN8iczD9Vmv/cllWzRik0mrjuEo0ZecEnYk04+25KaUslki3+VXz6a/rRJYem+zlAIX6ye0s/XHUeo+m+0bz43TOkqdlq3JnpwUR8uTRNuNJiU+ecfu3DWIbZuve4OgmvjodJI+70D8bK7gPaVB1HgxK6VYNnSwrn6ivkQLuudxnYSwT76s9vlRlIz03BeH27BiugD7qTNlQZLIYmBvpj/snQVI8ntEYr+qiAw=
Received: from airbuntu (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d45d0000000b0033b11e91c0bsm2341093wrs.81.2024.02.06.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 07:20:56 -0800 (PST)
Date: Tue, 6 Feb 2024 15:20:54 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Hongyan Xia <hongyan.xia2@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Morten Rasmussen <morten.rasmussen@arm.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-kernel@vger.kernel.org, David Dai <davidai@google.com>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [RFC PATCH v2 0/7] uclamp sum aggregation
Message-ID: <20240206152054.k3uskf3rhd4icmzt@airbuntu>
References: <cover.1706792708.git.hongyan.xia2@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1706792708.git.hongyan.xia2@arm.com>

On 02/01/24 13:11, Hongyan Xia wrote:

> [1]: https://lore.kernel.org/all/20230331014356.1033759-1-davidai@google.com/

Their solution is not acceptable for the same reason yours isn't. Saravana and
David know this and we discussed at LPC. uclamp hints are limits and should not
be summed.

> [2]: https://android.googlesource.com/kernel/gs/+/refs/heads/android-gs-raviole-5.10-android12-d1/drivers/soc/google/vh/kernel/sched/fair.c#510

I think I clarified several times so far that this is not related to uclamp.
Could you please refrain from referring to it again in the future? This is
misleading and neither helps your cause nor its cause. The fact that you're
relating to it makes me very worried as both links demonstrate lack of
understanding/confusion of what uclamp is supposed to be.

Again, this solution is not acceptable and you're moving things in the wrong
direction. We don't want to redesign what uclamp means, but fix some corner
cases. And you're doing the former not the latter.

