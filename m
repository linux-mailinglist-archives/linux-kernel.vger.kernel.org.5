Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004B17A328E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 22:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbjIPU4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjIPUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 16:55:57 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71741194;
        Sat, 16 Sep 2023 13:55:51 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bffa8578feso4375121fa.2;
        Sat, 16 Sep 2023 13:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694897749; x=1695502549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtXy98myC9Xeki202X9z45U3TYQHZBLtWJzwGTAcxHE=;
        b=lqaMUcTF/w2pd8V7QfC5ZyBCt2sokvGp4sOH9SFAW+nlrw1H1tvWa+Kr3z7C8vrOv1
         MnImkk8Stx+dBh16eBRlwerZJsoeyBwaGeF/hxaZotO6Jn2Djs2cRdW3lXnuDLSbTWK3
         /KJeuQHT/n317fdWWZrs4ex6fvBiemMgIulaEOcJG9RV2LWkPCjdEtyvEiTO6Hs0/Drf
         bELoY5ha5Xj2w/29/pFxCkZaLZMk3HkBXH9gonkISdtKhwAA/Xj05i5ZzxmB36zoDO+E
         Q1nS0Wz87fzTSQjOw1u5PBxSaxECseoWiC85qN2VnDkNShtB4l2PENm2+bVjxIpQfQFz
         NXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694897749; x=1695502549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtXy98myC9Xeki202X9z45U3TYQHZBLtWJzwGTAcxHE=;
        b=mLNr39E4ssQOCnL+V0J9AaeM+m+96kuEIdHC5aS2H82IuVVaUhxFSeL48D1EiGWzNT
         C74qz07Ofyz0VlSaMfDdAgGJjBSOji/MqE+Pz+nMUpzJps6oYRDQ7Q672xahMh6OK7sL
         kxZPa31B7+4EFtPV97KbuInXq+AWpTESecqMHkeLJo221IBKpB+zV9zsUgeYFWAEMAh3
         QRlqhAwnl7+xofUhkURHeZ2ZaIIQJ7lJb2cEWtl69m7IHim9lBwX6u9p8T6ArU79A0W1
         wo8ObbUosPrQsNF8Sl2QgV7LAnP47VRfX+EqlLdQc1zg996I7YX7DnwvKZkDLxVQ1Kgi
         d36A==
X-Gm-Message-State: AOJu0YyeZqXQWGJklCUUuXUTXUKy0KCu0RnbyW473nlFMYDLXzrFPUBQ
        4Y089Xdhx6EU/gS7CVCQJmc=
X-Google-Smtp-Source: AGHT+IHLF2BDHMY5EQ2cLRGY88cc4GRtF1HNeGRvKmupJtgipgh1Tp2VYUmzRaB1Rid1OduuxyxRJA==
X-Received: by 2002:a05:6512:2fc:b0:4f8:77db:1d9e with SMTP id m28-20020a05651202fc00b004f877db1d9emr4255346lfq.12.1694897749352;
        Sat, 16 Sep 2023 13:55:49 -0700 (PDT)
Received: from localhost.localdomain ([78.37.168.140])
        by smtp.gmail.com with ESMTPSA id br19-20020a056512401300b00502fd9110ffsm454504lfb.294.2023.09.16.13.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 13:55:48 -0700 (PDT)
From:   Ivan Bornyakov <brnkv.i1@gmail.com>
To:     sebastian.fricke@collabora.com
Cc:     Ivan Bornyakov <brnkv.i1@gmail.com>, bob.beckett@collabora.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        festevam@gmail.com, hverkuil@xs4all.nl,
        jackson.lee@chipsnmedia.com, kernel@collabora.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, nas.chung@chipsnmedia.com,
        nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v12 5/7] media: chips-media: wave5: Add the v4l2 layer
Date:   Sat, 16 Sep 2023 23:55:40 +0300
Message-ID: <20230916205542.9410-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230915-wave5_v12_on_media_master-v12-5-92fc66cd685d@collabora.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sebastian,

On Fri, Sep 15, 2023 at 23:11:34 +0200, Sebastian Fricke wrote:
> From: Nas Chung <nas.chung@chipsnmedia.com>
> 
> Add the decoder and encoder implementing the v4l2
> API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> 
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

[...]

> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> new file mode 100644
> index 000000000000..a13d968f5d04
> --- /dev/null
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c

[...]

