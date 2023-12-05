Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59341805BCF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442401AbjLEPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346834AbjLEPQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:16:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F5210C4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:17:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB9C433CA;
        Tue,  5 Dec 2023 15:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789424;
        bh=6fKZC+eA9tWy5T/DHWsGKDkWMqxND8c+CfabRDLbb5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJXG7JlaszHe4KzEfdrfKHQ93hUeexWhqtkR8rtMORW3at6ibHnZKhHpW+YOuuTgz
         tFeqQIBE7amRX0PG0FdHwpMdLxKDZsKx23XFsu87XNvgigkxV48g7NteWZCvudtsSR
         SFzjMNCgeGQLMLrh3mt633zV78qzlatV9CUm5iKIqLU2m+dBeAu04biM/9uMNR8Ffs
         6F3AKoT63IQnzBBrGJWmzvS4knRFho18pqt1JfZrtdXRhbQ1Lw92u4AiIVBWVqXNmN
         gDwJ45I1cvBFHw4pi8LivuYL2TlDqtBNV/VWxTlDf3S8csyCZDyfCHfWNktvvHgcG9
         h2V+f1VHjucYw==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH] perf/arm-cmn: Fix HN-F class_occup_id events
Date:   Tue,  5 Dec 2023 15:16:35 +0000
Message-Id: <170177862294.1058818.4996860407789168968.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5a22439de84ff188ef76674798052448eb03a3e1.1700740693.git.robin.murphy@arm.com>
References: <5a22439de84ff188ef76674798052448eb03a3e1.1700740693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 11:58:13 +0000, Robin Murphy wrote:
> A subtle copy-paste error managed to slip through the reorganisation
> of these patches in development, and not only give some HN-F events
> the wrong type, but use that wrong type before the subsequent patch
> defined it. Too late to fix history, but we can at least fix the bug.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] perf/arm-cmn: Fix HN-F class_occup_id events
      https://git.kernel.org/will/c/590f23b09240

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
