Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ACD79B8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbjIKUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbjIKLBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:01:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCDBCDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:01:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-502a25ab777so4116886e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694430107; x=1695034907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6D6uZQx0A7zu9HZThgkhNF6gppfDzg14ZGsi8FUaY4Q=;
        b=GOSoTT4UaccjQcJnHUj1GeXqRlrNKXB4d25DwVPYJKxntS9nhJJNn1WSq6r1ePDHNM
         sWFeeWxUuGPmO3IAqiFCte0rME8/AAv4w444Tg/1OI7KzGUphVg9kJ8x9wKwqs+tjE3s
         4A8nI4rEZa96jRO/0mqlPbRnkef19ToR6L1RzHtIKsvTpaXv3XBDZY3CmrCTTGRhPtEZ
         FRsnsLVKFFPTPn3vkpC2Ypvi4CYQnw7/rprROjDOmdd9dgcY6HGsPjFuCjOs/wqIzDQ7
         6TUhAU2zJ8r1kh1pIesiHL/xfm82X/q0h/nHMLjyR82LlFTdSUp4OGmtjLM+zGC68z4+
         gnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430107; x=1695034907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6D6uZQx0A7zu9HZThgkhNF6gppfDzg14ZGsi8FUaY4Q=;
        b=JCmRNkekbXOnKNjlhDNA45MbUtu9J2Sgu+H7SxMFhEEAG2ImvSBlR61lJWPRhAvnC4
         +1XQJYFaUe/NEYCciMPs3kky07bgpthUz8AqXk6n2o81vV7dWeZLK1c3Ev2rh1rWd5je
         BzuOO0rk50dCOxHzrdAcjIaX5bYgb3BJa/3jODKOO8+5tnrs0UdZUlqOlhvDyLmeAKE6
         JvueKdhW8noiLeGFOG4oHs07Yl6tCga9IkNOd8S/jQhbaJ4eo9TIWJMyM2Em0dle9RFl
         03+8rwiGBkZVE4jQyAOiFKNzzImOiVH2MKr9MtZWt+oxvVnPwV4cQeKbjKk3INx+PrMc
         4/Eg==
X-Gm-Message-State: AOJu0YznH5OvfDSH9RjaP2QAjGB6bp6JmUNP4hE5N/M9KcFpxelTbB8G
        yNi38PpzrMEpIt+ItRZFPKbF1Q==
X-Google-Smtp-Source: AGHT+IGuUFRIM5BpeluBoo5NEliARLhu4KUj73ZJ5zv60HnO5TW4G54nipJsf0t1IIjq2gfhWbu1wg==
X-Received: by 2002:a05:6512:3d1c:b0:4ff:8c9e:eb0d with SMTP id d28-20020a0565123d1c00b004ff8c9eeb0dmr9569849lfv.0.1694430107080;
        Mon, 11 Sep 2023 04:01:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id r16-20020a170906351000b0099bd86f9248sm5175514eja.63.2023.09.11.04.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:01:43 -0700 (PDT)
Message-ID: <3bb1e84f-3b65-0596-1b6b-6decb0ff53cc@linaro.org>
Date:   Mon, 11 Sep 2023 13:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 06/17] soc: qcom: Add Qualcomm APSS minidump kernel
 driver
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, vigneshr@ti.com, nm@ti.com,
        matthias.bgg@gmail.com, kgene@kernel.org, alim.akhtar@samsung.com,
        bmasney@redhat.com, quic_tsoni@quicinc.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@quicinc.com
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-7-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1694290578-17733-7-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2023 22:16, Mukesh Ojha wrote:
> Minidump is a best effort mechanism to collect useful and predefined
> data for first level of debugging on end user devices running on
> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
> or subsystem part of SoC crashes, due to a range of hardware and
> software bugs. Hence, the ability to collect accurate data is only
> a best-effort. The data collected could be invalid or corrupted,
> data collection itself could fail, and so on.

...

