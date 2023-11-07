Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C314B7E41AC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 15:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbjKGOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 09:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjKGOSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 09:18:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50110A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 06:18:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFE3C433C7;
        Tue,  7 Nov 2023 14:18:01 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
Date:   Tue,  7 Nov 2023 14:17:59 +0000
Message-Id: <169936667591.2397489.8626905802471861575.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 17:16:54 -0700, Ilkka Koskinen wrote:
> Coresight PMU driver didn't reject events meant for other PMUs.
> This caused some of the Core PMU events disappearing from
> the output of "perf list". In addition, trying to run e.g.
> 
>      $ perf stat -e r2 sleep 1
> 
> made Coresight PMU driver to handle the event instead of letting
> Core PMU driver to deal with it.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

[1/1] perf: arm_cspmu: Reject events meant for other PMUs
      https://git.kernel.org/arm64/c/15c7ef7341a2

-- 
Catalin

