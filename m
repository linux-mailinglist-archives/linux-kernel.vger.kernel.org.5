Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01FC5811908
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377627AbjLMQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjLMQSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:18:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C46619F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:18:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65902C433C7;
        Wed, 13 Dec 2023 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702484338;
        bh=KKtcCxUBiYEf/ALdZbGfMASRpIGnU7Bu8dtqIeEgDsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oo6LBVHrptCd7MKbR7lQ0IdPWsvdjqwSdmXOFwlaku+/UoTXVmsUn7oHh2to6ftjG
         N7efZNWJw5aD3jrdZpKXE3mUyrHXd57nfH54UAIJonJ9SVbjgXSSiPNu4DHrOMgK2u
         WiTiUKSDruB3sK9YGa3LhzKnlwijGWiRdryfGv1UCcMKVrJZ2N19xvbnMVmH/8H+0I
         O24Ku/aZo0XJsV1s4DvcR6FIm97l0sPWHqTva3x51w4m+Z7lmzvGRI6YPeUe53SrGs
         RPhLbQOAQ7T2Z3z0ST0opSLTrE+CUGN+/OyEXXsK0tEA/mJDWJxWSLfAXsCRfE0xCf
         FP0eGmt3ewgtw==
Date:   Wed, 13 Dec 2023 16:18:54 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <20231213161854.GR111411@google.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
 <20231213161352.GQ111411@google.com>
 <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023, Andy Shevchenko wrote:

> On Wed, Dec 13, 2023 at 04:13:52PM +0000, Lee Jones wrote:
> > On Mon, 11 Dec 2023, Andy Shevchenko wrote:
> 
> ...
> 
> > >  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> > > +					      0, lpss->priv, 1, 15, 16, 15,
> > >  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> > > -					      lpss->priv, 1, 15, 16, 15, 0,
> > >  					      NULL);
> > 
> > What an ugly interface.  Intel-only too, right?
> 
> Nope, de facto way how custom clocks are being introduced.
> See clk-provider.h for several similar APIs (that require an
> additional, custom, flags to be supplied).

This call only has 2 call-sites, both Intel.

Anyway, just checking to ensure both are being fixed-up.

-- 
Lee Jones [李琼斯]
