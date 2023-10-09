Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37637BE8B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbjJIRvj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 13:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346636AbjJIRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:51:38 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7C91;
        Mon,  9 Oct 2023 10:51:37 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-57c0775d4fcso601809eaf.0;
        Mon, 09 Oct 2023 10:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873896; x=1697478696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQBtcxUEBTteAt95r1bhShJsO6XhiQD8q2TBwfTAy8Y=;
        b=a27bL+5hUMdadMar1HdOrLQgvXFxc0nCTQXNIwpudT3K+tiDJpqtk2OYpdKlRA7XsN
         R5ZVLSYodOcYFp/Yx298TpKJvOV6znQ/yzXdDA3YSSthlGBf5v6VRZMbDaBewijbECSM
         rmCFwGdj6yHuDsvs+lbojVfrRdTkEgBHuNl0J/6VFsBGG6VXW/cjmSht4QldvjCoY2Wp
         WyxvEbEa5k712Brj5KkJvQ7eWmiGeGAu4FbNzfBdHviKxuz3rhen9UDgwJWlhwWAM20z
         DjdL263SqP5Y/cjI87PIuChdyQeViSfTfWASjN4wLdd5CKryD7vgzJJurM6Iwh3srZgc
         LDNA==
X-Gm-Message-State: AOJu0YxQ+YcEF+pOO2UZMvRrZCFA7EonA7h+EMB31oMd8urCBA17I2m1
        rcOb4FYzPBvvC1teZDb/a15COOcK8GLSYkKtNWw=
X-Google-Smtp-Source: AGHT+IGUmF/LVHHrOgPdHxSjp/xIgIZDRO1132XTPnCUXW1CQVgDWzrxUZ1VxL2ND11CHY8bBqQ/04JupLN2zIbwRQs=
X-Received: by 2002:a4a:de08:0:b0:56e:94ed:c098 with SMTP id
 y8-20020a4ade08000000b0056e94edc098mr14198631oot.0.1696873896270; Mon, 09 Oct
 2023 10:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
 <20231006173055.2938160-4-michal.wilczynski@intel.com> <CAJZ5v0jKJ6iw6Q=uYTf0at+ESkdCF0oWaXRmj7P5VLw+QppKPw@mail.gmail.com>
 <ZSEPGmCyhgSlMGRK@smile.fi.intel.com> <CAJZ5v0gF0O_d1rjOtiNj5ryXv-PURv0NgiRWyQECZZFcaBEsPQ@mail.gmail.com>
 <CAJZ5v0iDhOFDX=k7xsC_=2jjerWmrP+Na-9PFM=YGA0V-hH2xw@mail.gmail.com>
 <f8ff3c4b-376a-4de0-8674-5789bcbe7aa9@intel.com> <CAJZ5v0i4in=oyhXKOQ1MeoRP5fAhHdEFgZZp98N0pF8hB6BtbQ@mail.gmail.com>
 <be180b68-d31f-4e7f-aeaa-071be74e2696@intel.com>
In-Reply-To: <be180b68-d31f-4e7f-aeaa-071be74e2696@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Oct 2023 19:51:25 +0200
Message-ID: <CAJZ5v0g=MkRwFQ88SQfRcvwnii5VnXujC7ZUaDsncodNkzdNdQ@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 3:04 PM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 10/9/2023 2:27 PM, Rafael J. Wysocki wrote:
> > On Mon, Oct 9, 2023 at 10:40 AM Wilczynski, Michal
> > <michal.wilczynski@intel.com> wrote:
> >>

[cut]

> >> Yeah we could add platform device without removing acpi device, and
> >> yes that would introduce data duplication, like Andy noticed.
> > But he hasn't answered my question regarding what data duplication he
> > meant, exactly.
> >
> > So what data duplication do you mean?
>
> So what I meant was that many drivers would find it useful to have
> a struct device embedded in their 'private structure', and in that case
> there would be a duplication of platform_device and acpi_device as
> both pointers would be needed.

It all depends on how often each of them is going to be used in the
given driver.

This particular driver only needs a struct acpi_device pointer if I'm
not mistaken.

> Mind this if you only have struct device
> it's easy to get acpi device, but it's not the case the other way around.
>
> So for this driver it's just a matter of sticking to convention,

There is no convention in this respect and there is always a tradeoff
between using more memory and using more CPU time in computing in
general, but none of them should be wasted just for the sake of
following a convention.

> for the others like it would be duplication.

So I'm only talking about the driver modified by the patch at hand.

> In my version of this patch we managed to avoid this duplication, thanks
> to the contextual argument introduced before, but look at this patch:
> https://github.com/mwilczy/linux-pm/commit/cc8ef52707341e67a12067d6ead991d56ea017ca
>
> Author of this patch had to introduce platform_device and acpi_device to the struct ac, so
> there was some duplication. That is the case for many drivers to come, so I decided it's better
> to change this and have a pattern with keeping only 'struct device'.

Well, if the only thing you need from a struct device is its
ACPI_COMPANION(), it is better to store a pointer to the latter.
