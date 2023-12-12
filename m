Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0804780F474
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376438AbjLLRWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjLLRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:22:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FBEA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:22:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D12C433C7;
        Tue, 12 Dec 2023 17:22:56 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     will@kernel.org, Robin Murphy <robin.murphy@arm.com>
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ilkka@os.amperecomputing.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH] perf/arm-cmn: Fail DTC counter allocation correctly
Date:   Tue, 12 Dec 2023 17:22:54 +0000
Message-Id: <170240171501.947884.15604728153384166017.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
References: <ed589c0d8e4130dc68b8ad1625226d28bdc185d4.1702322847.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 19:27:28 +0000, Robin Murphy wrote:
> Calling arm_cmn_event_clear() before all DTC indices are allocated is
> wrong, and can lead to arm_cmn_event_add() erroneously clearing live
> counters from full DTCs where allocation fails. Since the DTC counters
> are only updated by arm_cmn_init_counter() after all DTC and DTM
> allocations succeed, nothing actually needs cleaning up in this case
> anyway, and it should just return directly as it did before.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] perf/arm-cmn: Fail DTC counter allocation correctly
      https://git.kernel.org/arm64/c/1892fe103c3a

-- 
Catalin

