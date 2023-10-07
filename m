Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B237BC6DF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343831AbjJGKlt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Oct 2023 06:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjJGKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:41:46 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F15193;
        Sat,  7 Oct 2023 03:41:45 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3af59a017a5so520448b6e.1;
        Sat, 07 Oct 2023 03:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696675304; x=1697280104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTW/418JZkwu1M4Lrtu4B4aaWXqu9uvEkO2zcTVWixQ=;
        b=QDGBZ65rhJHQocgEQp1TDLkgJ/bBPXLYLeOtSpzuuSZ8u6n1PaW8L/uxf6D74clgNX
         mmlpnku7HQkKTWNWhc0wg0NnsADsoQwkAZ/ysTG2AV/rRrAvBTnSS6oHBA1M6jH1nULD
         GMu6oQiekBFnGgnmHb7nXiE3btC5JYoFuNV23YZI0BkUSHGUW/BCAu10B1crKynozR9x
         hW2+OMJu2uVJM6QMBCSaMMLMgZkP4OXyuGTLe5+TU/1w/P0Kr1wD9FrpVlbjbpdoYgEV
         zveZYuD08axZfBgnIVEvO0bSjGGjqPCZlKG/IsFFbRhpAc9WycKr62ohFbqS7rWRVBse
         k0mQ==
X-Gm-Message-State: AOJu0YxCTwj8KbBmTp+dHKxei794qBcHPbXAH936bt/9fzFBw5HpagUP
        B/RQAePacnPddvd0VGKml2nCMoEMMdBiNXYlHxM=
X-Google-Smtp-Source: AGHT+IElnJy2W5QsXitT56398qgWSwz4X/Hh6r4lGHpWl5jLtHpoo5Mgk4b1e57UGg9q95IQOyrUu8EPj/9KcGfgC3M=
X-Received: by 2002:a05:6808:21a6:b0:3ad:ae0d:f845 with SMTP id
 be38-20020a05680821a600b003adae0df845mr13923287oib.5.1696675304578; Sat, 07
 Oct 2023 03:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com> <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com>
In-Reply-To: <ZSEPGmCyhgSlMGRK@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 7 Oct 2023 12:41:33 +0200
Message-ID: <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 9:56 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
> > <michal.wilczynski@intel.com> wrote:
>
> ...
>
> > >  struct acpi_ac {
> > >         struct power_supply *charger;
> > >         struct power_supply_desc charger_desc;
> > > -       struct acpi_device *device;
> > > +       struct device *dev;
> >
> > I'm not convinced about this change.
> >
> > If I'm not mistaken, you only use the dev pointer above to get the
> > ACPI_COMPANION() of it, but the latter is already found in _probe(),
> > so it can be stored in struct acpi_ac for later use and then the dev
> > pointer in there will not be necessary any more.
> >
> > That will save you a bunch of ACPI_HANDLE() evaluations and there's
> > nothing wrong with using ac->device->handle.  The patch will then
> > become almost trivial AFAICS and if you really need to get from ac to
> > the underlying platform device, a pointer to it can be added to struct
> > acpi_ac without removing the ACPI device pointer from it.
>
> The idea behind is to eliminate data duplication.

What data duplication exactly do you mean?

struct acpi_device *device is replaced with struct device *dev which
is the same size.  The latter is then used to obtain a struct
acpi_device pointer.  Why is it better to do this than to store the
struct acpi_device itself?
