Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45C07530AA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjGNEoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbjGNEol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:44:41 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EEE2D66
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:44:34 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2JmH72zzzBS5py
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:44:31 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689309871; x=1691901872; bh=uqV/KVaosrZlp0sdvjEgoWRj1jH
        nPyBvXFKURudroCg=; b=ZOzmu5JDNWwKS+/E19qIDFG1wqAvDrFwi4NJL6ZQlnC
        XidPQvfuQZyOAnxALTb/VQHOD9f39m37VLUZ+YTZU+hliByn3KEQ7qdppO2jsrLj
        W7cFehWoKhRfkh7KPhDr8k3pr1+3DtzdzVJpf1lAoIenakziOsAUPIHNLVQ/AVNx
        /04XIJ//cHOWq+TGkGoYZJ/jIdb0BN1leusgAJ7EOJxC+uluHhFtCF8kxn1PGlQo
        OGuejtSd2KzrGwfyVShGEImVzTmRMEcWZpF1VXdLb5rAHEJkYgeSIjAJBQjcsihw
        k1lFnHkiWYR9t8Xq2OgZggIEVzid6T0dBrfD4XPvXGA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PrbbnOP1ZQpn for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 12:44:31 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2JmH3R0hzBRSVj;
        Fri, 14 Jul 2023 12:44:31 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 12:44:31 +0800
From:   chenqingyun001@208suo.com
To:     maz@kernel.org, oliver.upton@linux.dev, catalin.marinas@arm.com,
        will@kernel.org
Cc:     kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Subject: [PATCH] KVM: arm64:space required before the open parenthesis '('
In-Reply-To: <tencent_40330B3E7AF84464D54533700BA6A0EF3F08@qq.com>
References: <tencent_40330B3E7AF84464D54533700BA6A0EF3F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <46eb0d5df76c8ac67c752d747b58be55@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code easier and understandable, put a space
before the opening parenthesis to distinguish functions
from parentheses for other purposes. Doing so can also
avoid some potential errors or ambiguities.

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kvm/inject_fault.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/inject_fault.c 
b/arch/arm64/kvm/inject_fault.c
index 0bd93a5f21ce..3cc891c0b292 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -29,7 +29,7 @@ static void pend_sync_exception(struct kvm_vcpu *vcpu)
       * changing context, and the exception itself can be delayed
       * until the next entry.
       */
-    switch(*vcpu_cpsr(vcpu) & PSR_MODE_MASK) {
+    switch (*vcpu_cpsr(vcpu) & PSR_MODE_MASK) {
      case PSR_MODE_EL2h:
      case PSR_MODE_EL2t:
          kvm_pend_exception(vcpu, EXCEPT_AA64_EL2_SYNC);
