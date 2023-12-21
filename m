Return-Path: <linux-kernel+bounces-9191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FBF81C21C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FF01F25442
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB43A7949D;
	Thu, 21 Dec 2023 23:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vp55ufAe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DFC78E9D;
	Thu, 21 Dec 2023 23:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E26BC433C8;
	Thu, 21 Dec 2023 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703202589;
	bh=DzS0lRbVCV60NGLtHqn9dKHYbNssxVYhq7y9jEs68bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vp55ufAeLpeinb2eUci6B5EAi0i6+wNoKKYCDj3OFsmm3urQo2FwvYBQTNtRCIKkN
	 qm22cVkj82A1oLxfZLcQgS4cQX4jW30/DwgEmVz04Q+yerWQVZgn95EAegmyyu6OYL
	 +Q7dtjWkGa/jyarkQDOUT9nEE8GQi7J5L3A53AZaynpnj45fuC/C9VEAX7MWF/6L+X
	 8Qo+5zxDBRGlYh7cqYaCc2uacXMiBcCH15mhgl8Ht5wJRi0iYdlcegd+SjN+em28xP
	 beG/e0dna1HSwEYSvDgiyTtzfPseeuO9SkjCpzfnbzn9fBDaXLnesaOuQv+Lw2PvJj
	 ZwGCvtNXlZHRw==
From: SeongJae Park <sj@kernel.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <nnn@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] mm/damon/vaddr: changed asm-generic/mman-common.h to linux/mman.h
Date: Thu, 21 Dec 2023 23:49:47 +0000
Message-Id: <20231221234947.59458-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221-asmgenericvaddr-v1-1-742b170c914e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Tanzir,


On Thu, 21 Dec 2023 23:11:01 +0000 Tanzir Hasan <tanzirh@google.com> wrote:

> asm-generic/mman-common.h can be replaced by linux/mman.h and the file
> will still build correctly. It is an asm-generic file which should be
> avoided if possible.
> 
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>

Thank you for this patch :)

Maybe we could add below Fixes: line?  I guess stable@ is intentionally not
added and that makes sense, but please let me know if you think differently.

Fixes: 6dea8add4d28 ("mm/damon/vaddr: support DAMON-based Operation Schemes")

Other than that, looks good to me.

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

