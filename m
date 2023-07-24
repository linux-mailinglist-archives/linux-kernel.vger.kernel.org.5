Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D375FF4B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjGXSul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGXSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:50:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70F2C10DC;
        Mon, 24 Jul 2023 11:50:37 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8657320A1078;
        Mon, 24 Jul 2023 11:50:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8657320A1078
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690224636;
        bh=mCB5gTwt3lxsMopysrW8PZ55OSbFNCUKGKtbfVk4ITk=;
        h=From:To:Cc:Subject:Date:From;
        b=YmEPZOKVfJuTtd5pHFFfSQos3hhVVUmZRIe5dRk57lILYgUig+MM6/B6lbnrLQlDz
         XY65jRBeq5N1DAaa1hBku/nJ7AD4DoXUVRPu3lrspNaCmDnkhtBNC3JOjQzIzZpMj0
         U3uNEJwSRLfslNmXWmX4oJuhBGmx21SUXAQmVf0w=
From:   Easwar Hariharan <eahariha@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     easwar.hariharan@microsoft.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [PATCH v2 5.15 0/3] ARM64 errata for stable kernel 5.15
Date:   Mon, 24 Jul 2023 18:50:14 +0000
Message-Id: <20230724185017.1675459-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series works around a few ARM64 errata.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev

Changelog:
==========
v1 -> v2:
 - Drop patch accepted as commit
   e4e7f67cc14e9638798f80513e84b8fb62cdb7e3 in v5.15.121
 - Appropriate sign-offs
 - v1 link:https://lore.kernel.org/stable/1689895414-17425-1-git-send-email-eahariha@linux.microsoft.com/

Robin Murphy (1):
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531

Suzuki K Poulose (2):
  arm64: errata: Add workaround for TSB flush failures
  arm64: errata: Add detection for TRBE write to out-of-range

 Documentation/arm64/silicon-errata.rst      | 12 ++++
 arch/arm64/Kconfig                          | 74 +++++++++++++++++++++
 arch/arm64/include/asm/barrier.h            | 16 ++++-
 arch/arm64/kernel/cpu_errata.c              | 39 +++++++++++
 arch/arm64/tools/cpucaps                    |  2 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 41 ++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 7 files changed, 184 insertions(+), 1 deletion(-)

-- 
2.25.1

