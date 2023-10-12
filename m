Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DFB7C61F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376699AbjJLAoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376671AbjJLAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:44:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103AF90;
        Wed, 11 Oct 2023 17:44:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A453EC433C7;
        Thu, 12 Oct 2023 00:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697071447;
        bh=gii1/SY/IIQ0trlQ2uqpr/lhWhqx2RSOhlKsZb9MFHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjbi5eqaRXNH3pe4v932grqsl0vVi3OqQtAF6gzwv9ba9dgmTy9bxxB1gl9HDL5tU
         +h7byR2/28RgO5vK3WIAbf6dbDgC1+T1h2yKrjT8ftknEZjlqfho7k8yA6tLEAkUg8
         wveMITdldXXDmJ2Z+sFHSM4exaq/LxWHXgfXGqgZRDBU2u9ZfmxBKm2fRPdesDxD+j
         IsbkdzUFYG94oLEWV8pML48aPj4gpCoJw1uMQMIRR0dnJcWCsSa8TyN3hnu39AdUXG
         2oJNdZk4uRnMPbyUkgseSIBRTEEHjCuugJeBQqJYHwzQ10ZaWOspWbxEE8ihwLEcM7
         d40+yzz1jOmrg==
Date:   Thu, 12 Oct 2023 08:43:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the imx-mxs tree with the net tree
Message-ID: <20231012004356.GR819755@dragon>
References: <20231012101434.1e5e7340@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012101434.1e5e7340@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:14:34AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the imx-mxs tree got a conflict in:
> 
>   arch/arm64/boot/dts/freescale/imx93.dtsi
> 
> between commit:
> 
>   23ed2be5404d ("arm64: dts: imx93: add the Flex-CAN stop mode by GPR")

Marc,

Is there any particular reason why this dts change needs to go via net
tree?  Otherwise, could you drop it from net and let it go via i.MX tree?

Shawn

> 
> from the net tree and commit:
> 
>   d34d2aa594d0 ("arm64: dts: imx93: add edma1 and edma2")
> 
> from the imx-mxs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
