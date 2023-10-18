Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1E7CE891
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjJRUK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRUKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:10:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D46114
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:10:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507b9408c61so3763370e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697659820; x=1698264620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vC8BSO57sX+RFvEjTRkQdrl0WXBXIli5ij6sBpRlpmY=;
        b=qp1Ttjd7bg4NjuZFjqHRmkIOMEi5eZZT+fmctQsM9QeVK52AlHj+pQuntQyJzTHJup
         tMocsb7Y8g1w277Flaw3inb6Ae548IXWa6+xs4PzI+k90VXTV4TEYVQeAjXCWUp0cwxB
         Vxn9/OQonQYbSfTvUw4HauQDqZTOTEp6ir1r0d3/hYKtuaNBQNI1EQgvpZaHJPegviUI
         eGTFP9q3l+7owQdLsOnwGVkJA5aqZviIgSU8qZZhvp3j+/36VuhH6bjn/F43sQkE+2jK
         H5WdKDEIAPmC6d6oOBNj0fJvTz9tOm36GSbxtLRn3Ggz0rDFS8RquSQtbfM6qtaIpRqs
         ZkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697659820; x=1698264620;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vC8BSO57sX+RFvEjTRkQdrl0WXBXIli5ij6sBpRlpmY=;
        b=FJ38e4kboMMg6Nkc0bS8peDHwow4vNyC4T3Rt+vVxNcNNipwoRfMAOeM6JngTsvhmJ
         PPv3eZAp2hnVcXFRjnQalVu2j4ukQ1VKJWHGrxqhhhu8Fqh4zxWP8FOocZOCQHZRFpIY
         hjrlnSnEE3/XKuZ3u18Je5avjUwD/XwxjUsR4gXDMWRVtnWZE+w5+b9KY3zrrAsTa7+l
         HxvsYHFygerYDviBilwNcI2bcJhUgzKdnbaJ4ZV1d27UuwqT0WHrbSElIRse56cNWl1O
         aWZFjDvOYO78YwT4MKRqRgQ7FtGE73U+ajx9jhLQxpkM1fId/cqjU6qj0lxHUnaaebI0
         TNYA==
X-Gm-Message-State: AOJu0Yw8fPiutnz6j41M7taDdajXeSJQj4GRarCHeC+hkaWbzPmSRobN
        xCPb+M+BS+Wxz3d+6M+2wgyrSg==
X-Google-Smtp-Source: AGHT+IEoV8GqxarhRZJW+0Q9BZA1W9wzW1qrmKIldTts6mlhYjR/7ldyMGUwHxDYw3kBmonbwYz5Ug==
X-Received: by 2002:a05:6512:15b:b0:507:a984:bf40 with SMTP id m27-20020a056512015b00b00507a984bf40mr40011lfo.47.1697659820172;
        Wed, 18 Oct 2023 13:10:20 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v7-20020a056512048700b0050336e38735sm816806lfq.92.2023.10.18.13.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 13:10:19 -0700 (PDT)
Message-ID: <5e1eacc5-721e-4ac1-a62f-ece6a1c4355c@linaro.org>
Date:   Wed, 18 Oct 2023 22:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] arm64: dts: qcom: ipq9574: populate the opp table
 based on the eFuse
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, ilia.lin@kernel.org,
        quic_kathirav@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1697600121.git.quic_varada@quicinc.com>
 <5d1bf44de58db10a20d1b116c7fd4b073d01271e.1697600121.git.quic_varada@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5d1bf44de58db10a20d1b116c7fd4b073d01271e.1697600121.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 11:29, Varadarajan Narayanan wrote:
> IPQ95xx SoCs have different OPPs available for the CPU based on
> SoC variant. This can be determined from an eFuse register
> present in the silicon.
> 
> Add support to read the eFuse and populate the OPPs based on it.
> 
> Frequency	1.2GHz	1.8GHz	1.5GHz	No	opp-supported-hw
> 					Limit
> ------------------------------------------------------------
> 936000000	1	1	1	1	0xf
> 1104000000	1	1	1	1	0xf
> 1200000000	1	1	1	1	0xf
> 1416000000	0	1	1	1	0x7
> 1488000000	0	1	1	1	0x7
> 1800000000	0	1	0	1	0x5
> 2208000000	0	0	0	1	0x1
> -----------------------------------------------------------
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2:	cpu_speed_bin -> cpu-speed-bin in node name
> 	Move comment to commit log
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
