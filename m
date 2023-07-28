Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75AA7673F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjG1RxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjG1RxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:53:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026A73588
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:52:56 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fcd615d7d6so4026860e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690566774; x=1691171574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SL9ORKV7EqBhOElFVd5vnXP5HIc4kBpa3/e5CVa3AcI=;
        b=pqFdhBqFxV1vXMvtxKLGxGxna95F1EiQl9DfW5vPWfjygSsGAPJVhk/KnTZ6XknLRX
         4wuQTBAqBwSmD+yZD1feRNTbJkPrZP+uRmAPJioI+LQ4VnezuvhnI9bJqgi8mgPbxbcb
         pn3aUKhv94/LRzp6AdJP6Oq28Oj2VssSCrIalB50p1ADeC7mrLr2J/Rp2kAqstsjhvEq
         ovJoLW2L9Nss1Z1Q3ACWF4x75jn4Kt9G5GKQIwvJDbWvktlYqyr8oZPOKNc59p644fYC
         tMnG/Obj3S/m+EfIO3pAsMfFkG/5REqXFem0cxQ7WTy33D6WEremM0krEIaIiTNH4GLX
         dK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566774; x=1691171574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL9ORKV7EqBhOElFVd5vnXP5HIc4kBpa3/e5CVa3AcI=;
        b=KCiJSjJ5vguarBIsQA0qZj8GaB1H824i0Yo7jA8EXL/TlJhzyKSTmzfhIbWziJLp1c
         VftwYNgyoKLObGYjQQb80G0ys1dFKMf/4BKLflvE8yg2ckUbDuclBE4RT5aLFtuWlrT/
         v6WFyX5rvw8NxvzVLHPM/eGdSuKsng61wwhCHGWTVmg2lCRbeMzObGRYzimlHZyYBiZw
         6KapvyYH/nxgmjey/2oHIQYM3ygdonZpe5XRXGiTDM6cIiTSru01xMxo1dtWGfw4y/KX
         pO6fFYEAaOodLJ/TvjgjHA85iRc58IZ9ipEh8BcedfYdgFZHu3xAgoEeD/8Sx8it0Dt3
         fikQ==
X-Gm-Message-State: ABy/qLain/FF4bcK1rGD6Bd62/9jcUcCqRXGUXUVz78zD9VPbISK/ny4
        8sI1LcVcBu4ekKeOmNcFMabqqQ==
X-Google-Smtp-Source: APBJJlFGl6dMuVGyqR+QXnIAMlLI6igrXS/52DnF0PKtWsKYAVFtQO+cRwB9qSKji1k4xApHlFoDSw==
X-Received: by 2002:a19:e05b:0:b0:4ef:ed49:fcc2 with SMTP id g27-20020a19e05b000000b004efed49fcc2mr2127957lfj.26.1690566774123;
        Fri, 28 Jul 2023 10:52:54 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id z5-20020ac25de5000000b004fdc8e52ddasm911957lfq.129.2023.07.28.10.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:52:53 -0700 (PDT)
Message-ID: <60271d41-7807-0808-34d0-684ab9e81a90@linaro.org>
Date:   Fri, 28 Jul 2023 19:52:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/33] iris: vidc: add helpers for state management
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-15-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-15-git-send-email-quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.2023 15:23, Vikash Garodia wrote:
> This implements the functions to handle different core
> and instance state transitions.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
[...]

