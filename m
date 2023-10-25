Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C837D7709
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYVrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJYVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:47:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E10A3;
        Wed, 25 Oct 2023 14:47:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A7DC433C7;
        Wed, 25 Oct 2023 21:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698270436;
        bh=/ssGNvI3QO9S6JDuh+JSb/c1bKl9Xnjh7wD3tiPxIfs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MlhcRMmbtykHIDQi0aDqUZsjwUdqTZfyA9ISZJMLgAjAFFiV/KZNZAGeQLZhvvCiM
         5dZgdIODPZ26Ct7w60rz1jJyacL4bVvvqZdKTMIJbj7tduWs6w1tuyjwtvvajKK0Y8
         4F2uFM+lRl0ldY52WP50hWJqRH3w2eCEpTizz2n86fhsG8uviKm4HNN3U1eyX/X8Oo
         LMXXmgUIM7Swia5UNLBd4/tn/S0lY07822+mzQPOHh3hEWdkJXC/pr2lW+11QADQO6
         Wv/ofMhpqip+QOSD3zo6PmwyGtxXgewic8gxrkhfmDI3Hze8FDLCmhRY9DOPK/+Yfu
         NQDpZEsHQnHMA==
Message-ID: <5f157c65b07eee357f7682be0945d638.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <be119e71-0456-4806-8c0a-e77732553f70@linaro.org>
References: <20231025-topic-sm8650-upstream-clocks-v1-0-c89b59594caf@linaro.org> <20231025-topic-sm8650-upstream-clocks-v1-10-c89b59594caf@linaro.org> <467bc514-1cff-4bc5-a553-fd1ef0886ee5@linaro.org> <be119e71-0456-4806-8c0a-e77732553f70@linaro.org>
Subject: Re: [PATCH 10/10] clk: qcom: rpmh: add clocks for SM8650
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Date:   Wed, 25 Oct 2023 14:47:13 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Neil Armstrong (2023-10-25 05:00:54)
> On 25/10/2023 10:47, Konrad Dybcio wrote:
> >=20
> >=20
> > On 10/25/23 09:32, Neil Armstrong wrote:
> >> Add RPMH Clocks for the SM8650 platform.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> > [...]
> >=20
> >> +static struct clk_hw *sm8650_rpmh_clocks[] =3D {
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_CXO_CLK]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D &clk_rpmh_bi_tcxo_div2.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_CXO_CLK_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_b=
i_tcxo_div2_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK1]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_=
clk6_a2.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK1_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpm=
h_clk6_a2_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK2]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_=
clk7_a2.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK2_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpm=
h_clk7_a2_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK3]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_=
clk8_a2.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_LN_BB_CLK3_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpm=
h_clk8_a2_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_RF_CLK1]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D &clk_rpmh_clk1_a1.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_RF_CLK1_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_c=
lk1_a1_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_RF_CLK2]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D &clk_rpmh_clk2_a1.hw,
> >> +=C2=A0=C2=A0=C2=A0 [RPMH_RF_CLK2_A]=C2=A0=C2=A0=C2=A0 =3D &clk_rpmh_c=
lk2_a1_ao.hw,
> >> +=C2=A0=C2=A0=C2=A0 /* missing RPMh resource address for clka3 */
> > So, the downstream driver suggested it's there but CMD-DB disagrees?
> >=20
> > Can we get a confirmation whether it should be there?
>=20
> There's a clka3 on the PMK8550, but it's undeclared in CMD-DB since
> unused/unconnected on the MTP & QRD platforms.

Can you add that comment here so we know why the resource is missing and
not just that it is missing?
