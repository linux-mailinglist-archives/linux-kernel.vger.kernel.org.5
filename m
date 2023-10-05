Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC497BA48F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjJEQHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbjJEQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:04:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F12F10B
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:48:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A0FF1682;
        Thu,  5 Oct 2023 06:32:36 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C3B43F641;
        Thu,  5 Oct 2023 06:31:56 -0700 (PDT)
Date:   Thu, 5 Oct 2023 14:30:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Olivier Deprez <Olivier.Deprez@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20231005133024.kdxfajmruedli4ne@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
 <20231004091154.GB1091193@rayden>
 <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
 <20231004153234.ktk6egntk7drao47@bogus>
 <CAHUa44GWA_WQSgOgtQKgawc11vpaD5B4q5rNq8fxnEFJk_NzmA@mail.gmail.com>
 <20231005084946.vn4mbizdisaw4q5d@bogus>
 <CAHUa44ETFTKE17tUMsAiF5vYk2yT9wQT-zE+22ic3jHrHhrrJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44ETFTKE17tUMsAiF5vYk2yT9wQT-zE+22ic3jHrHhrrJg@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 11:56:22AM +0200, Jens Wiklander wrote:
> On Thu, Oct 5, 2023 at 10:51 AM Sudeep Holla <sudeep.holla@arm.com> wrote:

[...]

> > A receiver(FF-A driver) must bind a non-framework notification to a
> > sender(SP) before the latter can signal the notification to the former.
> > Only the sender can ring these doorbells. A receiver uses the
> > FFA_NOTIFICATION_BIND interface to bind one or more notifications to the
> > sender.
> >
> > So, based on this text(modified to refer sender and receiver in the driver
> > context) from the spec, my understanding is the driver is the receiver
> > and the SP is the sender of the notification.
> >
> > Do you think I am missing someting here ? Sorry for agreeing with you
> > in v2 and silently changing it back without this actual discussion.
> > Olivier raised the issue and then when I went back and looked at the
> > spec, I realised why I had it this way from the beginning.
> 
> Thanks for the explanation, now I get it. My mistake was that I
> thought that sender and receiver meant the sender and receiver of the
> actual message being sent like with a direct request, it is using the
> same register and the same wording after all. Instead, it means the
> sender and receiver of an eventual notification, which of course is
> the exact opposite.
> 

Thanks for the response. Glad we are on same page now with respect to this.

-- 
Regards,
Sudeep
