Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D7D8128FE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443270AbjLNHWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNHWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:22:00 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF54100
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:22:06 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-db3fa47c2f7so8011354276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702538526; x=1703143326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFId4vI/rtSZSgTfU2r7XTw+wmzc0CVyAnfLkGgxiTM=;
        b=sjqLzUJW6RpdCQEgCN6K+N+OrI3ieQhj9QeR1xOnqITzq0TLtAym7qiAl1LTmg6rC1
         LtPZkWsHO9mLMG061fhIlLHNzyKTHeR6zdMQ+a6sGeGRyvUVe9oVKifDF+DnPAxdKRf6
         gTw7ui0IpQtf+HNZMbcqv31YD25BfUG1gTR2/9/wFdnPP5GfODd8QJjb7+XO6KFx35f5
         RrGKM4QQ2i5pUMmEKD5O4VFhub6wOcV3TXSMOX6UZJoNCd5rt7ptRoqzQaxsQ4jpVSR6
         i0rzJVPRf6JhhsNHCbUTvqE7Bw0hP2usN5MrksdxG163DNIGO7jR7dIaUZ9WW1WE5qmo
         CYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702538526; x=1703143326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFId4vI/rtSZSgTfU2r7XTw+wmzc0CVyAnfLkGgxiTM=;
        b=vVT+F0YyffWHRVEqnZgYbcPqKP7DPDnlX0xmcIRPGxv1DjqsuzsTgxEIuLIXxKci35
         LTevKl4yF4g1vwBgj/Dev1uBiBd1D7GL9hQgs4VLhJ2jkWmS/96FVAToH/QfQjOxo1Gi
         dn8vk87b5b5OzQn+3s5llZvQPocPGbME/7VCOWOxSOMI826XNAINBCLAsMa7re/r0SIM
         PE7edB0K9Dlr9iAhum2xs7zfL8lCRWCrE/squPwdBW69gCzsGU9FMdJ/0ZcQ+6g5ixvt
         IWk5Q00uI+bgr7iXvLMEdR3ulmvVEE3/vjNtfXJbCHToGUemqFuMQY0Y0o03dpMpUkEg
         y5tw==
X-Gm-Message-State: AOJu0YyTPTbZoWKp3RqXdUYiofg50ZYzp6yV6rISrJ23wdE5HthMo37N
        HzBiIL/ikdNItT58GkkvHWdz6k/70kdVQQ8zIkf8YQ==
X-Google-Smtp-Source: AGHT+IEIP8q9qBU3y2LHml94mJ5w75uay/PW56FAWRJuUt9I+fEJqyg3WA41JHlZil2H3kXxccuRg6o0HP4Vq3kWWb8=
X-Received: by 2002:a25:9d06:0:b0:dbc:6715:42b4 with SMTP id
 i6-20020a259d06000000b00dbc671542b4mr6327865ybp.73.1702538526017; Wed, 13 Dec
 2023 23:22:06 -0800 (PST)
MIME-Version: 1.0
References: <20231214062847.2215542-1-quic_ipkumar@quicinc.com> <20231214062847.2215542-4-quic_ipkumar@quicinc.com>
In-Reply-To: <20231214062847.2215542-4-quic_ipkumar@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Dec 2023 09:21:55 +0200
Message-ID: <CAA8EJpqJ_7CPjTs2zykqnZpm9bQ31G7Q+1CA308OdS1BNqK6GA@mail.gmail.com>
Subject: Re: [PATCH 03/10] arm64: dts: qcom: ipq5332: Add separate entry for
 USB pipe clock
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        vkoul@kernel.org, kishon@kernel.org, mani@kernel.org,
        quic_nsekar@quicinc.com, quic_srichara@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_varada@quicinc.com, quic_devipriy@quicinc.com,
        quic_kathirav@quicinc.com, quic_anusha@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 at 08:29, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
> Add separate entry in clock-controller for USB pipe clock.

In my opinion, there is no need to do that separately. Please squash
into patch 9.

>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 42e2e48b2bc3..f0d92effb783 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -213,6 +213,7 @@ gcc: clock-controller@1800000 {
>                                  <&sleep_clk>,
>                                  <0>,
>                                  <0>,
> +                                <0>,
>                                  <0>;
>                 };
>
> --
> 2.34.1
>
>


-- 
With best wishes
Dmitry
