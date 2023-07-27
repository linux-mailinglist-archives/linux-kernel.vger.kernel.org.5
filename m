Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A01B7657A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjG0PaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjG0PaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:30:13 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECCB171D;
        Thu, 27 Jul 2023 08:30:11 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 209FD2CD;
        Thu, 27 Jul 2023 15:30:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 209FD2CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690471811; bh=liQq2dcD8ikYAEgx+GWN26TRs+v1bIlFG3MTf+1itqY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=avPa/rGgULsp1j+Cpn2BIWYNrjNSMozHL9lue2atTdqGANTUOuLXoKBpkC+KL0VbR
         1nZggUD7uNlCkl1kZLVVw172es5QALetfyfgTQHHK8qiK5yII7EU3eLq8syIg7jpMO
         jIDgBICSsTGpmeMfhxHxC2UOtG6nqUy8K6PGiSKsWsn9g8dUap05O6wEAD7zKC3Wd+
         0wLowEKT54mnR/+cWs+Xz6uHT8xdtqUehi8LC/j+f+PeJIR/5WLB/GbsmZsVz9lI3e
         7u8yEELx/fm+BBhr1wb3kdwFUisvruAz3p753//0Wwp1iok35JULL1g2YxvsgFXepZ
         vISupjmKZHhtg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Reaver <me@davidreaver.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        David Reaver <me@davidreaver.com>
Subject: Re: [PATCH] docs: ABI: sysfs-bus-nvdimm: fix unexpected indentation
 error
In-Reply-To: <20230727152234.86923-1-me@davidreaver.com>
References: <20230727152234.86923-1-me@davidreaver.com>
Date:   Thu, 27 Jul 2023 09:30:10 -0600
Message-ID: <87o7jx5q4d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Reaver <me@davidreaver.com> writes:

> Fix the following error when running make htmldocs:
>
> Documentation/ABI/testing/sysfs-bus-nvdimm:10: ERROR: Unexpected indentation.
>
> This is caused by missing newlines before the code examples. In particular,
> before this patch, the second example for ctl_res_cnt doesn't render properly.
>
> Link: https://docs.kernel.org/admin-guide/abi-testing.html#abi-sys-bus-event-source-devices-nmemx-format
>
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-nvdimm | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-nvdimm b/Documentation/ABI/testing/sysfs-bus-nvdimm
> index de8c5a59c77f..8564a0ff0d3e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-nvdimm
> +++ b/Documentation/ABI/testing/sysfs-bus-nvdimm
> @@ -18,7 +18,9 @@ Description:	(RO) Attribute group to describe the magic bits
>  		Each attribute under this group defines a bit range of the
>  		perf_event_attr.config. Supported attribute is listed
>  		below::
> +
>  		  event  = "config:0-4"  - event ID
>
>  		For example::
> +
>  			ctl_res_cnt = "event=0x1"
>
>  What:           /sys/bus/event_source/devices/nmemX/events

Thanks for the patch.  This problem is already fixed in docs-next,
though, and thus in linux-next as well.

jon
