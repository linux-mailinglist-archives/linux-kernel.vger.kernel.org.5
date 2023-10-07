Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1997BC6E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 12:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbjJGKnY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 7 Oct 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343817AbjJGKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 06:43:22 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C98F692;
        Sat,  7 Oct 2023 03:43:19 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3ae473c0bd6so519193b6e.0;
        Sat, 07 Oct 2023 03:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696675399; x=1697280199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI+7EOVOyPWCiOOc7dvfxOKmEPx6gMqHAT3wBewOPrU=;
        b=CZI338f1HDEFFafiz5qjR7BeSR4m8uJbnPShA1LRCIV+shGic6t/7bnrtlDwFHdySj
         4FRmmgzrdc446sSqukw9sx+veRLQBWm5urJqxHnLtKbSWf36ONTdz+G2Xi/CpoH6VY4q
         9XxdHtlYk413j0nt2qDW/KJvnN+8cE8fYCy+l5kHEEbL3Ny4PMWHTeaGbGQQOyXlApFc
         mEni6B/homN7wNmp6dVrxUwfO5PcXeeXEBtKaMfzHP5RPXm+01cHxCbXNAGgwosvftws
         U9YwGliseTm39ee2kxT9Di8D+ClssgfbPpryOh928ryCHgZsiwIBJICvuPP97oEjRimG
         lT9Q==
X-Gm-Message-State: AOJu0YxLnVunWOj3tCZNSSG0jILOgD+SY8yEgNCUpzLRZpRNwXT65nfN
        P8ND1GcceF9djWRkPhMU/sMx4oWsYJxiEWYlsGM=
X-Google-Smtp-Source: AGHT+IF4LTmFQxadykDborHwetJ8pqWYYn9LbUePEy92IubMBSP9Q7MycDhRevGCicsDfB5lyYt5dAsDZjloWlQ3uz0=
X-Received: by 2002:a05:6820:390:b0:57c:6e35:251e with SMTP id
 r16-20020a056820039000b0057c6e35251emr10038284ooj.1.1696675399094; Sat, 07
 Oct 2023 03:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com> <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com> <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 7 Oct 2023 12:43:08 +0200
Message-ID: <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
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

On Sat, Oct 7, 2023 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Sat, Oct 7, 2023 at 9:56 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
> > > On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
> > > <michal.wilczynski@intel.com> wrote:
> >
> > ...
> >
> > > >  struct acpi_ac {
> > > >         struct power_supply *charger;
> > > >         struct power_supply_desc charger_desc;
> > > > -       struct acpi_device *device;
> > > > +       struct device *dev;
> > >
> > > I'm not convinced about this change.
> > >
> > > If I'm not mistaken, you only use the dev pointer above to get the
> > > ACPI_COMPANION() of it, but the latter is already found in _probe(),
> > > so it can be stored in struct acpi_ac for later use and then the dev
> > > pointer in there will not be necessary any more.
> > >
> > > That will save you a bunch of ACPI_HANDLE() evaluations and there's
> > > nothing wrong with using ac->device->handle.  The patch will then
> > > become almost trivial AFAICS and if you really need to get from ac to
> > > the underlying platform device, a pointer to it can be added to struct
> > > acpi_ac without removing the ACPI device pointer from it.
> >
> > The idea behind is to eliminate data duplication.
>
> What data duplication exactly do you mean?
>
> struct acpi_device *device is replaced with struct device *dev which
> is the same size.  The latter is then used to obtain a struct
> acpi_device pointer.  Why is it better to do this than to store the
> struct acpi_device itself?

This should be "store the struct acpi_device pointer itself", sorry.
