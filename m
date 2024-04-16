Return-Path: <linux-kernel+bounces-147545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9982B8A760F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CB51F22288
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A8D5A0F5;
	Tue, 16 Apr 2024 21:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U9Du23KI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46B44C6B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301368; cv=none; b=Fmq4609dagvRShG0QVYzxD+ZSvH/k5lARgemyX1q4E3PX0lsWrC4P5ISncIFWcs5pgUxqkAV6PTn28hWJNMSkAvdh9koZ5YQu4IxTf7iK22YkOo2EoN/pjWmDI6f80cDqIh0RcNpz4x8GvAo9ZrcKuch/dFYLWZrpgRUnkbjLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301368; c=relaxed/simple;
	bh=q1vR9iuTwpfrMkRWBq58oFjyaH02MidG9WMZWdYE5PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ag0wA1oCOw4o0irsQJIjtZBMTmAfIbNMuBl0e56/44LoTXhyLxOOr8K5GLuR9PDDArdbP9zH3RfgMtUI4f88dhE761X+4I1POrplSaqT7FEwRoUk3jK9RXPVAYiqVGG4akTEWtQZemff1Iaa52zcIqujDIAPuY0NVuRH4tocjts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=U9Du23KI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=se6IGHwx0p4O/ZB4wATxGcyPkfueklSfX1M0qValIYk=; b=U9Du23KIIYJ3IKEodyXouSHzf7
	Yn9Sve0BAcMrXCYeRPpS2ewB22yXmx+DkzF4EKmzHJOBJaaUsD9XOxJ+mgDL4Fetbz6zmC8gmf553
	POYISz1k33KtncZwVD1AbUY4lfHCdwcMhSkeQCA7T9s0f/zC/7Oi4xRqcKbpR7+kISXUvadEVlxns
	xKM3Z8IgXkeBMA5dPTnhgEjUSi13HEq5P6Dr9C8Txh1zrZexdLp5Bl48w2TtH14tha4Zqn/g0yK6x
	xI5YpjshK6XjLadQ/Gb+iUN9cS2Em0EVHrPx9OLopA+6O7mqjBXP5QKH67fcbtlEgaDvmJYD/rF8T
	WxHNiIQQ==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwpwx-0000000Dnb5-0tVk;
	Tue, 16 Apr 2024 21:02:43 +0000
Message-ID: <af0429dc-50eb-4800-87fd-4a63e72b0fc1@infradead.org>
Date: Tue, 16 Apr 2024 14:02:42 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: Fix no_vblank field references in documentation
To: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240416-drm-no_vblank-kdoc-link-v1-1-a1d8d1e9ff34@somainline.org>
 <4c882a69-8609-4b39-a95d-3128027373e1@infradead.org>
 <diiw2ptq4hsqby2zacdejeqyhksc4225atvmos2j74rklnw4v3@tdr5d5c24tpf>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <diiw2ptq4hsqby2zacdejeqyhksc4225atvmos2j74rklnw4v3@tdr5d5c24tpf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/16/24 2:00 PM, Marijn Suijten wrote:
> Hi Randy,
> 
> [..]
> 
>> Do you see differences in the generated html for these changes?
> 
> I have not yet generated the HTML locally to test this patch, but will surely do
> if that's a requirement.
> 
>> "&struct somestruct" and "&somestruct" should both be OK AFAIK, although
>> Documentation/doc-guide/kernel-doc.rst seems to say that using
>> "&struct somestruct" is preferred.
> 
> Keep in mind that this patch is about field/member references.  Quoting the
> relevant paragraph under "Highlights and cross-references":
> 
>   ``&struct_name->member`` or ``&struct_name.member``
>     Structure or union member reference. The cross-reference will be to the struct
>     or union definition, not the member directly.
> 
> This lacks the struct tag entirely, and observation shows that links with them
> don't highlight correctly (hence this patch) while member links without struct
> tag are clickable and have an anchor link to their parent struct.

Alrigthy. Thank you.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

