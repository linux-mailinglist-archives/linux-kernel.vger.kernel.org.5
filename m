Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E646788ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjHYSgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjHYSgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:36:14 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB4210A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:36:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so18737651fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692988570; x=1693593370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLEWMSPoyDheV9aTWoheYwMz3Vo4cd285Ih/pF7lT2I=;
        b=pJQyhkVl8YcIipcJ9Pzn13f/51SIzHseZSrVHyxc/scyKp7w5fsxK3cIEPlHjeZrHt
         7ZHxrE1tArirkg5nPVfBjrKajoBefPz9yQoQU7YmcMTMdctl+jxM9qQG1qE3w7JUzqpd
         9C9oRpX6KCuD5AHYQOp1EkdHw28eBKFRSPcNNu/W4XikXdqZjC3Bucov4M9YlV7Jw6TS
         gCMhOKiV8lYDps6chtAYxjD63Ef33wB6O93grYOZxwsEdgFcc/X6vLbxn56egIBLPoi+
         fQfc2u4GWN8fSQieypYlVtMGYZwbmWbMEkdWfOkMOi1cg4fKsAa5t+VQIiPPuRE6AmlL
         Zkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692988570; x=1693593370;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLEWMSPoyDheV9aTWoheYwMz3Vo4cd285Ih/pF7lT2I=;
        b=IVeeQ/mM9xEQgJBUaIcO1tnCVD54u1TwQDMMFDIbpwj1Nha2yFVZNW9uTkYpBGxwry
         w0Nsfu2NC6/DBySw/o5xNFrCXxOqV5ojsB6kJk+AdeRmrglJ+s9N1Jk6bxdn6NgEZ5A8
         wDIubXkg9F1Cp0hEHzDGOYtpE1KN8HSgJhE1mjoqUIMPqfN3pX2zunAkTI7vDB1r3tQz
         IsMVHczuHVldESVZPxdcw/68Plpx6dXJzW8AS8WTNOfCSxf9HJyVXyLP1meUB6Px69/Q
         3paU560WpIRkYH7YwB30JxbrC95E6knst0qLIjhKoYp9PNZGo8Tiw71TXCgGz/YA3sP4
         lEPg==
X-Gm-Message-State: AOJu0YzCzSr3IJe2X2nZUDiK7JhUOOTXnx0M/H5sB5jUqiVR3/YsuP1P
        wuv/4gHEmjNkze95s+y01kw7cA==
X-Google-Smtp-Source: AGHT+IHR8jriiddvsNutBDC/1xD3vmu1DzeYiRUzYUGOZrKMh2tFjAv8dxJQY+RNx+WKq9/5jF2DQw==
X-Received: by 2002:a2e:3610:0:b0:2bc:dea8:ba75 with SMTP id d16-20020a2e3610000000b002bcdea8ba75mr6346933lja.26.1692988569683;
        Fri, 25 Aug 2023 11:36:09 -0700 (PDT)
Received: from [192.168.1.101] (abxh59.neoplus.adsl.tpnet.pl. [83.9.1.59])
        by smtp.gmail.com with ESMTPSA id n12-20020a2e878c000000b002b787442f03sm438279lji.88.2023.08.25.11.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 11:36:09 -0700 (PDT)
Message-ID: <cec27271-fe3f-44d2-83e5-3f96f1e50178@linaro.org>
Date:   Fri, 25 Aug 2023 20:36:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sdm845: cheza doesn't support LMh
 node
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        David Heidelberg <david@ixit.cz>
Cc:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230823222741.89584-1-david@ixit.cz>
 <20230823222741.89584-2-david@ixit.cz>
 <CAD=FV=WaW5jKwXDTvyXjy45PSWu8LoT0LxYKM_mZAH3LxZPwrQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAD=FV=WaW5jKwXDTvyXjy45PSWu8LoT0LxYKM_mZAH3LxZPwrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.2023 20:24, Doug Anderson wrote:
> Hi,
> 
> On Wed, Aug 23, 2023 at 3:28 PM David Heidelberg <david@ixit.cz> wrote:
>>
>> Cheza firmware doesn't allow controlling LMh from the operating system.
>>
>> Fixes: 36c6581214c4 ("arm64: dts: qcom: sdm845: Add support for LMh node")
>> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> index d86b0d112110..8cc8fc290fd3 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
>> @@ -143,6 +143,10 @@ panel_in_edp: endpoint {
>>         };
>>  };
>>
>> +&cpufreq_hw {
>> +       /delete-property/ interrupts-extended; /* reference to lmh_cluster[01] */
>> +};
>> +
>>  &psci {
>>         /delete-node/ power-domain-cpu0;
>>         /delete-node/ power-domain-cpu1;
>> @@ -275,6 +279,14 @@ &BIG_CPU_SLEEP_1
>>                            &CLUSTER_SLEEP_0>;
>>  };
>>
>> +&lmh_cluster0 {
>> +       status = "disabled";
>> +};
>> +
>> +&lmh_cluster1 {
>> +       status = "disabled";
>> +};
> 
> It's not a huge deal to me, but as I understand it usually you'd put
> the "disabled" in sdm845.dtsi and then it would be up to all the other
> sdm845 boards to mark this as "okay".
it's more of a status = "nonstandardfirmware" :/

> 
> 
>>  /*
>>   * Reserved memory changes
>>   *
>> @@ -338,6 +350,8 @@ flash@0 {
>>
>>
>>  &apps_rsc {
>> +       /delete-property/ power-domains;
>> +
> 
> Is the deletion of the "power-domains" here related to LMh? That seems
> like it was added to sdm845.dtsi in a separate commit that doesn't
> talk about LMh at all...
psci

