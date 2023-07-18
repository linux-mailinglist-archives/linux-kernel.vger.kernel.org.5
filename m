Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435E75845D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 20:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGRSR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 14:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 14:17:25 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282B5B6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:17:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so8571789a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 11:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689704242; x=1692296242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtdblGg5jBy/9UdjzY2MwuPaOGVdkK2ygs+jc/rHbsI=;
        b=DQgV2zHYpUaxjuhMxzP6Oqc1LGh7YqOteKkDPGTEZzBXadvXn756Uubzfkgfjfq90X
         qRxIKRWbdYNZit0s71pVEoEHFgMH0bIaI1QdKFyyOcxypPTE1a+s7MKmv8BsJXjVj+T2
         NELmvM6fo6+mTf1BVawsd/BDQQuDEztFmIltRhyhkVGT2+CemLzmAj9HDAsY1bgyUeOa
         mP+0o274YlrTwGwqMG7ly3T9/jWDe+i+GoYYEYXGaHX89/pbLON5jfM3KoumV5kDj//K
         5AJLOi8GaeoUZqmqaQWob2EG9vfCC/URYT4Dq1XbCRTr8WLPLC/WG3m4VKR06U+yzK6P
         eEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704242; x=1692296242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtdblGg5jBy/9UdjzY2MwuPaOGVdkK2ygs+jc/rHbsI=;
        b=XNtyqhBchzAI9cv6QNw9rP/nztM4eF8/CoOYsJFQ6EDgAZOWPAY61SoKQJHitQp4tk
         rxBtJ0DFI/y9JueKeGnVXyEnS8aOLonlKy5UiKbnA1VP24umd2RN1VyZxJJ4aio334b6
         nXPWTPT6KJ23Le8NSnOxftpSz7ZaltWaMyDCm4xlggIk+kIjMKWFWk+RidtryOx4sjJu
         hXCAxmBvEk0D+YYdJgmhiLeifrUFTkhwUCs3KUWJe1rbitHIw6/kVAzR8Br2HSUg+XLo
         M1jlPZJOw+dPYBGdQnANRYr9PoO8v1ZtklVCV2a5v/bkopYFW9jdK2aROR4rIy3xx+82
         wwlw==
X-Gm-Message-State: ABy/qLYCtYl1sW2vmloPadtSBRNNOupBSSF750ocJ0ghiboqmad/iwPn
        D8pqFBEAHrv5CDTBPat9VmMiOw==
X-Google-Smtp-Source: APBJJlGiWY1EKNf9FkiAT/uOh62LJK1rZHb+JAcvP2bwDKhX7gSsrFR2Dvy9OXIbKA28S2qFehsUaQ==
X-Received: by 2002:aa7:cd47:0:b0:51f:f079:8761 with SMTP id v7-20020aa7cd47000000b0051ff0798761mr563469edw.15.1689704242657;
        Tue, 18 Jul 2023 11:17:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7d80f000000b0051e2670d599sm1571865edq.4.2023.07.18.11.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 11:17:22 -0700 (PDT)
Message-ID: <d9d5ffd5-6f85-f091-5d69-12cdd8d04c99@linaro.org>
Date:   Tue, 18 Jul 2023 20:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718160833.36397-3-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 18:08, Nikunj Kela wrote:
> Add a new transport channel to the SCMI firmware interface driver for
> SCMI message exchange on Qualcomm virtual platforms.
> 
> The hypervisor associates an object-id also known as capability-id
> with each hvc doorbell object. The capability-id is used to identify the
> doorbell from the VM's capability namespace, similar to a file-descriptor.
> 

...

> +
> +static bool qcom_hvc_chan_available(struct device_node *of_node, int idx)
> +{
> +	struct device_node *np = of_parse_phandle(of_node, "shmem", 0);
> +
> +	if (!np)
> +		return false;
> +
> +	of_node_put(np);
> +	return true;
> +}
> +
> +static inline void qcom_hvc_channel_lock_init(struct scmi_qcom_hvc *scmi_info)
> +{
> +	mutex_init(&scmi_info->shmem_lock);
> +}
> +
> +static inline void
> +qcom_hvc_channel_lock_acquire(struct scmi_qcom_hvc *scmi_info,
> +			      struct scmi_xfer *xfer __maybe_unused)

Why do you pass unused arguments?

> +{
> +	mutex_lock(&scmi_info->shmem_lock);

Why do you need these wrappers? Why not using mutexes directly?
If they are needed, then add lock __acquires annotation.


> +}
> +
> +static inline void qcom_hvc_channel_lock_release(struct scmi_qcom_hvc
> +						 *scmi_info)

Same comments.

> +{
> +	mutex_unlock(&scmi_info->shmem_lock);
> +}
> +
> +static int qcom_hvc_chan_setup(struct scmi_chan_info *cinfo,
> +			       struct device *dev, bool tx)
> +{
> +	struct device *cdev = cinfo->dev;
> +	struct scmi_qcom_hvc *scmi_info;
> +	resource_size_t size;
> +	struct resource res;
> +	struct device_node *np;
> +	unsigned long cap_id;
> +	u32 func_id;
> +	int ret, irq;
> +
> +	if (!tx)
> +		return -ENODEV;
> +
> +	scmi_info = devm_kzalloc(dev, sizeof(*scmi_info), GFP_KERNEL);
> +	if (!scmi_info)
> +		return -ENOMEM;
> +
> +	np = of_parse_phandle(cdev->of_node, "shmem", 0);
> +	if (!of_device_is_compatible(np, "arm,scmi-shmem"))

You leak here reference.

> +		return -ENXIO;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	of_node_put(np);
> +	if (ret) {
> +		dev_err(cdev, "failed to get SCMI Tx shared memory\n");
> +		return ret;
> +	}
> +
> +	size = resource_size(&res);
> +
> +	/* let's map 2 additional ulong since
> +	 * func-id & capability-id are kept after shmem.
> +	 *     +-------+
> +	 *     |       |
> +	 *     | shmem |
> +	 *     |       |
> +	 *     |       |
> +	 *     +-------+ <-- size
> +	 *     | funcId|
> +	 *     +-------+ <-- size + sizeof(ulong)
> +	 *     | capId |
> +	 *     +-------+ <-- size + 2*sizeof(ulong)
> +	 */
> +
> +	scmi_info->shmem = devm_ioremap(dev, res.start,
> +					size + 2 * sizeof(unsigned long));
> +	if (!scmi_info->shmem) {
> +		dev_err(dev, "failed to ioremap SCMI Tx shared memory\n");
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	func_id = readl((void *)(scmi_info->shmem) + size);
> +
> +#ifdef CONFIG_ARM64
> +	cap_id = readq((void *)(scmi_info->shmem) + size +
> +		       sizeof(unsigned long));
> +#else
> +	cap_id = readl((void *)(scmi_info->shmem) + size +
> +		       sizeof(unsigned long));
> +#endif
> +
> +	/*
> +	 * If there is an interrupt named "a2p", then the service and
> +	 * completion of a message is signaled by an interrupt rather than by
> +	 * the return of the hvc call.
> +	 */
> +	irq = of_irq_get_byname(cdev->of_node, "a2p");
> +	if (irq > 0) {
> +		ret = devm_request_irq(dev, irq, qcom_hvc_msg_done_isr,
> +				       IRQF_NO_SUSPEND,
> +				       dev_name(dev), scmi_info);
> +		if (ret) {
> +			dev_err(dev, "failed to setup SCMI completion irq\n");

return dev_err_probe, unless this is not called in probe... but then
using devm-interface raises questions.

Best regards,
Krzysztof

