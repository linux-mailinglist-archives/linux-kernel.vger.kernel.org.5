Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571157D2E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJWJba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjJWJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:31:26 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD0D66
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:31:24 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9b96c3b4be4so446737666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698053483; x=1698658283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tyFzM67x1/2Iv4+IBgYZUNJYMjWASdOO23llnCqnyIA=;
        b=wFkIGymV0HKs0TbYYDkZm2W3SnBBciJ4gyReg9y85QVJPACx08PaqGq3rHQpZF9iZT
         2ev5DOa6KRr1GYlDmX5zOk2jktJsZ4/Ay66YD1VBwn+oOtrAcLc99kjx8h+TZJZ9g6ZO
         3jDtvGokMSe6rkzxsueRJbkjq5UkeQGVHPJQZi/SjV+9iwT6zSGgyO7CaR3cSFrIdm6S
         kopiOvx5PDDum24CAsgrcJ1TX+znpfhj0rFH3aNsWDGg/FpCco9jhXtcPQde0bJTzin3
         wdDvE7m3EwoP4kmI+wmcuCBa7PM3+FVsdb84luBNLaogJkGYTR8bp2Z7YZOXVjVBrXnt
         pQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698053483; x=1698658283;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyFzM67x1/2Iv4+IBgYZUNJYMjWASdOO23llnCqnyIA=;
        b=KH0iuU4Y33gXD+SVEKkyu0LQ9x6DvkjWHmy0dxEsXtqf6MOm2SFF2L6k1uEMxsngaC
         oneGYIjBgvdwW1CDrt5j1isS74ZfEMw3BQCTjf1EuF/jn+BefRKUhmXiTYo3QfDGMWgu
         gkLJE2yUfo+p674F8pscoGX+9hexG8+sJereqK6xIWAuQ2yoB0U40/RBIRcgVQ+mYtBV
         hgh7ZnSoIoI/kD46n3fNor4yDxdp2sUdrf7TH1C3hbAHhp4GnJtY/pa7H+j+w1be9q6e
         V21J1wWwFbpxtnFW3Z+HF61ZOJ6MWQ65csc0CAE5gzQ6SMN/UEYnEMtRnGaHKCwJCB4G
         jT+Q==
X-Gm-Message-State: AOJu0Yyt91hsyWKMjAfk2KUUFmeuvLqEYYt8cOR8ksDAx8Gxc3oI5I14
        dI0G09Oxa5B1zuOOx2YR1P4CBA==
X-Google-Smtp-Source: AGHT+IGvGw7VaAxRV7tuzC8re9PUOmwoMFVRp8KzNDobE6qN4NnguuqTj3H6emVkvVYGFjMXYzsfWg==
X-Received: by 2002:a17:907:3f85:b0:9be:4eb8:5b1e with SMTP id hr5-20020a1709073f8500b009be4eb85b1emr6832064ejc.59.1698053482830;
        Mon, 23 Oct 2023 02:31:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906075700b009b27d4153cfsm6389962ejb.176.2023.10.23.02.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 02:31:22 -0700 (PDT)
Message-ID: <5bac8188-7d27-4efe-9493-dec4393fbeb0@linaro.org>
Date:   Mon, 23 Oct 2023 11:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] soc: qcom: memory_dump: Add memory dump driver
Content-Language: en-US
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com,
        quic_tingweiz@quicinc.com
References: <1698052857-6918-1-git-send-email-quic_zhenhuah@quicinc.com>
 <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1698052857-6918-4-git-send-email-quic_zhenhuah@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2023 11:20, Zhenhua Huang wrote:
> Qualcomm memory dump driver initializes system memory dump table.
> Firmware dumps system cache, internal memory, peripheral registers
> to DDR as per this table after system crashes and warm resets. The
> driver reserves memory, populates ids and sizes for firmware dumping
> according to the configuration.
> 
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---

...

> +
> +/* populate allocated region */
> +static int __init mem_dump_populate_mem(struct device *dev,
> +					struct page *start_page,
> +					size_t total_size)
> +{
> +	struct qcom_memory_dump *memdump = dev_get_drvdata(dev);
> +	struct qcom_dump_entry dump_entry;
> +	struct qcom_dump_data *dump_data;
> +	struct xbc_node *linked_list;
> +	phys_addr_t phys_end_addr;
> +	phys_addr_t phys_addr;
> +	const char *size_p;
> +	void *dump_vaddr;
> +	const char *id_p;
> +	int ret = 0;
> +	int size;
> +	int id;
> +
> +	phys_addr = page_to_phys(start_page);
> +	phys_end_addr = phys_addr + total_size;
> +	dump_vaddr = page_to_virt(start_page);
> +
> +	ret = mem_dump_register_data_table(dev, dump_vaddr, phys_addr);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "Mem Dump table set up is failed\n");
> +		return ret;

