Return-Path: <linux-kernel+bounces-101527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4A287A850
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA808B23CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A984502D;
	Wed, 13 Mar 2024 13:27:54 +0000 (UTC)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F3446A0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336474; cv=none; b=eiAKAGFnWYgBdNeTivP6NVcHREAt18ByZSpp73Sh0J3XiygXVJZH1cQNThH6aZlusPElvby8KqzHoKIYtk5R389H7umLuRHRYppMiynQLxWvDFlhb2W6ee9GDLEcqSrzJTiS89aa3VogvcNOp1fYPzAWuob8OWtxi0CasZMKMKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336474; c=relaxed/simple;
	bh=fob+OCoD/ZqFHOa7b+XC+USdOxB3YpQjVsw9rSR/cMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RuyQ+Nhn4/4qUDaDFUv4+0fQwoXZ3NQA8lf6HktVVxVbaURt7s/dfqpHq+8VLAk9FthPAKo8z/FVfZToIdM8+lk8YSYWEBluooGDVWtrRZ6wmSa9lcsaK6M6t1+bOEbYIambSfbGvBapojH49CiERHV8M17qiaZg9bppas78+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsx46Rhz4x0q;
	Thu, 14 Mar 2024 00:27:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, Kunwu Chan <chentao@kylinos.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240301085834.1512921-1-chentao@kylinos.cn>
References: <20240301085834.1512921-1-chentao@kylinos.cn>
Subject: Re: [PATCH v2] powerpc/mm: Code cleanup for __hash_page_thp
Message-Id: <171033598344.517247.16630935060498918995.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 01 Mar 2024 16:58:34 +0800, Kunwu Chan wrote:
> This part was commented from commit 6d492ecc6489
> ("powerpc/THP: Add code to handle HPTE faults for hugepages")
> in about 11 years before.
> 
> If there are no plans to enable this part code in the future,
> we can remove this dead code and replace with a comment
> explaining what the dead code was trying to say.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Code cleanup for __hash_page_thp
      https://git.kernel.org/powerpc/c/d9cf600ecb7b053345aa76c1988cf374260cfdaf

cheers

