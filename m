Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D409F793063
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbjIEUwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243938AbjIEUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:52:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795A8191;
        Tue,  5 Sep 2023 13:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A31CC433CC;
        Tue,  5 Sep 2023 20:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946740;
        bh=BUrYamCmFQ4Ttn1hNrIUKdIAYMcDPbuSbnr+EfDSve4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ABR1o7RTa+pTjLJdTd3q/2o5N659Gc5046YIqxJpmOyvijHPixlDBrU+/xBkBrVnJ
         1iakBxB85bK68Fx8z4u6VekOlitfUDCheitU7Yo7SE5V3IeoipA2unUUa3WdteWjbz
         m0jTkMDhbrafipE08UzooCuIFKvGGO7MUF7KuA5zhpuqQC+Sll0TirSUeNutYxY4lA
         rcPKZv3fEcqEAjIGH7/ogOZPxImvxUxuhcEKzXelVVQHQosgXaNzUnG2M17sAJhCOf
         7RB34qtTdRUsG4eV9GaOVVSiQHQmiLc8ZblTbsdbSWjDdp39XdcyyYvWx4n9dVYHZ+
         xEl/yPARA5DeQ==
Message-ID: <9a3a0300cd6c2f57b51e1cda61ed9162.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230901091823.30242-4-quic_luoj@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-4-quic_luoj@quicinc.com>
Subject: Re: [PATCH v6 3/4] clk: qcom: common: commonize qcom_cc_really_probe
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Tue, 05 Sep 2023 13:45:38 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luo Jie (2023-09-01 02:18:22)
> The previous wrapper qcom_cc_really_probe takes the platform
> device as parameter, which is limited to platform driver.
>=20
> As for qca8k clock controller driver, which is registered as
> the MDIO device, which also follows the qcom clock framework.
>=20
> To commonize qcom_cc_really_probe, updating it to take the
> struct device as parameter, so that the qcom_cc_really_probe
> can be utilized by the previous platform device and the new
> added MDIO device.
>=20
> Also update the current clock controller drivers to take
> &pdev->dev as parameter when calling qcom_cc_really_probe.
>=20
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
