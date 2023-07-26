Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F55762A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 06:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjGZE2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 00:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjGZE1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 00:27:40 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBB1FF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:26:26 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-34617b29276so1468815ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 21:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1690345586; x=1690950386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lavfuE2py63kVqVG37hnlHpSBQOco6qEbPDbyiaGHr8=;
        b=KqNnFaBvS8w7I7Srdl6Jvzm1b1m8LmOq6bK3MqaoIGO2Jsq06v9TC8TZKZ/LI8J5wR
         6G2uTZ5CofCxhiBDp8OUDQd4uGKXq+Ghy2JQLWqdNQaSuf3sx3bg+KWKkXxjuGn1k6Ns
         UAv/ymipwkhEjgru0+r9KINywii/CVWwNkj99dIaqLBjW8xQ59aBZs53xoxVyyhcAHXG
         /F435bvD/JsfH7CxoLctneRrgi3Cx0VedSUIQ6syZ8+BbEoPh+mVGrW1ugwLiHPeIb/Q
         fryDob8lF1DUfKrl6BRvkBu1j9fUe6VHD9dwTt7rDNExgRE09b0GNE59iwA8dgsQAceg
         7m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690345586; x=1690950386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lavfuE2py63kVqVG37hnlHpSBQOco6qEbPDbyiaGHr8=;
        b=iFdwBfzws/LKig8T3SKakIsG/9V9sQCN4STtiCiRBlzJTHV4rSfA8UKpNO3ftgKYA8
         ZPChLvF4KwQcPKS0uvO+SIeIU+ftug1kFDATDqARTf6CTJpqVFHbsZc3PjqT26mksrW4
         V3DuqWIfV9XBQNB9fJO2Y2TVXSRn6zc2OaR1fbAG5KndBSguL41ulkyj876fRJXSQnIO
         wVJs2oJQnoYrEJw8Ko6waO7/d2xPQLXxnhRgota/ZLEaYda13o61O7UMh7j3rKhBvvzY
         aJizRw6iUSqApv5aKeomV6UHfUO645L15NuHu2kX0ohZXQZ2rzD8rhcF17QwgGj4GPTb
         H9RQ==
X-Gm-Message-State: ABy/qLYy7GAYwYmukcWs2MSR10xfSaZcfQBzI1GpSdf4uAuCp6hknGIp
        3S/mXZ5QQn9XFo/1i38dIyduGPAxtvwNCe8egyUVIw==
X-Google-Smtp-Source: APBJJlHvcJ/8Fz022/unHWa1t7PeKP7/pURtkJm4fhXV77/BJ2s2iC9flzceWDnwDO/a8UM371CQfe7YxffPrAH9qk8=
X-Received: by 2002:a05:6e02:1c2a:b0:346:63f1:a96f with SMTP id
 m10-20020a056e021c2a00b0034663f1a96fmr3000190ilh.2.1690345585840; Tue, 25 Jul
 2023 21:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689792825.git.tjeznach@rivosinc.com> <d62ceb33620cab766d809e6bbf30eaf5b46bc955.1689792825.git.tjeznach@rivosinc.com>
 <CANXhq0r=2eqpy9wLjVt1U0J7=LpnJLcKV7N9d90jvCss=7+Fzg@mail.gmail.com>
 <CAK9=C2Vg9eR5LJPeqDDQ0pHZcrT5DOUzA8_wYEVEjfnhb6s8pw@mail.gmail.com>
 <CANXhq0oTrU_-OQroW7H+hvxcU7YROhkgdCF9g_WtPTzVFQL7gA@mail.gmail.com>
 <CAK9=C2XoQjPzZ5yB5jfTbee4-Pb8GgFAZRbfcMwMk9pyo39WxQ@mail.gmail.com>
 <CANXhq0q7R9Srx6U=fReq7LDLFgW6rMmjKH=o6MzDT5AWNRXP6w@mail.gmail.com> <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
