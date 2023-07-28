Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17043766EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjG1NrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbjG1NrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:47:06 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B310FC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:47:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso3777388e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690552024; x=1691156824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8dCklzQySsgGrzbKRv6dYPHQ8ax4hciSo7gzwbtVmS4=;
        b=Y2xGrmUH8ayVKeTux80wB9vfJRlwCMjYfVv6QI1UqF8M51dTQUHVFMkNPT5lee+k8l
         Q3W+EY6xQ1S7mkoIXzuAZ3UFUdC/6qRZjXurqpuvVA4o+HYAruA5I6N0Ar+ieq9O87Gu
         Mb4Dd1mBw7k4Fo3DnGQe+KzBD1NgsD5nVqf8AFlPNPLrJHNHp6mAD5eDxc8pXZnXSy5c
         W3YZhyqXPMEEBqanXAZTHnBSfPc5K4gz9mN5YHAVvGefFylTHayC/6MQ8ggVuXA6glHs
         84W6ZKLynijNjYKQjcn3VKnmaMs9/Ohi67vOa9oVgvhAWY2V3v0BZrZR/D06cFNk3jK5
         KcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690552024; x=1691156824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8dCklzQySsgGrzbKRv6dYPHQ8ax4hciSo7gzwbtVmS4=;
        b=O4u2iJ92my4Qk1tGbyGQFCta4ikz5frxUYLv0QgaOGnJJ9uVio/tT4GOd7vv9gKy/Q
         tTSgU60hM0pJ8j9454XYLg3jTY03KWKjV2eRGqOxsSccxi/mFLpKarnN9GbA6BTJbnll
         MjtXlRd2xBQZNXFWkphONhPXuQwpLLF3sBM5gpBw3wUkTaMPHYLmn/3Dr3AGAiEkJS2N
         +OIVZ8iCuXgE/FnD9BQJMIJqjGxHG3lq1G054YcTBDbVVaBSVnd0VmcsO9kPZACJD9Fq
         yCQ3MBdSbgtcCR3SwYfM+8VyJbF6GwYexN8Gm4YBFAp+qIn6W26Mhx1OAtHqWkoOiWGW
         EwRw==
X-Gm-Message-State: ABy/qLa67ltHwo769FBkAWcaMJ0xxPEvA/NENft3fY/8kjE1TKf7mh01
        hQ4o0ozHiGms0lWPXGeP4+9EBQ==
X-Google-Smtp-Source: APBJJlEfaQwcQm+IhhjDckQiWkjiJsxMewy/fhRPPphwyTbSI0jahKtl/r6RWUbJz8IRN55sKuaBPA==
X-Received: by 2002:a05:6512:340d:b0:4fd:b223:92c with SMTP id i13-20020a056512340d00b004fdb223092cmr2333178lfr.60.1690552023840;
        Fri, 28 Jul 2023 06:47:03 -0700 (PDT)
Received: from [192.168.1.101] (abym224.neoplus.adsl.tpnet.pl. [83.9.32.224])
        by smtp.gmail.com with ESMTPSA id c2-20020ac24142000000b004fe142ecd61sm827648lfi.139.2023.07.28.06.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 06:47:03 -0700 (PDT)
Message-ID: <a36f31a6-2ecf-7b9b-31d2-5f11549d6fc9@linaro.org>
Date:   Fri, 28 Jul 2023 15:47:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, mchehab@kernel.org, hans.verkuil@cisco.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_dikshita@quicinc.com
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
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
> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
> 
> This implements the platform driver methods, file
> operations and v4l2 registration.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  .../platform/qcom/iris/vidc/src/msm_vidc_probe.c   | 660 +++++++++++++++++++++
Moreover, this code is never compiled.

Sending dead code is almost always wrong.

Konrad
