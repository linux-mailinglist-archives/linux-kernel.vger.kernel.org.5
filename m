Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7648A7BD0FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjJHWqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344886AbjJHWqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:46:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181AA3;
        Sun,  8 Oct 2023 15:46:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A95C433C7;
        Sun,  8 Oct 2023 22:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696805160;
        bh=kotJJ9gsZkQcnHWqrlxm2deUqRwlycTaO/tg2RqNNko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n2k3nv66A7YBlXrB+jn/PMmf6Kbwu1QoO5H+tphBlky4GMOjW4R7XqmXs/eNXcmr1
         hk4vuH7fVWuNoawxFa3MyQCO871yng630/NymD5hLqsIbrp6D6U5byi4+F97ZINg2V
         6rwvVDTbqifL2wF/faMWkaLEFQvPfkqhB7m77IVtYb2pBeU0Npu3q40mrz5lvuaYRr
         ciqDwM3eNE/Z38lx+7CXnXA1RETJDcJ/4mJyLEVgCupZjXLLslt/Q8DNTQqzPn6s0q
         YSCaeMuriz9y7ylXS8teEJ8gv2AsaNeXUzW2Q63zlLa7mMVD3MahYpIz2qXMGaxGzh
         lVqAk/rR2bYFQ==
Message-ID: <729f0d44-7db9-46d2-bdee-9a58022d9229@kernel.org>
Date:   Mon, 9 Oct 2023 07:45:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Use device_get_match_data()
To:     Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tero Kristo <kristo@kernel.org>
Cc:     patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
References: <20231006213959.334439-1-robh@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20231006213959.334439-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 7. 06:39, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/clk-lochnagar.c             |  9 ++-------
>  drivers/clk/davinci/da8xx-cfgchip.c     |  8 +++-----
>  drivers/clk/davinci/pll.c               | 10 +++-------
>  drivers/clk/davinci/psc.c               | 10 +++-------
>  drivers/clk/qcom/gcc-msm8960.c          | 13 +++++--------
>  drivers/clk/qcom/gcc-msm8974.c          | 10 +++-------
>  drivers/clk/qcom/kpss-xcc.c             |  9 ++-------
>  drivers/clk/qcom/krait-cc.c             | 14 +++++---------
>  drivers/clk/qcom/mmcc-msm8960.c         | 16 +++++-----------
>  drivers/clk/qcom/mmcc-sdm660.c          |  8 ++------
>  drivers/clk/rockchip/clk-rk3399.c       |  9 ++-------
>  drivers/clk/samsung/clk-exynos-clkout.c |  8 +++-----
>  drivers/clk/ti/adpll.c                  | 14 ++++----------
>  13 files changed, 42 insertions(+), 96 deletions(-)
> 

For samsung exynos,
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

