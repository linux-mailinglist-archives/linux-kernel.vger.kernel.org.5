Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286707E5599
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKHLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344548AbjKHLd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:33:56 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47EF01BD4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:33:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FD591477;
        Wed,  8 Nov 2023 03:34:37 -0800 (PST)
Received: from bogus (unknown [10.57.82.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABC6E3F703;
        Wed,  8 Nov 2023 03:33:51 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:32:19 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: Fix ffa_notification_info_get() IDs
 handling
Message-ID: <20231108113219.GA1345456@bogus>
References: <20231108111549.155974-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108111549.155974-1-lpieralisi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 12:15:49PM +0100, Lorenzo Pieralisi wrote:
> To parse the retrieved ID lists appropriately in
> ffa_notification_info_get() the ids_processed variable should not
> be pre-incremented - we are dropping an identifier at the
> beginning of the list.
> 
> Fix it by using the post-increment operator to increment the number
> of processed IDs.
> 
> Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")

Thanks for spotting and fixing this. Much appreciated!
I will queue at -rc1.

-- 
Regards,
Sudeep
