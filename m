Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7520080284B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjLCWG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 17:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjLCWG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 17:06:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8EB107
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 14:06:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2415EC433C8;
        Sun,  3 Dec 2023 22:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701641191;
        bh=qldAQbGBW+m2Iv0KMth20Gs21ONUyoDeYfrXlBQU2To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJT1fu5eBo/UpN/4kLRKKSASIzIfeG1LiS2Gb77HsVGWvsait1zj6o+uHHQFfU5oL
         yiKyYxgOhqWev8bAYzzr6dWiD9aO24Usj3hYxMpqqAuiDAFZG8sx0qlmKMOhT5CQHw
         P/WgnGJ99buJO06uM8F+hTuCgroadCAhYEFUqcNHqscPzZ8OCPAQ6cKeD5S1S6AqBH
         JRYDJBZECk+79tWmm2D1Oc7UyI5lLEq8mF+3DlSGo35iBXZRD26/hjic9T6YsTXNKk
         6w6w26srSthcEFR8UQE+WcyqJbp8W7Pg7b5qJOeOmkBKvuwjjPBJ9a+k7NGfEQpLmA
         c1wrBTkXl27xw==
Date:   Sun, 3 Dec 2023 23:06:26 +0100
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
Subject: Re: [PATCH v4 19/24] i2c: designware: Uninline i2c_dw_probe()
Message-ID: <20231203220626.ild5flvaqvlsqbmy@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-20-andriy.shevchenko@linux.intel.com>
 <20231129232151.ueum2axn74qzuzes@zenone.zhora.eu>
 <ZWiN8sY-I8cyNWCs@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiN8sY-I8cyNWCs@smile.fi.intel.com>
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

On Thu, Nov 30, 2023 at 03:28:18PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 30, 2023 at 12:21:51AM +0100, Andi Shyti wrote:
> > Hi Andy,
> > 
> > On Mon, Nov 20, 2023 at 04:42:01PM +0200, Andy Shevchenko wrote:
> > > Since i2c_dw_probe() is going to be extended, uninline it to reduce
> > > the noise in the common header.
> > 
> > where is it going to be extended? It's not in thie series. I'm
> > fine with the patch anyway as it cleans up the header file.
> 
> It's used to be in the previous versions of the series where I have
> device_set_node() API to be used.

Thanks! I think this missed:

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Andi
