Return-Path: <linux-kernel+bounces-96715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802287607B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31435281193
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F28524D2;
	Fri,  8 Mar 2024 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="bdSRG0xm"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439935103F;
	Fri,  8 Mar 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888359; cv=none; b=hha/vUgFN0SxzdzuSwLb6/AuuDj53FTsSPg4aV51U1LMQtMl5MUaXO+LI914/FH/hVqCEgNPb+/7nffQIxmCYNTZFdV9QmV2YT1Jq460R8IFmqbMtAm1fDi8gSS28B0x38DXEO/4iwiifGBedp92mxSi8tuNOAcJLAZeMneQ7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888359; c=relaxed/simple;
	bh=9nk/LM8qbXxqqrGQTnt5jKWaF87oDn2J91q3tvQdGAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB0lJfT7YVSp5Zqqc051xJSF9sdMtkOwdpYbTEUDKt0vhD7jltvACkQTiCVrguWaPPPBO2EGZ333N4RNy+9TaAHJbCCWimKHZXxUY/kLZVwt1iQeuPAGE5HOPU/sLS3bGFJxQjzcRgsIhci/4ZdrJ7CVQktVnbRbQbWmbeCLql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=bdSRG0xm; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9nk/LM8qbXxqqrGQTnt5jKWaF87oDn2J91q3tvQdGAc=; t=1709888357;
	x=1710320357; b=bdSRG0xmeLMlyH1q4zHZRFOQZ96DPNKdWGyVdBaPjbdgD+cyotvxft8Pp2eT/
	YcXx2DlQlwhSHI32OlTD0s8i1ydk2n+dTkmlNvQZvT84ui5MzQfPTwTBwTetKwWWN+rxm9FnnBzjC
	wfIiLRJ6ct9u1RosnHKNHmn9D7VB/IY3H5B0WvLc/huDV1IN/eMICIbT4SspgsgSs8eU5QAyFEHNg
	30Jfq9zl0u9wP7QhZpGmvdIz4I5utKPup2aNkQ6+dtfzcQ3r+pW36ZoCq+J8GqJUlHiP7W/WgwOdc
	iiU17RskOH0mhca0IzS5NMTYU3gnM1XgL2m+IUMERlTPSZuMkw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1riW4D-0001ul-M1; Fri, 08 Mar 2024 09:59:01 +0100
Message-ID: <7c7e363b-ec9b-4b46-a0bf-7ae062d734d1@leemhuis.info>
Date: Fri, 8 Mar 2024 09:58:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/qxl: fixes qxl_fence_wait
Content-Language: en-US, de-DE
To: Alex Constantino <dreaming.about.electric.sheep@gmail.com>
Cc: 1054514@bugs.debian.org, airlied@redhat.com, carnil@debian.org,
 daniel@ffwll.ch, dri-devel@lists.freedesktop.org, kraxel@redhat.com,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 spice-devel@lists.freedesktop.org, timo.lindfors@iki.fi,
 tzimmermann@suse.de, virtualization@lists.linux-foundation.org
References: <fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info>
 <20240308010851.17104-1-dreaming.about.electric.sheep@gmail.com>
 <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20240308010851.17104-2-dreaming.about.electric.sheep@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709888357;95bd5470;
X-HE-SMSGID: 1riW4D-0001ul-M1

On 08.03.24 02:08, Alex Constantino wrote:
> Fix OOM scenario by doing multiple notifications to the OOM handler through
> a busy wait logic.
> Changes from commit 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait") would
> result in a '[TTM] Buffer eviction failed' exception whenever it reached a
> timeout.

Thx for working on this.

> Fixes: 5a838e5d5825 ("drm/qxl: simplify qxl_fence_wait")
> Link: https://lore.kernel.org/regressions/fb0fda6a-3750-4e1b-893f-97a3e402b9af@leemhuis.info

Nitpicking: that ideally should be pointing to
https://lore.kernel.org/regressions/ZTgydqRlK6WX_b29@eldamar.lan/ , as
that the report and not just a reply to prod things.

Ciao, Thorsten

