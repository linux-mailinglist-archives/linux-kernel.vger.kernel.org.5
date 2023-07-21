Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C712775D5EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGUUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGUUri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:47:38 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8B30E2;
        Fri, 21 Jul 2023 13:47:37 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 02D0A733;
        Fri, 21 Jul 2023 20:47:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 02D0A733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1689972457; bh=uooNNHsnavtZDFWMnhrK7qfIkdzRUtt/iYGfwA0MW60=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q5E12EouGHqAxrE/YXKVPqx/ucr3m21SL8SWzG99/mguvQ0EHTDbwSgcck7cWeBJs
         NTH4XtLvQ3eJqaL33fcNC71w99DHsM9BzlEm0QbzaNHfcjkGrZBC7LBcqdjqE5vfd8
         +BCf1KA5/cc2l12aNMFqAx4i2gjOZmuLeXawjVzZQUy1JW3amntPUKcJhYvCemAx+3
         RzZzIrbhZ5Dk2RKmQusAJ6wJwxWZyzL5xrtDRmAm1qwY+tBilPdusDsLXF2ijOHcAq
         OlqeATWzhuDpNgv6nCa08FWqDEbVLCzpmq6FzwkxiHziOZ26yKkkXAkuLpz43soneI
         T/Ll/5J+pxwRQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>, dan.j.williams@intel.com,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        hdegoede@redhat.com
Cc:     Hu Haowen <src.res.211@gmail.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: sysfs-bus-nvdimm: correct indentations
In-Reply-To: <20230716161443.1375-1-src.res.211@gmail.com>
References: <20230716161443.1375-1-src.res.211@gmail.com>
Date:   Fri, 21 Jul 2023 14:47:35 -0600
Message-ID: <87h6pxc7q0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hu Haowen <src.res.211@gmail.com> writes:

> The identations from line 1 to 4 within sysfs-bus-nvdimm were wrongly
> incompatible with the indentations of the following contents. Hence
> correct them.
>
> Discovered when I was executing "make htmldocs" and received the
> following stderr output:
>
>     /<... root dir ...>/Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.
>
> Signed-off-by: Hu Haowen <src.res.211@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index de8c5a59c77f..8d048f8e3c39 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -1,7 +1,7 @@
> -What:          nvdimm
> -Date:          July 2020
> -KernelVersion: 5.8
> -Contact:       Dan Williams <dan.j.williams@intel.com>
> +What:           nvdimm
> +Date:           July 2020
> +KernelVersion:  5.8
> +Contact:        Dan Williams <dan.j.williams@intel.com>
>  Description:

There's only one little problem ... that's not where the error was, so
this change doesn't actually make the warning go away.

I've committed the following instead.

Thanks,

jon

docs: ABI: fix an RST error in sysfs-bus-nvdimm

The literal blocks in this file lacked the necessary blank line at the top,
causing Sphinx to complain:

  /Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.

Add the lines it's longing for and bring about a bit of warning peace.

Reported-by: Hu Haowen <src.res.211@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/ABI/testing/sysfs-bus-nvdimm | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
index de8c5a59c77f..64eb8f4c6a41 100644
--- a/Documentation/ABI/testing/sysfs-bus-nvdimm
+++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
@@ -18,10 +18,12 @@ Description:	(RO) Attribute group to describe the magic bits
 		Each attribute under this group defines a bit range of the
 		perf_event_attr.config. Supported attribute is listed
 		below::
+
 		  event  = "config:0-4"  - event ID
 
 		For example::
-			ctl_res_cnt = "event=0x1"
+
+		  ctl_res_cnt = "event=0x1"
 
 What:           /sys/bus/event_source/devices/nmemX/events
 Date:           February 2022
-- 
2.41.0

