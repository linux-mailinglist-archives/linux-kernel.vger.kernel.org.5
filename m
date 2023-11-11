Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B277E89C6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 09:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjKKIQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 03:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjKKIQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 03:16:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363F3C25
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 00:16:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A37C433C8;
        Sat, 11 Nov 2023 08:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699690594;
        bh=CfBn0ztwBcbAQ+Aptc89/YJJxdrHTqXSPn8w7Fsv678=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=BjaNatcW2RPEQ+GVpd14LiyS5SMDN0geyfUrcLXy7MKzGTni/7xjM91PXkUci9+L1
         BqmOzzrU53xt4scjZ8+LEaZRyItjTnp4hQKJtIADuv5PbUznepUN4TtLRVPc1cdg88
         FgZfIgmS78NS3R6SqgYj5LfaBw/iAshm85YrtR1allkESxd7cIeGbaiImAVRy5WMU1
         dG4QjhUVBSTiJMzpr5qhzam0mO/mk011tlbBTD0TPQR39vPMbqr2lWYRVyZhWXDg3S
         IskPEYD3daON9ay0mjYUEdSxJZyvGaYHabaxDevrcmsWaO2U7j2zgigJL8qhNyy3vi
         VzIDoWvNZKleA==
Message-ID: <70821f4c-d0f8-4a35-b664-0823bf430816@kernel.org>
Date:   Sat, 11 Nov 2023 09:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/15] media: imx-asrc: Add memory to memory driver
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, hverkuil@xs4all.nl,
        sakari.ailus@iki.fi, tfiga@chromium.org, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
References: <1699595289-25773-1-git-send-email-shengjiu.wang@nxp.com>
 <1699595289-25773-15-git-send-email-shengjiu.wang@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <1699595289-25773-15-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 06:48, Shengjiu Wang wrote:
