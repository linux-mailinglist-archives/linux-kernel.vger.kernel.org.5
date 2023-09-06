Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28977936CD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjIFIGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjIFIGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:06:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E593CF4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:06:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52e297c7c39so4011461a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 01:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693987577; x=1694592377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N6rX866dZWeyzbwrDmGLylNXIPdDEierfj+vUzSrXHo=;
        b=OpMftCNYvMQ+JX4HPuHRdIFb38miZd91DdOI3N/Ld6RtW2c/lv4p5MMNFcpzE7JccN
         qWQIu/LtmocXSUYM/4rBYjhULtYLL8yw/674zROjMM6y2cZ/JXIaEn3I5OqK0h0t34qI
         OMuyuH43IRou5PHTNrf64n5rF02DVYOoiW9Dhv12NECcj1NCOF1LZqX0/oL6IMjOIOHx
         juVjHVa/JGjVHf/goJjB/Vg6SogQO6caoZ5RZuWz4tkdxb/CGyZyibtVM+qjYkIbLQSu
         1c5seF0GQQP6KKhi1z4xZgp1j8V2RQijBYfq+hFlB3xH1csRBQzlhOrpug6POQnJx6VB
         lvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693987577; x=1694592377;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6rX866dZWeyzbwrDmGLylNXIPdDEierfj+vUzSrXHo=;
        b=Y6olIV+qR+BoF3I0uKAXENEImgF4wVzzk9Rr3Es0DWuyPagN74fInQuibqZsVBXC3g
         N0tU5yJlBFWfnOljwuXlHw73+eNgOEqSwtBFINczeHgIAfc6ZisVu9SAAqic65amJ0W2
         DyMNMAzvytL95R+Kc94os9Q4XfRklvmPbOKrWdbNfa4LcnqIKvaP56kkPt5tsozi90G1
         V1ZZ7ysweluuPjWK7m2HWM3LdepyTVmRTsHquMQImMrEcz7QEsiHBUlQ9UCC5tvM6vn8
         bG3ZLiZQHa52fNiKdJyIjvnVDJNDTx/h14QMpcytBuSTGcgQ1bIn6MeJ/zfHbmCsnZ1z
         SUKA==
X-Gm-Message-State: AOJu0YyqEsR+3fxEPAcGmsguopYmrR9wGKpxfJRehSts4v101OptcFRP
        nHh/G4blIWrMI5r8BKKx3MCzJQ==
X-Google-Smtp-Source: AGHT+IGAd+DD8OLZo0kvehoHFC2Eczx87NK8Bkhpv9Weu6nYexYG43coH+qot4a4ptKUU/3kIRogPA==
X-Received: by 2002:a17:906:cc4e:b0:9a2:292d:ea63 with SMTP id mm14-20020a170906cc4e00b009a2292dea63mr1488410ejb.37.1693987577410;
        Wed, 06 Sep 2023 01:06:17 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id h5-20020a1709062dc500b009a2235ed496sm8871288eji.141.2023.09.06.01.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 01:06:16 -0700 (PDT)
Message-ID: <9df52150-f18b-cebd-11a8-a1c9dece09f0@linaro.org>
Date:   Wed, 6 Sep 2023 10:06:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND 5/7] dt-bindings: mailbox: qcom: add one more clock
 provider for IPQ mailbox
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Devi Priya <quic_devipriy@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com>
 <20230904-gpll_cleanup-v1-5-de2c448f1188@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904-gpll_cleanup-v1-5-de2c448f1188@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 06:56, Kathiravan Thirumoorthy wrote:
> Mailbox controller present in the IPQ SoCs takes the GPLL0 clock also as
> an input. Document the same.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

