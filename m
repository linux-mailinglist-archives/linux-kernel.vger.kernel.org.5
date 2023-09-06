Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB379452F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244039AbjIFVib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjIFVia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3EA19A0;
        Wed,  6 Sep 2023 14:38:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7171C433C8;
        Wed,  6 Sep 2023 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694036306;
        bh=bu1NpQnLhEgqdsoh9IOlN15FakFJxHtRmZJxrjVakXI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R0+kqOvaYUzY3SAQz2/8kfr/+dEpczdp5gxy6P02U+UKQutIAMb+WBKYHF+i0Si/5
         8RLovYT9ErpRNAl+bm48t3kdsyVilNgwuZ7EMZ+ikAI77h4m7/Gak/2wsbmlmkujr3
         Dfm8+WDfuc4dw++QiIPwqcNMCegS22PojtR3SuEvaAkAAhCfVV2towiLwDosbAx2Im
         +hLJ56DQzCvKEHHWdARHNS0lAGeC8SQp3RjzX8/Rw9oOPISXvFG70d5bK39lE5rhgM
         GIg3eY/AcI51+INH77Cg2lafYK5ihRrAeKuxMz3HIx0bn3etntU2CH2yWDehj1Ylu8
         Y/2Pzsc6nFkCA==
Message-ID: <bd8cd2836a219b36e14cddc504527dc3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230826125308.462328-2-cristian.marussi@arm.com>
References: <20230826125308.462328-1-cristian.marussi@arm.com> <20230826125308.462328-2-cristian.marussi@arm.com>
Subject: Re: [PATCH v2 1/6] firmware: arm_scmi: Simplify enable/disable Clock operations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        etienne.carriere@foss.st.com, peng.fan@oss.nxp.com,
        chuck.cannon@nxp.com, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 06 Sep 2023 14:38:24 -0700
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

Quoting Cristian Marussi (2023-08-26 05:53:03)
> SCMI Clock enable/disable operations come in 2 different flavours which
> simply just differ in how the underlying SCMI transactions is carried on:
> atomic or not.
>=20
> Currently we expose such SCMI operations through 2 distinctly named
> wrappers, that, in turn, are wrapped into another couple of similarly and
> distinctly named callbacks inside SCMI Clock driver user.
>=20
> Reduce the churn of duplicated wrappers by adding a param to SCMI Clock
> enable/disable operations to ask for atomic operation while removing the
> _atomic version of such operations.
>=20
> No functional change.
>=20
> CC: Michael Turquette <mturquette@baylibre.com>
> CC: Stephen Boyd <sboyd@kernel.org>
> CC: linux-clk@vger.kernel.org
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
