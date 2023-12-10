Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48280BAA1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjLJMQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjLJMQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:16:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AA5101
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:16:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF45EC433C8;
        Sun, 10 Dec 2023 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702210599;
        bh=86Fb/TnZD6UZ4D6D/ON2+9C91eIICKisOjrDG7Nsb38=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WJlbcfpxB+33Duifi28ytoTIWRIg4aSukwbAMIXaWrASDRlHvATPvQYn3kWGO0251
         p4eq9KCsXj+4qwLE1p+DKyEf5oB+X3f9fC+JwXVqEy3fvqlg/3mWFjWXSNXQC3hVAN
         QxVqnAY8wp+2R+LNOyl/8j5iyoRJvqe/L3AZarS4ZMvFKfi1PNJ4BK+mIOEiqvS6zI
         NhrqqJgXzsjZqERXoJ1nbaPsxQWEpw78rxpvrAXADS9y8ae0jNge/D/xSycJTlqM8W
         N/NzaK0bNAniXPIDqg5LzUt+mW94CV8H8doZBTYsxThnZfhktgRDHWdSXyJSOh/4Y6
         yARn9ck4xhnOw==
Date:   Sun, 10 Dec 2023 12:16:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petre Rodan <petre.rodan@subdimension.ro>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series
Message-ID: <20231210121632.12ff9640@jic23-huawei>
In-Reply-To: <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
References: <20231207164634.11998-1-petre.rodan@subdimension.ro>
        <20231207164634.11998-2-petre.rodan@subdimension.ro>
        <ZXIPUphL8ZEYDQxk@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 20:30:42 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Dec 07, 2023 at 06:46:29PM +0200, Petre Rodan wrote:
> > Adds driver for digital Honeywell TruStability HSC and SSC series
> > pressure and temperature sensors.
> > Communication is one way. The sensor only requires 4 bytes worth of
> > clock pulses on both i2c and spi in order to push the data out.
> > The i2c address is hardcoded and depends on the part number.
> > There is no additional GPIO control.
> > code is now based on iio/togreg  
> 
> There is room to improve, but I think it's good enough to be included and
> amended later on if needed.
That's almost always true :)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
Thanks

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it and see if it can find anything we missed.

Thanks,

Jonathan


