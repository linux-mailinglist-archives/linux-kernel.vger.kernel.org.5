Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E755A7A9662
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjIURAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjIURAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:00:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E611FC6;
        Thu, 21 Sep 2023 09:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3301C116A7;
        Thu, 21 Sep 2023 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293924;
        bh=k+oWmq5/Pe7Ad2WcpmyGau4Su5RU02XWHcpF3f+bt0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HCd5uoxI0DYs1sKTBnlJPv2cLm4Epi1yRRD8+m26r6LgCADejdZVkWauBM59S7mm9
         GX5xCgkd/P6zTkI8buwrmtvfsYVcqygtl29+bO+cBeY5lqlYpR7m0utuFrNOdyO6N3
         7HWVjyQjVcDgx4890o4qiegTVGhs/4gGgDKZs0tq6BfaQGiUhlvfUC8kcSIW6e9WW6
         v4gK31Dzm/eEIXnzFolY31bnuofJjQOukchp9rxphgPRT9Md2pTWlMr51ZX4hDVueH
         szWamPr5YQn4GzOPMhMYaHfyywfI7TQIsUPfYCELt2XqhlC05lbkYSFO6OMU/jufim
         Rp81aVO8E0wtw==
Date:   Thu, 21 Sep 2023 11:58:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Larry Lai <larry.lai@yunjingtech.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "GaryWang@aaeon.com.tw" <GaryWang@aaeon.com.tw>,
        Musa Lin <musa.lin@yunjingtech.com>,
        Jack Chang <jack.chang@yunjingtech.com>,
        Noah Hung <noah.hung@yunjingtech.com>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggVg==?= =?utf-8?Q?6?= 2/3] pinctrl:
 Add support pin control for UP board CPLD/FPGA
Message-ID: <20230921105838.GF3449785@google.com>
References: <20230915031123.14515-1-larry.lai@yunjingtech.com>
 <20230915031123.14515-3-larry.lai@yunjingtech.com>
 <CACRpkdbi0bS0yiJ9ac6Z44os0w6FyKm+UsvbgQEYzYKymjww-w@mail.gmail.com>
 <SEYPR06MB65077401CD3AA45A9D5E5C97F9FAA@SEYPR06MB6507.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEYPR06MB65077401CD3AA45A9D5E5C97F9FAA@SEYPR06MB6507.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023, Larry Lai wrote:

> Hi Linus, 
> 
>        Thank you for spending time to review the V6 patch, for your question, please kindly to check our comments with ">>" beginning.

I don't know about anyone else, but I'm finding this format hard to
read.  A full conversation using this style would be impossible to
decipher.

Please can you configure your editor/client to quote and reply properly?
That way previous responses and your comments can be easily
differentiated.

> 寄件者: Linus Walleij <linus.walleij@linaro.org>
> 寄件日期: 2023年9月15日 下午 05:02
> 收件者: Larry Lai <larry.lai@yunjingtech.com>
> 副本: lee@kernel.org <lee@kernel.org>; andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.com>; pavel@ucw.cz <pavel@ucw.cz>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; linux-gpio@vger.kernel.org <linux-gpio@vger.kernel.org>; linux-leds@vger.kernel.org <linux-leds@vger.kernel.org>; GaryWang@aaeon.com.tw <GaryWang@aaeon.com.tw>; Musa Lin <musa.lin@yunjingtech.com>; Jack Chang <jack.chang@yunjingtech.com>; Noah Hung <noah.hung@yunjingtech.com>
> 主旨: Re: [PATCH V6 2/3] pinctrl: Add support pin control for UP board CPLD/FPGA 

Your client should automatically strip this from the mail body.
>  
> On Fri, Sep 15, 2023 at 5:12 AM larry.lai <larry.lai@yunjingtech.com> wrote:
> 
> > The UP Squared board <http://www.upboard.com> implements certain
> > features (pin control) through an on-board FPGA.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Gary Wang <garywang@aaeon.com.tw>
> > Signed-off-by: larry.lai <larry.lai@yunjingtech.com>
> 
> This v6 overall looks good to me!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Can the patch be merged on its own?
> 
> > +#include "core.h"
> > +#include "intel/pinctrl-intel.h"
> 
> Didn't notice this before. But if Andy is OK with it, I'm
> OK with it, I guess there is a reason? Perhaps it warrants
> a comment explaining why you do this?
> >>
> Need struct intel_pinctrl gpp information to control dedicated Raspberry Pi compatible GPIOs. 
> These products (Up boards) are intel approves foundation kits.
> 
> Valid reasons:
> - You are using Intel-specific HW features also found in this
>    FPGA
> 
> Invalid reasons:
> - Using nifty macros or helpers, then either make them generic
>   or (if they are small) duplicate them.
> 
> If it was that thing I asked Andy to keep locally because I didn't
> agree with its generic usefulness, maybe I should be told to
> reconsider.
> 
> Yours,
> Linus Walleij

-- 
Lee Jones [李琼斯]
