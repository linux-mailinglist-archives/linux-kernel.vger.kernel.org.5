Return-Path: <linux-kernel+bounces-119610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2060588CB0F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D4E324424
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE2320DD3;
	Tue, 26 Mar 2024 17:34:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7945C06
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474498; cv=none; b=YkCfpp6PtetrmFeOPEhyexZ6vfNuNQ1Pwc5hnVBy1G0vXfegzXxfjMTWEbkEq4cncLtAwcaLLX83hsGcTlfjBA2xj4lbcBSRqJQO5uGOHibJ9EdSrbD+j3vy3EMTXU+fqhv67V98oahRtQCaFpeysRpJRAiejTaOoXd2obOBpxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474498; c=relaxed/simple;
	bh=lbl6QaHxe02Juccz6/C5e5ITu/8bnnT80pBEiwtkFv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h77u60DQEM+Xuwv/BLxMVz0GgoxD2ImvcdXmXXC85ZvCCMJvcetLoYc7HzUacZRUSo0VuxbcJEBPwdypP9Dkelz06z4sWVA7Gyu4qX0rjouEjztn7Uv/TSmLBi53aoq0XMabfaAAIcMCxkjZ2nb38rAW9Uu3stHKd7J6sqlg5qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91814C433C7;
	Tue, 26 Mar 2024 17:34:57 +0000 (UTC)
Date: Tue, 26 Mar 2024 17:34:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/kmemleak: Disable KASAN instrumentation in
 kmemleak
Message-ID: <ZgMHP5oVpNRvImq-@arm.com>
References: <20240307190548.963626-1-longman@redhat.com>
 <20240307190548.963626-3-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307190548.963626-3-longman@redhat.com>

On Thu, Mar 07, 2024 at 02:05:48PM -0500, Waiman Long wrote:
> Kmemleak ia a memory leak checker. KASAN is also a memory checker but
> it focuses more on finding out-of-bounds and use-after-free bugs. Since
> kmemleak is inherently slow especially on systems with large number of
> CPUs, adding KASAN instrumentation will make it slower even more. As
> kmemleak is not for production use, the utility of enabling KASAN there
> is questionable.
> 
> This patch disables KASAN instrumentation for configurations that
> enable both of them to slightly reduce performance overhead.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

