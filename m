Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBBE7984BB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 11:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242076AbjIHJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbjIHJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 05:21:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46819B0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 02:21:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52eed139ec2so790302a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 02:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694164903; x=1694769703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+t4XGXne8eyrgNgv4aLe9v9k8kUrW4rRZ8o7Qd75n90=;
        b=joSXIzBFEMm7AKMvPtpVwvT4XdFy+0IazWPp49EAPN2HwTpRiIS8AuJw+ca+rcI8MZ
         ikTKZxpUi59xNZCwQv39eQxkrSYatM32Klp1f82HrZg6D0+SXHF2kxIZ028KhuTTdCFW
         8UuHLSblJy7hiL1KeikBpiwqtOmSLDhIisrIejbkThKYgUUrULfg7sQF1eTO+pD1l2PV
         wk9rGkEPIlJtygQZ9m1G1z35Pm5bhQho/74P4NnEw7vo8lYy9jJ/huDfjc2nnu4akAK4
         oSJqQzxiOooQf8l+oZSj+qFLbNFYnYlbQFmmoQxCOGfqFoh95qbSjQj2wdSXO06wnyfS
         Lozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694164903; x=1694769703;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+t4XGXne8eyrgNgv4aLe9v9k8kUrW4rRZ8o7Qd75n90=;
        b=xL1oGb3MnK5VSZpbu80cpy3MHmhJHYptHfSdKSGykF/wJRAwflx80G+0pRvS8DulHb
         DwZPPsMDp6a8/THONb5ss+oGpehWNQtvetiUDs78Q4MxgA110WzdgEKM8PcNvs52l/jP
         /EKj63EdAcsphd6PKIxcgrmCN5yje12Utdf2DWhegLAGaHP78O1wwmwsDYVGPmX0BnZv
         TL3KM96PJ9O5fbC9Afq5HBEs2P14oISssIfU4LcUnfQJdTqsB3Pc2N01i9nB06g/kSyC
         JqcmW2IM15BXO6zTeNjoDbr73QGKulku2wuvgFtyJ8w3Qr8W7ZplzNjXS+1ya+Cmi8s1
         1I3Q==
X-Gm-Message-State: AOJu0YzS02Yst5fNmXEVIWEXSVeuLDRhF3T9+RdzVNqTEaI4Vc1RhPCQ
        Pw7C3fjDSGwagUN9pMiQEa0ikQ==
X-Google-Smtp-Source: AGHT+IHRH/NXG6vD5wH5kstbMaMlUumZsAyEMHQ60OJncOJzJ+U/toGziZwcoA22vBDP8NdSzTOOHQ==
X-Received: by 2002:a17:907:7885:b0:992:c8d7:b66f with SMTP id ku5-20020a170907788500b00992c8d7b66fmr1456299ejc.75.1694164902870;
        Fri, 08 Sep 2023 02:21:42 -0700 (PDT)
Received: from [192.168.37.45] (178235177197.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.197])
        by smtp.gmail.com with ESMTPSA id t14-20020a1709064f0e00b0099e05fb8f95sm765507eju.137.2023.09.08.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 02:21:42 -0700 (PDT)
Message-ID: <6ea97401-34da-403c-a05d-e3bd7f891068@linaro.org>
Date:   Fri, 8 Sep 2023 11:21:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/17] media: qcom: camss: Functionally decompose
 CSIPHY clock lookups
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, rfoss@kernel.org,
        todor.too@gmail.com, agross@kernel.org, andersson@kernel.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230907164410.36651-1-bryan.odonoghue@linaro.org>
 <20230907164410.36651-13-bryan.odonoghue@linaro.org>
 <b2639cdc-30a7-4caa-b6c7-05ea2f3c0fd2@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <b2639cdc-30a7-4caa-b6c7-05ea2f3c0fd2@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.09.2023 11:20, Konrad Dybcio wrote:
> On 7.09.2023 18:44, Bryan O'Donoghue wrote:
>> The csiphyX_timer and csiX_phy values need not be hard-coded. We can
>> functionally decompose the string matching inside of a loop.
>>
>> Static string values are brittle, difficult to extend and not required
>> anyway since the camss->res->csiphy_num value informs us of the number
>> of CSIPHYs and hence the set of potential clocks for a given CSIPHY.
>>
>> In simple terms if we have five CSIPHYs we can have no more and no less
>> than five csiphy_timer clocks. Similarly csi_phy core clocks have a 1:1
>> relationship with the PHY they clock.
>>
>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> ---
> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
Actually, well, I'm not sure about the breaks inside..

Konrad
