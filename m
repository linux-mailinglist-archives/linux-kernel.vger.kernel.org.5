Return-Path: <linux-kernel+bounces-13147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F89C82004F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B14B21FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C025125B5;
	Fri, 29 Dec 2023 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y8SykXx6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ADC125B0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jdfHfTT3DefZaMq66qHiHAagBb+Df8zEc06UQXPphJY=; b=Y8SykXx6aDVkOUvNGs7LHZBvjS
	WPO/XLBxxmmajKPco0fpzW1xp3Unn9iAHP0p4dRlN5+iqblxtrAuk1+rC0RGQ1tcnKaNspLcfN7q2
	WPqFZoPOq0rK3XiPQttLy8izJwFNctBM8hUJti91VSdWRv70+nUKYVUcEsc01D3gsYL20xGHEG64F
	T88uQqhlfRrdhZ2DCeW5/D2fTc97+WbOxUOiJHNcjmJiAF4eK229P3yaJ/Bi5v9MDn/STs0oyHgIq
	X7Fjmi5pI6UOTO6HsFn0wPX3T2iQk7GA2z5C0ha4wDV8VQdvZVC9XbX1fuSFt1Iec+wBEqR/k8PEd
	6iv94jMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rJExP-006J5L-4A; Fri, 29 Dec 2023 15:39:31 +0000
Date: Fri, 29 Dec 2023 15:39:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Malkoot Khan <engr.mkhan1990@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/cma: Use 'unsigned int' for cma_area_count type
 clarity
Message-ID: <ZY7oM8E5Mqqs5xHz@casper.infradead.org>
References: <20231229153238.153627-1-engr.mkhan1990@gmail.com>
 <20231229153238.153627-2-engr.mkhan1990@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229153238.153627-2-engr.mkhan1990@gmail.com>

On Fri, Dec 29, 2023 at 03:32:38PM +0000, Malkoot Khan wrote:
> Replace 'unsigned' with 'unsigned int' for the variable cma_area_count.

Please don't run coding style tools over other people's code.  Such
changes are generally unwelcome.

