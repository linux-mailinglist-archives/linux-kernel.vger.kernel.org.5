Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D778776968
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHIUBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHIUBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:01:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820A7D2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:01:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso2950581fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691611307; x=1692216107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ1eCCRsmpVHZrS4sKtqBMzcWmBsYroCWh79xqLVR1E=;
        b=YJovnMML6TndQtUyqCEzZyvehv6jNsQmsEF7U8GyBOtXa0iot6D9R3l1Na726bL0Y7
         paSVLKK844P//I6+0rX2QXYe4NNidXlHK/OajPBITlWxeBw4iaxUJhmpfAxSRNlr8XAq
         LOGpdrjQfyC7wt+RzN2Sk7KivCC+KMp969CxP5MARvJ9KTGWhBPWBW69gEHyrFbPPfk3
         vNK9+Gv1Q+RKwFf2hTfYmSi+C6U2nir6fmLwKG92+yjRsq9V+oWQ0AXFKvHyoDzekn/A
         lKpYHwHqkpCt4Fh9OHkKH3neKJaEUVcWpw8xo9jdIG3qjeNQ3ELN864kri5OrBJ9mCP1
         BcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691611307; x=1692216107;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ1eCCRsmpVHZrS4sKtqBMzcWmBsYroCWh79xqLVR1E=;
        b=fIX6hIRDi0gOOcoMR/TsAlYz2515BcOTSBvKeHkFR1siKLY51E2dNU2BD/Vv5LTLhi
         8Wt87qn3Ofd3jn/BnnjBRaqdQyiOjnRrES/wpH+WBZvdYuzpUVvLrzg1zEfLPHLFj7Nk
         RaH/TPXZcSyRyKCij44Dmuh1JXW7+6OuOj+a9sqrucmquj1aLtA5fMpEKAc0Rd6+Tch2
         hpaZBixcWbzWQCylKveQ2NfvwAwQ2Weo7zUpYNbfm9tlE3ZoRe2DcZ4F+bfyuaJ+6gck
         PgYgswAO5bgqDnHgQdBrJZj5+yJZ3MQY62SGVFNBNekGFSkQUReCJsPN1gUN5doBGnHr
         +NgQ==
X-Gm-Message-State: AOJu0YxTo5CT+F/W5QTC1KEV/PSV5FYxogTlnqQJTLbzDaXloDnx2w8Y
        AhiQPm5OF+n+8bw1k+gfC1lsSA==
X-Google-Smtp-Source: AGHT+IGcq1O1Od+Pz8nFE+WyuxFVXqKm3kdxHchi1rZJLDr/DAg8dEQC/PG/DjnEZap1rVkzSuHz8Q==
X-Received: by 2002:a2e:3c0f:0:b0:2b6:e12f:267 with SMTP id j15-20020a2e3c0f000000b002b6e12f0267mr180202lja.5.1691611306686;
        Wed, 09 Aug 2023 13:01:46 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id c19-20020a05651c015300b002b9358f5088sm2876186ljd.53.2023.08.09.13.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 13:01:46 -0700 (PDT)
Message-ID: <7d9ac1c6-be2d-4fd6-ba56-3976ec847274@linaro.org>
Date:   Wed, 9 Aug 2023 22:01:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] clk: qcom: Add ECPRICC driver support for QDU1000 and
 QRU1000
Content-Language: en-US
To:     Imran Shaik <quic_imrashai@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-4-quic_imrashai@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230808051407.647395-4-quic_imrashai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.08.2023 07:14, Imran Shaik wrote:
> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.
> 
> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
> ---
Please ensure inline hex is lowercase

No GDSCs in this clock controller?

Konrad
