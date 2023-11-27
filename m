Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB97FAE8D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjK0XpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjK0XpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:45:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F01B1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 15:45:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F130EC433C8;
        Mon, 27 Nov 2023 23:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701128715;
        bh=5NyhAgAnJED9vs5yJQyLZIgE4q88VxwoLIUkobS3I4I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=J2RWegIEJTLwURIvpx64vrZE5M5ajwQ4E/h4FVrrnFqIxocmYo8Er2r5BHO+4n2QI
         4UUNf3BY49BWKSmTMK3lXdiT3mI6mJary8a72s0l3vjdRSThWp8ljvhYmytvYM4QCo
         QlScTRK58aUSUJdfwqmpMMxUK90D+lhmVfYSpdU9GxTinHmRoglZcc6rzKRYyVp6Rg
         dgGYJVlTrZfuUV8nq8+Vw3vlhk+8Qt29SwiLQPF5dCrFxZ4i+GB+WK1hf9xzXn324O
         L/WUMQ88Zixoss7AigXGWCDgWKa8WErIv6j3W2xcchAdKTiU7WxRNnrZx+rkFy9H+P
         Cqq/29Gii9mWQ==
Message-ID: <3c547faab0533196a06196ed3856fa75.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231107064545.13120-1-quic_jkona@quicinc.com>
References: <20231107064545.13120-1-quic_jkona@quicinc.com>
Subject: Re: [PATCH] clk: qcom: Fix SM_CAMCC_8550 dependencies
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 27 Nov 2023 15:45:12 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jagadeesh Kona (2023-11-06 22:45:45)
> SM_GCC_8550 depends on ARM64 but it is selected by
> SM_CAMCC_8550, which should have the same dependencies
> as SM_GCC_8550 to avoid the below Kconfig warning reported
> by kernel test robot.
>=20
> WARNING: unmet direct dependencies detected for SM_GCC_8550
>   Depends on [n]: COMMON_CLK [=3Dy] && COMMON_CLK_QCOM [=3Dy] && (ARM64 |=
| COMPILE_TEST [=3Dn])
>   Selected by [y]:
>   - SM_CAMCC_8550 [=3Dy] && COMMON_CLK [=3Dy] && COMMON_CLK_QCOM [=3Dy]
>=20
> Fixes: ccc4e6a061a2 ("clk: qcom: camcc-sm8550: Add camera clock controlle=
r driver for SM8550")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311062309.XugQH7AH-lkp@i=
ntel.com/
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---

Applied to clk-fixes
