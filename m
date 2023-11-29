Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D67FCC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjK2Ar3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 19:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK2Ar1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 19:47:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5205510C1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 16:47:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9ED5C433C8;
        Wed, 29 Nov 2023 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701218854;
        bh=T3oSnu23CiLc/ppZ560z8WBsWJDQuNlw2P+rkqW8w+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cz0qJS7ZR4XDVRukpVgCtunRftXagH3R1kYCt2T0lQ5xrSdeIkbIhTfoCxX+K9lAe
         4nhbqQzxM0L6DJY1m4EB8TCHcRM5VsUlabcz1iNpC9VlX3695WXcUl+hnbME1Hp55N
         HydCNeCBzuY44+qkWTDASdbrfp0IMeSsyO/ba2GLhnFgv5uO4R8NW/KlGzI9EnRr/w
         1Ki+cd/250TMEDLc+SNJTORhoGYAm+Og7n5jJgcwr3shBJr5BovV3Sf7icxgGRdMvf
         D1cgjwsg5bUwCwsBS/WgPG7bpUd3NH/CR13Ks2aSCrYuscTKY03ZytgjVDlb57o+PM
         jqTvf68ire8Pg==
Date:   Wed, 29 Nov 2023 01:47:30 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 17/24] i2c: designware: Remove ->disable() callback
Message-ID: <20231129004730.hjnvtku3r4dzpn5f@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-18-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-18-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:41:59PM +0200, Andy Shevchenko wrote:
> Commit 90312351fd1e ("i2c: designware: MASTER mode as separated driver")
> introduced ->disable() callback but there is no real use for it. Both
> i2c-designware-master.c and i2c-designware-slave.c set it to the same
> i2c_dw_disable() and scope is inside the same kernel module.
> 
> That said, replace the callback by explicitly calling the i2c_dw_disable().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
