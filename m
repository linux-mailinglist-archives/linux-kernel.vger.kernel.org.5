Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376C7639C0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234326AbjGZO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGZO7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:59:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EEF9CE;
        Wed, 26 Jul 2023 07:59:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3618C168F;
        Wed, 26 Jul 2023 08:00:03 -0700 (PDT)
Received: from bogus (unknown [10.57.96.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88EB43F67D;
        Wed, 26 Jul 2023 07:59:18 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:58:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, scclevenger@os.amperecomputing.com,
        leo.yan@linaro.org, linux-acpi@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: drivers/pnp/pnpacpi/core.c:253:17: warning: 'strncpy' specified
 bound 50 equals destination size
Message-ID: <20230726145843.jlubnrcjaejfduky@bogus>
References: <20230710062500.45147-7-anshuman.khandual@arm.com>
 <20230726140515.368981-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140515.368981-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 03:05:15PM +0100, Suzuki K Poulose wrote:
> On 25/07/2023 15:30, Rafael J. Wysocki wrote:
> > On Tue, Jul 25, 2023 at 4:040x202FPM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 25/07/2023 15:00, Rafael J. Wysocki wrote:
> >>> On Tue, Jul 25, 2023 at 3:270x202FPM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>>>
> >>>> On 25/07/2023 13:28, Rafael J. Wysocki wrote:
> >>>>> On Tue, Jul 25, 2023 at 12:350x202FPM Suzuki K Poulose
> >>>>> <suzuki.poulose@arm.com> wrote:
> >>>>>>
> >>>>>> Hi Rafael
> >>>>>>
> >>>>>> Apologies for hijacking this thread, but please please could
> >>>>>> you respond to the following patch ?
> >>>>>>
> >>>>>> We have been waiting for your Ack since last two months.
> >>>>>>
> >>>>>> https://lkml.kernel.org/r/46a3d6d3-f14e-efde-83eb-5952f313f909@arm.com
> >>>>>
> >>>>> Sorry about that, but I'm not sure why you need an ACK from me for
> >>>>> this.0x00A0 AMBA is an ARM thing and I'm not even familiar with the driver
> >>>>> in question.
> >>>>>
> >>>>
> >>>> I understand, but there is a change to the drivers/acpi/acpi_amba.c ,
> >>>> which is technically under your maintenance. The change is removing
> >>>> the custom hook for the ETMv4 ID from the AMBA list and moving it
> >>>> directly under the ETMv4 driver. Greg would like an Ack from you
> >>>> before that can be queued. It missed the merged window last time
> >>>> due to that and didn't want to miss it again this time.
> >>>
> >>> OK, so please feel free to add an ACK from me to that patch.
> >>>
> >>
> >> Thanks.
> >>
> >>> It also would be good to find an ARM maintainer for acpi_amba.c, so
> >>> people don't have to wait for my ACK on every change in that file.
> >>
> >> Sudeep Holla (our resident ACPI expert) has reviewed the patch, but
> >> I guess he is in the Reviewer ranks.
> >
> > Well, next time you get a Reviewed-by from Sudeep on ARM-related ACPI
> > material, it is far more meaningful than my ACK.0x00A0 You probably don't
> > need the latter if you have the former.

Thanks Rafael and this aligns with my understanding. I had mentioned to
Suzuki informally. Since I wasn't sure why this was not covered under
Arm ACPI maintainership for whatever historical reasons, I didn't make
it formally on the list. I think it would be better if we move that file
under it to be explicit and avoid any confusion in the future. I will
send the update soon.

-- 
Regards,
Sudeep
