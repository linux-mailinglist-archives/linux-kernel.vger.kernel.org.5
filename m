Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0467BFF30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjJJO0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjJJO0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:26:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA3BB91;
        Tue, 10 Oct 2023 07:26:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9B61FB;
        Tue, 10 Oct 2023 07:27:20 -0700 (PDT)
Received: from e125770.cambridge.arm.com (e125770.arm.com [10.1.199.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF193F762;
        Tue, 10 Oct 2023 07:26:38 -0700 (PDT)
From:   Luca Fancellu <luca.fancellu@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wei Liu <wei.liu@kernel.org>, Paul Durrant <paul@xen.org>,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        Rahul Singh <rahul.singh@arm.com>
Subject: [PATCH 0/1] Add software timestamp capabilities to xen-netback device
Date:   Tue, 10 Oct 2023 15:26:29 +0100
Message-Id: <20231010142630.984585-1-luca.fancellu@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

during some experiment using PTP (ptp4l) between a Dom0 domain and a DomU guest,
I noticed that the virtual interface brought up by the toolstack was not able
to be used as ptp4l interface on the Dom0 side, a brief investigation on the
drivers revealed that the backend driver doesn't have the SW timestamp
capabilities, so in order to provide them, I'm sending this patch.

Luca Fancellu (1):
  xen-netback: add software timestamp capabilities

 drivers/net/xen-netback/interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.34.1

