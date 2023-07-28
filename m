Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE11766EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjG1NzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbjG1NzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45506DB;
        Fri, 28 Jul 2023 06:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D733F62159;
        Fri, 28 Jul 2023 13:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32028C433C8;
        Fri, 28 Jul 2023 13:55:15 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     lpieralisi@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rafael@kernel.org, Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc:     Will Deacon <will@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()
Date:   Fri, 28 Jul 2023 14:55:13 +0100
Message-Id: <169055250812.1025105.13485697321170348706.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 19:33:45 +0800, Guanghui Feng wrote:
> According to the ARM IORT specifications DEN 0049 issue E,
> the "Number of IDs" field in the ID mapping format reports
> the number of IDs in the mapping range minus one.
> 
> In iort_node_get_rmr_info(), we erroneously skip ID mappings
> whose "Number of IDs" equal to 0, resulting in valid mapping
> nodes with a single ID to map being skipped, which is wrong.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] ACPI/IORT: Remove erroneous id_count check in iort_node_get_rmr_info()
      https://git.kernel.org/arm64/c/003e6b56d780

-- 
Catalin

