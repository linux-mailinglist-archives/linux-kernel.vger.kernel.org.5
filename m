Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959C47F9779
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjK0CVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjK0CVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:21:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B4D110
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:21:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E88C433C8;
        Mon, 27 Nov 2023 02:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701051707;
        bh=bC2ssL/QECbp/dStYuVy7bosUCcMH2N8jkkHjJLYJnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=esUJY4t28KqAgZi/NF1BJyvYwUsOTktrX0mBJwlFALH1aUm04CCexiidqrEj62rrR
         BG3QcWecVE5NUN60mHWGx4SGYzV233ltR7ooW1dO42dWuU2bitFPGi9MxptzCzFJSs
         t+TvM3XCED+uQ7NK6D28ct22hL54NBucjrD+CH6Qpt0ANLIt7FMrWUJMq16cSinVwR
         DbhGZeqLSi1vlqqoXpq4fHYOD+qkpKDuhz+507iEc5l1M1pRHLDryb2/rtVL9Xd4h7
         iaOugiYBPUotxLOhUh9R/IX/Qi5F97X3OW46oWQcrLwBqeevgXmwVQk/JgZSSSFTNb
         eAAtKGtcIWwJA==
Date:   Mon, 27 Nov 2023 10:21:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.li@nxp.com>
Cc:     alexander.stein@ew.tq-group.com, alexandre.belloni@bootlin.com,
        conor+dt@kernel.org, conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, peng.fan@nxp.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: Re: [PATCH v2 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Message-ID: <20231127022140.GJ87953@dragon>
References: <20231017194657.3199749-1-Frank.Li@nxp.com>
 <20231017194657.3199749-2-Frank.Li@nxp.com>
 <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUz/8fBWtnwdSW9w@lizhi-Precision-Tower-5810>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 10:51:13AM -0500, Frank Li wrote:
> On Tue, Oct 17, 2023 at 03:46:57PM -0400, Frank Li wrote:
> > Add I3C1 and I3C2.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> @Guo Shawn:
> 
> Driver part already merged. 
> 
> Please pick up dts part

Rob had a comment [1] about SoC specific compatible.  That's not what we
want?

Shawn

[1] https://lkml.iu.edu/hypermail/linux/kernel/2310.2/03035.html
