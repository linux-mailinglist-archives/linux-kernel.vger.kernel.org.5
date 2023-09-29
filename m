Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68AF7B3385
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbjI2N0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbjI2N0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:26:09 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE2A139
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:26:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adb9fa7200so150824066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695993966; x=1696598766; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RU+nGBxPHmO+YMgDRXpz23ytpIb5xFuGx0xQN0oYtCA=;
        b=qKXkGu/rA1llhGxBniJuo/rGF54DeHNh6kyKpWZmYiy6wyFCWnyh05lmOwfHrr5vqK
         T13sv/tGjZilpg/x67IZfnnALkbJdp1KS4rOL4KMsasMzRj9caqTJTMb+JxzEQlqT+0E
         YR1L4giF9Yepan2sFU61PvZCF2yYTihE0bNJo5TuPIYYII3nrBDMcKrOyvHueETf46K/
         ydn7HtSdHgHt0zPciJ5jJZijmx8pCamSnNAgAc/LYgGPmBr74s5cLc5472bJFEybRFW+
         PwDggl5X04vXJdCneCRyd4U+mSDZO6kONT3xnUfooBoQC8BQy7dXLh7H3MgXDPuBZgz0
         K6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695993966; x=1696598766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RU+nGBxPHmO+YMgDRXpz23ytpIb5xFuGx0xQN0oYtCA=;
        b=D8Jejx5OIgX4b5T82cbbFCheHVBJd2ZyBqcwWPFW8hUC2NYE2d/KKacg4eoNy49kc9
         8ZIl71KKzSHVeAZUXRIWf1wGa3sMD2IMefRxPK5EA8p1PrxrqeBNRH+G/bUbXB9KjxT+
         mFUohVvEyVcGHXt1lJ9ytLg/OrdEp2Nul9OPd0SG3fxQMJoBqYMOadE5vMiof2iGZQhl
         axiZS9y6GoisMlbgatmxkB2C5wjIhe1s2QEhss1kTkNhmOPmeNHHh00TbafiwzuyVSLr
         as9TjcS1gG6P4gDmfUZvtjVBYMhTRzEsPUMGIaKsIbHV5cW8NniosltKnsnCXZOiFGVW
         x/rA==
X-Gm-Message-State: AOJu0Yy4YrnHnme5DAOF581+3AvyW8jtVVu1L+nlYxoUxC0nKBCGNdoK
        zy9E1+n8/CUB1HZxmNQZ+IY8iw==
X-Google-Smtp-Source: AGHT+IHyYZ73egSBweUZ8ehMhZFpqK94+RpftDUfd4mbYz368Z/GKqdpJr+rjN+iLcM1tMDo+mnWrQ==
X-Received: by 2002:a17:907:7b8f:b0:9ae:5a56:be32 with SMTP id ne15-20020a1709077b8f00b009ae5a56be32mr4249912ejc.38.1695993966418;
        Fri, 29 Sep 2023 06:26:06 -0700 (PDT)
Received: from [192.168.0.123] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b009a193a5acffsm12220458ejk.121.2023.09.29.06.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 06:26:06 -0700 (PDT)
Message-ID: <ed61f6a1-a21d-cc23-b995-7692a2e8530a@linaro.org>
Date:   Fri, 29 Sep 2023 15:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 3/4] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 IDP board
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mani@kernel.org, alim.akhtar@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
 <20230929131936.29421-4-quic_nitirawa@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230929131936.29421-4-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 15:19, Nitin Rawat wrote:
> Add UFS host controller and PHY nodes for sc7280 IDP board.
> 
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
I did not add these tags to this patch, drop them.

Konrad
