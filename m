Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5585777709
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 13:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjHJLbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 07:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjHJLbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 07:31:13 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBE4E42
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:31:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe167d4a18so7300615e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691667071; x=1692271871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3RXPprJU2hE5cjuYnx4i6Sk1OK80+5yCKiP5CQ+QSgM=;
        b=iHF2MTU5fL8hJmdrBzYuTDiTez4b+1cyTh51MWBygiHIGstB79dxwzTB2UpKguaPnv
         mYhPMMCrBzaZUl4dkAw7An9j4KAUZe6AE38e6Qx8huGrEZ3SqQP3VboHcogkhB7ts2o2
         abIsgI8h7upMpFwml6siZTv81Ms63FP4nlxDIAsPCaUI9UYFBClborQFOHHjgR4IWfw6
         OOzEQYWw+ywLBi6WYE1WfPGfd/e6Fs8DJaBih2HAZXGgiw1YKmxUY98mqozGXCi7LW2h
         MFzNCj++scnSkxiXk/VKN30pMezoAR9LLAHOnjSFl/Afg2RH+vRj+U13bsTKVk2vDG94
         enTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691667071; x=1692271871;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3RXPprJU2hE5cjuYnx4i6Sk1OK80+5yCKiP5CQ+QSgM=;
        b=J+9L0ikACxm4R1q5/9A/+GaVRoPEd2r0UyVV84IEAI/RgaZGrADOVncUPCud2k7MTQ
         huRy4+7JrsgRDUd+KTbgWmpGJ+ZDRqJBom2hu67RUFCwCMDqSJup3Bedm4tzEIe83NMW
         rpQ1tm68qYbsTeyolEF28zjDtoZ39v49Fhb5PsTOYlCe85YbRTWZ3D4f8rf93g9EsWVk
         qACY1fXkjTKEb3sL9qzmGYrCaPEH1TDZerk8uqAfnyO9uPZMKPuB0U+osRhQBDguvrWe
         /PGE+eAdGRWjhTqUnRYzsLRckni+ajV8vRawkFSeoG/tLnTXT8Eh+rrUnhmHvhZzv1g1
         4KOg==
X-Gm-Message-State: AOJu0YzZQp6OfTboLFu1MW5cGhptyUOA7xGGwD/bxSII2w0ncumROkqM
        UQ1J1hHdwLI+0n9lEqFeLdEBZmQfsZ42vOkz5E0=
X-Google-Smtp-Source: AGHT+IGgoU7CaH3jrKEgzmN3TkhCvzlo2bonJN+g/P6j6+GtXJDgXP7CtM9BrRR4HEoPTcmlS4OBlQ==
X-Received: by 2002:a7b:c859:0:b0:3fe:1232:93fa with SMTP id c25-20020a7bc859000000b003fe123293famr1692343wml.22.1691667071069;
        Thu, 10 Aug 2023 04:31:11 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c21c100b003fe1e3937aesm1831728wmj.20.2023.08.10.04.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 04:31:10 -0700 (PDT)
Message-ID: <59b61d65-a827-d252-cdc2-a256f99cb4d9@linaro.org>
Date:   Thu, 10 Aug 2023 12:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/4] venus: hfi: add checks to handle capabilities from
 firmware
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, tfiga@chromium.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-4-git-send-email-quic_vgarodia@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <1691634304-2158-4-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 03:25, Vikash Garodia wrote:
> The hfi parser, parses the capabilities received from venus firmware and
> copies them to core capabilities. Consider below api, for example,
> fill_caps - In this api, caps in core structure gets updated with the
> number of capabilities received in firmware data payload. If the same api
> is called multiple times, there is a possibility of copying beyond the max
> allocated size in core caps.
> Similar possibilities in fill_raw_fmts and fill_profile_level functions.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1a73374a04e5 ("media: venus: hfi_parser: add common capability parser")
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>   drivers/media/platform/qcom/venus/hfi_parser.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_parser.c b/drivers/media/platform/qcom/venus/hfi_parser.c
> index 6cf74b2..9d6ba22 100644
> --- a/drivers/media/platform/qcom/venus/hfi_parser.c
> +++ b/drivers/media/platform/qcom/venus/hfi_parser.c
> @@ -86,6 +86,9 @@ static void fill_profile_level(struct hfi_plat_caps *cap, const void *data,
>   {
>   	const struct hfi_profile_level *pl = data;
>   
> +	if (cap->num_pl + num >= HFI_MAX_PROFILE_COUNT)
> +		return;
> +
>   	memcpy(&cap->pl[cap->num_pl], pl, num * sizeof(*pl));
>   	cap->num_pl += num;
>   }

Why append and discard though ?

Couldn't we reset/reinitalise the relevant indexes in hfi_sys_init_done() ?

Can subsequent notifications from the firmware give a new capability set 
? Presumably not.

IMO though instead of throwing away the new data, we should throw away 
the old data, no ?

---
bod
