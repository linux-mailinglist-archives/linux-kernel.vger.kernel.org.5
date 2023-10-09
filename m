Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1616B7BDBC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbjJIM2A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 08:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346554AbjJIM17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:27:59 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62AACA;
        Mon,  9 Oct 2023 05:27:56 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57b83ff7654so267106eaf.1;
        Mon, 09 Oct 2023 05:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696854476; x=1697459276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEFOPfZ+WmfDKLy1rOdw40S5bHAGj56vhBWEOoNahLc=;
        b=LEp5VgFt4I8onQp75e7ILxHLsgvZpG/bKqi1vpgQn1H4DQDZLcclNjtV6Zi0+ThBpp
         7lj1pguc9Nwc0FetLc5MVcsTJUmLytsJt2uqckBIEbg9rYSeBrlg51HNrgRIsh9vsTeK
         16mQpGdjrLLcnQH7rApVVeWIoIUxTDQTb3DBMnz4e0Y3vbO3QxQBYFkh2i5qoB87OI2C
         NmzRtD5+iJBBeWi253q8aQj4eSHxONJ9Vqlf1WXrmaV64JvR4Uy3g8GCV2nxDcHUUwOX
         ZPw/mlykJSPO8VShrEBSNsIaWWGIGsRHN/KcQflwMC8Bn/8BkDTKkYD2z7aw9dapo6GR
         4yMw==
X-Gm-Message-State: AOJu0YxqhvBupU5nF0koUVq4YdaZFnjD5r6m6saYgus0tqSiV/3a+Cku
        wZLTIPJitC09a/siJS1pWM2FM1f9MFbikJ3zESs=
X-Google-Smtp-Source: AGHT+IE16hjIAXtQbaTARMEtCEdUW23oYu18iT1kcYEb7pXOFT2vsR9IK17LNz/BFPtOYC2RZpJhsFgsHt1aeZyNDuQ=
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id
 t8-20020a4ab588000000b00578c2af45b5mr12916582ooo.0.1696854475961; Mon, 09 Oct
 2023 05:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com> <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com> <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
 <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com> <f8ff3c4b-376a-4de0-8674-5789bcbe7aa9@intel.com>
In-Reply-To: <f8ff3c4b-376a-4de0-8674-5789bcbe7aa9@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Oct 2023 14:27:43 +0200
Message-ID: <CAJZ5v0i4in=oyhXKOQ1MeoRP5fAhHdEFgZZp98N0pF8hB6BtbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] ACPI: AC: Replace acpi_driver with platform_driver
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev, rafael.j.wysocki@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:40 AM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
> Hi !
>
> Thanks a lot for a review, to both of you ! :-)
>
> On 10/7/2023 12:43 PM, Rafael J. Wysocki wrote:
> > On Sat, Oct 7, 2023 at 12:41 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Sat, Oct 7, 2023 at 9:56 AM Andy Shevchenko
> >> <andriy.shevchenko@intel.com> wrote:
> >>> On Fri, Oct 06, 2023 at 09:47:57PM +0200, Rafael J. Wysocki wrote:
> >>>> On Fri, Oct 6, 2023 at 8:33 PM Michal Wilczynski
> >>>> <michal.wilczynski@intel.com> wrote:
> >>> ...
> >>>
> >>>>>  struct acpi_ac {
> >>>>>         struct power_supply *charger;
> >>>>>         struct power_supply_desc charger_desc;
> >>>>> -       struct acpi_device *device;
> >>>>> +       struct device *dev;
> >>>> I'm not convinced about this change.
> >>>>
> >>>> If I'm not mistaken, you only use the dev pointer above to get the
> >>>> ACPI_COMPANION() of it, but the latter is already found in _probe(),
> >>>> so it can be stored in struct acpi_ac for later use and then the dev
> >>>> pointer in there will not be necessary any more.
> >>>>
> >>>> That will save you a bunch of ACPI_HANDLE() evaluations and there's
> >>>> nothing wrong with using ac->device->handle.  The patch will then
> >>>> become almost trivial AFAICS and if you really need to get from ac to
> >>>> the underlying platform device, a pointer to it can be added to struct
> >>>> acpi_ac without removing the ACPI device pointer from it.
>
> Yeah we could add platform device without removing acpi device, and
> yes that would introduce data duplication, like Andy noticed.

But he hasn't answered my question regarding what data duplication he
meant, exactly.

So what data duplication do you mean?

> And yes, maybe for this particular driver there is little impact (as struct device is not
> really used), but in my opinion we should adhere to some common coding
> pattern among all acpi drivers in order for the code to be easier to maintain
> and improve readability, also for any newcomer.

Well, maybe.

But then please minimize the number of code lines changed in this
particular patch and please avoid changes that are not directly
related to the purpose of the patch.

> >>> The idea behind is to eliminate data duplication.
> >> What data duplication exactly do you mean?
> >>
> >> struct acpi_device *device is replaced with struct device *dev which
> >> is the same size.  The latter is then used to obtain a struct
> >> acpi_device pointer.  Why is it better to do this than to store the
> >> struct acpi_device itself?
> > This should be "store the struct acpi_device pointer itself", sorry.
>
> Hi,
> So let me explain the reasoning here:
>
> 1) I've had a pleasure to work with different drivers in ACPI directory. In my
>     opinion the best ones I've seen, were build around the concept of struct
>     device (e.g NFIT). It's a struct that's well understood in the kernel, and
>     it's easier to understand without having to read any ACPI specific code.
>     If I see something like ACPI_HANDLE(dev), I think 'ah-ha -  having a struct
>     device I can easily get struct acpi_device - they're connected'. And I think
>     using a standardized macro, instead of manually dereferencing pointers is
>     also much easier for ACPI newbs reading the code, as it hides a bit complexity
>     of getting acpi device from struct device. And to be honest I don't think there would
>     be any measurable performance change, as those code paths are far from
>     being considered 'hot paths'. So if we can get the code easier to understand
>     from a newcomer perspective, why not do it.

I have a differing opinion on a couple of points above, and let's make
one change at a time.

>
> 2) I think it would be good to stick to the convention, and introduce some coding
>      pattern, for now some drivers store the struct device pointer, and other store
>      acpi device pointer . As I'm doing this change acpi device pointer become less
>      relevant, as we're using platform device. So to reflect that loss of relevance
>      we can choose to adhere to a pattern where we use it less and less, and the
>      winning approach would be to use 'struct device' by default everywhere we can
>      so maybe eventually we would be able to lose acpi_device altogether at some point,
>      as most of the usage is to retrieve acpi handle and execute some AML method.
>      So in my understanding acpi device is already obsolete at this point, if we can
>      manage to use it less and less, and eventually wipe it out then why not ;-)

No, ACPI device is not obsolete, it will still be needed for various
things, like power management and hotplug.

Also, I'd rather store a struct acpi_device than acpi_handle, because
the latter is much better from the compile-time type correctness
checks and similar.

I can send my version of the $subject patch just fine if you strongly
disagree with me.
