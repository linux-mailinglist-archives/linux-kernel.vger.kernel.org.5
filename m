Return-Path: <linux-kernel+bounces-77931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9656860CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A91E1F25916
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD30A4F5ED;
	Fri, 23 Feb 2024 08:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VgbPUV1v"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7717BAC;
	Fri, 23 Feb 2024 08:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676915; cv=none; b=NedCMmzAfbDj8Uo1S5MXot05icABGzsCfBlTg2koMsYh5pago+q1as6yS2PxZNoEet5rzFICf82X8TRp6+Hr94Pz1/nU0+clJ3Rx02bxfKA3aT3jiTbuMJ53D9TSnxTh/c3j8TTnyDL66VqYjm03HEt0u7/AzPPu0eegy5FZQEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676915; c=relaxed/simple;
	bh=cWWIxYRgoOxuJ68j1q9tZim4FqZAlZlra0e2EyXAcqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mboc+jDOcp2MvCYQzzUvyByRGsXvFiJ0RHxDTsespbPPrZIsJYlW/C80J0+EEK6SHCYCIAq2BnUWnlqNjY/pHa1RtuRah+5y91rqVzkqcUwCJDqp0FzchuMmmK9j9hAiwGsRKQET1dl8Tluv6DyZJUPNEKIoT/vasq+AjWujXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VgbPUV1v; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708676911;
	bh=cWWIxYRgoOxuJ68j1q9tZim4FqZAlZlra0e2EyXAcqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VgbPUV1vaOZ1+Qy2HpOhr+qA2MyPZzmIs2aDRGaC6TtZeyXnn8i6yskawRRSDVrIr
	 B7vzNaGsr5cDdjRyl/AVD5xnzSCyfnsxkYTjU2fhroXaPw6CJyPpPLY2K/AWhEjsOi
	 imunYIf5BH1qCEiANnOjuadrvXGj9oeS+UHsE5f1WeKi+zwuFOvzVQZnzwoQDTktla
	 eXsGErXMmAoCKIFh4b/kWkmLJM8UpfW+RdLSTbi4DUXw9cqdlkGPAhOp+DWxHfkSqF
	 Ku9H6p347w1ZUsibw5cvdWulxsKjJzRM6h/UPryhiwhKm16Axs4TBhuMg5v4AuE0Qa
	 YhdbTBqgKGo+w==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 30BC437813DF;
	Fri, 23 Feb 2024 08:28:30 +0000 (UTC)
Message-ID: <298d953d-6320-4dda-b31e-c9503dc91cdb@collabora.com>
Date: Fri, 23 Feb 2024 09:28:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3,2/2] media: mediatek: vcodec: adding lock to protect
 encoder context list
Content-Language: en-US
To: Yunfei Dong <yunfei.dong@mediatek.com>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Nathan Hebert <nhebert@chromium.org>, Irui Wang <irui.wang@mediatek.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig <frkoenig@chromium.org>,
 Daniel Vetter <daniel@ffwll.ch>, Steve Cho <stevecho@chromium.org>,
 linux-media@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20240222092609.31382-1-yunfei.dong@mediatek.com>
 <20240222092609.31382-3-yunfei.dong@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240222092609.31382-3-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/02/24 10:26, Yunfei Dong ha scritto:
> The ctx_list will be deleted when scp getting unexpected behavior, then the
> ctx_list->next will be NULL, the kernel driver maybe access NULL pointer in
> function vpu_enc_ipi_handler when going through each context, then reboot.
> 
> Need to add lock to protect the ctx_list to make sure the ctx_list->next isn't
> NULL pointer.
> 
> Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


