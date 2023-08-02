Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF3276D502
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjHBRVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjHBRVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:21:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 609AC1981;
        Wed,  2 Aug 2023 10:21:08 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.1.149])
        by linux.microsoft.com (Postfix) with ESMTPSA id A75EC238C426;
        Wed,  2 Aug 2023 10:21:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A75EC238C426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690996867;
        bh=4jDcbklJrsKBYdf2y2dqW6EAK/gtkk33I6wCWWdrm+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=CWwqu1pmYTHHfU/HTFMtKAcyeCy7de8aD2crMMcccJSgSuIqtqQ/KhMFBsDyQJIag
         rW52gxG4VFPCswfGCkIMLunZUWKKIw7bmVvPVt23w+LT+U6uatp1NLqBDNEi6rTjKk
         g6IhvpurL+j4i3aQWhVAVoXGYltHz4dxeuH8T+gs=
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
Subject: [PATCH v3 6.1 0/4] ARM SMMUv3 errata for 6.1
Date:   Wed,  2 Aug 2023 17:20:56 +0000
Message-Id: <20230802172100.1599164-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
v2 -> v3:
 - v2 was generated from the wrong branch, resulting in slightly incorrect context for a hunk
 - v2 link: https://lore.kernel.org/stable/20230802170911.1593275-1-eahariha@linux.microsoft.com/T/#t

v1 -> v2:
 - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
 - v1 link: https://lore.kernel.org/stable/20230724185107.1675882-1-eahariha@linux.microsoft.com/T/#u

Robin Murphy (4):
  iommu/arm-smmu-v3: Work around MMU-600 erratum 1076982
  iommu/arm-smmu-v3: Document MMU-700 erratum 2812531
  iommu/arm-smmu-v3: Add explicit feature for nesting
  iommu/arm-smmu-v3: Document nesting-related errata

 Documentation/arm64/silicon-errata.rst      |  4 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 +++++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 ++++
 3 files changed, 62 insertions(+)

-- 
2.25.1

