Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631797BC6BC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343808AbjJGKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343765AbjJGKWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:22:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32A93
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 03:22:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405497850dbso26845365e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Oct 2023 03:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696674164; x=1697278964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqilCv5Y7OgUls6eEsFl4izAbkmsrC4YupwkFefaSTo=;
        b=pbhUEEKPg597Uik4f64LmK/R/taJQoonjKiedX7MRp0NfZJ/CxIBDEyJOc0h+tVm1M
         9BLGP6Ef26JV9TeIKJZlrXxXgekKVJAbyXTduzx7kXwoaUL155CKWMGdkPB/VeXyTVoz
         qUYRwnvuvsfLIRSNwSzSn4KFuq3PWeFl2mhJJ/V0TnPdl/zOpGWpE3wcK5A1UWQ4CDwH
         JZjlBBg5Bgdo6zlISPfnkq8wEeROiMTNzXYMEMv8IgGIILcr8DYzoF/rH+17EOD4xl55
         5yRVc8x2XO2TXdWn1MlctJLodByLcw8+d6ZK8GjYizrcGEPFCyaq9YUh0T+KqltQ8oxr
         Odzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696674164; x=1697278964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqilCv5Y7OgUls6eEsFl4izAbkmsrC4YupwkFefaSTo=;
        b=N3yD5GYjkDButzoLro1pAzIOQhS6qOzz1XXPHAS3wqa5PFb+pP2Qn9T1fA82W3+ua4
         mvuFFMASv6KnCt76z21zWz9uU5CE5NMHrvFsWgiw1wG80IZsCKtBclwi0hlKed56XWRs
         b2ziG2wiF27xFNvSj+aR+Sekx0f2K2aQYh+ULlseN9zRVxvfR6gNK/cyWOeuVKtnLMX/
         55B4RfxKUj3Zfdj6aRz9GfQTyJ4u2Rm6JDXCa8ubZm75lHMsG4s7iQMQ0akSNEfnIUd5
         TsLFGcQvDalLnQzLMRLpibwYL1chSPGkBgxsXqkNQXBP2/cGHRVHMyRcR9r7XAWu2Ijo
         K6LA==
X-Gm-Message-State: AOJu0YyXPLeBduYkKOq6hFm3mALIdKPKpkdmAJQW83GWSissQTxYqI/X
        pM127vjtKHkmriiRCJFfSoCu9Q==
X-Google-Smtp-Source: AGHT+IHJ71f3tRP3apgT5STfsq44y4DWfd8TlMOEtV5af+pDBokX82ABU0Kl8lLUnPfY4vNGmnzobg==
X-Received: by 2002:a7b:c8d7:0:b0:405:3b92:2fed with SMTP id f23-20020a7bc8d7000000b004053b922fedmr9094920wml.26.1696674164303;
        Sat, 07 Oct 2023 03:22:44 -0700 (PDT)
Received: from [172.20.10.4] (82-132-213-54.dab.02.net. [82.132.213.54])
        by smtp.googlemail.com with ESMTPSA id v14-20020a05600c214e00b00401c595fcc7sm8036849wml.11.2023.10.07.03.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Oct 2023 03:22:43 -0700 (PDT)
Message-ID: <53348f45-f5c5-e5ba-b0a8-d004655a6053@linaro.org>
Date:   Sat, 7 Oct 2023 11:22:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] nvmem: core: Fix possible buffer overflow on nvmem cell
 write
Content-Language: en-US
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20231003131343.1324962-1-loic.poulain@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231003131343.1324962-1-loic.poulain@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Loic for the patch,

On 03/10/2023 14:13, Loic Poulain wrote:
> Nothing prevents a nvmem consumer to try writing excessive data to a
> given nvmem cell (except when bit_offset is 0). The allocated buffer
> of size 'cell->bytes' in nvmem_cell_prepare_write_buffer may not be
> large enough to host the copied 'len' bytes.
> 
Did you hit this path?

  __nvmem_cell_entry_write already has a check for (cell->bit_offset == 
0 && len != cell->bytes))

What is the bit_offset in your case?

Can you provide more details?

thanks,
srini

> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>   drivers/nvmem/core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index eaf6a3fe8ca6..0b27ab3b3b86 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1654,6 +1654,9 @@ static void *nvmem_cell_prepare_write_buffer(struct nvmem_cell_entry *cell,
>   	int i, rc, nbits, bit_offset = cell->bit_offset;
>   	u8 v, *p, *buf, *b, pbyte, pbits;
>   
> +	if (len > cell->bytes)
> +		return ERR_PTR(-EINVAL);
> +
>   	nbits = cell->nbits;
>   	buf = kzalloc(cell->bytes, GFP_KERNEL);
>   	if (!buf)
