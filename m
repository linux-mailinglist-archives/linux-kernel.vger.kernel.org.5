Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871D97CEC85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjJSABS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjJSABQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 20:01:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1185113;
        Wed, 18 Oct 2023 17:01:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365F8C433C9;
        Thu, 19 Oct 2023 00:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697673675;
        bh=rP7crk+7H3pWmLbFwNJV2ubulsPElMxFOiBSUaF9ogs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oozyOtg/uHTOP/QCDQg98pjVL/M1zrPyUUl+49m99KSrXNF3HAfFEOFAL6lAXr0xy
         orCLZQLlwrrzWvi1GT4Oa+CBHqvx01VZWV/qMTWQ03cCUPxX2EC5UcSsc7ETubQDOk
         O2aWvsLOZuNxnahtX1WoiBFI+6BdjUth9LIuQsIHGkQCLflcua/YJ42BoesolaawKT
         u2ttrlKMP9CKBEQ6k5FBDYLASj7+vQykp3rbGpsPBO8AqNXsXzzKsqNUqP84Aeijx6
         uPu64+1Mb4jj6v5ZdKYTeWEW7d8obFPe6rJdX/l0M6CRHwN03XZjhHdj/HP1hB/2Kx
         MOf1lwUUfYXLA==
Message-ID: <45b739e3c7dd15248b160487f7133fb7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ccffe81713e207d517b5a9f0f1ef906db7add25b.1697600121.git.quic_varada@quicinc.com>
References: <cover.1697600121.git.quic_varada@quicinc.com> <ccffe81713e207d517b5a9f0f1ef906db7add25b.1697600121.git.quic_varada@quicinc.com>
Subject: Re: [PATCH v3 3/8] clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, ilia.lin@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        mturquette@baylibre.com, quic_kathirav@quicinc.com,
        rafael@kernel.org, robh+dt@kernel.org, viresh.kumar@linaro.org
Date:   Wed, 18 Oct 2023 17:01:13 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Varadarajan Narayanan (2023-10-18 02:29:16)
> The earlier 'l' value of 0x3e is for 1.5GHz. Not all SKUs support
> this frequency. Hence set it to 0x2d to get 1.1GHz which is
> supported in all SKUs.

Maybe also add the detail to the commit text that the frequency can
still increase above this initial configuration made here when the
cpufreq driver picks a different OPP.

>=20
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
