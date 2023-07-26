Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DEE763A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbjGZPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbjGZPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:05:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3016D2733;
        Wed, 26 Jul 2023 08:05:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68A4D168F;
        Wed, 26 Jul 2023 08:04:48 -0700 (PDT)
Received: from bogus (unknown [10.57.96.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C1FA3F67D;
        Wed, 26 Jul 2023 08:04:02 -0700 (PDT)
Date:   Wed, 26 Jul 2023 16:03:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Steve Clevenger OS <scclevenger@os.amperecomputing.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Len Brown <lenb@kernel.org>,
        Ganapatrao Kulkarni OS <gankulkarni@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
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
Subject: Re: acpi: Remove ETM from AMBA scan list (was Re: [PATCH V6 6/6]
 coresight: etm4x: Add ACPI support in platform driver)
Message-ID: <20230726150327.jfhla23nhlszigq7@bogus>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
 <20230710062500.45147-7-anshuman.khandual@arm.com>
 <38f0c8f3-5fb3-a18a-456d-867da2998786@arm.com>
 <ac77142d-964b-691d-ea15-105a523d9738@arm.com>
 <46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com>
 <abbcf3c8-fbd9-727e-780b-74aaf5ae8ec1@os.amperecomputing.com>
 <CAJZ5v0iy9QfSRuy_kNNZarJZyO35GN25Td39GGN=kNbr0-fuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iy9QfSRuy_kNNZarJZyO35GN25Td39GGN=kNbr0-fuBA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 04:33:26PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 25, 2023 at 10:18 PM Steve Clevenger OS
> <scclevenger@os.amperecomputing.com> wrote:
> >
> >
> > Hi Rafael, Len,
> >
> > On 7/24/2023 9:25 AM, Suzuki K Poulose wrote:
> > > Hi Rafael/Len
> > >
> > > On 19/07/2023 11:11, Suzuki K Poulose wrote:
> > >> Rafael, Len
> > >>
> > >> Ping (packets 6, lost 100%).
> > >>
> > >>
> > >> On 10/07/2023 17:40, Suzuki K Poulose wrote:
> > >>> Rafael, Len
> > >>>
> > >>> On 10/07/2023 07:25, Anshuman Khandual wrote:
> > >>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > >>>>
> > >>>> Drop ETM4X ACPI ID from the AMBA ACPI device list, and instead just
> > >>>> move it
> > >>>> inside the new ACPI devices list detected and used via platform driver.
> > >>>>
> > >>>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > >>>> Cc: Len Brown <lenb@kernel.org>
> > >>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > >>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> > >>>> Cc: Mike Leach <mike.leach@linaro.org>
> > >>>> Cc: Leo Yan <leo.yan@linaro.org>
> > >>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> > >>>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > >>>> Cc: linux-acpi@vger.kernel.org
> > >>>> Cc: coresight@lists.linaro.org
> > >>>> Cc: linux-arm-kernel@lists.infradead.org
> > >>>> Cc: linux-kernel@vger.kernel.org
> > >>>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com> (for ACPI specific
> > >>>> changes)
> > >>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > >>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > >>>
> > >>> We would like to queue this via coresight tree. The acpi_amba bits have
> > >>> been reviewed by Sudeep. Please could you give us an Ack, if you are
> > >>> happy with the proposal ?
> > >>>
> > >
> > > Please could one of you respond to this patch ? We are blocked on your
> > > Ack for queuing this. There are machines out there, which rely on this
> > > patch to use Arm self-hosted tracing based on CoreSight.
> > >
> > > Kind regards
> > > Suzuki
> >
> > Ampere Computing AmpereOne machines rely on this patch series to enable
> > System Register Access to the ETMv4. Ampere removed the ETM MMIO
> > descriptions from our CoreSight ACPI to use this.
> >
> > Suzuki's e-mail requests for review/Ack of this patch thread date back
> > to May 30.
> 
> I've just talked to Suzuki about this:
> 
> https://lore.kernel.org/linux-acpi/20230726140515.368981-1-suzuki.poulose@arm.com
> 
> This patch has received a Reviewed-by from Sudeep which for all
> purposes should be sufficient for any ARM-related ACPI material that
> doesn't affect any other architectures.  An ACK from me (or Len for
> that matter) would not make any real difference from the technical
> perspective.
> 
> I would appreciate assigning an official ARM maintainer to acpi_amba.c
> so as to avoid such unnecessary delays in the future.

Ah I just crossed and replied on other thread. I will soon send an update
to add this file under Arm ACPI for the maintenance.

-- 
Regards,
Sudeep