> +static void wave5_vpu_get_interrupt_for_inst(struct vpu_instance *inst, u32 status)
> +{
> +	struct vpu_device *dev = inst->dev;
> +	u32 seq_done;
> +	u32 cmd_done;
> +	int val;
> +
> +	seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
> +	cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
> +
> +	if (status & BIT(INT_WAVE5_INIT_SEQ)) {
> +		if (seq_done & BIT(inst->id)) {
> +			seq_done &= ~BIT(inst->id);
> +			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_done);
> +			val = BIT(INT_WAVE5_INIT_SEQ);
> +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> +		}
> +	}
> +	if (status & BIT(INT_WAVE5_ENC_SET_PARAM)) {
> +		if (seq_done & BIT(inst->id)) {
> +			seq_done &= ~BIT(inst->id);
> +			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_done);
> +			val = BIT(INT_WAVE5_ENC_SET_PARAM);
> +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> +		}
> +	}
> +	if (status & BIT(INT_WAVE5_DEC_PIC) ||
> +	    status & BIT(INT_WAVE5_ENC_PIC)) {
> +		if (cmd_done & BIT(inst->id)) {
> +			cmd_done &= ~BIT(inst->id);
> +			wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST, cmd_done);
> +			val = BIT(INT_WAVE5_DEC_PIC);
> +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> +		}
> +	}
> +}
> +
> +static irqreturn_t wave5_vpu_irq(int irq, void *dev_id)
> +{
> +	struct vpu_device *dev = dev_id;
> +
> +	if (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
> +		struct vpu_instance *inst;
> +		u32 irq_status = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
> +
> +		list_for_each_entry(inst, &dev->instances, list) {
> +			wave5_vpu_get_interrupt_for_inst(inst, irq_status);
> +		}
> +
> +		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_status);
> +		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
> +
> +		return IRQ_WAKE_THREAD;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
> +{
> +	struct vpu_device *dev = dev_id;
> +	struct vpu_instance *inst;
> +	int irq_status, ret;
> +
> +	list_for_each_entry(inst, &dev->instances, list) {
> +		while (kfifo_len(&inst->irq_status)) {
> +			ret = kfifo_out(&inst->irq_status, &irq_status, sizeof(int));
> +			if (!ret)
> +				break;
> +
> +			if (irq_status == BIT(INT_WAVE5_INIT_SEQ) ||
> +			    irq_status == BIT(INT_WAVE5_ENC_SET_PARAM))
> +				complete(&inst->irq_done);
> +			else /* DEC/ENC_PIC */
> +				inst->ops->finish_process(inst);
> +
> +			wave5_vpu_clear_interrupt(inst, irq_status);
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}

I believe, instead of
wave5_vpu_irq() + wave5_vpu_get_interrupt_for_inst() + wave5_vpu_irq_thread()
you can reduce interrupt handling to only threaded part with something like this:

static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
{
	u32 irq_status, seq_done, cmd_done;
	struct vpu_device *dev = dev_id;
	struct vpu_instance *inst;

	while (wave5_vdi_read_register(dev, W5_VPU_VPU_INT_STS)) {
		irq_status = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
		seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
		cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);

		list_for_each_entry(inst, &dev->instances, list) {
			if (irq_status & BIT(INT_WAVE5_INIT_SEQ) ||
			    irq_status & BIT(INT_WAVE5_ENC_SET_PARAM)) {
				if (seq_done & BIT(inst->id)) {
					seq_done &= ~BIT(inst->id);
					wave5_vdi_write_register(dev,
								 W5_RET_SEQ_DONE_INSTANCE_INFO,
								 seq_done);
					complete(&inst->irq_done);
				}
			}

			if (status & BIT(INT_WAVE5_DEC_PIC) ||
			    status & BIT(INT_WAVE5_ENC_PIC)) {
				if (cmd_done & BIT(inst->id)) {
					cmd_done &= ~BIT(inst->id);
					wave5_vdi_write_register(dev,
								 W5_RET_QUEUE_CMD_DONE_INST,
								 cmd_done);
					inst->ops->finish_process(inst);
				}
			}

			wave5_vpu_clear_interrupt(inst, irq_status);
		}
			
		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_status);
		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
	}

	return IRQ_HANDLED;
}

Is it better?

[...]

> +static int wave5_vpu_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct vpu_device *dev;
> +	const struct wave5_match_data *match_data;
> +	u32 fw_revision;
> +
> +	match_data = device_get_match_data(&pdev->dev);
> +	if (!match_data) {
> +		dev_err(&pdev->dev, "missing device match data\n");
> +		return -EINVAL;
> +	}
> +
> +	/* physical addresses limited to 32 bits */
> +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));

dma_set_mask_and_coherent()? Also error check?

