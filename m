Return-Path: <linux-kernel+bounces-23282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF5482AA3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168331F2630F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB9116428;
	Thu, 11 Jan 2024 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="nffDKb6F"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6838816420
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28ca63fd071so2687794a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1704963739; x=1705568539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+g8rx/Js9kR9z/v7+Mn1kTVZXJSN4sbVOGbBgK7rO7Y=;
        b=nffDKb6F8Wo/dkiC42w6CwY2fB0Y+mLFMG6O3Ar9G4AT+3aJShOCDpaygqiRBvsCT9
         bJRk8MojAPNWK6tNvFCzYT2b+Vq3VLxowgudjtaC1sxpQZGaihQLu5nxCJuJm5gHs4y3
         mVAY0421ojNpxUjVuiC8+4AannqZtGdZDdjxjQ9/OunWrI3XTgr+8CuqoGA/eIFaDDQe
         5fmotibGaDx++fwgVRJhVr1G6MNVVVHYD4jqizj28KEDY1TLbOZ+B/8ozdJRHA1G+IFA
         iE8Ypqq8WPHCI5P3QEbtoXV52L/VZabHAlVIG1j1EcYbdsuTdhwGk8sQLL4RcTrl2iFf
         uvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963739; x=1705568539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g8rx/Js9kR9z/v7+Mn1kTVZXJSN4sbVOGbBgK7rO7Y=;
        b=HAJEdOwFwDPX5wSdECCxmaVquCyfS2c6GrdU28LG2clvR6aQ8keZjKusLms28tCQkO
         6y8tJo5aR6Lk4yyLXH06hWeccfAn3Z85kqToBMesdXBY+Cg5q5igslBHgiOZqIHzZ1xG
         XF+ay/ESgKmKWbgZPAiR5X73pE1aSd6wU3Xug7YHkcADORoTv4TnXq4q4T/zSziS5waQ
         OS6vekyJpORPrU56X9bkESmFaX/YAsT1jfRQhmmbKHzbUQJhL8Ix8LJypkJtk3LM32yZ
         So0qctdRQ23nh/0+mfVZoCd24KENXCQ0/SapjPCAznNJf4IpBSqDmvcwON7BBQIChWpW
         9P7A==
X-Gm-Message-State: AOJu0YzpFTr5XRwNfmgM6T7pxwOMc7aBS13MCByHm5gKwORHCnlKzC2f
	LMKpzBKxynZBJS93UX/FWG+R/GC2aVb7Dn74Xb8yfenqWIQ=
X-Google-Smtp-Source: AGHT+IG1anub9IXtnzE0NkJV8/hkigke48pXyoI6NhvhVXOStVvkDJD/vNcvk7XrJv0ekhWe9d6Eug==
X-Received: by 2002:a17:90a:df03:b0:28c:8eb9:3029 with SMTP id gp3-20020a17090adf0300b0028c8eb93029mr692801pjb.50.1704963739586;
        Thu, 11 Jan 2024 01:02:19 -0800 (PST)
Received: from dread.disaster.area (pa49-180-249-6.pa.nsw.optusnet.com.au. [49.180.249.6])
        by smtp.gmail.com with ESMTPSA id sb8-20020a17090b50c800b0028be1050020sm3144238pjb.29.2024.01.11.01.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 01:02:19 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rNqx6-008svE-12;
	Thu, 11 Jan 2024 20:02:16 +1100
Date: Thu, 11 Jan 2024 20:02:16 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v3 07/11] mm: vmalloc: Offload free_vmap_area_lock lock
Message-ID: <ZZ+umGZ2NFQN/KuW@dread.disaster.area>
References: <20240102184633.748113-1-urezki@gmail.com>
 <20240102184633.748113-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240102184633.748113-8-urezki@gmail.com>

On Tue, Jan 02, 2024 at 07:46:29PM +0100, Uladzislau Rezki (Sony) wrote:
> Concurrent access to a global vmap space is a bottle-neck.
> We can simulate a high contention by running a vmalloc test
> suite.
> 
> To address it, introduce an effective vmap node logic. Each
> node behaves as independent entity. When a node is accessed
> it serves a request directly(if possible) from its pool.
> 
> This model has a size based pool for requests, i.e. pools are
> serialized and populated based on object size and real demand.
> A maximum object size that pool can handle is set to 256 pages.
> 
> This technique reduces a pressure on the global vmap lock.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Why not use a llist for this? That gets rid of the need for a
new pool_lock altogether...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

