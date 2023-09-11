Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6079B4CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbjIKWKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjIKLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:09:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 805F1E40
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:09:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcde83ce9fso71834591fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694430590; x=1695035390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ItV/PafZYbRtZG+3EH6sRu97i9Pet4QO+NBJ8/y2iuI=;
        b=tg4h2AL9gT7/qUV0jFTrvkPJl9a/skFZyfbwb9lpcls46kdOpKy/0zULUF05nAJKrw
         ITd7nMPZiaS5PsZzg1uTs9LpnOIGc5IQoXbM6B0QK8XpMLmTWz7Uvoa0s4ZTgz5Jq9t4
         v0U5o8trLtrjzW4IH2vQo4mpKEbOiin4b62jWutcLNlCqZmZsOvN5+FxgDlk21bHCJDq
         AGy8mFU5AJj5nVJ+LxeMb8183iNYaxF1hzP/jM4wDcZfI50R1cg8CQ5wa0RSetIfcJDN
         Epx6SgrPMDqtOePCk98hrz6ZZ1pRWPxrXpWGXqxYXtz71fRYbYppSVB44eXGFYlNXoj4
         UTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430590; x=1695035390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ItV/PafZYbRtZG+3EH6sRu97i9Pet4QO+NBJ8/y2iuI=;
        b=pO5GZnveNK3StdzatLa2d69yXfU/mfcoajv8q/kDPdwfwhlHxOiUpIUhoLIOQifhif
         XX0EsNM66yqVLkxKZTNmwH7s3YTV+KVaFt6XWG+GZQlQL1V8+CZkg1WGDN9HXiveGkEa
         OfuaT+7LjxJ9oPlRCD9TVN/J9NSDtRCjap166td0rMcVlg6wD7gS+BBQSfaJ4aCrqYjz
         BZH1pQyuPNfmwcfcYEB2vaOBOixQhMThDMppqxCK3cfsyPwW0ibjo8aSb2HGzGl7LeFv
         WnYzlKgpVBLxtuJ7wX0nAx/VArvHCH4PnQwVYx6PUo+a6B1gkmW//83njZT6ijycyIpY
         GkzQ==
X-Gm-Message-State: AOJu0YySjTJiG3405Cd1sJ7GCutqxAcQzcxN8LrtJblL899GXqNjI1zi
        dvrqC0NjBQkZ3xeajXqIGHMcow==
X-Google-Smtp-Source: AGHT+IEA9FyfM8rXa+3k+u+doQWaGigDrU1zuRRVi1v3E2XELPt5LPr2HsZJRl0XxMdT23XFarwUrQ==
X-Received: by 2002:a2e:8543:0:b0:2bd:180d:67b7 with SMTP id u3-20020a2e8543000000b002bd180d67b7mr6601812ljj.40.1694430589764;
        Mon, 11 Sep 2023 04:09:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id lw7-20020a170906bcc700b009a168ab6ee2sm5129780ejb.164.2023.09.11.04.09.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:09:48 -0700 (PDT)
Message-ID: <0041a391-12ba-2e1b-0954-fbc0e00be631@linaro.org>
Date:   Mon, 11 Sep 2023 13:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 11/17] qcom_minidump: Register ramoops region with
 minidump
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
 <1694290578-17733-12-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1694290578-17733-12-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2023 22:16, Mukesh Ojha wrote:
> Register all the pstore frontend with minidump, so that they can
> be dumped as default Linux minidump region to be collected on
> SoC where minidump is enabled.
> 

...

> +
> +	record.type = type;
> +	record.id = 0;
> +	max_dump_cnt = 0;
> +	name = pstore_type_to_name(record.type);
> +	do {
> +		ret = pstore_region_defined(&record, &virt, &phys, &size, &max_dump_cnt);
> +		if (ret < 0)
> +			break;
> +
> +		mdr_list = devm_kzalloc(dev, sizeof(struct md_region_list), GFP_KERNEL);

sizeof(*)

Please fix it everywhere in your code.

> +		if (!mdr_list)
> +			return -ENOMEM;
> +
> +		md_region = &mdr_list->md_region;
> +		scnprintf(md_region->name, sizeof(md_region->name) - 1, "K%s%llu", name, record.id);
> +		md_region->virt_addr = virt;
> +		md_region->phys_addr = phys;
> +		md_region->size = size;
> +		ret = qcom_minidump_region_register(md_region);
> +		if (ret) {
> +			pr_err("failed to register minidump region\n");
> +			break;
> +		}
> +
> +		list_add(&mdr_list->list, &ramoops_region_list);
> +	} while (record.id < max_dump_cnt && ++record.id);
> +
> +	return ret;
> +}


Best regards,
Krzysztof

