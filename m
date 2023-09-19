Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD27A69C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjISRmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjISRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A9A71AD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40C031FB;
        Tue, 19 Sep 2023 10:42:14 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E443F5A1;
        Tue, 19 Sep 2023 10:41:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:41:03 +0100
Subject: [PATCH RFT v2 15/18] KVM: arm64: FFA: Remove access of endpoint
 memory access descriptor array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-15-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3159; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=CTw1x/D0KwElSeI7bOG81XZhTChJRsMLSO0KjaEGR4U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd08ijrI42Lh58f8oTpL9xDXv7bsVLVErApak
 RQb2w+a4CaJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndPAAKCRAAQbq8MX7i
 mL1wEADAELBqtAik9x4UepITZU0z/I+3vFWE2SosXnm8ecouzOr+jrbMGQc949mh2Q556M/3EY0
 nyJC0znVU4KcMYBlxaKH6WNwXTvt0/qTORdvDe1VziFrQufZPO1lRJx2qlsXfd+MiUQ/k6rqVhk
 dkDdzQUdE0h8lRxGphdXm98bBCqFDbOprxsLGm8gYMoNsnhoPQ8Nb9iVnBpJEHXoKTy4bb24dzY
 Sf7ct40lcOFjTnV2aZ5LFlSNqwEq3QgV42J51d9eC0z5ZipZYA/ziB2WuApjUl+OnZQf5Mp0KSm
 MmIQprkLEFVumN8j2gj3NsuCK6+m8lPR2Cr49B5R+7IiLMNTLZ0fd7QnvnBbcukwzULMOgs+xT0
 VKPCHmiuC1Ahz97LdqsCfg2k5kpvGqIBGxFqXOlUumE7byxhyAhW+7NHA5yeTpGXztdFNKgvEO3
 LXlQngZb6n1JAtxCQVwSfQv3G/KC0N5xNFhJmL0G+lr+9280qC0z/gLYayEvzGsKebU71Awlsh9
 7Cq/ofN+hzZkWtxlDP1ahjGSsBSshLzydMUvA4IqtxVzPoToN8iKpUyuwigcPoLpmLzsqCySWnH
 Sk7Aq2xQP6GJZm6BQ0egx2A/6miKmMkjo9LhbSyirdCtMVTRxuppJ2aKM1EzNTXIU60kLDpQWBh
 pSEs5oIIeE42WlQ==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FF-A v1.1 removes the fixed location of endpoint memory access descriptor
array within the memory transaction descriptor structure. In preparation
to remove the ep_mem_access member from the ffa_mem_region structure,
provide the accessor to fetch the offset and use the same in FF-A proxy
implementation.

The accessor take the boolean argument that indicates if the memory access
descriptor versions is v1(old format) or not. Currently it is set true as
FF-A proxy supports only v1.0

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Will Deacon <will@kernel.org>
Cc: Quentin Perret <qperret@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/nvhe/ffa.c | 8 ++++++--
 include/linux/arm_ffa.h       | 6 ++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
index ab4f5d160c58..45e78af76e25 100644
--- a/arch/arm64/kvm/hyp/nvhe/ffa.c
+++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
@@ -423,6 +423,7 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	DECLARE_REG(u32, fraglen, ctxt, 2);
 	DECLARE_REG(u64, addr_mbz, ctxt, 3);
 	DECLARE_REG(u32, npages_mbz, ctxt, 4);
+	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	struct ffa_mem_region *buf;
 	u32 offset, nr_ranges;
@@ -452,7 +453,8 @@ static __always_inline void do_ffa_mem_xfer(const u64 func_id,
 	buf = hyp_buffers.tx;
 	memcpy(buf, host_buffers.tx, fraglen);
 
-	offset = buf->ep_mem_access[0].composite_off;
+	ep_mem_access = (void *)buf + ffa_mem_desc_offset(buf, 0, true);
+	offset = ep_mem_access->composite_off;
 	if (!offset || buf->ep_count != 1 || buf->sender_id != HOST_FFA_ID) {
 		ret = FFA_RET_INVALID_PARAMETERS;
 		goto out_unlock;
@@ -504,6 +506,7 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	DECLARE_REG(u32, handle_lo, ctxt, 1);
 	DECLARE_REG(u32, handle_hi, ctxt, 2);
 	DECLARE_REG(u32, flags, ctxt, 3);
+	struct ffa_mem_region_attributes *ep_mem_access;
 	struct ffa_composite_mem_region *reg;
 	u32 offset, len, fraglen, fragoff;
 	struct ffa_mem_region *buf;
@@ -528,7 +531,8 @@ static void do_ffa_mem_reclaim(struct arm_smccc_res *res,
 	len = res->a1;
 	fraglen = res->a2;
 
-	offset = buf->ep_mem_access[0].composite_off;
+	ep_mem_access = (void *)buf + ffa_mem_desc_offset(buf, 0, true);
+	offset = ep_mem_access->composite_off;
 	/*
 	 * We can trust the SPMD to get this right, but let's at least
 	 * check that we end up with something that doesn't look _completely_
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 748d0a83a4bc..7be240e37f36 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -357,6 +357,12 @@ struct ffa_mem_region {
 #define CONSTITUENTS_OFFSET(x)	\
 	(offsetof(struct ffa_composite_mem_region, constituents[x]))
 
+static inline u32
+ffa_mem_desc_offset(struct ffa_mem_region *buf, int count, bool mem_desc_v1)
+{
+	return COMPOSITE_OFFSET(0);
+}
+
 struct ffa_mem_ops_args {
 	bool use_txbuf;
 	u32 nattrs;

-- 
2.42.0

