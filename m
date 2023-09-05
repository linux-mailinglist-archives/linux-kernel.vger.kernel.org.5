Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911D793062
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243980AbjIEUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbjIEUw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:52:28 -0400
X-Greylist: delayed 455 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:52:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7847113E;
        Tue,  5 Sep 2023 13:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27AC7C433CB;
        Tue,  5 Sep 2023 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693946689;
        bh=cO2tbtWKndLvU3JOGtuY04T5nAb5s1s0eT+FGj58JlI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VqHoLJQ39vGME1mgrTZsQTuZPg4IlNoXN5+OjHNLa+h0SHmpEynYwllolt0fMF1aq
         HB86e82fCGHeaKbVkzW+1V/Ccc2go5jQZ12XrEyCBXHRm8AWdoaBySJ0OOs0XyumRP
         YhPfe31sxd1Ctu/H4o3EDBae4YrZHpzYgbsbbcFnGgjniSb3caA+mDZjAAazTLLqOC
         BptcEVYSjy7It7JLi0w30UQBabnoibUdzO8oFyKhpOJ8EdCWscYFwoBDV2pZbK76Fe
         iQtO/y9pSm/pU2N101yG46vjhskCg4JutspDPOH9Kw1d+9gRMdNHvHgKFZ7nxygswH
         Q9kcrjkaEeHdQ==
Message-ID: <41a65b3c3bd907891f376afcc8d60513.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230901091823.30242-2-quic_luoj@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-2-quic_luoj@quicinc.com>
Subject: Re: [PATCH v6 1/4] clk: qcom: branch: Add clk_branch2_prepare_ops
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Luo Jie <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Tue, 05 Sep 2023 13:44:46 -0700
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

Quoting Luo Jie (2023-09-01 02:18:20)
> Add the clk_branch2_prepare_ops for supporting clock controller
> where the hardware register is accessed by MDIO bus, and the
> spin lock can't be used because of sleep during the MDIO
> operation.
>=20
> The clock is enabled by the .prepare instead of .enable when
> the clk_branch2_prepare_ops is used.
>=20
> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
