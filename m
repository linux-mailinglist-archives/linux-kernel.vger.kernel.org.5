Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4F27673A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 19:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbjG1RlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjG1RlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 13:41:20 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5673A9A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:41:18 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso3947485e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690566077; x=1691170877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVWjcXDl51I+C9UlnxCYGcAWrlhLisPeGOSprqX5qlI=;
        b=yFySC/3xshuUNJw99b2CECHNYFBnjDLGeJDVlmDglxYcDHWRk+zN6AhheVvGHkMe0x
         nZW2rdGH5fZcTZJu9G3RWGHy8/Chrx917YLctxwl4kC67DVsUrT0Nqi/YtWAKgJeeMjp
         FnCILrkWg8AfQDMEHaMC6/n1SC1jERlmW+8oP5bzQPahZbq4sN+8rARdQBmleEsm7Jbc
         p+Pvif3dmSWDcgsshGNZPjv4Ghd+0EM36E60IR7eGIk+RsX/4+fD8LD8zOQ02zzJuc4o
         DdD1PEW3dvbCH8msshQmzK7MRCcC2ISiuVaL3kOBp/V7rS59ruYNr4nZwoA8/bEpqmQR
         PX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690566077; x=1691170877;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVWjcXDl51I+C9UlnxCYGcAWrlhLisPeGOSprqX5qlI=;
        b=OdzXeuvsnsw5lb7t4ilDk68L//TBP31o4tIby2A9OSh3WdNa/QJDhlufb5klkc5HM7
         X4hj8sob8Qo5mgQVBcfvafEUZN3NXXNLx68W7PEv5CzBuVThX7IupVpJSPgIZGCsOPiW
         QKXePeUB0VB2Y49FrPWVkrGajtjmJ+irBOAbNv4fRr5lU7nHuROMXSDXNiE36yEsi4Mg
         AzXAeX9jzRBtYqHe5B7egnUUgdS8eJeTigUN+eytWPbzgV09eyPn/2oBvBG2oFgdlh0Y
         dkSt1OE0Rl2zVyk3QmzV09l5GFS45q0UETZZQPy+2zRjr6nJHQSPFzK03k3t5/vKEnOm
         YI4Q==
X-Gm-Message-State: ABy/qLbYIc5fi/dpSQomleIHqz3zo1jYZ5KhMsg4ZyH62b60x3NjYh8v
        N813U0NS4r2yI+wN3yx1VF/Fug==
X-Google-Smtp-Source: APBJJlGEsdtEwWWJfacVcGi+Dsqd2b+jGFfvJ4z/rc3dtCIIxrqGuwRCY+tS+E4GlzN+3ut+SY007A==
X-Received: by 2002:a05:6512:3d88:b0:4fe:18be:ef37 with SMTP id k8-20020a0565123d8800b004fe18beef37mr2678219lfv.61.1690566076947;
        Fri, 28 Jul 2023 10:41:16 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25299000000b004fbb1f7352csm888982lfm.72.2023.07.28.10.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 10:41:16 -0700 (PDT)
Message-ID: <7a727add-6aa6-fe3d-b2bd-7e0bd2f93579@linaro.org>
Date:   Fri, 28 Jul 2023 19:41:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/33] iris: vidc: add helper functions
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-11-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-11-git-send-email-quic_vgarodia@quicinc.com>
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
> This implements common helper functions for v4l2 to vidc and
> vice versa conversion for different enums.
> Add helpers for state checks, buffer management, locks etc.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
[...]

> +
> +#define is_odd(val) ((val) % 2 == 1)
> +#define in_range(val, min, max) (((min) <= (val)) && ((val) <= (max)))
> +#define COUNT_BITS(a, out) {       \
hweight.* functions?

[...]

> +
> +const char *cap_name(enum msm_vidc_inst_capability_type cap_id)
> +{
> +	const char *name = "UNKNOWN CAP";
Perhaps it'd be worth to include the unknown cap id here

> +
> +	if (cap_id >= ARRAY_SIZE(cap_name_arr))
> +		goto exit;
> +
> +	name = cap_name_arr[cap_id];
> +
> +exit:
> +	return name;
> +}
[...]

> +
> +const char *buf_name(enum msm_vidc_buffer_type type)
> +{
> +	const char *name = "UNKNOWN BUF";
Similarly here

> +
> +	if (type >= ARRAY_SIZE(buf_type_name_arr))
> +		goto exit;
> +
> +	name = buf_type_name_arr[type];
> +
> +exit:
> +	return name;
> +}
[...]

> +const char *v4l2_type_name(u32 port)
> +{
> +	switch (port) {
switch-case seems a bit excessive here.

> +	case INPUT_MPLANE:      return "INPUT";
> +	case OUTPUT_MPLANE:     return "OUTPUT";
> +	}
> +
> +	return "UNKNOWN";
> +}
[...]

There's some more stuff I'd comment on, but 4500 lines in a single patch
is way too much to logically follow.

Couple more style suggestions:
- use Reverse-Christmas-tree sorting for variable declarations
- some oneliner functions could possibly become preprocessor macros
- when printing giant debug messages, you may want to use loops
- make sure your indentation is in order, 100 chars per line is
  totally fine
- generally inline magic hex values are discouraged, but if they're
  necessary, the hex should be lowercase

Konrad
