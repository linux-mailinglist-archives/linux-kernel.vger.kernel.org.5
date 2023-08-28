Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E178B69E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjH1Rgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbjH1RgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:36:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74124129;
        Mon, 28 Aug 2023 10:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A887619A9;
        Mon, 28 Aug 2023 17:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D76C433C7;
        Mon, 28 Aug 2023 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693244171;
        bh=khAhSNkkvgPxvpni4X10fm1fWoh1aSP8vHZAonVLaU4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XaDSnFJYFj7sGgMHoiKHyFZ93lu1oHgVpElveESQZkJ01Hk2Cu2YtLMYw1+/ltyn1
         bYBAQ/Ny1zpoBa05DPq/NY0EyYsdvcwxUe4AGR30S2jvqM7azI/OA0CN38680illAE
         tX7QYtK1xnwzHiFppbKMZZfTuSdyE8iD7sPO+3mbc+dxdU9dmoAjmVzeCbLhJ9MKmH
         JZxquIxyClFWs7H0eN+j24gcQdroYAyE54QKTDscaw79a9gypSQgrVedVo9cTRKnAe
         llqtYaiZeybJU00+CujJQFueFCmXazZ2Y0PJXvL6QpLLuwsB+GlmCcJY1fc3FiVFuq
         R2YQY0irSPVyQ==
Date:   Mon, 28 Aug 2023 18:36:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: msa311: Use correct header(s)
 instead of string_helpers.h
Message-ID: <20230828183630.54b3fb35@jic23-huawei>
In-Reply-To: <20230809064723.24jgjgr7pclzz5yo@CAB-WSD-L081021>
References: <20230808164152.66748-1-andriy.shevchenko@linux.intel.com>
        <20230809064723.24jgjgr7pclzz5yo@CAB-WSD-L081021>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 09:47:23 +0300
Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> Hello Andy,
> 
> Thank you for the patch!
> 
> On Tue, Aug 08, 2023 at 07:41:52PM +0300, Andy Shevchenko wrote:
> > There is nothing from string_helpers.h used in the driver, correct
> > the header inclusion block accordingly.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> 
> Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> 
Applied

Thanks,
J
> > ---
> >  drivers/iio/accel/msa311.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> > index 6ddcc3c2f840..b8ddbfd98f11 100644
> > --- a/drivers/iio/accel/msa311.c
> > +++ b/drivers/iio/accel/msa311.c
> > @@ -33,7 +33,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regmap.h>
> > -#include <linux/string_helpers.h>
> > +#include <linux/string_choices.h>
> >  #include <linux/units.h>
> >  
> >  #include <linux/iio/buffer.h>
> > -- 
> > 2.40.0.1.gaa8946217a0b
> >   
> 

