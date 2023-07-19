Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50DF8758ED4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGSHXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGSHXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:23:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28AB1997;
        Wed, 19 Jul 2023 00:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 827F6612A5;
        Wed, 19 Jul 2023 07:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E248C433C7;
        Wed, 19 Jul 2023 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689751405;
        bh=dl/xbzvNpFPXTANoFrIGeITmpH+NRNJBJT23DfptPik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OClJZ61FtFVnfVpy8HzBH3fYU8YKCjcNMQl3s3z3pWvuHE3EYwXjBmWTf+/OEWxz+
         TJt+ocZbha6UbXBKyP9JoxamvaKXAykNtYLZ0lYWgUM2Mg9Mnn6/UfHPuawAA0U57A
         mGQBfK/okTym/bMmiprth5yNwtGEsaBUXrl2icSlfpPO/UKQxiu/Bd70qz1FpqNOnL
         M3U6dStfQViZU5QpjvGn/Do07yComhhc0B9F4aHDYxTlMrSGr97X88v95D35djX5+o
         6d4QgJnQQ6JGibk1bXczRYJgN6N/koabZV4QLVsraxLes0icAXo/xie3b2YJHwMjoF
         b5X63ZkeslDDg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qM1X4-00018j-1d;
        Wed, 19 Jul 2023 09:23:34 +0200
Date:   Wed, 19 Jul 2023 09:23:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] clk: qcom: fix runtime PM bugs
Message-ID: <ZLePdiuBzab8WffW@hovoldconsulting.com>
References: <20230718132902.21430-1-johan+linaro@kernel.org>
 <1da2842e-e5a3-e0e5-ea7d-7da5f4b84001@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da2842e-e5a3-e0e5-ea7d-7da5f4b84001@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 03:46:03PM +0200, Konrad Dybcio wrote:
> On 18.07.2023 15:28, Johan Hovold wrote:
> > This series fixes a number of runtime PM related bugs found through
> > inspection.

> I was thinking whether we should maybe incorporate RPM enablement
> into qcom common functions.. The only issue I see is that some
> clocks register pm clocks atop that, but I guess we could introduce
> some sort of a pm_clks names array to solve that?

Possibly, but you currently also have the hardcoded clock enables and
some other variations.

Johan