> +static int asrc_m2m_probe(struct platform_device *pdev)
> +{
> +	struct fsl_asrc_m2m_pdata *data = pdev->dev.platform_data;
> +	struct device *dev = &pdev->dev;
> +	struct asrc_m2m *m2m;
> +	int ret;
> +
> +	m2m = devm_kzalloc(dev, sizeof(struct asrc_m2m), GFP_KERNEL);

sizeof(*)

> +	if (!m2m)
> +		return -ENOMEM;
> +
> +	m2m->pdata = *data;
> +	m2m->pdev = pdev;
> +
> +	ret = v4l2_device_register(dev, &m2m->v4l2_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register v4l2 device\n");
> +		goto err_register;
> +	}
> +
> +	m2m->m2m_dev = v4l2_m2m_init(&asrc_m2m_ops);
> +	if (IS_ERR(m2m->m2m_dev)) {
> +		dev_err(dev, "failed to register v4l2 device\n");

Why aren't you using dev_err_probe() at all?

> +		ret = PTR_ERR(m2m->m2m_dev);
> +		goto err_m2m;
> +	}
> +
> +	m2m->dec_vdev = video_device_alloc();
> +	if (!m2m->dec_vdev) {
> +		dev_err(dev, "failed to register v4l2 device\n");

Why do you print errors on ENOMEM?

Did you run coccinelle?

> +		ret = -ENOMEM;
> +		goto err_vdev_alloc;
> +	}
> +
> +	mutex_init(&m2m->mlock);
> +
> +	m2m->dec_vdev->fops = &asrc_m2m_fops;
> +	m2m->dec_vdev->ioctl_ops = &asrc_m2m_ioctl_ops;
> +	m2m->dec_vdev->minor = -1;
> +	m2m->dec_vdev->release = video_device_release;
> +	m2m->dec_vdev->lock = &m2m->mlock; /* lock for ioctl serialization */
> +	m2m->dec_vdev->v4l2_dev = &m2m->v4l2_dev;
> +	m2m->dec_vdev->vfl_dir = VFL_DIR_M2M;
> +	m2m->dec_vdev->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_AUDIO_M2M;
> +
> +#ifdef CONFIG_MEDIA_CONTROLLER
> +	m2m->mdev.dev = &pdev->dev;
> +	strscpy(m2m->mdev.model, M2M_DRV_NAME, sizeof(m2m->mdev.model));
> +	snprintf(m2m->mdev.bus_info, sizeof(m2m->mdev.bus_info),
> +		 "platform:%s", M2M_DRV_NAME);
> +	media_device_init(&m2m->mdev);
> +	m2m->mdev.ops = &asrc_m2m_media_ops;
> +	m2m->v4l2_dev.mdev = &m2m->mdev;
> +#endif
> +
> +	ret = video_register_device(m2m->dec_vdev, VFL_TYPE_AUDIO, -1);
> +	if (ret) {
> +		dev_err(dev, "failed to register video device\n");
> +		goto err_vdev_register;
> +	}
> +
> +#ifdef CONFIG_MEDIA_CONTROLLER
> +	ret = v4l2_m2m_register_media_controller(m2m->m2m_dev, m2m->dec_vdev,
> +						 MEDIA_ENT_F_PROC_AUDIO_RESAMPLER);
> +	if (ret) {
> +		dev_err(dev, "Failed to init mem2mem media controller\n");
> +		goto error_v4l2;
> +	}
> +
> +	ret = media_device_register(&m2m->mdev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register mem2mem media device\n");
> +		goto error_m2m_mc;
> +	}
> +#endif
> +
> +	video_set_drvdata(m2m->dec_vdev, m2m);
> +	platform_set_drvdata(pdev, m2m);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +#ifdef CONFIG_MEDIA_CONTROLLER
> +error_m2m_mc:
> +	v4l2_m2m_unregister_media_controller(m2m->m2m_dev);
> +#endif
> +error_v4l2:
> +	video_unregister_device(m2m->dec_vdev);
> +err_vdev_register:
> +	video_device_release(m2m->dec_vdev);
> +err_vdev_alloc:
> +	v4l2_m2m_release(m2m->m2m_dev);
> +err_m2m:
> +	v4l2_device_unregister(&m2m->v4l2_dev);
> +err_register:
> +	return ret;
> +}
> +
> +static void asrc_m2m_remove(struct platform_device *pdev)
> +{
> +	struct asrc_m2m *m2m = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +#ifdef CONFIG_MEDIA_CONTROLLER
> +	media_device_unregister(&m2m->mdev);
> +	v4l2_m2m_unregister_media_controller(m2m->m2m_dev);
> +#endif
> +	video_unregister_device(m2m->dec_vdev);
> +	video_device_release(m2m->dec_vdev);
> +	v4l2_m2m_release(m2m->m2m_dev);
> +	v4l2_device_unregister(&m2m->v4l2_dev);
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +/* suspend callback for m2m */
> +static int asrc_m2m_suspend(struct device *dev)
> +{
> +	struct asrc_m2m *m2m = dev_get_drvdata(dev);
> +	struct fsl_asrc *asrc = m2m->pdata.asrc;
> +	struct fsl_asrc_pair *pair;
> +	unsigned long lock_flags;
> +	int i;
> +
> +	for (i = 0; i < PAIR_CTX_NUM; i++) {
> +		spin_lock_irqsave(&asrc->lock, lock_flags);
> +		pair = asrc->pair[i];
> +		if (!pair || !pair->req_pair) {
> +			spin_unlock_irqrestore(&asrc->lock, lock_flags);
> +			continue;
> +		}
> +		if (!completion_done(&pair->complete[V4L_OUT])) {
> +			if (pair->dma_chan[V4L_OUT])
> +				dmaengine_terminate_all(pair->dma_chan[V4L_OUT]);
> +			asrc_input_dma_callback((void *)pair);
> +		}
> +		if (!completion_done(&pair->complete[V4L_CAP])) {
> +			if (pair->dma_chan[V4L_CAP])
> +				dmaengine_terminate_all(pair->dma_chan[V4L_CAP]);
> +			asrc_output_dma_callback((void *)pair);
> +		}
> +
> +		if (asrc->m2m_pair_suspend)
> +			asrc->m2m_pair_suspend(pair);
> +
> +		spin_unlock_irqrestore(&asrc->lock, lock_flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int asrc_m2m_resume(struct device *dev)
> +{
> +	struct asrc_m2m *m2m = dev_get_drvdata(dev);
> +	struct fsl_asrc *asrc = m2m->pdata.asrc;
> +	struct fsl_asrc_pair *pair;
> +	unsigned long lock_flags;
> +	int i;
> +
> +	for (i = 0; i < PAIR_CTX_NUM; i++) {
> +		spin_lock_irqsave(&asrc->lock, lock_flags);
> +		pair = asrc->pair[i];
> +		if (!pair || !pair->req_pair) {
> +			spin_unlock_irqrestore(&asrc->lock, lock_flags);
> +			continue;
> +		}
> +		if (asrc->m2m_pair_resume)
> +			asrc->m2m_pair_resume(pair);
> +
> +		spin_unlock_irqrestore(&asrc->lock, lock_flags);
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops asrc_m2m_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(asrc_m2m_suspend,
> +				      asrc_m2m_resume)
> +};
> +
> +static struct platform_driver asrc_m2m_driver = {
> +	.probe  = asrc_m2m_probe,
> +	.remove_new = asrc_m2m_remove,
> +	.driver = {
> +		.name = M2M_DRV_NAME,
> +		.pm = &asrc_m2m_pm_ops,
> +	},
> +};
> +module_platform_driver(asrc_m2m_driver);
> +
> +MODULE_DESCRIPTION("Freescale ASRC M2M driver");
> +MODULE_ALIAS("platform:" M2M_DRV_NAME);

You should not need MODULE_ALIAS() in normal cases. If you need it,
usually it means your device ID table is wrong (e.g. misses either
entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
for incomplete ID table.


> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

