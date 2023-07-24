Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161DF75EEC7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 11:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGXJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 05:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjGXJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 05:12:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C70187
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:12:36 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-993d1f899d7so727243766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690189954; x=1690794754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fh4EDpkUKXX0i2jSGB1PBtJy0KS6P9QG8sx5m74zofM=;
        b=k7sd9ry9f7KEkVokM1xv+AAbCPIUgxP9XVqzO2oMvoiFvG/KjABl32DheQa3U+CUC4
         FiNKfOU4mjEp9GJcI0Im9xwYFtPAIZbXJzoxBZ/rr6RF5MlQJ0kJAVrUTUTeDxI9XkQy
         qWGaACOxgXzHWqRKbhJnXkE+kOdZMIe41i0vCaZUNjm760cbJH+6w5Ty3z/OHyDLnvEN
         0EPDsV6gNixv/DBpu2SVDzffU4PrMSt6DhSna0c1zR0eAOASjDQZI/BWq7g2AcuTy7jr
         2bgX4+HoikeVPH6/aaWveSXFCU0WTMON9pJ61shYVBFC1X5Oxw9lu+khduMMptAw9RbC
         lGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189954; x=1690794754;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh4EDpkUKXX0i2jSGB1PBtJy0KS6P9QG8sx5m74zofM=;
        b=LYnF8vchv3MwQin3r5rvKnt2qH+ht2h0fMzGFxN3/wRjTwRRlUgxsw+wom950+6I0k
         /KR22Rw2BbyFpke6zaZEF92qY1Saz7k6gb0/Sm3rJrHku9CunvDTLy4QSh+TBIshrEPQ
         2MkRNDaMI6MM5Eq5bFkG+pf5LLMtBUAFMWJwjJzTLmzrrRqRYS0e/tmRlVABE8KMvdfe
         aw+V0M2DS2IIbijZBDmmDrHbO8FjV+0FY86Fn5S78N8NnFIFwxGmMo9vbKzRKDntIix8
         T+JAo70kT/2325e5hajEwnikIgOwVmoOua1Z6bUnPWlbqWEm9sPnhMoD+z9fbgvq7vmH
         zn9A==
X-Gm-Message-State: ABy/qLY/YfGrQde0tzN4ndqdCZ1yH+GPkLvByC2jJwI/k9TElMd2g9RL
        m8ZZ3tweuVVo0cmHMXOZxBfnFg==
X-Google-Smtp-Source: APBJJlFyiqbyrtae4oPoU8c9essn66hxwhB/tZ54efWazcZSBJL34UATeiWbByL1xXKVtIQgz5XF7Q==
X-Received: by 2002:a17:906:64d2:b0:993:d6a7:13b with SMTP id p18-20020a17090664d200b00993d6a7013bmr10019595ejn.22.1690189954456;
        Mon, 24 Jul 2023 02:12:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906254f00b00992d122af63sm6445656ejb.89.2023.07.24.02.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 02:12:33 -0700 (PDT)
Message-ID: <4d8143bc-03db-4f6b-9833-44cbaf95ecac@linaro.org>
Date:   Mon, 24 Jul 2023 11:12:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
 <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Content-Language: en-US
In-Reply-To: <c52ee94f-f60b-f8f0-f93c-221beec0224a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 11:05, Krzysztof Kozlowski wrote:
> On 27/06/2023 18:24, Konrad Dybcio wrote:
>> The description of reg[1] says that register is optional. Adjust
>> minItems to make it truly optional.
>>
>> Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
> 
> This patch does not make sense. It wasn't also tested. The code
> (minItems) is already there.


What's more - there is no such commit as 12f40018b6a9!

Bjorn,
You might find this useful (fake Fixes tag should be detected):
https://github.com/krzk/tools/blob/master/linux/git-hooks-post-commit

Best regards,
Krzysztof

