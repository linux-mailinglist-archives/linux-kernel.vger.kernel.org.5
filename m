Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9686E7999EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbjIIQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346206AbjIIPll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:41:41 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2913D;
        Sat,  9 Sep 2023 08:41:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so53001881fa.0;
        Sat, 09 Sep 2023 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694274095; x=1694878895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bazo2KU1dPKrrOcg/X9lZoXi1aVqyf7ItDAKxGtR4wM=;
        b=HlPHzxd92YLz+PCc/LaQAcFg4i1FiTVHMy0egNOCQusSH7eU6ATzQg5HpAUnKHwGJP
         xK1vHkIsdFjpk6ajWnCRTrgPVL9oOailuzXH6cSsT4HR2p8b876kCWW1tNhMMyYWhEh/
         OupRQtGZyvjWPFZY139xKg3DzL1m6gazFkHDnslm52XD3+uopwNK9eJhKaUvLSD95UCT
         A9D2lzpuG8VD3NhrMPWwPnd1Je8dEQw8VU4RGWecuX/M6HzeNyPeoFO3UxOutZYJP15b
         b1e3agLhNlGiJqhH7kHJMB17QTjUFmNRYPG1uNtcYqz+H4CJ0pW8UK/HBm8/ZfNIOOZe
         MIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694274095; x=1694878895;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bazo2KU1dPKrrOcg/X9lZoXi1aVqyf7ItDAKxGtR4wM=;
        b=vJLxQgcIw1yiyJYAPAEWGLVkhBAm8O6Qr6gSSJCtlqpZSi/u1QQAYksnKvaB2ULlAL
         DEvSv3pdVb4rY+GJHh87n1sCa/rOEwtmhs6xYc/jOC85de6t67B3mjKiUEuraC2yXyCD
         5Yz/mI8MmXQKcYq8lvATXTDCQ80YmoaZbTxuxSVp3xMGFQDtrANIEdjOKGbxp/Gjw+BA
         g9YwOQOFpYmTX+0zTGWLm1siPqKo0Q+O8f3i8S9wZO9lu6MAV+RCFIurbUHJqMXdElZQ
         zYi9gBjVY20LiWbDSlIg941egB1UL7KF65N2Hw1LIWULus2mi88SpqYyQPUFbVL5YLMI
         Nr7g==
X-Gm-Message-State: AOJu0Yx89CYdcQkpGeoN6QQF1qTED5fK4ulef7N66u63wFvZpaMLCpEO
        BMxLhm8RRQBr2Ivq87BKdk0+FCFC74HCNg==
X-Google-Smtp-Source: AGHT+IGVv1rEkOaRPl81NAP8E7KdVqexzwcVszloDudt1EKXtf6mubD5YowJLVrJt9bDAx/S6HMqqQ==
X-Received: by 2002:a2e:9297:0:b0:2ba:18e5:1064 with SMTP id d23-20020a2e9297000000b002ba18e51064mr3970152ljh.14.1694274094785;
        Sat, 09 Sep 2023 08:41:34 -0700 (PDT)
Received: from [192.168.3.32] (dh207-96-186.xnet.hr. [88.207.96.186])
        by smtp.gmail.com with ESMTPSA id kj13-20020a170907764d00b009a1b857e3a5sm2482685ejc.54.2023.09.09.08.41.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 08:41:33 -0700 (PDT)
Message-ID: <eaabca40-446d-effd-5d5f-f3e2618ff616@gmail.com>
Date:   Sat, 9 Sep 2023 17:41:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RESEND 6/7] clk: qcom: apss-ipq6018: add the GPLL0 clock
 also as clock provider
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
 <20230904-gpll_cleanup-v1-6-de2c448f1188@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230904-gpll_cleanup-v1-6-de2c448f1188@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06. 09. 2023. 06:56, Kathiravan Thirumoorthy wrote:
> While the kernel is booting up, APSS PLL will be running at 800MHz with
> GPLL0 as source. Once the cpufreq driver is available, APSS PLL will be
> configured and select the rate based on the opp table and the source will
> be changed to APSS_PLL_EARLY.
>
> Without this patch, CPU Freq driver reports that CPU is running at 24MHz
> instead of the 800MHz.
>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
I can confirm that this works on IPQ8074 as well, it now properly sees the
default CPU clock of 800MHz instead of XO rate.

Tested-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/clk/qcom/apss-ipq6018.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> index f2f502e2d5a4..4e13a085a857 100644
> --- a/drivers/clk/qcom/apss-ipq6018.c
> +++ b/drivers/clk/qcom/apss-ipq6018.c
> @@ -20,16 +20,19 @@
>   
>   enum {
>   	P_XO,
> +	P_GPLL0,
>   	P_APSS_PLL_EARLY,
>   };
>   
>   static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
>   	{ .fw_name = "xo" },
> +	{ .fw_name = "gpll0" },
>   	{ .fw_name = "pll" },
>   };
>   
>   static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
>   	{ P_XO, 0 },
> +	{ P_GPLL0, 4 },
>   	{ P_APSS_PLL_EARLY, 5 },
>   };
>   
>
