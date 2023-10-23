Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407727D2DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjJWJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJWJJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:09:59 -0400
Received: from out0-196.mail.aliyun.com (out0-196.mail.aliyun.com [140.205.0.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD1398;
        Mon, 23 Oct 2023 02:09:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047193;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---.V5pF1jV_1698052193;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.V5pF1jV_1698052193)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 17:09:54 +0800
From:   "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Hou Wenlong" <houwenlong.hwl@antgroup.com>,
        "Andy Shevchenko" <andy@infradead.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Darren Hart" <dvhart@infradead.org>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        "Juergen Gross" <jgross@suse.com>,
        <platform-driver-x86@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 0/2] x86/xen/pvh: Clean up stack canary setup in PVH entry
Date:   Mon, 23 Oct 2023 17:09:37 +0800
Message-Id: <cover.1698051454.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the stack canary setup in the PVH entry. For a 64-bit kernel,
use fixed_percpu_data to set up GSBASE. For a 32-bit kernel, set up the
%fs register explicitly.

Hou Wenlong (2):
  x86/xen/pvh: Set up percpu for stack canary in 32-bit kernel entry
  x86/xen/pvh: Use fixed_percpu_data to set up GS base

 arch/x86/platform/pvh/head.S | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


base-commit: 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52
--
2.31.1

