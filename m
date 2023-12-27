Return-Path: <linux-kernel+bounces-12257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF1D81F206
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1381C225FB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1E2481AB;
	Wed, 27 Dec 2023 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MjY/HB9f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC5E481A4
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 20:58:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661C2C433C8;
	Wed, 27 Dec 2023 20:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703710734;
	bh=nVIXdXTdlWdkqE/2/J9dc3xAOUa+ZEXhxjCS1ovFzRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjY/HB9fglm3RR9yjFHrErDDhjl2mpNchHTuMZPLSRlKBY802XFzhXarLC0b589ez
	 cNjeuOJlejNZ+h2vXKbu1g4+gz0NxqaJxehHi5ln0zPn7PF5Xuqb4KWxcTW3Omf1tu
	 Z6UvQ41VMPxOfmtoM7MwEpeAZr/hEWbWIg/CvOFM=
Date: Wed, 27 Dec 2023 12:58:53 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Barry Song <21cnbao@gmail.com>, Seth Jennings <sjenning@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Vitaly Wool
 <vitaly.wool@konsulko.com>, Nhat Pham <nphamcs@gmail.com>, Chris Li
 <chriscli@google.com>, Yosry Ahmed <yosryahmed@google.com>, Dan Streetman
 <ddstreet@ieee.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v4 1/6] mm/zswap: change dstmem size to one page
Message-Id: <20231227125853.2dd07cd61f8a8df95042677c@linux-foundation.org>
In-Reply-To: <af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
References: <20231213-zswap-dstmem-v4-0-f228b059dd89@bytedance.com>
	<20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com>
	<CAGsJ_4wuTZcGurby9h4PU2DwFaiEKB4bxuycaeyz3bPw3jSX3A@mail.gmail.com>
	<af0a03d5-e536-41b7-9ab8-c5985794b7db@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 14:11:06 +0800 Chengming Zhou <zhouchengming@bytedance.com> wrote:

> > i remember there was an over-compression case,  that means the compressed
> > data can be bigger than the source data. the similar thing is also done in zram
> > drivers/block/zram/zcomp.c
> 
> Right, there is a buffer overflow report[1] that I just +to you.

What does "[1]" refer to?  Is there a bug report about this series?

