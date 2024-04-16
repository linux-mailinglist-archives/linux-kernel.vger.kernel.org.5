Return-Path: <linux-kernel+bounces-147544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EC68A760B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BE31C210EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AC958203;
	Tue, 16 Apr 2024 21:00:35 +0000 (UTC)
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42D744C6B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713301234; cv=none; b=qdR0BiDPC0havICrlVBzlmW+sdDmKMTz+16TBm7babytGR4Kn87wDKFImxRcrlqTX/NUFwmTuXCGV8QmCgLMPgcP1QzNTjRXXY9MXQ0kkQ6MbS9GInwQc9u3VgvsPeEhp3/gL5McFhhuhuRPX87kP0Y1g1RWQcuiVkgiywMrPzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713301234; c=relaxed/simple;
	bh=c4odR+vhNr1gpC0I1ceJlx7upJY6i4LbPccqnp/yshI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PA07sYyCZz0F9HvveSyj7U2Vrz/K54P8uRha07guBO9aYLTK0W9ALcatHxPWnHGfAHEguAWhgZsR0Kxill3/EXrmnTDqKqPmnE1YJMdEAuqVKFl4qGyPpKnaOYvUw7Sh3dKorkE2F/21+FlE7Qr/AQYF4WxrWuxmPSgQDjqUpRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B4B3F4067F;
	Tue, 16 Apr 2024 23:00:30 +0200 (CEST)
Date: Tue, 16 Apr 2024 23:00:29 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH] drm: Fix no_vblank field references in documentation
Message-ID: <diiw2ptq4hsqby2zacdejeqyhksc4225atvmos2j74rklnw4v3@tdr5d5c24tpf>
References: <20240416-drm-no_vblank-kdoc-link-v1-1-a1d8d1e9ff34@somainline.org>
 <4c882a69-8609-4b39-a95d-3128027373e1@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c882a69-8609-4b39-a95d-3128027373e1@infradead.org>

Hi Randy,

[..]

> Do you see differences in the generated html for these changes?

I have not yet generated the HTML locally to test this patch, but will surely do
if that's a requirement.

> "&struct somestruct" and "&somestruct" should both be OK AFAIK, although
> Documentation/doc-guide/kernel-doc.rst seems to say that using
> "&struct somestruct" is preferred.

Keep in mind that this patch is about field/member references.  Quoting the
relevant paragraph under "Highlights and cross-references":

  ``&struct_name->member`` or ``&struct_name.member``
    Structure or union member reference. The cross-reference will be to the struct
    or union definition, not the member directly.

This lacks the struct tag entirely, and observation shows that links with them
don't highlight correctly (hence this patch) while member links without struct
tag are clickable and have an anchor link to their parent struct.

- Marijn

