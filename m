Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951007D6E12
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbjJYNtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234942AbjJYNtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:49:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11F84133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 06:49:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5732F4;
        Wed, 25 Oct 2023 06:49:44 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C1E3F64C;
        Wed, 25 Oct 2023 06:49:00 -0700 (PDT)
Date:   Wed, 25 Oct 2023 14:47:28 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 0/4] firmware: arm_ffa: Few fixes for FF-A notification
 support
Message-ID: <20231025134728.7pibtoergxqdus5z@bogus>
References: <20231024-ffa-notification-fixes-v1-0-d552c0ec260d@arm.com>
 <CAHUa44GewV_GcBWk89foNu8EPVgQ03LvOTxzjgp5Smis34GWdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44GewV_GcBWk89foNu8EPVgQ03LvOTxzjgp5Smis34GWdA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 01:55:38PM +0200, Jens Wiklander wrote:
> Hi Sudeep,
>
> On Tue, Oct 24, 2023 at 12:56 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi,
> >
> > These are set of small fixes around FF-A notification support that are
> > currently queued in -next. It is mostly to take care of absence of
> > the notification support in the firmware as well as allowing them to be
> > optional and continue initialisation even when the notification fails.
> >
> > Regards,
> > Sudeep
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> > Sudeep Holla (4):
> >       firmware: arm_ffa: Allow FF-A initialisation even when notification fails
> >       firmware: arm_ffa: Setup the partitions after the notification initialisation
> >       firmware: arm_ffa: Add checks for the notification enabled state
> >       firmware: arm_ffa: Fix FFA notifications cleanup path
> >
> >  drivers/firmware/arm_ffa/driver.c | 65 ++++++++++++++++++++++++++-------------
> >  1 file changed, 44 insertions(+), 21 deletions(-)
>
> Works as expected with and without FF-A notifications enabled in the
> secure world.
>
> Tested-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks a lot for testing, much appreciated!

--
Regards,
Sudeep
