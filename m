Return-Path: <linux-kernel+bounces-108683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3B0880E5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221881F22B88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A93339FFF;
	Wed, 20 Mar 2024 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rPLC2rbm"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49CA3BB20;
	Wed, 20 Mar 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926027; cv=none; b=fG5aE5Ccho66SLJukFcWcmVVLpfyTsDEKTWpMDce/dH40H62GSj07dYTysg5lF4bK96YdodrmZNuuObM8MjZeTr6wsRgY8FDea84SOUytavO7AZkZqEEt5Db6FCOSERVrHZKC7xZ+7fFAkCBeYykPyDZ0nxeuyN1EBaHRL3r1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926027; c=relaxed/simple;
	bh=f5TBxsXEtnxxjUawzCCMKUWjeP88hHOAUk3qAGQHobE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoP51EGwGPrxUbyR+9gooAGUTiWBvxsQVKa655FdmN4GrUX6ZZ2K6ahv+/uiqbGxZwf7KRXbqJz7ih5OAmjJlfHOOEtZGvG8yE7SDIOFspZZS6TdD2WwYJ7mMUGpmF1q+fufpo0ZZ8A6xVIs8nzD8ktmicZepE5xxm0OQUWNkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rPLC2rbm; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710926024;
	bh=f5TBxsXEtnxxjUawzCCMKUWjeP88hHOAUk3qAGQHobE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rPLC2rbmMfSDL7SfVIjwIYPwavzcX5JR0Ow7R6VJm+E3lHQtX+X1awhmPtEvl/gjQ
	 tI5V9EyYtORf10G8dNND9QJQMNlFh3xkLQoEmJzzBLbXNNIawEU4BV3aYDtc/mp8SN
	 kcroNKFQ9/PdG2osZ8/MckyJKyPWnJsbfVqQdB34WN+wE3Kp1fPSpKOIB47wqraDJE
	 cBwBKbwoL/frmwfWy/+2lBZG//ldG2EN4Wv1waiId/wUYvRYReS+Rn/fEmO1swaoVI
	 z6o+uIxIfzI7w9dPDpNE1nmo/SzvxqLIx23Js0o/fBk1Z/l7U53kyKbL2yneYr17t+
	 XbT7BCp6+zETw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2D02137813C4;
	Wed, 20 Mar 2024 09:13:43 +0000 (UTC)
Message-ID: <c09b063f-a11a-4bc0-8b12-3d66f692c48c@collabora.com>
Date: Wed, 20 Mar 2024 10:13:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mediatek: vcodec: Handle invalid decoder vsi
Content-Language: en-US
To: Irui Wang <irui.wang@mediatek.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, nicolas.dufresne@collabora.com,
 sebastian.fricke@collabora.com
Cc: Longfei Wang <longfei.wang@mediatek.com>,
 Maoguang Meng <maoguang.meng@mediatek.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240320061336.2615-1-irui.wang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240320061336.2615-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/03/24 07:13, Irui Wang ha scritto:
> Handle invalid decoder vsi in vpu_dec_init to ensure the decoder vsi is
> valid for future use.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

This commit needs a Fixes tag, can you please add the relevant one and resend?

Thanks,
Angelo

> ---
>   .../media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c    | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> index 82e57ae983d5..17770993fe5a 100644
> --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_vpu_if.c
> @@ -231,6 +231,12 @@ int vpu_dec_init(struct vdec_vpu_inst *vpu)
>   	mtk_vdec_debug(vpu->ctx, "vdec_inst=%p", vpu);
>   
>   	err = vcodec_vpu_send_msg(vpu, (void *)&msg, sizeof(msg));
> +
> +	if (IS_ERR_OR_NULL(vpu->vsi)) {
> +		mtk_vdec_err(vpu->ctx, "invalid vdec vsi, status=%d", err);
> +		return -EINVAL;
> +	}
> +
>   	mtk_vdec_debug(vpu->ctx, "- ret=%d", err);
>   	return err;
>   }


