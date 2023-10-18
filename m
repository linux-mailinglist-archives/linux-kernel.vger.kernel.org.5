Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33187CEC74
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 01:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjJRX7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 19:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJRX7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 19:59:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA40106;
        Wed, 18 Oct 2023 16:59:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC09C433C7;
        Wed, 18 Oct 2023 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697673587;
        bh=FqB0xX+9WJ6jUZfPZjzCTE6Y5V5SPa1rNDB782OU+Jg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DfDMnrbTJRmdHYN3n1P8IIn05wCjMm3Cz+r8dvc9ix/w53TnqaM36PRYr5S7H+y+l
         HSi/Zd2ng88iPWIjqgu58KNyoHKJdy8VI52I6rTbIAr1CN59cyb7JKv70Q9RoVIy0Z
         pMGmIzQAxMg9s+eSyphYlrYVPEZgDmO3wAHBszEkYNEc9m1Ihb4P69jb3inEj8l0gl
         7ckt4EVwd6cSqO9dCzWJGLMW7UN1I9KLjmF2vXcWknVJ5GdVR2p48nSC4+WrDNaeiw
         dVeguFvToow349Rf9sCv8dACEENpuBVFcr7UTIYtSb45ABZdRR8en4EdKqgl9FOc6H
         X4bLkzzIqwa2Q==
Message-ID: <d7772d43a9800a6e44a913f33fba163e.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9fe546088cb150cb42237a6f6a3d68f1c2c87987.1697600121.git.quic_varada@quicinc.com>
References: <cover.1697600121.git.quic_varada@quicinc.com> <9fe546088cb150cb42237a6f6a3d68f1c2c87987.1697600121.git.quic_varada@quicinc.com>
Subject: Re: [PATCH v3 2/8] clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
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
Date:   Wed, 18 Oct 2023 16:59:45 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Varadarajan Narayanan (2023-10-18 02:29:15)
> The set rate and determine rate operations are different between
> Stromer and Stromer Plus PLLs. Hence, use stromer plus ops for
> ipq_pll_stromer_plus.

What goes wrong if we don't have this patch? Please add that detail to
the commit text.

>=20
> Fixes: c7ef7fbb1ccf ("clk: qcom: apss-ipq-pll: add support for IPQ5332")
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
