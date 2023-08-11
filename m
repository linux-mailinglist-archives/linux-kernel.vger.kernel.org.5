Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8447789FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 11:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjHKJd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjHKJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 05:33:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CE3271E;
        Fri, 11 Aug 2023 02:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691746403; x=1723282403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=d0hT4879fMQpRw9FZEoq0nUoQYAeQnv07LCy31EVohE=;
  b=QSTqdh4njowGgyCcS9Q099JAGcUQX4Vs8oGg5VjaMBMPk5ZzsODb4J1E
   pbh+DCYV5pPdepYPiwqz2vLWAfMN4BT6xRXyls+XIgXplj2OrVKxqrHpZ
   Ad8qYc3RQnClTjv+bo1gji2JWaBZNGCAziYG0TEfdYn1rXJpt63XMAytY
   7oJdrlq3fo38dqM3VoMZZrU+cPVvng8IDqGriKoEdHqCBz/5CMzikRDj8
   khIZhSkc8HCbwRew54VRX42j0lfwh2kf3jyx9Xgsq/iUGB1llthaji0i1
   qUdEWtqyefU+/5zM+ACRdtztBxBf8G0WQnoozYUIKATJhOGmMKWlHF3Vj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="369109561"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="369109561"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="735728561"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="735728561"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2023 02:33:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qUOWC-008i8T-2V;
        Fri, 11 Aug 2023 12:33:16 +0300
Date:   Fri, 11 Aug 2023 12:33:16 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Message-ID: <ZNYAXK69CIiBhiRT@smile.fi.intel.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
 <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
 <CAB9BWhcPpZRNPki1j0spCzN0kF=-1P1ZwtOLULmr2Raz6aO-_w@mail.gmail.com>
 <ZNTtl9MKHWWbqpnq@smile.fi.intel.com>
 <CAB9BWhd6cmYSGXF33hKMq6x0USm+tjFCKLZHRvj7aPXuomDzng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB9BWhd6cmYSGXF33hKMq6x0USm+tjFCKLZHRvj7aPXuomDzng@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:31:01PM +0800, wenhua lin wrote:
> On Thu, Aug 10, 2023 at 10:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 10, 2023 at 08:42:36PM +0800, wenhua lin wrote:
> > > On Tue, Aug 8, 2023 at 9:51 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Aug 08, 2023 at 03:25:01PM +0800, Wenhua Lin wrote:

...

> > > > > +     u32 rows_en; /* enabled rows bits */
> > > > > +     u32 cols_en; /* enabled cols bits */
> > > >
> > > > Why not bitmaps?
> > >
> > > Bitmap has been used, each bit represents different rows and different columns.
> >
> > I meant the bitmap type (as of bitmap.h APIs).
> 
> I understand what you mean, I need to study how this bitmap is used.

Input subsystem already is using them.

...

> > > > > +static int sprd_keypad_parse_dt(struct device *dev)
> > > >
> > > > dt -> fw
> > >
> > > I don't quite understand what you mean,。
> > > is it to change the function name to sprd_keypad_parse_fw?
> >
> > Yes. And make it firmware (which may be ACPI/DT or something else).
> 
> We need to think about how to modify it.

As I told already, replace mention of "DT"/"OF" by "firmware" and use device
property APIs as per property.h.

...

> > > > And I'm wondering if input subsystem already does this for you.
> > >
> > > I don't quite understand what you mean.
> >
> > Does input subsystem parse the (some of) device properties already?
> 
> Yes

Does it cover what you are parsing here? At least partially...

...

> > > > > +err_free:
> > > > > +     devm_kfree(&pdev->dev, data);
> > > >
> > > > Huh?!
> >
> > It's a red flag, and you have no answer to it...
> 
> I realized the problem, the interface using devm_  does not need to do the free.
> I will fix this issue in patch v2.

The problem is to understand where you can and where you can't use devm_*()
in the first place. _Then_ as you said.

> > > > > +     return ret;

...

> > > > > +             .owner = THIS_MODULE,
> > > >
> > > > ~15 years this is not needed.
> > > > Where did you get this code from? Time machine?
> > >
> > > Do you mean the keypad driver is no longer in use?
> >
> > No, I meant specifically emphasized line.
> 
> The keypad driver code is used on the platform
>  and has not been submitted to the community.

I'm not sure I understand to what you reply here...
I'm talking about the "owner" member assignment in the respective
data structure.

-- 
With Best Regards,
Andy Shevchenko


