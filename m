Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8787718B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHGDOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 23:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjHGDON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 23:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BB910F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 20:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 238206135B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C269FC433C7;
        Mon,  7 Aug 2023 03:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691378051;
        bh=eMNIxWdTggckFAuJaLod3e0uPFISgtKFh3Psf6FdSyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxEag8t3rCkFPbZFqihsWYTs05lwd15Uuho+ogDRO+OmABtNvLYeBF+ldfNy7QtN6
         RF9/S0Icg+jzCX+RFJL4PFBt5QwyOmVqLaXQ5FjatjSQiTA5PouzEYnywj5XEXTjWI
         AUFZyAKhU3arC/kG5xPlb3AB9QnbXX8lsL8A+hTgSJurEmTqoT28O6+4b/0Lfw5+Bm
         bhgLCiA4ZvtK6aeIfMM3eTyEm83i1KltK0CQUYCfCCBv18JvuufjIw7s0vGTxt6Zny
         VlmXkKc8AHLMTb65Jffz1EaXXBsSsrFASP/Gcanmh/Eep2JCXybaIoS/eCR4VP7U3h
         piIfoq+0CBPeA==
Date:   Mon, 7 Aug 2023 11:14:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
Message-ID: <20230807031401.GP151430@dragon>
References: <20230731090449.2845997-1-peng.fan@oss.nxp.com>
 <20230731090449.2845997-6-peng.fan@oss.nxp.com>
 <20230807025412.GN151430@dragon>
 <DU0PR04MB9417C47BDAC2BDF8D00B7DFE880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417C47BDAC2BDF8D00B7DFE880CA@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 02:57:17AM +0000, Peng Fan wrote:
> Hi Shawn,
> 
> > Subject: Re: [PATCH V5 5/9] firmware: imx: scu: use EOPNOTSUPP
> > 
> > On Mon, Jul 31, 2023 at 05:04:45PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > EOPNOTSUPP is preferred than ENOTSUPP.
> > 
> > Could you elaborate why?
> 
> From checkpatch.pl:
> "ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP"
> I could add this in commit message if you prefer.

Yes, please.

Shawn
