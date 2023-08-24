Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AC47877DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbjHXSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243055AbjHXSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:31:26 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E4019A3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:31:23 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99cce6f7de2so7111766b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692901882; x=1693506682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHxjDQLOCthdb2vOB7myfGcdjPbgOV2WfFp3TGN+WRY=;
        b=eukiwibifUULqvd6CYIXEMoWahdTVNG8+hR53B2q+GN9Wjkh3B4r2P8jpG7SVtngc8
         7wTAOPTLzaIjhycCyWpysLbIIVyWsCU6HqsA/Arenb6DpRxRkN+nwcmN1wN7lUkPOBWa
         Bio15T2OJtH3MxVHeQlDE7kzHd8gK2UvyC2dK7lOvRfHgXgZToZrzehK08iR1Sz8Fe6v
         y+AVsMgZU1TevqO48P4zdr/k7Tm50F/E7RRlM6Liho633R+oyrt6l3n9fxpbocNEjyaA
         woaIBtBuzx/CARD5clTn3wV4rrLzGsRnyvCajWctpHEZH3y7eOypZNHWyhSdzu5XACin
         57xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901882; x=1693506682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHxjDQLOCthdb2vOB7myfGcdjPbgOV2WfFp3TGN+WRY=;
        b=kKI83FHEPdW33THu1vxX9dcep5e+KR2BqRBkI92V7Vh27t4xj/9GMAsnle+xGI3zza
         KVQiyXaVDh47sXJNgCBXl86R1ezGDxsxyUP6/v9gAvijFvleINnh8mebuMXtbSdy4vdi
         aUC3YQhqANaGmkuUMRYLbVSxeYx3hNTCpygSs31ZWWXi5q1WWvuYC9mqSCPoHUvk+Mqr
         DLQ7sR6OGgHpetv38YbsCzI9R9H7O9EE6navBOglqmdK2ySz4j7oNFguRcHr8IjFN16m
         tDHQG/A12pcc4/ZlZ/LQr3fh9YNM563v07E+qTGOoqaYTJgo219V3iZJLqUyRpmoqIFB
         o7MA==
X-Gm-Message-State: AOJu0YywMj0iWKCYyxpo5RxkzSdFtxeDLOc0ZCp10mpTVCPxTuJCNRrN
        9c1aj+aWv/q/z7ryd3JuvNsxkg==
X-Google-Smtp-Source: AGHT+IGn208X6QNPLbSZpc2ImkY97zpO5rszn47C/A/fDWfJ/UmfcWRTAqF4k7WU8Fz15ks1vqd2Hw==
X-Received: by 2002:a17:906:5304:b0:99e:8a1:9df7 with SMTP id h4-20020a170906530400b0099e08a19df7mr12174136ejo.74.1692901882266;
        Thu, 24 Aug 2023 11:31:22 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id e16-20020a170906045000b00992b510089asm11263356eja.84.2023.08.24.11.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:31:21 -0700 (PDT)
Message-ID: <2356672b-8f9c-d33f-dcbc-7940b3b36bcc@linaro.org>
Date:   Thu, 24 Aug 2023 20:31:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 06/11] firmware: imx: add driver for NXP EdgeLock
 Enclave
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     kernel test robot <lkp@intel.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-7-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823073330.1712721-7-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 09:33, Pankaj Gupta wrote:
> The Edgelock Enclave , is the secure enclave embedded in the SoC
> to support the features like HSM, SHE & V2X, using message based
> communication channel.
> 
> ELE FW communicates on a dedicated MU with application core where
> kernel is running. It exists on specific i.MX processors. e.g.
> i.MX8ULP, i.MX93.
> 
> Reported-by: kernel test robot <lkp@intel.com>

Wrong tag. Bot did not report this driver.

> Closes:https://lore.kernel.org/oe-kbuild-all/202304120902.bP52A56z-lkp@intel.com

Drop.

> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---

...

