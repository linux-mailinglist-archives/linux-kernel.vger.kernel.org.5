Return-Path: <linux-kernel+bounces-155527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727D78AF38F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7881F220AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E31113CAAB;
	Tue, 23 Apr 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzG1UA5v"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472A013CA98;
	Tue, 23 Apr 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888641; cv=none; b=TP0648ulkyXEDw5e1PEtr2lk1TwhJpcjkyELPuX/vDQa8O/dhLYMszOkwfz16dYSznuWir096B041fNPkuGHOEf+mOI6J57xf0Y4CAtMWJsJx2EFXv8AubfaeSIfZe34jP+az9LK28e1tX+F6+XJEFWMuhpKbGGyfEkY+OUeONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888641; c=relaxed/simple;
	bh=o1a72SriqCofRJAiL12cU0C8WO49MwZYhQEM8zzR6b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPf40Dgie/NnPbv6Z9Du8PoDibHNUVO+aGZbym8t4j5HD4Sx44CqHSa76uzW9QIuRxBrvZMDMX0ZphFQDOdLNzer5cqzfgkPYFNlVQKXRlfngX14vBW3sbN63tRiH7uEf6JklY/lIuy5rbyKoBDay75WZyDp2wdJ8P9Anih9guM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzG1UA5v; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5b6e8f662so45900965ad.0;
        Tue, 23 Apr 2024 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713888639; x=1714493439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89XsLxTIyZU/1YlCByEe65lWUqJGzh8blemR9I/n6po=;
        b=PzG1UA5vjNoXi+HnIiVW4fD5unW/+h6n86ijNNxMBS8PTjyN4RAN7gHkTSQLljAb69
         /uEHdX0UgNvLHlfvU1xdt3eN1rlk0jTbTsWzkmgAZds0GCRIthVv4bx6MNCHbHY/ovPK
         SxnDlvIREXkVjqMiZP7JfNXk1EBmoyQVBd1nodLVRNEgGNoS54s5fv9eCk8N8aXCRHfY
         ca8kfUWQ6d+Yhs5RsUqKMzEaGXp9RDTm+tKuKRhavavIHkS6oZscpUKUFa2OMjUj6Chr
         bqRIrD0W+rmSUxkGVJKVRZyMUPm1Qjy8Zd1Zotckac3vwqjcz83DEuTiMqr4gqJqnoqP
         +SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713888639; x=1714493439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89XsLxTIyZU/1YlCByEe65lWUqJGzh8blemR9I/n6po=;
        b=QtmC+yY5y+wXqgNn50lVj2y9MpEaQspcU/PvLnFGkCQ19pehlrjtS2EMM6r16Cd0xS
         WgluQGV5Ape9UF0+9J7E76PVSonfUUsLKBpTNCbHwn5hn3pKp0lauc2YLfg7oel3L3p7
         t4pGWgMrIB7QL354fGqqDelqRh41DnzRSsMOUumaCBUIoqvyO6NpQhM5BSbACkYghIHf
         KyLbivZs3CAKUwXOneBczUZtqWqzJmE8Z4wqtLwUxd6ZOvCUGVYN7tKtRqtbEvU1qQhu
         XjdGVcw2+BvUhNObh6PjKO4KdxweHlfmIH1HB5HrR2G39yyfWvKx3zcOWKfZYrq5lxg9
         7TFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+jWft8cyrhxD6V6wu/MH3nXOdjYljpHYrZY8dfzivt68WJxoPizC7Tw4OE7PMXgt5zEh9N/53NY8V8eGsqc2hYhVp0AAk
X-Gm-Message-State: AOJu0YzWILBToEBDWsks+VWr0HnIppp/hoXxKxEigAnwjfpLNHhqIPJ6
	PaWRdPTOrbp2fHWr4dvMtzkkQ5lOY/JKXS8P9qafPb08WtuxBvomSqRJhpei
X-Google-Smtp-Source: AGHT+IHCRskPKThiqLtki3QqWsynFY74sXkHpV/B/WwPyjov7Ur/kIqVS1cbHVle23QYScT8y2QGOQ==
X-Received: by 2002:a17:902:ce87:b0:1e5:d0e3:b960 with SMTP id f7-20020a170902ce8700b001e5d0e3b960mr15985656plg.11.1713888639407;
        Tue, 23 Apr 2024 09:10:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id r3-20020a170902be0300b001e27462b988sm10200288pls.61.2024.04.23.09.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:10:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Apr 2024 06:10:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org, Sam Sun <samsun1006219@gmail.com>,
	xingwei lee <xrivendell7@gmail.com>,
	syzkaller-bugs@googlegroups.com,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>, stable@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix divide error in
 wq_update_node_max_active()
Message-ID: <ZifdfQ_vjqGqNdPk@slm.duckdns.org>
References: <CAEkJfYPGS1_4JqvpSo0=FM0S1ytB8CEbyreLTtWpR900dUZymw@mail.gmail.com>
 <20240423124548.1253842-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423124548.1253842-1-jiangshanlai@gmail.com>

Hello, Lai.

On Tue, Apr 23, 2024 at 08:45:48PM +0800, Lai Jiangshan wrote:
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 0066c8f6c154..b31cd7faeb9f 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1591,7 +1591,7 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
>  		off_cpu = -1;
>  
>  	total_cpus = cpumask_weight_and(effective, cpu_online_mask);
> -	if (off_cpu >= 0)
> +	if (off_cpu >= 0 && total_cpus > 1)
>  		total_cpus--;

Can we do this explicitly instead? ie. test total_cpus before using it as
divisor and use max_active explicitly if it's zero.

Thanks.

-- 
tejun

