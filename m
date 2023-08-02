Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A4176D51D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjHBR0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHBR0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:26:30 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D373EDC;
        Wed,  2 Aug 2023 10:26:29 -0700 (PDT)
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42F78238C432;
        Wed,  2 Aug 2023 10:26:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42F78238C432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690997189;
        bh=ecpQEzlsMPOnKIlS7EnMnD+nKR125o8h+55Vy2FLKS0=;
        h=From:To:Cc:Subject:Date:From;
        b=ZOrC9y9u/ZJ4eY02RAa7YIzyQXZsWhwH74yOuETF5MFgQ/eWAC55NIl4y3SpgblKV
         0cbjbHSAUjfVM1IKsgNRCQD9apH/dYkAXihq3Vmq4IecXpsIbpn/iASiWBugq4WtdD
         Censli2/aaxqZ3Yjrdy6auH6cdu+DbBzF7zvuyTQ=
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
Subject: [PATCH v2 6.4 0/4] ARM SMMUv3 errata for 6.4
Date:   Wed,  2 Aug 2023 17:26:16 +0000
Message-Id: <20230802172620.1628017-1-eahariha@linux.microsoft.com>
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
v1 -> v2:
 - Backport other relevant errata patches from the same series as MMU-700 erratum 2812531
 - v1 link: https://lore.kernel.org/stable/20230724185130.1676140-1-eahariha@linux.microsoft.com/T/#u

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

