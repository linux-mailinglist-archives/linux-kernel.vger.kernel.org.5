Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B97D248C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjJVQ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 12:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjJVQ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 12:28:04 -0400
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45BFB
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 09:28:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ubIvqzpaN1gtMubIvqacuc; Sun, 22 Oct 2023 18:27:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697992079;
        bh=INIIQaK5X3fnI0W54Dh7daNnY2U6zqvjTPzA48XdS3U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=k3rhCkHSS4P2p8LFRggKoz/tyuAJkojsl/19c2MH44v/hcbQtSK4umtesyAzbrIhy
         PHTKJKv18seaEU11ZZecTK+RFeWXK3me6n1qDFyBUUy4qXHpEQXw1ryoFvxItmfYFj
         orJDoKTHU0t/8s6c7N0Ek/3sAv8xiP8pXPmhN/XeMYSvTwMHGULAYNO4vvKGTX4800
         2mD3K7Tv+golLqpnDaeAAiU5yg6NvmsFCKF+0KXdR2AkvOMaYN6lczwIPDEsEEtRGV
         74bsZJoRGXr+zHeRPxDv7r80B54FGZSaSbXUipvIth5tiRfK0FCj6Cn0/CPl1Oxmpk
         oxLw0/8Z7XRJg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Oct 2023 18:27:59 +0200
X-ME-IP: 86.243.2.178
Message-ID: <a836dc4d-99e3-494d-b374-594f53287bae@wanadoo.fr>
Date:   Sun, 22 Oct 2023 18:27:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/8] media: chips-media: wave5: Add vpuapi layer
Content-Language: fr
To:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Darren Etheridge <detheridge@ti.com>
References: <20230929-wave5_v13_media_master-v13-0-5ac60ccbf2ce@collabora.com>
 <20230929-wave5_v13_media_master-v13-4-5ac60ccbf2ce@collabora.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230929-wave5_v13_media_master-v13-4-5ac60ccbf2ce@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 12/10/2023 à 13:01, Sebastian Fricke a écrit :
> From: Nas Chung <nas.chung@chipsnmedia.com>
> 
> Add the vpuapi layer of the wave5 codec driver.
> This layer is used to configure the hardware according
> to the parameters.
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---

...

> +int wave5_vpu_dec_clr_disp_flag(struct vpu_instance *inst, int index)
> +{
> +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> +	int ret = 0;

Nit: No need to init.

> +	struct vpu_device *vpu_dev = inst->dev;
> +
> +	if (index >= p_dec_info->num_of_display_fbs)
> +		return -EINVAL;
> +
> +	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
> +	if (ret)
> +		return ret;
> +	ret = wave5_dec_clr_disp_flag(inst, index);
> +	mutex_unlock(&vpu_dev->hw_lock);
> +
> +	return ret;
> +}

...

> +int wave5_vpu_dec_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter)
> +{
> +	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
> +	int ret = 0;
> +
> +	switch (cmd) {
> +	case DEC_GET_QUEUE_STATUS: {
> +		struct queue_status_info *queue_info = parameter;
> +
> +		queue_info->instance_queue_count = p_dec_info->instance_queue_count;
> +		queue_info->report_queue_count = p_dec_info->report_queue_count;
> +		break;
> +	}
> +	case DEC_RESET_FRAMEBUF_INFO: {
> +		int i;
> +
> +		for (i = 0; i < MAX_REG_FRAME; i++) {
> +			ret = wave5_vpu_dec_reset_framebuffer(inst, i);
> +			if (ret)
> +				break;
> +		}
> +
> +		for (i = 0; i < MAX_REG_FRAME; i++) {
> +			ret = reset_auxiliary_buffers(inst, i);
> +			if (ret)
> +				break;
> +		}
> +
> +		wave5_vdi_free_dma_memory(inst->dev, &p_dec_info->vb_task);
> +		break;
> +	}
> +	case DEC_GET_SEQ_INFO: {
> +		struct dec_initial_info *seq_info = parameter;
> +
> +		*seq_info = p_dec_info->initial_info;
> +		break;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

return ret;
?

CJ

> +}

...

