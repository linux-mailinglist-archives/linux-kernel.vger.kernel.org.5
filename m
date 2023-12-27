Return-Path: <linux-kernel+bounces-12216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5B81F172
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E6A1C210A6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429744C61;
	Wed, 27 Dec 2023 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Odl1enjz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BB1E52F
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 18:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7FAC433C7;
	Wed, 27 Dec 2023 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703702565;
	bh=Itb1htvmWYpO4t/GAfB1X1BEGP2JCKRav8Pymo8NuEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Odl1enjzu74MzygvCIiuGdQhGuwBJGYIrfEtU38Js+pJaoZgqZtkgAzxnt8KMGu1Z
	 HnIBfcbwruRGCu4fnHHGpQUY7F610YMk2gcSRgtmGCxsz2CP9vBZFtS/g54K0EOiqb
	 vXLQMw500IYoKRuQK2K0rtEuQiKxOdMtZzsO8p2I=
Date: Wed, 27 Dec 2023 10:42:44 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: David Rientjes <rientjes@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org, surenb@google.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, souravpanda@google.com
Subject: Re: Sysfs one-value-per-file (was Re: [PATCH] vmstat: don't auto
 expand the sysfs files)
Message-Id: <20231227104244.824b0977ae6d4bb6b37f6f79@linux-foundation.org>
In-Reply-To: <13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
	<3d415ab4-e8c7-7e72-0379-952370612bdd@google.com>
	<CA+CK2bA2vZp3e+HHfB-sdLsPUYghMxvKcWURktDtNjwPL79Csw@mail.gmail.com>
	<b1049bfa-68c4-e237-30a9-1514a378c7f1@google.com>
	<CA+CK2bBxbvO-osm5XKk4VkaXYgfZXkDAtfayaYJ-vXo=QFqGPA@mail.gmail.com>
	<13e5fbd4-d84d-faba-47f1-d0024d2c572d@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 16:53:31 -0800 (PST) David Rientjes <rientjes@google.com> wrote:

> But for existing files and conventions, I think we should settle it as 
> "keep doing what you've been doing for 13+ years" and don't force this 
> argument every time a kernel developer wants to just add one more stat.

Absolutely.  Let's do what makes most sense.  For new things, one value
per file.  For stats which logically group with other existing stats,
do whatever the existing other stats are currently doing.

