Return-Path: <linux-kernel+bounces-66626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11BD855F29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF982894BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8996A000;
	Thu, 15 Feb 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vdRLr0SL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5486169DF0;
	Thu, 15 Feb 2024 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992993; cv=none; b=mtNXoYtHMaTTDRbEVhUztX6y3HH67phcWFGNtocXk0wDerZkLMZ8DkavWonkWHNgKK5v0F65+kgNklWKIv2T+fu2P1KU/yWJjb7qk7vd21YcKeJ3fZX3ZncEqYI9KjFfTdsEwzviZX8OHcJs3ZqRKg3vNJOW2YjOd+hBmnRscGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992993; c=relaxed/simple;
	bh=lCKAiQ1BgMuFxaAEpE7w6O8TyAdEMRj0SufRx1KfSQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IECVQNsISilyOGDd8fkIN+TQiYjrFm9jf+qBRzsZ9uqhiiNbwLMmk7l9iF5/YEDH06fLORX7bIXDqWdVwIANFVfdMeNOUFPyTfkEAJCcYKvOkyq2R0uT7ez2zoUtuCD8BKipZxqAMo7pJep1tQMuxGodqFNM1vy1Og7aXQkfDAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vdRLr0SL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707992983;
	bh=lCKAiQ1BgMuFxaAEpE7w6O8TyAdEMRj0SufRx1KfSQ4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vdRLr0SLlXy+WD9tG1YIsF9FZLOC9Ck90t/SzhMX1YTkqmHPhs3662tv1zeYOqzbP
	 gYtysHX1iaaVtaO/quHSWYrygrR/LZnsDrz2jmC2XeFBBTMJQGMVeRlMy+k2mI27yH
	 b5D8CRBLTfu3XdhTzjoQox4Ip+SS+xFBhwK/S9MEYK9VIPQIptvPEoB5bk6Ng7xvKY
	 bISZqW458jcqsXYHaX5zaRxjaw4fz1lgmf0kUQOI+5YJ+u8z2VqBbh/dL3D8S5nTnp
	 ZGO1hMVhNcG6Kat2SZ1QQGw0OEypsUHoGLTyD2uURgDOsSRpsrYzmFfV5MVgNtYaUq
	 MmVdQ4+9Z39ZA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 178123780FC7;
	Thu, 15 Feb 2024 10:29:43 +0000 (UTC)
Message-ID: <4dcfaf49-aaac-4980-a149-02fec3109f31@collabora.com>
Date: Thu, 15 Feb 2024 11:29:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] media: platform: mtk-mdp3: drop calling
 cmdq_pkt_finalize()
Content-Language: en-US
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 Moudy Ho <moudy.ho@mediatek.com>
References: <20240215004931.3808-1-chunkuang.hu@kernel.org>
 <20240215004931.3808-7-chunkuang.hu@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240215004931.3808-7-chunkuang.hu@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 15/02/24 01:49, Chun-Kuang Hu ha scritto:
> Because client driver has the information of struct cmdq_client, so
> it's not necessary to store struct cmdq_client in struct cmdq_pkt.
> cmdq_pkt_finalize() use struct cmdq_client in struct cmdq_pkt, so it's
> going to be abandoned. Therefore, use cmdq_pkt_eoc() and cmdq_pkt_nop()
> to replace cmdq_pkt_finalize().

No, it's not because cmdq_pkt_finalize() has cmdq_client, but because we want
finer grain control over the CMDQ packets, as not all cases require the NOP
packet to be appended after EOC.

Besides, honestly I'm not even sure if the NOP is always required in MDP3, so...

..Moudy, you know the MDP3 way better than anyone else - can you please
check if NOP is actually needed here?

Thanks!
Angelo

> 
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c | 3 ++-
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 2 ++
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h | 1 +
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> index 6adac857a477..a420d492d879 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
> @@ -471,7 +471,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
>   		dev_err(dev, "mdp_path_config error\n");
>   		goto err_free_path;
>   	}
> -	cmdq_pkt_finalize(&cmd->pkt);
> +	cmdq_pkt_eoc(&cmd->pkt);
> +	cmdq_pkt_nop(&cmd->pkt, mdp->cmdq_shift_pa);
>   
>   	for (i = 0; i < num_comp; i++)
>   		memcpy(&comps[i], path->comps[i].comp,
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> index 94f4ed78523b..2214744c937c 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
> @@ -231,6 +231,8 @@ static int mdp_probe(struct platform_device *pdev)
>   		goto err_put_scp;
>   	}
>   
> +	mdp->cmdq_shift_pa = cmdq_get_shift_pa(mdp->cmdq_clt->chan);
> +
>   	init_waitqueue_head(&mdp->callback_wq);
>   	ida_init(&mdp->mdp_ida);
>   	platform_set_drvdata(pdev, mdp);
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
> index 7e21d226ceb8..ed61e0bb69ee 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.h
> @@ -83,6 +83,7 @@ struct mdp_dev {
>   	u32					id_count;
>   	struct ida				mdp_ida;
>   	struct cmdq_client			*cmdq_clt;
> +	u8					cmdq_shift_pa;
>   	wait_queue_head_t			callback_wq;
>   
>   	struct v4l2_device			v4l2_dev;


