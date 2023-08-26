Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA77895AA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjHZJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjHZJ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:57:40 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD35C9D
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:57:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so24980581fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693043856; x=1693648656;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aua3gYWkAMWJVQyBmIfnLUGEni4FpTIcr8CUf3I7br8=;
        b=wxhHVISWturkYWnhJLkm2HclL9RtvdH2oHbk/m3KjyHYfVk/RcQS+004zyEGM2hdCA
         FZ6++DIE52BPaXph8RXd4EeRUZCjwgUzW7DEdCa1EsXTQfsVEM1jmCjgNv0fi8E3JDVS
         0xnPbL9ZfGU4rIUEkrZmI1fva1TlObm5sXY1sbny8syhvg+f7r/GvWp1/H+O99vpvyjp
         A9DXjxLo1evicS8+Ymj4A1oB4qOGd+5LxM8uBo1gcR7sY1IS27crbg/5u3lUeUoZTwlu
         e/zkdxXXr6KfgfWLna+1nk+yKmGEIvBTgQBPMpBPEnNe+lkiOmmpIKTUBm+h2xgwutrw
         VjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693043856; x=1693648656;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aua3gYWkAMWJVQyBmIfnLUGEni4FpTIcr8CUf3I7br8=;
        b=WZCXE8qVF9Pt1VV+lyA/GWdFD3YdEA22VnG2y3a+FTYiN20GeY7NuWwSAkKoIcije8
         cc29WXJTJpPzoksr20ufNGKAqD126Ig2+Xjj3C/LMB4SanUROIVLIxX3+BAcJLdwvRqs
         oDVwTYL7O7ibSg5F5eyaeUgZfMxdvs5AxEaTEMeBOCchxsJ0Z9pmZ7LW9O0SixFW1AKn
         YBjC6wM8n1Rgiy/Ze5hGLTE8p0LnosGYLVV6YzdKNw0I5O3vdMr4caBaQNhvhlDqioSs
         S6YDSCyxkEtgkwhtR/Ffc+M3K+7IolACMRr6xEVtBQ3HWick1tiz2cvS7O/MIcgPSWnX
         adMg==
X-Gm-Message-State: AOJu0YxNTYVxmExb9aAz2i6UcYa4GxWBnZofO+khKS6gwdue+tNvlZ+t
        +teYqqymDyszS/kjzWeNY1KoOQ==
X-Google-Smtp-Source: AGHT+IHUlsI+c52x3kPtVY3Hzm2nRP68e0I1M7ZcRbEB8udHaYL/9QsQgU42poi0rFc9WI+fxfCNKQ==
X-Received: by 2002:a2e:3607:0:b0:2bb:9fcf:6f64 with SMTP id d7-20020a2e3607000000b002bb9fcf6f64mr15601874lja.28.1693043855971;
        Sat, 26 Aug 2023 02:57:35 -0700 (PDT)
Received: from [192.168.1.101] (abyl74.neoplus.adsl.tpnet.pl. [83.9.31.74])
        by smtp.gmail.com with ESMTPSA id d5-20020a2e8905000000b002b6e77e87fcsm701986lji.68.2023.08.26.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Aug 2023 02:57:35 -0700 (PDT)
Message-ID: <5b53b622-79fe-4249-8309-7e72eec687f0@linaro.org>
Date:   Sat, 26 Aug 2023 11:57:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] media: qcom: camss: Pass remainder of variables
 as resources
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-5-bryan.odonoghue@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230823104444.1954663-5-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.2023 12:44, Bryan O'Donoghue wrote:
> The following variables are being assigned statically based on
> compatible strings in the probe path.
> 
> * enum camss_version version;
> * int csiphy_num;
> * int csid_num;
> * int vfe_num;
> * int vfe_lite_num;
> * int vfe_total_num;
> 
> Migrate those variables to resource parameters passed in on platform
> probe arguments. The one caveat is for VFE it has been necessary to
> intoduce a new variable vfe_total_num to capture the aggregate value of
> vfe_num + vfe_lite_num.
> 
> All the rest of the changes are rote camss->variable to
> camss->res->variable with the parameter tables now populating the listed
> variables.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
I don't see anything immediately wrong. This was long necessary!

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
