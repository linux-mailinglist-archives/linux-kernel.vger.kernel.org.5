Return-Path: <linux-kernel+bounces-162774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDDC8B6057
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE3DB20E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6371272D3;
	Mon, 29 Apr 2024 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q+TQ62Oy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F01272CA;
	Mon, 29 Apr 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412705; cv=none; b=pHChRT+W3krkTbqJ5hu0ZL4buEc2AROK3Em2U1/mjE3OrGW6yF41J+2bonI0EhULDbywpUaht3VpDkPd9Ue0I30oQtdYlujhYmjVtHE0w33sh31oBr+zoC+X4eLh++nr7Jyj1S3bdYg+V27rbtjO2c6yBN1d3MVxPBmAa0XC4fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412705; c=relaxed/simple;
	bh=1eUVYVp+Xjc4OAJFJGhCu1jSoyHLPRmAVQDaix2FU1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxTMMV+Tk8PjsyWeForAo4r4srbx71y8KH6jlkB6K+hW92PkZB6oe4xM8SfLl6xO6V6fucsV4DbFyJOV8qSJIRR6yJB0nWWH3+X5rBc09qzAx/YJVixYAp27qO6EJJLcqYJHvcAAzWE5cADoLqi7ayvByDuCkx/BC5lKfNQkQeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q+TQ62Oy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714412702;
	bh=1eUVYVp+Xjc4OAJFJGhCu1jSoyHLPRmAVQDaix2FU1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+TQ62OyNKLmCbA/w4rO9bbrxYPz4cep6d9dHLQAtOwTRrbuv4Ias4EavOK/ywMIN
	 gLmVE/xm3EJbuHB9jotUbQnRml/fJFV1bQc3dZZwWh7k9rvJkIql2l2/dG5vi8QXyp
	 j/IzOVv0WiDK8A1CVYcS+BU7KFFFL+M/4yNZDXKObdq1xlA2CqZdOvJ3GkZSDMRxnh
	 qF3jmtoG4k+XTnWZEHHBg01wyNnqNxiiZ7YmTRTNCPxYJf5xMONyjv0I2IZTr68jr8
	 iJc3f1DK9mkluAuo1y9l+pzUpLhin6nAtNafUCeGfKfY5U9SQyof96L2z2WpojK0DG
	 Nk8rFdn22m4uA==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A0D6837809CE;
	Mon, 29 Apr 2024 17:45:00 +0000 (UTC)
Message-ID: <8c39b3c3-8146-4418-8835-6dbfe38a85ec@collabora.com>
Date: Mon, 29 Apr 2024 19:44:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: amphion: Remove lock in s_ctrl callback
To: Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
 hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 ming.qian@oss.nxp.com, imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <20240425065011.105915-3-ming.qian@nxp.com>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20240425065011.105915-3-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ming Qian,

W dniu 25.04.2024 o 08:50, Ming Qian pisze:
> There is no need to add lock in s_ctrl callback, it has been
> synchronized by the ctrl_handler's lock, otherwise it may led to
> deadlock if driver call v4l2_ctrl_s_ctrl().
> 
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>   drivers/media/platform/amphion/vdec.c | 2 --
>   drivers/media/platform/amphion/venc.c | 2 --
>   2 files changed, 4 deletions(-)
> 
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
> index a57f9f4f3b87..6a38a0fa0e2d 100644
> --- a/drivers/media/platform/amphion/vdec.c
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -195,7 +195,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   	struct vdec_t *vdec = inst->priv;
>   	int ret = 0;
>   
> -	vpu_inst_lock(inst);

I assume that PATCH v2 2/3 might cause the said deadlock to happen?
If so, maybe it would make more sense to make the current patch preceed
  PATCH v2 2/3? Otherwise the kernel at PATCH v2 2/3 introduces a potential
deadlock.

Regards,

Andrzej

>   	switch (ctrl->id) {
>   	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
>   		vdec->params.display_delay_enable = ctrl->val;
> @@ -207,7 +206,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   		ret = -EINVAL;
>   		break;
>   	}
> -	vpu_inst_unlock(inst);
>   
>   	return ret;
>   }
> diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
> index cdfaba9d107b..351b4edc8742 100644
> --- a/drivers/media/platform/amphion/venc.c
> +++ b/drivers/media/platform/amphion/venc.c
> @@ -518,7 +518,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   	struct venc_t *venc = inst->priv;
>   	int ret = 0;
>   
> -	vpu_inst_lock(inst);
>   	switch (ctrl->id) {
>   	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>   		venc->params.profile = ctrl->val;
> @@ -579,7 +578,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>   		ret = -EINVAL;
>   		break;
>   	}
> -	vpu_inst_unlock(inst);
>   
>   	return ret;
>   }


