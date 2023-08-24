Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39DF787457
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242227AbjHXPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242296AbjHXPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:34:26 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEAA1BCE;
        Thu, 24 Aug 2023 08:34:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A9257536;
        Thu, 24 Aug 2023 15:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A9257536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692891243; bh=m8PIWp3rkbepBP10suG7pdRXP/B1Q4PpkFk2I8j2j2o=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=M3X1rbBNwFgO/A5mukU7k2V/bycTKdJaobaECkAOUZW8QWRmf7u09CfjWkjuRRRHI
         TBKMWJUuz9fuxBCDG2mXWSAMs2GTZHN6suc5t0RcTSQIf3KSa4wUSJ4JsRuQkeUpWM
         LTF/5MWDLWGNaHiQ3bz6PFBIiowQ8uOXuxZPuBK6h+SsV5a9qErCMXc4gqGXUySuhP
         nzqEJdKlu6XZwAdkOu03jQGEc38tcGk7XttfpnnRV4vWmSoV8qFYi+yY8VblI0qQhK
         6S0ORRogn8cvxhTbgFtNfUDt7Rrm8DlWFVi9kSEsJHB3wzLD18MEvoXA9yCTR1EWrs
         L3dhj1N0KQpNQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: consolidate embedded interfaces
In-Reply-To: <CADDUTFx_o+kULEMbZWAECBKb4Fo85c303YiCUmgk50Z=7TSkkw@mail.gmail.com>
References: <20230725135537.2534212-1-costa.shul@redhat.com>
 <CADDUTFx_o+kULEMbZWAECBKb4Fo85c303YiCUmgk50Z=7TSkkw@mail.gmail.com>
Date:   Thu, 24 Aug 2023 09:34:03 -0600
Message-ID: <87il94tpxw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

> soft reminder 

I thought I was clear...I still don't see how this organization makes
sense.  What is "embedded" about misc devices?

Thanks,

jon

> On Tue, 25 Jul 2023 at 16:56, Costa Shulyupin <costa.shul@redhat.com> wrote:
>
>  to make page Subsystems APIs more organized as requested
>
>  Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
>  ---
>   Documentation/subsystem-apis.rst | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
>  diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
>  index 90a0535a932a..7453586114d4 100644
>  --- a/Documentation/subsystem-apis.rst
>  +++ b/Documentation/subsystem-apis.rst
>  @@ -60,20 +60,28 @@ Storage interfaces
>      scsi/index
>      target/index
>
>  -**Fixme**: much more organizational work is needed here.
>  +Embedded interfaces
>  +-------------------
>  +
>  +.. toctree::
>  +   :maxdepth: 1
>  +
>  +   iio/index
>  +   spi/index
>  +   i2c/index
>  +   fpga/index
>  +   w1/index
>  +   misc-devices/index
>  +
>  +**Fixme**: some organizational work is still needed here.
>
>   .. toctree::
>      :maxdepth: 1
>
>      accounting/index
>      cpu-freq/index
>  -   fpga/index
>  -   i2c/index
>  -   iio/index
>      leds/index
>      pcmcia/index
>  -   spi/index
>  -   w1/index
>      watchdog/index
>      virt/index
>      hwmon/index
>  @@ -83,6 +91,5 @@ Storage interfaces
>      bpf/index
>      usb/index
>      PCI/index
>  -   misc-devices/index
>      peci/index
>      wmi/index
>  -- 
>  2.41.0
