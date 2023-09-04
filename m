Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B7E79128E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352460AbjIDHuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjIDHup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:50:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA40DF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:50:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4227066a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693813840; x=1694418640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rwo1JQ07wN9AZgkdq/ZN73aYRmpPxX5x4XvDTXJBqg=;
        b=lYUepP5XD7GGYxipiVNlbz7XRpnQFNjTWMbqIz5HEYI5O0b+qZKBJEn871ZDFXSY/F
         g78u6DwCDDfYAhlPNo/2DabdOCCKsBMICunUIEzm1Gd0d5XoYZoCNgC2eGgikzoaJzDk
         eUJiwSNYNhSMr8StDMr6DphKFk9/UhWIh+zwT2uYKNALcGbvuzoz/iI0yFvBwKhOW4/k
         8ohMwsEzoA+55+43ZurD+5Tlm1R71IHbgbdfDREKszBWXjJO9BwJu9+XdVDBRaY4ZB1V
         lzs6SDYr85oumHsnMhBrXgH1rHwmVIgoB9ZOvjtrh6FM//eU4oHz/qZZ5Nc0ntbp68O1
         EmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813840; x=1694418640;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rwo1JQ07wN9AZgkdq/ZN73aYRmpPxX5x4XvDTXJBqg=;
        b=In4EN05GOZQ7mleuHMUBV0btuYWRgBKhPoXhHjr5SzquG/KU4qntKCyGn9YYMuIMjk
         9NX3uFinxButtICttXgfOfSq8Rqnu84PUBI+DCJFbur0nCEobqeXAtYfbuLJ6w/YKBJt
         MJO2C+eNp0n8GuGcwgx35zTLu7fdbrY1m/wKXCkYHgiRxs3EgfEUGmcERcC1eHsvD5Dh
         RYlD8uRC40IUckhRkx2QwZLviYR2gjOofAmUYiHemlQ8Vrz1ykIi/0U9bKCIPxCfR8t0
         qu3FMnhzgHYv7W5dWy5iBOK1OOxxRZfH1X/OIrE9/O76uA6T4xX4/Yz6NAUMbL1Vtm+n
         VwZg==
X-Gm-Message-State: AOJu0Yz/7JR9X1VpXwxk5yZbo+di7fR5R9VirKiRbdUi4zzzXgnLMgGN
        Eg54uCxP9+OHA/CJ0FKSNwCXfw==
X-Google-Smtp-Source: AGHT+IEMqpCQ0XocZ/dxGoFxB/NYSHOnxzelUaffF8qI5OwbjunnTJ/liyc30D7juKnqGjdDfxzxpQ==
X-Received: by 2002:a17:907:7b9e:b0:9a1:d29c:fb6b with SMTP id ne30-20020a1709077b9e00b009a1d29cfb6bmr13395072ejc.25.1693813840320;
        Mon, 04 Sep 2023 00:50:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709061dd400b00982a352f078sm5750337ejh.124.2023.09.04.00.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:50:39 -0700 (PDT)
Message-ID: <f6943509-25c5-b4fe-2218-638cc06a4e04@linaro.org>
Date:   Mon, 4 Sep 2023 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Content-Language: en-US
To:     Tanmay Shah <tanmay.shah@amd.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829181900.2561194-4-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi,

On 29/8/23 20:19, Tanmay Shah wrote:
> Use new dt bindings to get TCM address and size
> information. Also make sure that driver stays
> compatible with previous device-tree bindings.
> So, if TCM information isn't available in device-tree
> for zynqmp platform, hard-coded address of TCM will
> be used.
> 
> New platforms that are compatible with this
> driver must add TCM support in device-tree as per new
> bindings.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>   drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
>   1 file changed, 221 insertions(+), 58 deletions(-)


>   /**
> @@ -75,11 +79,17 @@ struct mbox_info {
>    * Hardcoded TCM bank values. This will be removed once TCM bindings are
>    * accepted for system-dt specifications and upstreamed in linux kernel

Just curious, for how long this fall back code has to be maintained?
(When/how will we know we can remove it?)

>    */
> -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
> +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
> +};