In-Reply-To: <592edb17-7fa4-3b5b-2803-e8c50c322eee@linux.intel.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 26 Jul 2023 12:26:14 +0800
Message-ID: <CANXhq0pS_=YxgrxSKbdfrFdGcBduzk3LTyC4vp_hqoJTbX3e0g@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: Add RISC-V IOMMU bindings
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Tomasz Jeznach <tjeznach@rivosinc.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
        linux-kernel@vger.kernel.org, Sebastien Boeuf <seb@rivosinc.com>,
        iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:21=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com=
> wrote:
>
> On 2023/7/24 21:23, Zong Li wrote:
> >>>>> In RISC-V IOMMU, certain devices can be set to bypass mode when the
> >>>>> IOMMU is in translation mode. To identify the devices that require
> >>>>> bypass mode by default, does it be sensible to add a property to
> >>>>> indicate this behavior?
> >>>> Bypass mode for a device is a property of that device (similar to dm=
a-coherent)
> >>>> and not of the IOMMU. Other architectures (ARM and x86) never added =
such
> >>>> a device property for bypass mode so I guess it is NOT ADVISABLE to =
do it.
> >>>>
> >>>> If this is REALLY required then we can do something similar to the Q=
COM
> >>>> SMMU driver where they have a whitelist of devices which are allowed=
 to
> >>>> be in bypass mode (i.e. IOMMU_DOMAIN_IDENTITY) based their device
> >>>> compatible string and any device outside this whitelist is blocked b=
y default.
> >>>>
> >>> I have considered that adding the property of bypass mode to that
> >>> device would be more appropriate. However, if we want to define this
> >>> property for the device, it might need to go through the generic IOMM=
U
> >>> dt-bindings, but I'm not sure if other IOMMU devices need this. I am
> >>> bringing up this topic here because I would like to explore if there
> >>> are any solutions on the IOMMU side, such as a property that indicate=
s
> >>> the phandle of devices wishing to set bypass mode, somewhat similar t=
o
> >>> the whitelist you mentioned earlier. Do you think we should address
> >>> this? After all, this is a case of RISC-V IOMMU supported.
> >> Bypass mode is a common feature across IOMMUs. Other IOMMUs don't
> >> have a special property for bypass mode at device-level or at IOMMU le=
vel,
> >> which clearly indicates that defining a RISC-V specific property is no=
t the
> >> right way to go.
> >>
> >> The real question is how do we set IOMMU_DOMAIN_IDENTITY (i.e.
> >> bypass/identity domain) as the default domain for certain devices ?
> >>
> >> One possible option is to implement def_domain_type() IOMMU operation
> >> for RISC-V IOMMU which will return IOMMU_DOMAIN_IDENTITY for
> >> certain devices based on compatible string matching (i.e. whitelist of
> >> devices). As an example, refer qcom_smmu_def_domain_type()
> >> of drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >>
> > That is indeed one way to approach it, and we can modify the
> > compatible string when we want to change the mode. However, it would
> > be preferable to explore a more flexible approach to achieve this
> > goal. By doing so, we can avoid hard coding anything in the driver or
> > having to rebuild the kernel  whenever we want to change the mode for
> > certain devices. While I have considered extending a cell in the
> > 'iommus' property to indicate a device's desire to set bypass mode, it
> > doesn't comply with the iommu documentation and could lead to
> > ambiguous definitions.
>
> Hard coding the matching strings in the iommu driver is definitely not a
> preferable way. A feasible solution from current code's point of view is
> that platform opt-in the device's special requirements through DT or
> ACPI. And in the def_domain_type callback, let the iommu core know that,
> hence it can allocate a right type of domain for the device.
>
> Thoughts?
>

It would be nice if we can deal with it at this time. As we discussed
earlier, we might need to consider how to indicate that, such as
putting a property in device side or iommu side, and whether we need
to define it in generic dt-binding instead of RISC-V specific
dt-binding.

> Best regards,
> baolu
