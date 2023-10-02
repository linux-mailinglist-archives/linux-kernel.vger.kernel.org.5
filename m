Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8EF7B5823
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238399AbjJBQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbjJBQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:21:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F394B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:21:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 432E3C15;
        Mon,  2 Oct 2023 09:22:18 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497983F762;
        Mon,  2 Oct 2023 09:21:38 -0700 (PDT)
Date:   Mon, 2 Oct 2023 17:20:07 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Subject: Re: [PATCH v3 14/17] KVM: arm64: FFA: Remove access of endpoint
 memory access descriptor array
Message-ID: <20231002162007.ij6pmejqqmzeypze@bogus>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-14-c8e4f15190c8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ffa_v1-1_notif-v3-14-c8e4f15190c8@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 04:03:03PM +0100, Sudeep Holla wrote:
> FF-A v1.1 removes the fixed location of endpoint memory access descriptor
> array within the memory transaction descriptor structure. In preparation
> to remove the ep_mem_access member from the ffa_mem_region structure,
> provide the accessor to fetch the offset and use the same in FF-A proxy
> implementation.
> 
> The accessor take the boolean argument that indicates if the memory access
> descriptor versions is v1(old format) or not. Currently it is set true as
> FF-A proxy supports only v1.0
> 

Will, Marc,

Can you please provide your Ack if you are OK with this change so that I can
take the series via Arm SoC ? I kept the KVM change independent and the patch
removing the structure member is 16/17[1]

--
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230929-ffa_v1-1_notif-v3-16-c8e4f15190c8@arm.com