> +
> +static int se_fw_probe(struct platform_device *pdev)
> +{
> +	struct ele_mu_device_ctx *dev_ctx;
> +	struct device *dev = &pdev->dev;
> +	struct ele_mu_priv *priv;
> +	const struct of_device_id *of_id = of_match_device(se_fw_match, dev);
> +	struct imx_info *info = NULL;
> +	char *devname;
> +	int ret;
> +	int i;
> +	struct device_node *np;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private data\n");
> +		return ret;

No, really, I asked to clean this driver from such crap. It is crap
because automated tools point it. It's a requirement to run them, which
you did not.

You must run coccicheck, smatch, sparse, W=1 builds and several build
tests. All of them must pass without single warning.


> +	}
> +	memset(priv, 0x0, sizeof(*priv));
> +	priv->dev = dev;
> +	dev_set_drvdata(dev, priv);
> +
> +	/*
> +	 * Get the address of MU.
> +	 */
> +	np = pdev->dev.of_node;
> +	if (!np) {
> +		dev_err(dev, "Cannot find MU User entry in device tree\n");
> +		ret = -EOPNOTSUPP;
> +		goto exit;
> +	}
> +
> +	/* Initialize the mutex. */
> +	mutex_init(&priv->mu_cmd_lock);
> +	mutex_init(&priv->mu_lock);
> +
> +	priv->cmd_receiver_dev = NULL;
> +	priv->waiting_rsp_dev = NULL;
> +
> +	/* Mailbox client configuration */
> +	priv->ele_mb_cl.dev		= dev;
> +	priv->ele_mb_cl.tx_block	= false;
> +	priv->ele_mb_cl.knows_txdone	= true;
> +	priv->ele_mb_cl.rx_callback	= ele_mu_rx_callback;
> +
> +	ret = ele_mu_request_channel(dev, &priv->tx_chan,
> +				     &priv->ele_mb_cl, "tx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request tx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret = ele_mu_request_channel(dev, &priv->rx_chan,
> +				     &priv->ele_mb_cl, "rx");
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to request rx channel\n");
> +
> +		goto exit;
> +	}
> +
> +	ret = of_property_read_u32(np, "fsl,mu-id", &priv->ele_mu_id);
> +	if (ret) {
> +		ret = -EINVAL;
> +		dev_err(dev, "Not able to read mu-id.\n");
> +		goto exit;
> +	}
> +
> +	info = (struct imx_info *)of_id->data;
> +	priv->ele_mu_did = info->mu_did;
> +	priv->max_dev_ctx = info->max_dev_ctx;
> +	priv->cmd_tag = info->cmd_tag;
> +	priv->rsp_tag = info->rsp_tag;
> +	priv->success_tag = info->success_tag;
> +
> +	priv->ctxs = devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_ctx,
> +				  GFP_KERNEL);
> +
> +	if (!priv->ctxs) {
> +		ret = -ENOMEM;
> +		dev_err(dev, "Fail allocate mem for private dev-ctxs.\n");
> +		goto exit;
> +	}
> +
> +	/* Create users */
> +	for (i = 0; i < priv->max_dev_ctx; i++) {
> +		dev_ctx = devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNEL);
> +		if (!dev_ctx) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for device context\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->dev = dev;
> +		dev_ctx->status = MU_FREE;
> +		dev_ctx->priv = priv;
> +
> +		priv->ctxs[i] = dev_ctx;
> +
> +		/* Default value invalid for an header. */
> +		init_waitqueue_head(&dev_ctx->wq);
> +
> +		INIT_LIST_HEAD(&dev_ctx->pending_out);
> +		INIT_LIST_HEAD(&dev_ctx->pending_in);
> +		sema_init(&dev_ctx->fops_lock, 1);
> +
> +		devname = devm_kasprintf(dev, GFP_KERNEL, "%s_mu%d_ch%d",
> +					 info->se_name,
> +					 priv->ele_mu_id, i);
> +		if (!devname) {
> +			ret = -ENOMEM;
> +			dev_err(dev,
> +				"Fail to allocate memory for misc dev name\n");
> +			goto exit;
> +		}
> +
> +		dev_ctx->miscdev.name = devname;
> +		dev_ctx->miscdev.minor = MISC_DYNAMIC_MINOR;
> +		dev_ctx->miscdev.fops = &ele_mu_fops;
> +		dev_ctx->miscdev.parent = dev;
> +		ret = misc_register(&dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev, "failed to register misc device %d\n",
> +				ret);
> +			goto exit;
> +		}
> +
> +		ret = devm_add_action(dev, if_misc_deregister,
> +				      &dev_ctx->miscdev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to add action to the misc-dev\n",
> +				ret);
> +			goto exit;
> +		}
> +	}
> +
> +	init_completion(&priv->done);
> +	spin_lock_init(&priv->lock);
> +
> +	list_add_tail(&priv->priv_data, &priv_data_list);
> +	dev_set_drvdata(dev, priv);
> +
> +	if (info->reserved_dma_ranges) {
> +		ret = of_reserved_mem_device_init(dev);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed to init reserved memory region %d\n",
> +				ret);
> +			priv->flags &= (~RESERVED_DMA_POOL);
> +			goto exit;
> +		}
> +		priv->flags |= RESERVED_DMA_POOL;
> +	}
> +
> +	if (info->socdev) {
> +		ret = imx_soc_device_register(dev, info);
> +		if (ret) {
> +			dev_err(dev,
> +				"failed[%d] to register SoC device\n", ret);
> +			goto exit;
> +		}
> +	}
> +
> +	pr_info("i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",

dev_info

> +		info->se_name,
> +		priv->ele_mu_id);
> +	return devm_of_platform_populate(dev);
> +
> +exit:
> +	/* if execution control reaches here, ele-mu probe fail.
> +	 * hence doing the cleanup
> +	 */
> +	return se_probe_cleanup(pdev);
> +}
> +
> +struct device *get_se_dev(uint32_t mu_id)
> +{
> +	struct ele_mu_priv *priv;
> +
> +	list_for_each_entry(priv, &priv_data_list, priv_data) {
> +		if (priv->ele_mu_id == mu_id)
> +			return priv->dev;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(get_se_dev);

Uhu, that's GPL. Anyway, this needs to be documented.

> +
> +static int se_fw_remove(struct platform_device *pdev)
> +{
> +	se_probe_cleanup(pdev);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int se_fw_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int se_fw_resume(struct device *dev)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < priv->max_dev_ctx; i++)
> +		wake_up_interruptible(&priv->ctxs[i]->wq);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops se_fw_pm = {
> +	SET_SYSTEM_SLEEP_PM_OPS(se_fw_suspend, se_fw_resume)
> +};
> +
> +static struct platform_driver se_fw_driver = {
> +	.driver = {
> +		.name = "fsl-se-fw",
> +		.of_match_table = se_fw_match,
> +		.pm = &se_fw_pm,
> +	},
> +	.probe = se_fw_probe,
> +	.remove = se_fw_remove,
> +};
> +MODULE_DEVICE_TABLE(of, se_fw_match);
> +
> +module_platform_driver(se_fw_driver);
> +
> +MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
> +MODULE_DESCRIPTION("iMX Secure Enclave FW Driver.");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/firmware/imx/se_fw.h b/drivers/firmware/imx/se_fw.h
> new file mode 100644
> index 000000000000..b3502affbc85
> --- /dev/null
> +++ b/drivers/firmware/imx/se_fw.h
> @@ -0,0 +1,168 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2021-2023 NXP
> + */
> +
> +#ifndef SE_MU_H
> +#define SE_MU_H
> +
> +#include <linux/miscdevice.h>
> +#include <linux/semaphore.h>
> +#include <linux/mailbox_client.h>
> +
> +/* macro to log operation of a misc device */
> +#define miscdev_dbg(p_miscdev, fmt, va_args...)                                \

No, drop.  Don't create your own abstraction layers over common Linux code.

> +	({                                                                     \
> +		struct miscdevice *_p_miscdev = p_miscdev;                     \
> +		dev_dbg((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
> +		##va_args);                                                    \
> +	})
> +
> +#define miscdev_info(p_miscdev, fmt, va_args...)                               \

No, drop.

> +	({                                                                     \
> +		struct miscdevice *_p_miscdev = p_miscdev;                     \
> +		dev_info((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name, \
> +		##va_args);                                                    \
> +	})
> +
> +#define miscdev_err(p_miscdev, fmt, va_args...)                                \

No, drop.

> +	({                                                                     \
> +		struct miscdevice *_p_miscdev = p_miscdev;                     \
> +		dev_err((_p_miscdev)->parent, "%s: " fmt, (_p_miscdev)->name,  \
> +		##va_args);                                                    \
> +	})
> +/* macro to log operation of a device context */
> +#define devctx_dbg(p_devctx, fmt, va_args...) \
> +	miscdev_dbg(&((p_devctx)->miscdev), fmt, ##va_args)
> +#define devctx_info(p_devctx, fmt, va_args...) \
> +	miscdev_info(&((p_devctx)->miscdev), fmt, ##va_args)
> +#define devctx_err(p_devctx, fmt, va_args...) \
> +	miscdev_err((&(p_devctx)->miscdev), fmt, ##va_args)

No, drop all these.

> +
> +#define MAX_MESSAGE_SIZE		31
> +#define MAX_RECV_SIZE			MAX_MESSAGE_SIZE
> +#define MAX_RECV_SIZE_BYTES		(MAX_RECV_SIZE << 2)
> +#define MAX_MESSAGE_SIZE_BYTES		(MAX_MESSAGE_SIZE << 2)
> +
> +#define ELE_MSG_DATA_NUM		10
> +
> +#define MSG_TAG(x)			(((x) & 0xff000000) >> 24)
> +#define MSG_COMMAND(x)			(((x) & 0x00ff0000) >> 16)
> +#define MSG_SIZE(x)			(((x) & 0x0000ff00) >> 8)
> +#define MSG_VER(x)			((x) & 0x000000ff)
> +#define RES_STATUS(x)			((x) & 0x000000ff)
> +#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
> +#define S4_DEFAULT_MUAP_INDEX		(2)
> +#define S4_MUAP_DEFAULT_MAX_USERS	(4)
> +
> +#define DEFAULT_MESSAGING_TAG_COMMAND           (0x17u)
> +#define DEFAULT_MESSAGING_TAG_RESPONSE          (0xe1u)
> +
> +#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +
> +struct ele_imem_buf {
> +	u8 *buf;
> +	phys_addr_t phyaddr;
> +	u32 size;
> +};
> +
> +struct ele_buf_desc {
> +	u8 *shared_buf_ptr;
> +	u8 *usr_buf_ptr;
> +	u32 size;
> +	struct list_head link;
> +};
> +
> +/* Status of a char device */
> +enum mu_device_status_t {
> +	MU_FREE,
> +	MU_OPENED
> +};
> +
> +struct ele_shared_mem {
> +	dma_addr_t dma_addr;
> +	u32 size;
> +	u32 pos;
> +	u8 *ptr;
> +};
> +
> +/* Private struct for each char device instance. */
> +struct ele_mu_device_ctx {
> +	struct device *dev;
> +	struct ele_mu_priv *priv;
> +	struct miscdevice miscdev;
> +
> +	enum mu_device_status_t status;
> +	wait_queue_head_t wq;
> +	struct semaphore fops_lock;
> +
> +	u32 pending_hdr;
> +	struct list_head pending_in;
> +	struct list_head pending_out;
> +
> +	struct ele_shared_mem secure_mem;
> +	struct ele_shared_mem non_secure_mem;
> +
> +	u32 temp_cmd[MAX_MESSAGE_SIZE];
> +	u32 temp_resp[MAX_RECV_SIZE];
> +	u32 temp_resp_size;
> +	struct notifier_block ele_notify;
> +};
> +
> +/* Header of the messages exchange with the EdgeLock Enclave */
> +struct mu_hdr {
> +	u8 ver;
> +	u8 size;
> +	u8 command;
> +	u8 tag;
> +}  __packed;
> +
> +#define ELE_MU_HDR_SZ	4
> +#define TAG_OFFSET	(ELE_MU_HDR_SZ - 1)
> +#define CMD_OFFSET	(ELE_MU_HDR_SZ - 2)
> +#define SZ_OFFSET	(ELE_MU_HDR_SZ - 3)
> +#define VER_OFFSET	(ELE_MU_HDR_SZ - 4)
> +
> +struct ele_api_msg {
> +	u32 header; /* u8 Tag; u8 Command; u8 Size; u8 Ver; */
> +	u32 data[ELE_MSG_DATA_NUM];
> +};
> +
> +struct ele_mu_priv {
> +	struct list_head priv_data;
> +	struct ele_mu_device_ctx *cmd_receiver_dev;
> +	struct ele_mu_device_ctx *waiting_rsp_dev;
> +	/*
> +	 * prevent parallel access to the MU registers
> +	 * e.g. a user trying to send a command while the other one is
> +	 * sending a response.
> +	 */
> +	struct mutex mu_lock;
> +	/*
> +	 * prevent a command to be sent on the MU while another one is still
> +	 * processing. (response to a command is allowed)
> +	 */
> +	struct mutex mu_cmd_lock;
> +	struct device *dev;
> +	u8 ele_mu_did;
> +	u32 ele_mu_id;
> +	u8 cmd_tag;
> +	u8 rsp_tag;
> +	u8 success_tag;
> +
> +	struct mbox_client ele_mb_cl;
> +	struct mbox_chan *tx_chan, *rx_chan;
> +	struct ele_api_msg tx_msg, rx_msg;
> +	struct completion done;
> +	spinlock_t lock;
> +	/* Flag to retain the state of initialization done at
> +	 * the time of ele-mu probe.
> +	 */
> +	uint32_t flags;
> +	u8 max_dev_ctx;
> +	struct ele_mu_device_ctx **ctxs;
> +	struct ele_imem_buf imem;
> +};
> +
> +#endif
> diff --git a/include/linux/firmware/imx/ele_base_msg.h b/include/linux/firmware/imx/ele_base_msg.h
> new file mode 100644
> index 000000000000..9c05936ba813
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_base_msg.h
> @@ -0,0 +1,37 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2021-2023 NXP
> + *
> + * Header file for the ELE Base API(s).
> + */
> +
> +#ifndef ELE_BASE_MSG_H
> +#define ELE_BASE_MSG_H
> +
> +#include <linux/types.h>
> +
> +#define WORD_SZ				4
> +#define MESSAGING_VERSION_7		0x7
> +#define ELE_NONE_VAL			0x0
> +
> +#define ELE_GET_INFO_BUFF_SZ		0x100
> +#define ELE_GET_INFO_READ_SZ		0xA0
> +#define DEVICE_GET_INFO_SZ		0x100
> +
> +#define GET_INFO_SOC_INFO_WORD_OFFSET	1
> +#define GET_INFO_UUID_WORD_OFFSET	3
> +#define GET_INFO_SL_NUM_MSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 3)
> +#define GET_INFO_SL_NUM_LSB_WORD_OFF \
> +	(GET_INFO_UUID_WORD_OFFSET + 0)
> +
> +#define ELE_GET_INFO_REQ                0xDA
> +#define ELE_GET_INFO_REQ_MSG_SZ		0x02
> +
> +#define ELE_BASE_API_VERSION		0x6
> +#define ELE_SUCCESS_IND			0xD6
> +#define ELE_FAILURE_IND			0x29
> +
> +int ele_get_info(struct device *dev, phys_addr_t addr, u32 data_size);
> +
> +#endif
> diff --git a/include/linux/firmware/imx/ele_mu_ioctl.h b/include/linux/firmware/imx/ele_mu_ioctl.h
> new file mode 100644
> index 000000000000..b0f00acddecc
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_mu_ioctl.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
> +/*
> + * Copyright 2019-2023 NXP
> + */
> +
> +#ifndef ELE_MU_IOCTL_H
> +#define ELE_MU_IOCTL_H
> +
> +/* IOCTL definitions. */
> +
> +struct ele_mu_ioctl_setup_iobuf {
> +	u8 *user_buf;
> +	u32 length;
> +	u32 flags;
> +	u64 ele_addr;
> +};
> +
> +struct ele_mu_ioctl_shared_mem_cfg {
> +	u32 base_offset;
> +	u32 size;
> +};
> +
> +struct ele_mu_ioctl_get_mu_info {
> +	u8 ele_mu_id;
> +	u8 interrupt_idx;
> +	u8 tz;
> +	u8 did;
> +};
> +
> +struct ele_mu_ioctl_signed_message {
> +	u8 *message;
> +	u32 msg_size;
> +	u32 error_code;
> +};
> +
> +#define ELE_MU_IO_FLAGS_IS_OUTPUT	(0x00u)
> +#define ELE_MU_IO_FLAGS_IS_INPUT	(0x01u)
> +#define ELE_MU_IO_FLAGS_USE_SEC_MEM	(0x02u)
> +#define ELE_MU_IO_FLAGS_USE_SHORT_ADDR	(0x04u)
> +#define ELE_MU_IO_FLAGS_IS_IN_OUT	(0x08u)
> +
> +#define ELE_MU_IOCTL			0x0A /* like MISC_MAJOR. */
> +#define ELE_MU_IOCTL_ENABLE_CMD_RCV	_IO(ELE_MU_IOCTL, 0x01)
> +#define ELE_MU_IOCTL_SHARED_BUF_CFG	_IOW(ELE_MU_IOCTL, 0x02, \
> +					struct ele_mu_ioctl_shared_mem_cfg)
> +#define ELE_MU_IOCTL_SETUP_IOBUF	_IOWR(ELE_MU_IOCTL, 0x03, \
> +					struct ele_mu_ioctl_setup_iobuf)
> +#define ELE_MU_IOCTL_GET_MU_INFO	_IOR(ELE_MU_IOCTL, 0x04, \
> +					struct ele_mu_ioctl_get_mu_info)
> +#define ELE_MU_IOCTL_SIGNED_MESSAGE	_IOWR(ELE_MU_IOCTL, 0x05, \

No documentation.

Plus you just created some completely vendor-specific interface for the
firmware. I don't think this is suitable for upstream. Find respective
existing interface and use it.

Your Cc list is absolutely huge, but these are NXP people, not community
folks. Please reverse it and include instead other maintainers, not 10
NXP people.

I'll be NAKing for these reasons till you fix it.

Best regards,
Krzysztof

