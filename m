Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C73B775179
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjHIDmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHIDmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:42:10 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D3D21718;
        Tue,  8 Aug 2023 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=uAI03z7nuqrRXQTXLmImIyVAYwiBH9IDECMGmfL5IxI=;
        b=HPMm25zaRUk3pNfO+ue+f/Y+PjYMbmaEkybyoItezahiCocmC+w/7djirgqlW/
        zMhWSNDpoav5cNYOPKTnzqaTCTZtyMzTOhjp88pkb/p+RpipB2OOZ+VZSGWHk7Ti
        zBKXwf0E0CGsr14kwQ9VJJIUJcO1GWw7nSgs63gaL+F/s=
Received: from localhost.localdomain (unknown [39.144.137.205])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wAHzaXvCtNkLjZuCg--.12136S2;
        Wed, 09 Aug 2023 11:41:36 +0800 (CST)
From:   xingtong_wu@163.com
To:     andriy.shevchenko@linux.intel.com
Cc:     ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com,
        markgross@kernel.org, xingtong.wu@siemens.com, lee@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        gerd.haeussler.ext@siemens.com, tobias.schaffner@siemens.com,
        lkp@intel.com
Subject: [PATCH v3 0/2] fix logical errors for BX-59A
Date:   Mon,  3 Aug 2043 01:35:14 +0800
Message-Id: <20430802173515.2363-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ZNEUHo0fR280O4mN@smile.fi.intel.com>
References: <ZNEUHo0fR280O4mN@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHzaXvCtNkLjZuCg--.12136S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XF43uw18tw17Ar4DJr1fJFb_yoWxCrc_Cr
        WIvwn7Ar4YqrZrZ3409F13Jryaka4UXr18ArnrtFyag343Ar1DKr1jkrWrWry7Wa45Cr9Y
        yayDWaySkw13JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeiZ27UUUUU==
X-Originating-IP: [39.144.137.205]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiMxHG0FXmF6EdOwAAsX
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_DATE_IN_FUTURE_Q_PLUS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

changes since v2:
 - Collect tag "Reviewed-by" in changelog
 - Delete blank line between tags block "Closes" and "Signed-off-by"

changes since v1:
 - Improve the changelog to make things clear

These are rather simple patches fixing logical errors in Siemens
IPC drivers.

xingtong.wu (2):
  platform/x86/siemens: simatic-ipc: fix logical error for BX-59A
  platform/x86/siemens: simatic-ipc-batt: fix logical error for BX-59A

 drivers/platform/x86/siemens/simatic-ipc-batt.c | 3 ++-
 drivers/platform/x86/siemens/simatic-ipc.c      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1

