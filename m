Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07857E9C18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKMMZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKMMZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:25:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC2AFD59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:25:30 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0630FFEC;
        Mon, 13 Nov 2023 04:26:16 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 078683F6C4;
        Mon, 13 Nov 2023 04:25:29 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_ffa: Declare ffa_bus_type structure in the header
Date:   Mon, 13 Nov 2023 12:25:26 +0000
Message-ID: <169987803527.35505.9196446282686706242.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024105715.2369638-1-sudeep.holla@arm.com>
References: <20231024105715.2369638-1-sudeep.holla@arm.com>
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

On Tue, 24 Oct 2023 11:57:15 +0100, Sudeep Holla wrote:
> smatch reports:
> drivers/firmware/arm_ffa/bus.c:108:17: warning:
> 	symbol 'ffa_bus_type' was not declared. Should it be static?
> 
> ffa_bus_type is exported to be useful in the FF-A driver. So this
> warning is not correct. However, declaring the ffa_bus_type structure
> in the header like many other bus_types do already removes this warning.
> So let us just do the same and get rid of the warning.
> 
> [...]

Applied to sudeep.holla/linux (for-next/ffa/fixes), thanks!

[1/1] firmware: arm_ffa: Declare ffa_bus_type structure in the header
      https://git.kernel.org/sudeep.holla/c/3fad96e9b21b
--
Regards,
Sudeep

