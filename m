Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F712763934
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjGZOdl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 10:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjGZOdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:33:39 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E3196;
        Wed, 26 Jul 2023 07:33:38 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1bb701d39ddso517751fac.0;
        Wed, 26 Jul 2023 07:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690382018; x=1690986818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Updrikr1bw98x36EK4C9daMQvPB+rcMs3qVutcNNDGw=;
        b=EJf3qEdYeuJGq2W/QKDoJ1ndON9Xz6zUY+rdz4gZ8qz7zcKrYeZo8Qh2gUKdhGeoqq
         mtto56LbU3c7L4CabJNpfm/ux7GaYxJECFkkPuZ68r+Hs7o/GcbcZpsSxbi0aT7Q4nM9
         UkcAc3ZflFEu79SIQoRlffxiLFN2/3nO+jixNpmVdn41LYvEGUZyQB3cEyAcMP/pQi3D
         txzcooD8CKo9VeqPTMcsT3ICAC4y4jCR8iUqW8FPEMLbjiuvlfE7xUiDC3cK3TJZnpjl
         FvUewicOWJPVdAD6XzFWYWhFLW2fFcX7MQQgihUuGycuM6sH+htaEIrusTioIjCi/ddq
         +Idg==
X-Gm-Message-State: ABy/qLZRDodPUPtJl17zKWqRbUJmLJ544lziY4UmNwEYymKUfaDSq0YQ
        FnmZQFlSMzJhblfSQDbu5H5aMAQlbJi4JdHiYKc=
X-Google-Smtp-Source: APBJJlGL7alqSLyJJMLIJRTAZiW23Xy5V5TqymN7uiXU59nGkFA6ViiFrYqec8vKpUHT6TD3aKfI9ZtM9W8xeZ+sucA=
X-Received: by 2002:a05:6870:eca3:b0:1b3:8cfd:fecf with SMTP id
 eo35-20020a056870eca300b001b38cfdfecfmr2327521oab.0.1690382017821; Wed, 26
 Jul 2023 07:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <20230710062500.45147-7-anshuman.khandual@arm.com> <38f0c8f3-5fb3-a18a-456d-867da2998786@arm.com>
 <ac77142d-964b-691d-ea15-105a523d9738@arm.com> <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
 <abbcf3c8-fbd9-727e-780b-74aaf5ae8ec1@os.amperecomputing.com>
In-Reply-To: <abbcf3c8-fbd9-727e-780b-74aaf5ae8ec1@os.amperecomputing.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Jul 2023 16:33:26 +0200
Message-ID: <CAJZ5v0iy9QfSRuy_kNNZarJZyO35GN25Td39GGN=kNbr0-fuBA@mail.gmail.com>
Subject: Re: acpi: Remove ETM from AMBA scan list (was Re: [PATCH V6 6/6]
 coresight: etm4x: Add ACPI support in platform driver)
To:     Steve Clevenger OS <scclevenger@os.amperecomputing.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Ganapatrao Kulkarni OS <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
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

On Tue, Jul 25, 2023 at 10:18 PM Steve Clevenger OS
<scclevenger@os.amperecomputing.com> wrote:
>
>
> Hi Rafael, Len,
>
> On 7/24/2023 9:25 AM, Suzuki K Poulose wrote:
> > Hi Rafael/Len
> >
> > On 19/07/2023 11:11, Suzuki K Poulose wrote:
> >> Rafael, Len
> >>
> >> Ping (packets 6, lost 100%).
> >>
> >>
> >> On 10/07/2023 17:40, Suzuki K Poulose wrote:
> >>> Rafael, Len
> >>>
> >>> On 10/07/2023 07:25, Anshuman Khandual wrote:
> >>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>>
> >>>> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just
> >>>> move it
> >>>> inside the new ACPI devices list detected and used via platform driver.
> >>>>
> >>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >>>> Cc: Len Brown <lenb@kernel.org>
> >>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>> Cc: Mike Leach <mike.leach@linaro.org>
> >>>> Cc: Leo Yan <leo.yan@linaro.org>
> >>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> >>>> Cc: linux-acpi@vger.kernel.org
> >>>> Cc: coresight@lists.linaro.org
> >>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>> Cc: linux-kernel@vger.kernel.org
> >>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific
> >>>> changes)
> >>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >>>
> >>> We would like to queue this via coresight tree. The acpi_amba bits have
> >>> been reviewed by Sudeep. Please could you give us an Ack, if you are
> >>> happy with the proposal ?
> >>>
> >
> > Please could one of you respond to this patch ? We are blocked on your
> > Ack for queuing this. There are machines out there, which rely on this
> > patch to use Arm self-hosted tracing based on CoreSight.
> >
> > Kind regards
> > Suzuki
>
> Ampere Computing AmpereOne machines rely on this patch series to enable
> System Register Access to the ETMv4. Ampere removed the ETM MMIO
> descriptions from our CoreSight ACPI to use this.
>
> Suzuki's e-mail requests for review/Ack of this patch thread date back
> to May 30.

I've just talked to Suzuki about this:

https://lore.kernel.org/linux-acpi/20230726140515.368981-1-suzuki.poulose@arm.com

This patch has received a Reviewed-by from Sudeep which for all
purposes should be sufficient for any ARM-related ACPI material that
doesn't affect any other architectures.  An ACK from me (or Len for
that matter) would not make any real difference from the technical
perspective.

I would appreciate assigning an official ARM maintainer to acpi_amba.c
so as to avoid such unnecessary delays in the future.
