Return-Path: <linux-kernel+bounces-163514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE6D8B6C5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5181F1F221AA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC404502C;
	Tue, 30 Apr 2024 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iL6LMZpP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2684085A;
	Tue, 30 Apr 2024 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464043; cv=none; b=m3ht3kXIiPpFgXrN04DG3G1l0xdtKF95ldjP70HdxOkNGQHP6x/BOKC5PjHYbIYQSh8zY1mphEaLZlOsfgkpLGHhMNPvYqZUltRAb+DjF9b2ZQ8GYSavI4uzIBCbQ+zQQ/WmwoF8CJvwNmptOKbW/wQvRAEbxg4A6HvnCD22fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464043; c=relaxed/simple;
	bh=Sdu/C7hyTUr/WF/VK529ijLrles5NiZWSgYvV8Hn1+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpA6HYxw/e/B1kLy7m0K149SbMzPOE5UDg3NXVU0SvP0Wf0Szi7cYO1UCgUayvVBLMHkSI5Rh1BbLyllmrYtGDCQzELpIYPqkdTuQGSHz1vwVBb7KsAe4jZogQIgyY2SIRjS/UnmvR5uC0NHYNoy61Ktt8T7uLC+hk/CNK5v4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iL6LMZpP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714464040;
	bh=Sdu/C7hyTUr/WF/VK529ijLrles5NiZWSgYvV8Hn1+s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iL6LMZpPcspw/gXwxn6LU00o6c98eIlLAM6zdawslNrS8719ouaDwu6pj2GI5s0PB
	 oUD5MLcvN4n5nlhEsc0qfh0t0tdeu8cwc8rQ1dBpmVUxBDBhYP/uuYvxH0GF4P0zLu
	 I7p03DA/ZSVDtX6UZHKzWVCy9F5rB1iS7+VBbhcOhGzE+vKcNuKG3UojuixEGMJKur
	 RCS5J7K7BDzbjS8KuGSzpzEM0hv6MshUCWrf100SpMr0kx6EgdDkS4trNBMgllhC+B
	 lQvrfThjWnUYeH353fcSx2cBjsWobwDZRcCRs8uzvwn666rSpvQU9DbVmFu9861YqG
	 O4apTxbJX6W6g==
Received: from [100.95.196.182] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: andrzej.p)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CA69D3782039;
	Tue, 30 Apr 2024 08:00:39 +0000 (UTC)
Message-ID: <0c0e2d02-b719-4f8b-afca-c839bb77f287@collabora.com>
Date: Tue, 30 Apr 2024 10:00:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] media: amphion: Remove lock in s_ctrl callback
To: ming qian <ming.qian@oss.nxp.com>, Ming Qian <ming.qian@nxp.com>,
 mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc: shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
 xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
 imx@lists.linux.dev, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240425065011.105915-1-ming.qian@nxp.com>
 <20240425065011.105915-3-ming.qian@nxp.com>
 <8c39b3c3-8146-4418-8835-6dbfe38a85ec@collabora.com>
 <be54f273-7bba-4db0-bc52-5ddbb3982d84@oss.nxp.com>
Content-Language: en-US
From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <be54f273-7bba-4db0-bc52-5ddbb3982d84@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ming,

W dniu 30.04.2024 o 04:32, ming qian pisze:
> Hi Andrzej,
> 
>> Hi Ming Qian,
>>
>> W dniu 25.04.2024 o 08:50, Ming Qian pisze:
>>> There is no need to add lock in s_ctrl callback, it has been
>>> synchronized by the ctrl_handler's lock, otherwise it may led to
>>> deadlock if driver call v4l2_ctrl_s_ctrl().
>>>
>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>> ---
>>>   drivers/media/platform/amphion/vdec.c | 2 --
>>>   drivers/media/platform/amphion/venc.c | 2 --
>>>   2 files changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/amphion/vdec.c 
>>> b/drivers/media/platform/amphion/vdec.c
>>> index a57f9f4f3b87..6a38a0fa0e2d 100644
>>> --- a/drivers/media/platform/amphion/vdec.c
>>> +++ b/drivers/media/platform/amphion/vdec.c
>>> @@ -195,7 +195,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>       struct vdec_t *vdec = inst->priv;
>>>       int ret = 0;
>>> -    vpu_inst_lock(inst);
>>
>> I assume that PATCH v2 2/3 might cause the said deadlock to happen?
>> If so, maybe it would make more sense to make the current patch preceed
>>   PATCH v2 2/3? Otherwise the kernel at PATCH v2 2/3 introduces a potential
>> deadlock.
>>
>> Regards,
>>
>> Andrzej
>>
> 
> I actually discovered this problem when I was preparing the v2 2/3 patch.
> 
> But in the v2 2/3 patch, it tried to add a read-only ctrl, then I just
> unset the s_ctrl callback for the new added ctrl, the potential deadlock
> is caused by call the s_ctrl back in a locked environment, so after unset
> the s_ctrl callback, the 2/3 patch won't trigger the deadlock even if
> this patch is missing.
> 
> In order to avoid encountering similar problems in the future, that
> driver may set or get some ctrl, I added this patch.

Do I understand you correctly that patch 2/3 is written in such a way that
it does not introduce a deadlock, and you add patch 3/3 only to prevent future
problems? If so, it seems to me that patch 3/3 could/should be separate from
this series, as it does not quite match "Add average qp control".

Regards,

Andrzej

> 
> Best regards,
> Ming
> 
>>>       switch (ctrl->id) {
>>>       case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
>>>           vdec->params.display_delay_enable = ctrl->val;
>>> @@ -207,7 +206,6 @@ static int vdec_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>           ret = -EINVAL;
>>>           break;
>>>       }
>>> -    vpu_inst_unlock(inst);
>>>       return ret;
>>>   }
>>> diff --git a/drivers/media/platform/amphion/venc.c 
>>> b/drivers/media/platform/amphion/venc.c
>>> index cdfaba9d107b..351b4edc8742 100644
>>> --- a/drivers/media/platform/amphion/venc.c
>>> +++ b/drivers/media/platform/amphion/venc.c
>>> @@ -518,7 +518,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>       struct venc_t *venc = inst->priv;
>>>       int ret = 0;
>>> -    vpu_inst_lock(inst);
>>>       switch (ctrl->id) {
>>>       case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
>>>           venc->params.profile = ctrl->val;
>>> @@ -579,7 +578,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
>>>           ret = -EINVAL;
>>>           break;
>>>       }
>>> -    vpu_inst_unlock(inst);
>>>       return ret;
>>>   }
>>


