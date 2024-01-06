Return-Path: <linux-kernel+bounces-18705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581CC826161
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 21:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A64D1B21A66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97EF50A;
	Sat,  6 Jan 2024 20:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A2qBwJ9Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C5EF4E4;
	Sat,  6 Jan 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=pA1bko8lyTP4VSP1WU3Gn+CtWUsuPvxhSOBVoaYEFOw=; b=A2qBwJ9Y4P2spmD8U5tsDlmMai
	2YTGlEy/+cUGl1zf4QWj32bWeX5lBZFEAJQVah6O7D6Lg5EXr6fUrJQBTzwzz9DkIXEw8Rp30SxFl
	8hns/43fmMlzNrRApOC8Yw4+EJTMbcyLAG5OIz0iTJhWfoAoG1mVVQoUtt3UcQ5+133vZQt5vcO3T
	A2bk3zI58V+TtY2qq7fdwCiDPpXSyXkohMqVsnBTWv3whXpfraE04TBaknA5xgDSIRW6gXdr0lzbn
	ppJDMFsmUtwFirSWSMYPmG6EFd6jATfw2d62r+LKHrD18vAq4Is4tmyrC6S0m9bhccs78aUEMxp0Q
	WDnvUDOw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMCs7-001ots-2c;
	Sat, 06 Jan 2024 20:02:19 +0000
Message-ID: <a5988e51-3ab4-43e8-938a-1e3fb84424fe@infradead.org>
Date: Sat, 6 Jan 2024 12:02:14 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc-guide: kernel-doc: tell about object-like macros
Content-Language: en-US
To: linux-kernel@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20240106050137.6445-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240106050137.6445-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/5/24 21:01, Randy Dunlap wrote:
> Since 2014 kernel-doc has supported describing object-like macros
> macros but it is not documented anywhere. I should have required
> some documentation for it when I merged the patch. :(
> 
> There are currently only 3 uses of this (all in DRM headers, in
> include/drm/*.h). There have recently been a few other attempts
> at using kernel-doc for object-like macros, but they didn't use the
> "define" keyword and I mistakenly told them that kernel-doc does
> not support such documentation.  :( again.
> 
> Add object-like kernel-doc documentation now so that more may know
> about it and use it.
> 
> Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/doc-guide/kernel-doc.rst |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Jon,
I'm going to send a v2 of this patch. Please don't merge this one.

Thanks.
-- 
#Randy

