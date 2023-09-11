Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97379AD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbjIKUz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236594AbjIKLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:02:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418FECE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:02:34 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so6967930e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694430152; x=1695034952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IeK6HQWOkE6erW/8t8XvbP/nXkU1GU8xBhJ8mesdBUw=;
        b=MWQoaKSNNKbir7N9+SzvDmj2SFq6UAe42uI1SAjtnda44Z9mmSnCJwr2Rktw77xcn1
         i69EnN8jP3N6VGXk1WdT0uXYGxFpN5E4es2KeZj7OygHMh3JrHlu/9t8EvFtFLxDEKN1
         9Va8bIBXyWG1Tyte3CKxHhiT+UxH0LTndXcz5Gzpg0mnGBIJ4AcCWUH4YYBmqYUF6MbP
         FTDIu0vG3+VhxVP+FFhot94pnnhsfTnJuZxraeLHaBSakr+eiomuw4wFLRH0vFlA66UE
         gcFr/BCvD8xHD2nXVMPBYicQU69chSnP+f5BxsKI+tKGa9t+JoiDQ24skodTUaauKb+6
         C3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694430152; x=1695034952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IeK6HQWOkE6erW/8t8XvbP/nXkU1GU8xBhJ8mesdBUw=;
        b=WfXL0mQD2UomPy6rFED2Bv1Z9/XhKFdvQ7d+GITHva8mUGGujQYPQ3PcVaQ8EU9ozB
         rtXt3WQH5trs/fpW1AodSUbHPFn8PmqaFSD/8LusjxTBBdZYNsyCGaFO7Pdch4mmMN/f
         Vwf2rDXVlIYh07unybU/m5ZrOq27vfV/GBzjcxOg2Bd7iaoSdb9kdFGHaMOHcTAns98j
         8I5+zrrB05BUP3EjZoqLPF8hyMKnFGlUzx76gZsULTnujTq03+Lk2h0neCyS0pHztfKR
         jpLDJXNE/iqzZPmsnFmZva1XGOIZIuNNkZZqL0MV6UOP0wJcIJ7KrLUlcLQbFCoFyX29
         2RYw==
X-Gm-Message-State: AOJu0Yy14gsG2+Iyu6tLFPanw/LL8EdQ3ZZiEYRp16seCz9OphYzmngL
        pw9LGdJ7IeODDyOvPo1fsuHr/w==
X-Google-Smtp-Source: AGHT+IEKKrXTCBCABNJdmP3x5+smqQBfXEnldaNpLWrHhAXFPqtMZ9mgYBI5HztaY0OQCZFgFLOtDg==
X-Received: by 2002:ac2:5bc8:0:b0:4fe:15b5:a5f9 with SMTP id u8-20020ac25bc8000000b004fe15b5a5f9mr6933428lfn.54.1694430152499;
        Mon, 11 Sep 2023 04:02:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id pk24-20020a170906d7b800b0098d2d219649sm5250690ejb.174.2023.09.11.04.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 04:02:31 -0700 (PDT)
Message-ID: <e833b9c1-23e3-f8ad-feec-000c053bd020@linaro.org>
Date:   Mon, 11 Sep 2023 13:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [REBASE PATCH v5 01/17] docs: qcom: Add qualcomm minidump guide
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
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-2-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1694429639-21484-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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

On 11/09/2023 12:53, Mukesh Ojha wrote:
> Add the qualcomm minidump guide for the users which tries to cover
> the dependency, API use and the way to test and collect minidump
> on Qualcomm supported SoCs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

Please let us review your previous patch before sending new versions or
resends or rebases.

Best regards,
Krzysztof