That's not the syntax. Syntax is return dev_err_probe

> +	}
> +
> +	ret = qcom_init_memdump_imem_area(dev, total_size);
> +	if (ret)
> +		return ret;
> +
> +	/* Apply two tables: QCOM_DUMP_TYPE_TABLE and QCOM_DUMP_TYPE_DATA */
> +	mem_dump_apply_offset(&dump_vaddr, &phys_addr,
> +			      sizeof(struct qcom_dump_table) * 2);
> +
> +	/* Both "id" and "size" must be present */
> +	xbc_node_for_each_subkey(memdump->mem_dump_node, linked_list) {
> +		const char *name = xbc_node_get_data(linked_list);
> +
> +		if (!name)
> +			continue;
> +
> +		id_p = xbc_node_find_value(linked_list, "id", NULL);
> +		size_p = xbc_node_find_value(linked_list, "size", NULL);
> +
> +		if (id_p && size_p) {
> +			ret = kstrtoint(id_p, 0, &id);
> +			if (ret)
> +				continue;
> +
> +			ret = kstrtoint(size_p, 0, &size);
> +
> +			if (ret)
> +				continue;
> +
> +		/*
> +		 * Physical layout: starting from two qcom_dump_data.
> +		 * Following are respective dump meta data and reserved regions.
> +		 * Qcom_dump_data is populated by the driver, fw parse it
> +		 * and dump respective info into dump mem.
> +		 * Illustrate the layout:
> +		 *
> +		 *   +------------------------+------------------------+
> +		 *   | qcom_dump_table(TABLE) | qcom_dump_table(DATA)  |
> +		 *   +------------------------+------------------------+
> +		 *   +-------------+----------+-------------+----------+
> +		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
> +		 *   +-------------+----------+-------------+----------+
> +		 *   +-------------+----------+-------------+----------+
> +		 *   |qcom_dump_data| dump mem|qcom_dump_data| dump mem |
> +		 *   +-------------+----------+-------------+----------+
> +		 *   ...
> +		 */

You have wrong indentation here.

> +			dump_data = dump_vaddr;
> +			dump_data->addr = phys_addr + QCOM_DUMP_DATA_SIZE;
> +			dump_data->len = size;
> +			dump_entry.id = id;
> +			strscpy(dump_data->name, name,
> +				sizeof(dump_data->name));
> +			dump_entry.addr = phys_addr;
> +			ret = mem_dump_data_register(dev, QCOM_DUMP_TABLE_LINUX,
> +						     &dump_entry);
> +			if (ret) {
> +				dev_err_probe(dev, ret, "Dump data setup failed, id = %d\n",
> +					      id);

Syntax is return dev_err_probe

> +				return ret;
> +			}
> +
> +			mem_dump_apply_offset(&dump_vaddr, &phys_addr,
> +					      size + QCOM_DUMP_DATA_SIZE);
> +			if (phys_addr > phys_end_addr) {
> +				dev_err_probe(dev, -ENOMEM, "Exceeding allocated region\n");

ENOMEM? Does not look right then.

> +				return -ENOMEM;
> +			}
> +		} else {
> +			continue;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int __init mem_dump_probe(struct platform_device *pdev)
> +{
> +	struct qcom_memory_dump *memdump;
> +	struct device *dev = &pdev->dev;
> +	struct page *page;
> +	size_t total_size;
> +	int ret = 0;
> +
> +	memdump = devm_kzalloc(dev, sizeof(struct qcom_memory_dump),
> +			       GFP_KERNEL);
> +	if (!memdump)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, memdump);
> +
> +	/* check and initiate CMA region */
> +	ret = mem_dump_reserve_mem(dev);
> +	if (ret)
> +		return ret;
> +
> +	/* allocate and populate */
> +	page = mem_dump_alloc_mem(dev, &total_size);
> +	if (IS_ERR(page)) {
> +		ret = PTR_ERR(page);
> +		dev_err_probe(dev, ret, "mem dump alloc failed\n");

No, the syntax is:
ret = dev_err_probe

But why do you print messgaes for memory allocations?

> +		goto release;
> +	}
> +
> +	ret = mem_dump_populate_mem(dev, page, total_size);
> +	if (!ret)
> +		dev_info(dev, "Mem dump region populated successfully\n");

Drop simple probe success messages. Not needed.

> +	else
> +		goto free;
> +
> +	return 0;
> +
> +free:
> +	cma_release(dev_get_cma_area(dev), page, (total_size / PAGE_SIZE));
> +
> +release:
> +	of_reserved_mem_device_release(dev);

Where is cleanup on unbind?

> +	return ret;
> +}
> +
> +static const struct of_device_id mem_dump_match_table[] = {
> +	{.compatible = "qcom,mem-dump",},
> +	{}
> +};
> +
Best regards,
Krzysztof