> +static int qcom_apss_md_table_init(struct minidump *md,
> +				   struct minidump_subsystem *mdss_toc)
> +{
> +	struct minidump_ss_data *mdss_data;
> +
> +	mdss_data = devm_kzalloc(md->dev, sizeof(*mdss_data), GFP_KERNEL);
> +	if (!mdss_data)
> +		return -ENOMEM;
> +
> +	mdss_data->md_ss_toc = mdss_toc;
> +	mdss_data->md_regions = devm_kcalloc(md->dev, MAX_NUM_ENTRIES,
> +					     sizeof(struct minidump_region),
> +					     GFP_KERNEL);
> +	if (!mdss_data->md_regions)
> +		return -ENOMEM;
> +
> +	mdss_toc = mdss_data->md_ss_toc;
> +	mdss_toc->regions_baseptr = cpu_to_le64(virt_to_phys(mdss_data->md_regions));
> +	mdss_toc->enabled = cpu_to_le32(MINIDUMP_SS_ENABLED);
> +	mdss_toc->status = cpu_to_le32(1);
> +	mdss_toc->region_count = cpu_to_le32(0);
> +
> +	/* Tell bootloader not to encrypt the regions of this subsystem */
> +	mdss_toc->encryption_status = cpu_to_le32(MINIDUMP_SS_ENCR_DONE);
> +	mdss_toc->encryption_required = cpu_to_le32(MINIDUMP_SS_ENCR_NOTREQ);
> +
> +	md->apss_data = mdss_data;
> +
> +	return 0;
> +}
> +
> +static int qcom_apss_minidump_probe(struct platform_device *pdev)
> +{
> +	struct minidump_global_toc *mdgtoc;
> +	struct minidump *md;
> +	size_t size;
> +	int ret;
> +
> +	md = devm_kzalloc(&pdev->dev, sizeof(struct minidump), GFP_KERNEL);

sizeof(*)

Didn't you get such comments already?


> +	if (!md)
> +		return -ENOMEM;
> +
> +	md->dev = &pdev->dev;
> +	mdgtoc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, &size);
> +	if (IS_ERR(mdgtoc)) {
> +		ret = PTR_ERR(mdgtoc);
> +		dev_err(md->dev, "Couldn't find minidump smem item: %d\n", ret);
> +		return ret;

The syntax is:
return dev_err_probe

> +	}
> +
> +	if (size < sizeof(*mdgtoc) || !mdgtoc->status) {
> +		dev_err(md->dev, "minidump table is not initialized: %d\n", ret);

ret is uninitialized here. Please use automated tools for checking your
code:
coccinelle, smatch and sparse

> +		return -EINVAL;
> +	}
> +
> +	mutex_init(&md->md_lock);
> +	ret = qcom_apss_md_table_init(md, &mdgtoc->subsystems[MINIDUMP_APSS_DESC]);
> +	if (ret) {
> +		dev_err(md->dev, "apss minidump initialization failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* First entry would be ELF header */
> +	ret = qcom_md_add_elfheader(md);
> +	if (ret) {
> +		dev_err(md->dev, "Failed to add elf header: %d\n", ret);
> +		memset(md->apss_data->md_ss_toc, 0, sizeof(struct minidump_subsystem));

Why do you need it?

> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, md);
> +
> +	return ret;
> +}
> +
> +static int qcom_apss_minidump_remove(struct platform_device *pdev)
> +{
> +	struct minidump *md = platform_get_drvdata(pdev);
> +	struct minidump_ss_data *mdss_data;
> +
> +	mdss_data = md->apss_data;
> +	memset(mdss_data->md_ss_toc, cpu_to_le32(0), sizeof(struct minidump_subsystem));

Why do you need it?

> +	md = NULL;

That's useless assignment.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver qcom_minidump_driver = {
> +	.probe = qcom_apss_minidump_probe,
> +	.remove = qcom_apss_minidump_remove,
> +	.driver  = {
> +		.name = "qcom-minidump-smem",
> +	},
> +};
> +
> +module_platform_driver(qcom_minidump_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm APSS minidump driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:qcom-minidump-smem");

Add a proper ID table instead of re-inventing it with module aliases.

Best regards,
Krzysztof

