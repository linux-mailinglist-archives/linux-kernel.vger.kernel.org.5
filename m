Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586C07F18BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjKTQix convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 11:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjKTQiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:38:51 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2F1A1;
        Mon, 20 Nov 2023 08:38:44 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1cc28719cb0so8098135ad.0;
        Mon, 20 Nov 2023 08:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498324; x=1701103124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQOioIBEe44MwPtkyvqYFQAPmWMTxr0AHcSiFY3JvEw=;
        b=DnMQudJR3Wr000u/XnmjMYt2A53FuvP8uzDUW823YlkmghXdCM5i1gY/U9Pg21fI6N
         TT4NdHgZVXsMe95I4wZ3Oq5Yj8001scT01LUkPp8xNXK2/yFoilF49kFW8B2qmWFyy3a
         4lWsbES7L4/3vpfzhtCXEGmA29XR2ArwGGXfY2pY+rdI0BBdMxhp5IxJK7iCsNf3SiZU
         TksD4eC5W83vGD+MStab9ROqXvcMaovdq+MmqlTcOzKZTKMZa8OTVTsbUnXUarFseS9b
         c006qR++YBT4FsiXJw3XJlAM6XHQlVteF+TNQvtZvVDf3hyz6LTpSdfklUdWzQKS5pL+
         VarA==
X-Gm-Message-State: AOJu0YzDTui567Q3OQ4E/KKPxu1kiAx6l4uBDubDqsnDnoN9y2C1vHnk
        HtefUtKoHFuss7vviFDUXynf9C4IBIxstB5rXYY=
X-Google-Smtp-Source: AGHT+IHZxZmoC+y3JhyFoImDC8R1QNZWBDz2hZ4XJpcQr4bg8N5VcIMpm08Ag25h8Eor/wZ2zmtn31A4efX9X1F30zY=
X-Received: by 2002:a05:6a20:e125:b0:187:df59:5c43 with SMTP id
 kr37-20020a056a20e12500b00187df595c43mr12459064pzb.2.1700498323819; Mon, 20
 Nov 2023 08:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20231114-arm-build-bug-v1-1-458745fe32a4@linaro.org>
 <b2354c21-3a1a-c446-fee0-db0c78d05c71@gmail.com> <CAJZ5v0idWdJq3JSqQWLG5q+b+b=zkEdWR55rGYEoxh7R6N8kFQ@mail.gmail.com>
 <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
In-Reply-To: <41160dbf-d8c8-4dc0-9fda-42cc97df5b77@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 17:38:32 +0100
Message-ID: <CAJZ5v0jNOXKv2fHNGUDjDvvg6FGbXuahhH9dBhWiAwiPv3fH8A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: acenv: Permit compilation from within the kernel
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Sam Edwards <cfsworks@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 5:19 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
>
>
> On 11/20/23 08:46, Rafael J. Wysocki wrote:
> > On Tue, Nov 14, 2023 at 7:09 PM Sam Edwards <cfsworks@gmail.com> wrote:
> >>
> >> On 11/13/23 16:08, Linus Walleij wrote:
> >>> After commit a103f46633fd the kernel stopped compiling for
> >>> several ARM32 platforms that I am building with a bare metal
> >>> compiler. Bare metal compilers (arm-none-eabi-) don't
> >>> define __linux__.
> >>
> >> Hi Linus,
> >>
> >> I saw the same baremetal-compiler error here on the ARM64 side of the
> >> fence, and narrowed the problem to the same commit as you.
> >>
> >>>
> >>> This is because the header <acpi/platform/acenv.h> is now
> >>> in the include path for <linux/irq.h>:
> >>
> >> More generally, I think it's because of this addition to linux/acpi.h:
> >> +#include <linux/fw_table.h>
> >>
> >> linux/acpi.h is supposed to ensure _LINUX is defined (if it isn't
> >> already done by a non-baremetal compiler) before we start pulling in
> >> ACPICA includes, so that ACPICA knows the platform. But because
> >> fw_table.h contains:
> >> #include <linux/acpi.h>
> >> #include <acpi/acpi.h>
> >>
> >> ...the circular include does nothing (linux/acpi.h's include guard stops
> >> the include before _LINUX is defined) and we end up pulling in
> >> acpi/acpi.h before we're ready.
>
> Not including either causes compile errors for me.

Interesting.  What errors do you get if you include linux/acpi.h only?

It should not be necessary to include acpi/acpi.h in addition to
linux/acpi.h, because the latter is expected to include the former.
If it doesn't do that, something is amiss.

> And directly including acpi/acpi.h w/o linux/acpi.h causes triggering the #error and some other stuff:
>
> ./include/acpi/platform/aclinux.h:18:2: error: #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
>    18 | #error "Please don't include <acpi/acpi.h> directly, include <linux/acpi.h> instead."
>       |  ^~~~~
>
>
> Only including linux/acpi.h:
> In file included from ./include/linux/acpi.h:18,
>                  from init/main.c:30:
> ./include/linux/fw_table.h:32:37: error: field ‘common’ has incomplete type
>    32 |         struct acpi_subtable_header common;
>       |                                     ^~~~~~
> ./include/linux/fw_table.h:33:36: error: field ‘hmat’ has incomplete type
>    33 |         struct acpi_hmat_structure hmat;
>       |                                    ^~~~
> ./include/linux/fw_table.h:34:40: error: field ‘prmt’ has incomplete type
>    34 |         struct acpi_prmt_module_header prmt;
>       |                                        ^~~~
> ./include/linux/fw_table.h:35:33: error: field ‘cedt’ has incomplete type
>    35 |         struct acpi_cedt_header cedt;
>       |                                 ^~~~
>
>
> >
> > Yes, that's the problem AFAICS.  Dave?
> >
> > What about moving the fw_table.h include in linux/acpi.h below the
> > mutex.h one, along with the EXPORT_SYMBOL_ACPI_LIB-related
> > definitions?
>
> This builds cleanly for me.

OK, so I'm wondering if this also helps the other people in this thread.
