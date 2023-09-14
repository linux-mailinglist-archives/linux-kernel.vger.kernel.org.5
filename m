Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF9B7A0ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjINQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjINQaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:30:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678591FCE;
        Thu, 14 Sep 2023 09:30:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C7FC433C7;
        Thu, 14 Sep 2023 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694709018;
        bh=nhzaDPtDjFNbPiCIGqGrvXSRv8u+mkX5rY5cXHPXIyg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Dm8BJHKO+oN1VPX59fBzNz5hbhtgnQTaYqEzNlqiHyg3/Q+TebdGXj2DcI3a2WO0g
         fU84tjCBbCgehDqn8bZsOzcN6mjV67vc6lQGVnjKjIEjyWUkvC/WYSeG92GE57jAfx
         dLdWUBX6itACTWdaC6jc15D9ZzLhfEDJCB6mhMx7W5siky4FI4y4Lp+d+c768DN8pn
         ZIBGMA8/MRfKmtLIKrWK6dZBnrH5jZBhEQjFtbkOj0LZ8egKX7zfgAr3R3Gn2rENu0
         FnbUZit7JL1A230nO7ifdOsD0kPVrWYqXd5lAtBQI3nhob61IGES8GJpGBXsX4V7ku
         3geRAMW/3X15Q==
Message-ID: <580f3934ab1171e27d785db7362c342d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9952fa20-a27f-3240-cc49-5c5109febfc1@quicinc.com>
References: <20230901091823.30242-1-quic_luoj@quicinc.com> <20230901091823.30242-5-quic_luoj@quicinc.com> <27ae3297ad161fd67706db70b402db04.sboyd@kernel.org> <16d09acf-7bdd-04ee-6faf-936c0366df03@quicinc.com> <17681a9f756cc70a190c674c51b90140.sboyd@kernel.org> <5a4805f7-f802-b1ba-9804-59c0fe6c7f26@quicinc.com> <92058c25fb11b75ee0a2298a684825e9.sboyd@kernel.org> <f67b354c-8a4b-49f5-6275-66b7d614301a@quicinc.com> <82adb75659e0d278e25b65b0e81df99a.sboyd@kernel.org> <9952fa20-a27f-3240-cc49-5c5109febfc1@quicinc.com>
Subject: Re: [PATCH v6 4/4] clk: qcom: add clock controller driver for qca8386/qca8084
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
To:     Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, catalin.marinas@arm.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, will@kernel.org
Date:   Thu, 14 Sep 2023 09:30:15 -0700
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jie Luo (2023-09-12 20:27:25)
>=20
>=20
> On 9/13/2023 1:18 AM, Stephen Boyd wrote:
> > Quoting Jie Luo (2023-09-12 05:07:02)
> >>
> >> and freq_tbl are necessary to this clock.
> >=20
> > I still don't see why the freq_tbl is necessary.
>=20
> Hi Stephen,
> For clk_rcg2_ops, freq_tbl is used to find the closest rate to decided=20
> the parent clock, the configuration of clock source and clock divider=20
> are saved in the freq_tbl to configure the RCG hardware register, the=20
> mapping of parent clock and hardware register value is decided by the=20
> freq_tbl for the RCG clock.

The divider is always 1. The frequency is the frequency of the parent.
The two pieces of information are already known without the frequency
table. Why is it needed?
