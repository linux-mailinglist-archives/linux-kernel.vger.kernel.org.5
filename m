Return-Path: <linux-kernel+bounces-105892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E195487E618
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D25628266E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0049A2C6BD;
	Mon, 18 Mar 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUota3MG"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866B22C6B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754836; cv=none; b=pBXueWzND3QTrQWCWjUlZyp2sfW4O080JoasJx6Uac9LvR1pYMnfc+RQUbuKSfYoO4zzGuYqAIUtSV3REg1z2EXSbb2mUbZ4k79/h4IvmkEHUOkbMutedzxW1LdY54+2z/xiAMT3vcZRNDzRqvuFKS7Enzzb6J8A0S/moswcGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754836; c=relaxed/simple;
	bh=9ZcDOwOqW2gF0C2lI0a37n8cgKWGS5eMMytStmdvdAU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QWgoACZKUZF709QCAfvuP7CSM817RZdPs1dNiUqIyAjXIieFi3ST6GvX+B8U1YK2cHZVe7GTfJ5hcR6TkoUfA2kj5nrZqraJQ6PSMZ8uk9Nxpv9mcZa9tMgzt42o7fdgHdEN35d76LcESlnfUp7/VP+W/+8kNcWrgFxWc1+LVUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUota3MG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ed6078884so1305266f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710754833; x=1711359633; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IlTtOZqwQBQp58gzcbNXtnMX5UBC9Jqt776QgB9ni+4=;
        b=gUota3MG6QQ0HzJp/su8LipP0gi1BIepomEjDDXo2r254aDjZJA15p35lgQs8mvS6m
         SSaZR3CoSLPAwi9v6es4+LiJEljXz3mhuJUM1NMPimyGncXu3+ozr+ghO3B/+Pf3dTh/
         xRaL0VsLmN7FprAhoPpYL4uewtd1BiTEmLuSp0x9/lVpccxkYrvYGKncRZTDmOHEFwlW
         h02esXyYwvi9zsi5KDq8iyX3QOALDNVqksnS7PgW7Ue4baro/kYPbnG5RdThVGuxsdm4
         d0hx4sor1ma4KCbfzE6I87aQVwEbKb/bqdWzW+cVEPy7HziX5zCe5mq0fIjdgdUyY/7p
         EsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710754833; x=1711359633;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlTtOZqwQBQp58gzcbNXtnMX5UBC9Jqt776QgB9ni+4=;
        b=KawhMl8t72jC/CA2nqKFJG1XA/Bc0d+MNR2osKIeSRhGlHplUAH3lU9J6+ejjX9+0D
         aRK23X+V/CVafO1No0ujqD9S9xborKU9Yutpzt1NTbaWs4qI/hwHUDOz2+m525WsPGPR
         3tviv4DD8BTgMOLFJuUPUeSyx/omg9JpODuCIxJCJWuHfs5WNcw3nuWdWME6eq2cAlU/
         LkiunP/QHUcbGG/v4Ay2sBFp0XGkRMIO7+mKDTYt0GFhZeXMkYxGxvK/dIGP6y6CepNn
         xdnA8woW5rBOXBGqIUtU86eDRVuwao63IBXRjpT+RirjMe1uQ3Vyg4st3QEM9Z8oF6Bl
         kwVA==
X-Gm-Message-State: AOJu0YzC8/Z9uSUHSsqn/XvvFVuHuab/Ilsml5fDmENIidOmcCeigY6G
	DDwvQ/TfakW/GBTZ715L/cZuATWtlRdFhpuhaV64OWuaaS0RKHTK
X-Google-Smtp-Source: AGHT+IH6mCw6mLyut3I43YtoUs70hq5ucpI5g0XO82WSUEx2HTQitNDE/jlNFnpl1rdOXklTDvug9Q==
X-Received: by 2002:adf:db4d:0:b0:33e:621e:35b2 with SMTP id f13-20020adfdb4d000000b0033e621e35b2mr11230086wrj.6.1710754832450;
        Mon, 18 Mar 2024 02:40:32 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d5146000000b0034171f3aeedsm2662419wrt.19.2024.03.18.02.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:40:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 18 Mar 2024 10:40:29 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>
Subject: [GIT PULL] IRQ fix
Message-ID: <ZfgMDZiXhrimMVC3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Linus,

Please pull the latest irq/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-03-17

   # HEAD: ca5b0b717b75d0f86f7f5dfe18369781bec742ad irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32

A RISC-V irqchip driver fix.

 Thanks,

	Ingo

------------------>
Samuel Holland (1):
      irqchip/riscv-intc: Fix use of AIA interrupts 32-63 on riscv32


 drivers/irqchip/irq-riscv-intc.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f87aeab460eb..9e71c4428814 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -149,8 +149,9 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
 	 * Only allow hwirq for which we have corresponding standard or
 	 * custom interrupt enable register.
 	 */
-	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
-	    (hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+	if (hwirq >= riscv_intc_nr_irqs &&
+	    (hwirq < riscv_intc_custom_base ||
+	     hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
 		return -EINVAL;
 
 	for (i = 0; i < nr_irqs; i++) {
@@ -183,10 +184,12 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 		return -ENXIO;
 	}
 
-	if (riscv_isa_extension_available(NULL, SxAIA))
+	if (riscv_isa_extension_available(NULL, SxAIA)) {
+		riscv_intc_nr_irqs = 64;
 		rc = set_handle_irq(&riscv_intc_aia_irq);
-	else
+	} else {
 		rc = set_handle_irq(&riscv_intc_irq);
+	}
 	if (rc) {
 		pr_err("failed to set irq handler\n");
 		return rc;
@@ -195,7 +198,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn, struct irq_ch
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
 	pr_info("%d local interrupts mapped%s\n",
-		riscv_isa_extension_available(NULL, SxAIA) ? 64 : riscv_intc_nr_irqs,
+		riscv_intc_nr_irqs,
 		riscv_isa_extension_available(NULL, SxAIA) ? " using AIA" : "");
 	if (riscv_intc_custom_nr_irqs)
 		pr_info("%d custom local interrupts mapped\n", riscv_intc_custom_nr_irqs);

