Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AD07B83A4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjJDPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjJDPcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96598C4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:32:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFE9EC15;
        Wed,  4 Oct 2023 08:33:16 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 422893F762;
        Wed,  4 Oct 2023 08:32:37 -0700 (PDT)
Date:   Wed, 4 Oct 2023 16:32:34 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Olivier Deprez <Olivier.Deprez@arm.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
Message-ID: <20231004153234.ktk6egntk7drao47@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com>
 <20231004091154.GB1091193@rayden>
 <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:50:26AM +0100, Olivier Deprez wrote:
> Hi Jens,
> 
> > dst_id and drv_info->vm_id should be swapped.
> 
> I'm curious about this because swapping like this actually makes hafnium
> fail. Need to check from the spec.

I did check after I had swapped this in v2(because I was convinced Jens) was
correct and you reported the failure. Reading the spec again the other day,
I got corrected myself and agreed with Olivier and my original
implementation(v1) which matches this patch(v3).

-- 
Regards,
Sudeep
