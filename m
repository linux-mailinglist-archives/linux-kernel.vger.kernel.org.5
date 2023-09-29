Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356797B3392
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbjI2N2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjI2N17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:27:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6C1AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:27:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99de884ad25so1900252966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695994074; x=1696598874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RR4iyWCnxxiTXwK+vJVjfTwNi467Lc8/0G6NTNSWVB0=;
        b=IWSpDQt5ZerILotY2LCgGMHfGcidH514RvuZ37mI0J7ymSoXo3/9U1DAxrZnl0Ang5
         mmzigvtU5Alx+b9wvr+VAVWIZYtLzWnIs96MNk+xsdIrv6YDp9NSOiEFq05ndeU8AAFM
         Dcaz8y5pVICB2kWXAmVCfURIK8E3mwcR4OXckIe1ckVJmSrf9SmdsmghKYLIVQRpJ/AH
         WL9OVkEX2kzt2UcTzIVJw/8n6bFjhqVDKhvMW6km7CP4/5k6hKITv2L0UITAi0TJjQob
         jZKXt9ZmsBQ8dHtsKeA5mZ958NtyFrXP+w1P4OmxuBaMdj7cCQw8CGwNiL6HFcxPkQLi
         3C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695994074; x=1696598874;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR4iyWCnxxiTXwK+vJVjfTwNi467Lc8/0G6NTNSWVB0=;
        b=lgPzmrUh3U0TEFox3cd7hgY7mvhjd/2N/coRwTzwJbMJ5Fm7oQAl+l9SuvH7PeteYX
         PS6ccMskT1CJ6q76ykEpxy08aKhz35rX85lpiMhQERYarHGjOIznO2xlmcdkNjpp8g93
         78lvMadOpaehau3hDcX4hzSBr1cRykBNjLHhYoQ5DJkIXWiEL0c3d8DKNVRyq/Y4mbSN
         le/W/8GDY/O9qJk/6+53hVfX8ornVru3lEnDenCrI/9q5RLwMYntJVsKm51qo+4VA1AH
         CX6Dii5BsxVFGlvKIkjHEZyL14J9s89P9HopenH+yG41D/LfVD2JYk/bFOoZow9jIra6
         cRhw==
X-Gm-Message-State: AOJu0Yw17S9GEkqS1AKhuryOQigYptlN1rW+MenxMcU/UoAFjk5WQ3Ua
        CVCL5BoQY4TP6f5zrUfq1mea/A==
X-Google-Smtp-Source: AGHT+IFLyGaiTMrR/ocztQjw9LLZesCasMqbpd1yQIMKHkXVtKlcB84ep632aGhUJa3c+jjPh7ZHYg==
X-Received: by 2002:a17:906:20dd:b0:9ae:729c:f647 with SMTP id c29-20020a17090620dd00b009ae729cf647mr3368023ejc.77.1695994074437;
        Fri, 29 Sep 2023 06:27:54 -0700 (PDT)
Received: from [192.168.0.123] (178235177217.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.217])
        by smtp.gmail.com with ESMTPSA id dt18-20020a170906b79200b0099bcf9c2ec6sm12351420ejb.75.2023.09.29.06.27.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 06:27:54 -0700 (PDT)
Message-ID: <11b9d087-4668-e3a7-cae4-95b810fa64d1@linaro.org>
Date:   Fri, 29 Sep 2023 15:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 0/4] Add UFS host controller and Phy nodes for sc7280
Content-Language: en-US
To:     Nitin Rawat <quic_nitirawa@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, mani@kernel.org, alim.akhtar@samsung.com,
        bvanassche@acm.org, avri.altman@wdc.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        cros-qcom-dts-watchers@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230929131936.29421-1-quic_nitirawa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/23 15:19, Nitin Rawat wrote:
> This patch adds UFS host controller and Phy nodes for Qualcomm sc7280 SOC
> and sc7280 Board.
> 
> Changes from v3:
> - Addresses Mani comment to include interconnect entry.
These are not the only changes you've made.

> 
> Changes from v2:
> - Addressed Konrad comment to update binding qcom,ufs.yaml
> - Addresses mani/konrad comment to align ufs clock entry in devicetree.
> 
> Changes from v1:
> - Addressed mani comment to separate soc and board change.
> - Addressed mani comment to sort ufs node in ascending order.
> 
> Nitin Rawat (4):
>    scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
>    arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
>    arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
>    dt-bindings: ufs: qcom: Align clk binding property for Qualcomm UFS
> 
> Nitin Rawat (4):
>    scsi: ufs: qcom: dt-bindings: Add SC7280 compatible string
>    arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 soc
>    arm64: dts: qcom: sc7280: Add UFS nodes for sc7280 IDP board
>    dt-bindings: ufs: qcom: Align clk binding property for Qualcomm UFS
And this is bad.

Please use the b4 tool [1], half of the issues will be solved..

Konrad

[1] https://b4.docs.kernel.org/
