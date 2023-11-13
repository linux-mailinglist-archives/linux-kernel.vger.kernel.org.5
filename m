Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2D7E9C17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjKMMYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKMMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:24:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C42E1D59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:24:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1253FEC;
        Mon, 13 Nov 2023 04:25:28 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9A193F6C4;
        Mon, 13 Nov 2023 04:24:42 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Fix ffa_notification_info_get() IDs handling
Date:   Mon, 13 Nov 2023 12:24:40 +0000
Message-ID: <169987803531.35505.15435711878332048887.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231108111549.155974-1-lpieralisi@kernel.org>
References: <20231108111549.155974-1-lpieralisi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2023 12:15:49 +0100, Lorenzo Pieralisi wrote:
> To parse the retrieved ID lists appropriately in
> ffa_notification_info_get() the ids_processed variable should not
> be pre-incremented - we are dropping an identifier at the
> beginning of the list.
> 
> Fix it by using the post-increment operator to increment the number
> of processed IDs.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/1] firmware: arm_ffa: Fix ffa_notification_info_get() IDs handling
      https://git.kernel.org/sudeep.holla/c/f1ed48ef97e2
--
Regards,
Sudeep