> +enum msm_vidc_core_sub_state {
> +	CORE_SUBSTATE_NONE                   = 0x0,
> +	CORE_SUBSTATE_POWER_ENABLE           = BIT(0),
> +	CORE_SUBSTATE_GDSC_HANDOFF           = BIT(1),
> +	CORE_SUBSTATE_PM_SUSPEND             = BIT(2),
> +	CORE_SUBSTATE_FW_PWR_CTRL            = BIT(3),
> +	CORE_SUBSTATE_PAGE_FAULT             = BIT(4),
> +	CORE_SUBSTATE_CPU_WATCHDOG           = BIT(5),
> +	CORE_SUBSTATE_VIDEO_UNRESPONSIVE     = BIT(6),
> +	CORE_SUBSTATE_MAX                    = BIT(7),
Why store it in an enum if they're not consecutive? You can make them
preprocessor #defines.

> +};
> +
> +enum msm_vidc_core_event_type {
> +	CORE_EVENT_NONE                      = BIT(0),
> +	CORE_EVENT_UPDATE_SUB_STATE          = BIT(1),
> +};
Ditto (even though techinically they're consecutive)

> +
> +enum msm_vidc_state {
> +	MSM_VIDC_OPEN,
> +	MSM_VIDC_INPUT_STREAMING,
> +	MSM_VIDC_OUTPUT_STREAMING,
> +	MSM_VIDC_STREAMING,
> +	MSM_VIDC_CLOSE,
> +	MSM_VIDC_ERROR,
> +};
> +
> +#define MSM_VIDC_SUB_STATE_NONE          0
> +#define MSM_VIDC_MAX_SUB_STATES          6
> +/*
> + * max value of inst->sub_state if all
> + * the 6 valid bits are set i.e 111111==>63
> + */
> +#define MSM_VIDC_MAX_SUB_STATE_VALUE     ((1 << MSM_VIDC_MAX_SUB_STATES) - 1)
> +
> +enum msm_vidc_sub_state {
> +	MSM_VIDC_DRAIN                     = BIT(0),
> +	MSM_VIDC_DRC                       = BIT(1),
> +	MSM_VIDC_DRAIN_LAST_BUFFER         = BIT(2),
> +	MSM_VIDC_DRC_LAST_BUFFER           = BIT(3),
> +	MSM_VIDC_INPUT_PAUSE               = BIT(4),
> +	MSM_VIDC_OUTPUT_PAUSE              = BIT(5),
Ditto

[...]

> +static int msm_vidc_core_init_wait_state(struct msm_vidc_core *core,
> +					 enum msm_vidc_core_event_type type,
> +					 struct msm_vidc_event_data *data)
> +{
> +	int rc = 0;
rc seems never assigned again, good to drop

[...]

> +
> +static int msm_vidc_core_init_state(struct msm_vidc_core *core,
> +				    enum msm_vidc_core_event_type type,
> +				    struct msm_vidc_event_data *data)
> +{
> +	int rc = 0;
Ditto

[...]

> +static int msm_vidc_core_error_state(struct msm_vidc_core *core,
> +				     enum msm_vidc_core_event_type type,
> +				     struct msm_vidc_event_data *data)
> +{
> +	int rc = 0;
Ditto

[...]

> +int msm_vidc_update_core_state(struct msm_vidc_core *core,
> +			       enum msm_vidc_core_state request_state, const char *func)
> +{
> +	struct msm_vidc_core_state_handle *state_handle = NULL;
> +	int rc = 0;
Ditto

[...]

> +int msm_vidc_change_core_state(struct msm_vidc_core *core,
> +			       enum msm_vidc_core_state request_state, const char *func)
> +{
> +	enum msm_vidc_allow allow;
> +	int rc = 0;
Ditto

[...]

> +bool is_state(struct msm_vidc_inst *inst, enum msm_vidc_state state)
> +{
> +	return inst->state == state;
> +}
> +
> +bool is_sub_state(struct msm_vidc_inst *inst, enum msm_vidc_sub_state sub_state)
> +{
> +	return (inst->sub_state & sub_state);
> +}
Why are there 2 separate funcs for core and inst? Don't we have
a pointer within one to the other?


[...]

> +
> +int msm_vidc_update_state(struct msm_vidc_inst *inst,
> +			  enum msm_vidc_state request_state, const char *func)
> +{
> +	struct msm_vidc_state_handle *state_handle = NULL;
> +	int rc = 0;
rc is unused

[...]

> +static int msm_vidc_set_sub_state(struct msm_vidc_inst *inst,
> +				  enum msm_vidc_sub_state sub_state, const char *func)
> +{
> +	char sub_state_name[MAX_NAME_LENGTH];
> +	int cnt, rc = 0;
ditto

Konrad
