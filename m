Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05067D3DD0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjJWRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjJWRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:33:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F205A90
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 10:33:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F14C433C9;
        Mon, 23 Oct 2023 17:33:31 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <jeremy.linton@arm.com>
Cc:     Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        maz@kernel.org, anshuman.khandual@arm.com, krisman@suse.de,
        broonie@kernel.org, james.morse@arm.com, ionela.voinescu@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] arm64: cpufeatures: Display enabled cores
Date:   Mon, 23 Oct 2023 18:33:29 +0100
Message-Id: <169808237958.1650772.18027344607013633145.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017052322.1211099-1-jeremy.linton@arm.com>
References: <20231017052322.1211099-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 00:23:19 -0500, Jeremy Linton wrote:
> The AMU feature can be enabled on a subset of the cores in a system.
> Because of that, it prints a message for each core as it is detected.
> This becomes tedious when there are hundreds of cores. Instead, for
> CPU features which can be enabled on a subset of the present cores,
> lets wait until update_cpu_capabilities() and print the subset of cores
> the feature was enabled on.
> 
> [...]

Applied to arm64 (for-next/cpufeat-display-cores), thanks!

[1/3] arm64: cpufeature: Display the set of cores with a feature
      https://git.kernel.org/arm64/c/23b727dc2092
[2/3] arm64: cpufeature: Change DBM to display enabled cores
      https://git.kernel.org/arm64/c/04d402a453c3

I dropped the third patch from the series.

-- 
Catalin

