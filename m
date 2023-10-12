Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5351A7C6973
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjJLJ02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjJLJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:26:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1E59D;
        Thu, 12 Oct 2023 02:26:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB02C433C9;
        Thu, 12 Oct 2023 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697102784;
        bh=SN5ObSl4Uu8gXNwMaztHTM/KocrE8JwPmVEwIA7cPzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ii/HaIIEB8FKKms945hE7uYJ8PBHAViha1kEmbvamGua2e4FZFqAw+UO5MFE93HOF
         6kkmKMl5792yq5AWzd7uigl5E1q/obnzkcImynN7YM2CChHMjUDZA3Vlwj0vPvY4FV
         xyPI2rxlyVmPik0gp0Z9ZHPBNbkfiIz05tPnEyHut/AqWF64DnJ6OMGhufBr9csmt2
         o5JbxKXRXrj3se+GBnn5U2LOxu3LbavWJxOZ0CkHBub8es+FiDkhHNuvHD/7Qt2oD/
         Q+3UJqs7bTo0VX94FZAWfl6puLcUJMXABmlfto9si/N++JMfmTv6JQ5thtKyF5f8FK
         rtTrQtoeovx/A==
Date:   Thu, 12 Oct 2023 10:26:18 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] mfd: Use device_get_match_data()
Message-ID: <20231012092618.GF8314@google.com>
References: <20231009211356.3242037-3-robh@kernel.org>
 <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v66ZHD8mMMNVwp+sTYT6DAFDUrP8ydeTo7KW+uUtBRM3bQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023, Chen-Yu Tsai wrote:

> On Tue, Oct 10, 2023 at 5:14 AM Rob Herring <robh@kernel.org> wrote:
> >
> > Use preferred device_get_match_data() instead of of_match_device() to
> > get the driver match data. With this, adjust the includes to explicitly
> > include the correct headers.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/mfd/axp20x.c           | 22 +++-------------------
> 
> I'd keep the error message, but otherwise for axp20x,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> >  drivers/mfd/hi6421-pmic-core.c |  9 +++------
> >  drivers/mfd/mxs-lradc.c        |  9 ++-------
> >  drivers/mfd/qcom-spmi-pmic.c   |  6 ++++--
> >  drivers/mfd/qcom_rpm.c         |  8 ++++----
> >  drivers/mfd/tps65910.c         | 11 ++---------
> >  drivers/mfd/twl4030-power.c    |  9 +++------
> >  drivers/mfd/twl6030-irq.c      | 10 +++++-----
> >  8 files changed, 26 insertions(+), 58 deletions(-)

FYI, this patch is not in my inbox.

-- 
Lee Jones [李琼斯]
