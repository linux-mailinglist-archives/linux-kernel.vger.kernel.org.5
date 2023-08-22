Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF4E784B76
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjHVUen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjHVUel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 16:34:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA5CF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:38 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so6215151a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 13:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692736477; x=1693341277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz9r4yHVJPlmq0FQ5zhHfDzA75nwNO0/VTx/JdIInIA=;
        b=bPZRW0UnM/HtazxdIhJKSk+wHiO0PgNwrYul+qpJSxlGcHzdWcrmadxxCf0cs20Ict
         S0gSkcIMe+mnSeapLn/9bGIPSpn1OTgWueGfUQaNBm9m18pAnc/msp5BaQ5EPXBpcVMs
         z/7GF+J4fFSiJdt82LlVy5ZlxhtjLnebLctYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692736477; x=1693341277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz9r4yHVJPlmq0FQ5zhHfDzA75nwNO0/VTx/JdIInIA=;
        b=e8+HkP5oqYZck271ZQkHZO6hI9pQzkNfSy8qAtWGFzCDbucgupWMMz4KmKF4WXz588
         rmZLk1NEwsHzKytBWkyXiizJtbmqURKtGmeWeWxb6xbF9Rqx/BH3CGiy9kKauVMWC9EU
         CAb5nuTE2JX8LTFjvYfgQgNOBMAiVLyYxiAiqhbkReJqQaayC2Hj85DKAqaxAsKm1xXR
         JEJhryp4RyV9s3FplQvQZ6MlCtuYL0WlDyw69hEv2N1yAtTmwVwlYuVXUUsxz8ZahgxL
         e8XX9NG2PlRYAgrD1b93UIEoes4Mcb4yGVvbRu9Z5hPFMQbHuw9XGHrlaf4Fsxs045r8
         sFmQ==
X-Gm-Message-State: AOJu0YxaBTMEhAyTODHIWWMyFY09OS8LijsETCzOKBRd1kcheMExMQol
        FYmU5rQ8VxFJmWXfjfRjUO/9+sz+c/p2WcjiuYDgcg==
X-Google-Smtp-Source: AGHT+IE3JDNsYnOGC7CywTwIPiVA6qAVO5JKtVwDTFQL9LtR8meFQRxaAKJGESt3x7bMREUsu3Qc0knhhK10NckJvEM=
X-Received: by 2002:aa7:cd56:0:b0:523:4057:fa6e with SMTP id
 v22-20020aa7cd56000000b005234057fa6emr6171021edw.42.1692736476988; Tue, 22
 Aug 2023 13:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194821.2961213-1-sjg@chromium.org> <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 22 Aug 2023 14:34:25 -0600
Message-ID: <CAPnjgZ1iXoiByBPvBJfOa+q7qV5mvq4yGm483TmypzSKKy5PYg@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: Add a schema for memory map
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 22 Aug 2023 at 12:53, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Aug 21, 2023 at 2:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The Devicespec specification skips over handling of a logical view of
> > the memory map, pointing users to the UEFI specification.
>
> It's more that the DT spec defines what is not used with UEFI. If UEFI
> covers more than the DT Spec defined, then we should look at that.
>
> I would look some into (IBM) PowerPC for any prior art in this area.
> Unfortunately, not publicly documented other than any users.

OK, but I'm not sure what you are looking for here. The DT (as
currently specified) is an incomplete description of memory, for
EFI-type firmware. I recall the ePAPR thing, but not much else. Any
pointers?

>
> > It is common to split firmware into 'Platform Init', which does the
> > initial hardware setup and a "Payload" which selects the OS to be boote=
d.
> > Thus an handover interface is required between these two pieces.
> >
> > Where UEFI boot-time services are not available, but UEFI firmware is
> > present on either side of this interface, information about memory usag=
e
> > and attributes must be presented to the "Payload" in some form.
> >
> > This aims to provide an initial schema for this mapping.
> >
> > Note that this is separate from the existing /memory and /reserved-memo=
ry
> > nodes, since it is mostly concerned with what the memory is used for. I=
t
> > may cover only a small fraction of available memory, although it could =
be
> > used to signal which area of memory has ECC.
> >
> > For now, no attempt is made to create an exhaustive binding, so there a=
re
> > some example types lists. This can be completed once this has passed
> > initial review.
>
> I don't have much interest in picking this up unless there's some
> wider agreement. From the previously referenced discussion[1], it
> didn't seem like there was. But none of those folk are Cc'ed here.

Yes, Ron pointed me to that...although it isn't quite the same thing.
That is implementing a way to pass SMBIOS and ACPI tables through to
Linux, right? But it does mention memory types, so I'll send a new
version with those people on cc, in case they don't look at linux-acpi
much.

But note, this is for *firmware* (on both sides of the interface).
Whether it is useful for Linux is another question. But in any case,
we should avoid having things in the DT which Linux cannot validate /
parse.

>
> > ---
> >
> > Changes in v2:
> > - Reword commit message
> >
> >  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 dtschema/schemas/memory-map.yaml
> >
> > diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory=
-map.yaml
> > new file mode 100644
> > index 0000000..97e531e
> > --- /dev/null
> > +++ b/dtschema/schemas/memory-map.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +# Copyright 2023 Google LLC
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/memory-map.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: /memory-map nodes
> > +description: |
> > +  Common properties always required in /memory-map nodes. These nodes =
are
> > +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and U=
EFI")
> > +  in the Devicetree Specification.
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
>
> This goes in the root node?

I suppose I'm just confused about how the schema is described. I think
it is better to have a /memory-map node with subnodes of that for each
region.

>
> > +  usage:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    description: |
> > +      Describes the usage of the memory region, e.g.:
> > +
> > +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata"=
,
> > +        "runtime-code", "runtime-data"
>
> Can't these be covered by reserved-memory? The client is free to
> reclaim any regions if it knows what they are.

I don't see that in the schema, but given what you say, it is
definitely an option.

If the reserved-memory node hiding somewhere?

>
> > +  attr:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description: |
> > +      Attributes possessed by this memory region:
> > +
> > +        "single-bit-ecc" - supports single-bit ECC
> > +        "multi-bit-ecc" - supports multiple-bit ECC
> > +        "no-ecc" - non-ECC memory
>
> Isn't this pretty much a property of a memory region as a whole. IOW,
> couldn't it just go into /memory node(s)?

Yes I think so. I wasn't sure if adding it there would break things,
but it seems not.

>
> > +
> > +patternProperties:
> > +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> > +    type: object
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      reg:
> > +        minItems: 1
> > +        maxItems: 1024
> > +
> > +    required:
> > +      - reg
> > +
> > +additionalProperties: true
> > +
> > +...
> > --
> > 2.42.0.rc1.204.g551eb34607-goog
>
> [1] https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16=
-1-cuiyunhui@bytedance.com/

I collected email addresses from that thread as best I could, and will
cc them on v3.

Regards,
Simon
