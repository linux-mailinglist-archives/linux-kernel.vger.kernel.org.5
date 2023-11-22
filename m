Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBF37F5109
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344369AbjKVUD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjKVUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:03:57 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D171B6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:03:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507cee17b00so116573e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700683432; x=1701288232; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Io/gjQ08AuDbFAY0fMf9d/V1TR/FZrGyaBoM54Wv8Dg=;
        b=zWD4RCs5NskLi+UE+EVMUMu5jlQmQP6K7m3XpDfIQRP9NeqpUhu6viK9B+ISp5I+tU
         Qa1WQeqaUAW7jUnw0MF2UtFseCh7VuYGVg1aRtRCth91d89TMmBFqk5KpLbkI150Vhaj
         Dp2uTS8UTXKcbXboZTj76d0rlpKT9qwQEp4VNNJHhpQOHSBN2yjqiJQQu+6DEg+pCPdb
         gfGKJTX+a/FugNyewoqDHBmORDQVT0El7r2ESZg3e5LaEFHPRnS4lsarmXRNlQDFWFA/
         n68REdwg91HJ7lZl+xNtnSBe0+9Pis5CUan4qyiKUOy2TsdHnrEzA7Am/zsPP5SxihmL
         7O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700683432; x=1701288232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Io/gjQ08AuDbFAY0fMf9d/V1TR/FZrGyaBoM54Wv8Dg=;
        b=Rjr6MzI4egnKrS29h704eHyFESno1gsAAMmbTVRwZLKFfwa6LmA4U6OcKjvZsqMLEF
         7dzlqz5bvyW0h1AuLlHN6f6k8/vhogRl46Sl6mmNIZgmtNPvhZUMoZKRupT7ZY7gvxVO
         PIZtGvFdV0tP9XDrldl+63hMsPrOyzB/wW0gRLBcJ2rJ20IhFjI9e0DJln+Y4EL9Bgqv
         /H5OdXV4XAo97cNtZ36xH8lr/3taNixAlenpWYTu/W/N1kbsVsiJsduYHJ3YQcYy8Ik7
         KREPTYyB6b+33w7RXsgDogj5y7nvumkzWR+QlxfPf7ujrrY6AbMrXVngm4wdNFLR304b
         jmFg==
X-Gm-Message-State: AOJu0YzEFPwHwI//yAhyrmJLsUXFMh5SVD05ssdvWYX3dOkI7wwvTUuX
        jhL0zQySW1kcSisqOAol0Y/G9g==
X-Google-Smtp-Source: AGHT+IHz/4Br/9+seo/Lrak4kInlCaTk0gNCYlhXMZj9w9gtMMfU7nZufobL54nVG+7FpfSZWSIVJg==
X-Received: by 2002:a19:c511:0:b0:509:e5a4:2af2 with SMTP id w17-20020a19c511000000b00509e5a42af2mr2294279lfe.49.1700683431515;
        Wed, 22 Nov 2023 12:03:51 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z15-20020ac2418f000000b005079ff02b36sm1932808lfh.131.2023.11.22.12.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:03:51 -0800 (PST)
Message-ID: <1bb81371-e829-4e02-a234-02f84433f4bf@linaro.org>
Date:   Wed, 22 Nov 2023 21:03:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] phy: qcom: qmp-ufs: Add SC7180 support
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>, hexdump0815@googlemail.com
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20231117201720.298422-1-davidwronek@gmail.com>
 <20231117201720.298422-6-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231117201720.298422-6-davidwronek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/17/23 21:08, David Wronek wrote:
> The SC7180 UFS PHY is identical to the one found on SM7150. Add a
> compatible for it.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
Should it not reuse the 7150 compatible as a fallback then?

Konrad
