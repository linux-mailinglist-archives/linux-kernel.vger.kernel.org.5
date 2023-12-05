Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B878053AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347070AbjLEL6y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Dec 2023 06:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347050AbjLEL6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:58:52 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31298;
        Tue,  5 Dec 2023 03:58:57 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1fb1620a00eso708909fac.1;
        Tue, 05 Dec 2023 03:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701777536; x=1702382336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSL9QExZG9P5l4mTBqjK/DgzgISuVuBfkBZthiusuiI=;
        b=EvIlCLBrNan04ODiCTkik6pdGse6h+uMnrHYSyaGn8FvGvAWHBxU5AznvKDbTTwGof
         bMh7MvseJnEEUt8ZM6gTo9Fy2/7iPy7m/SNMK4cZlUVkljIxh/3Ce1juxPX/fbEljR0Q
         bZ2rZz5mm2coGC/XNW/REEKS5VzV6atHl9wdgBnaD7HdbObpEWNitlYRdlrX7WQ0nbH9
         4GxMCDjgy+0O9KRQIMC+YKB3CRcIL5ZdS2aEDZa886f4oYMoFWFcmL6Q9BGnVMF+0A1T
         /gjItvTdapo8R9BlhA+VZrmgXbdBscUoZ5uyDjPsU5JX5qifMnK4dBVuRPrYCDcQX+AA
         Y9oA==
X-Gm-Message-State: AOJu0YyA6syXHCOcz/4tcZmJ9a5R4dy3CiFUxkCD4evBL0J8Z7Et72/8
        YQGDGRdYdkejXdUA+PkUULYqPemPDI7jDb2W7K18UGEK
X-Google-Smtp-Source: AGHT+IHNvB+T2rSjyBIGY6W2fYh/tu7ZWbs0fYLgN59gg8mrmMBnUYzBo/0dnMSnKAfDL/kEmG943bfYLJuumz5dNps=
X-Received: by 2002:a05:6870:440b:b0:1fb:23ec:3318 with SMTP id
 u11-20020a056870440b00b001fb23ec3318mr8617620oah.0.1701777536336; Tue, 05 Dec
 2023 03:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20231123100617.28020-1-raag.jadav@intel.com> <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
In-Reply-To: <ZW6iyu4qF0V7wCXG@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Dec 2023 12:58:44 +0100
Message-ID: <CAJZ5v0iCjD7hwBmFVZ7VcN=FMXhbTJ4Gvm=7X5tXBg3g0j1puA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Support _UID matching for integer types
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 5:11 AM Raag Jadav <raag.jadav@intel.com> wrote:
>
> On Thu, Nov 23, 2023 at 03:36:12PM +0530, Raag Jadav wrote:
> > This series updates the standard ACPI helpers to support _UID matching
> > for both integer and string types, and uses them in a couple of places.
> >
> > Changes since v2:
> > - Drop __builtin functions to reduce complexity (Rafael)
> > - Update tags
> >
> > Changes since v1:
> > - Fix build errors
>
> Bump.
>
> Anything I can do to move this forward?

It is on my list of pending material, I'll get to it this week (I think).

Thanks!
