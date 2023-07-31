Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC5768DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjGaHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjGaHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:18:18 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73EA410F7;
        Mon, 31 Jul 2023 00:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=GqXdW
        gOA0GKbV5QreBcisbO608+F8lVv/+YmWwkfnGY=; b=iHaklhcQPnARfiC28dn58
        ZqkPgBtSr1N9c6GFOo/1SZaX5Y8M4MWkI7hcv4+BCJUxCZiP2ij774i+9tshJsra
        T6vBYpKPbtCL9O0CyxUfHcHEVdGoIBx1RWwz0JsquRekNhJb+JdJ2TT8ju9iPm9M
        uPqln+68SeyKR4bZjcLzJU=
Received: from localhost.localdomain (unknown [39.144.138.187])
        by zwqz-smtp-mta-g3-1 (Coremail) with SMTP id _____wBHp79qX8dkyjkSBw--.38597S2;
        Mon, 31 Jul 2023 15:14:51 +0800 (CST)
From:   xingtong_wu@163.com
To:     hdegoede@redhat.com, markgross@kernel.org,
        henning.schild@siemens.com, andriy.shevchenko@linux.intel.com,
        lee@kernel.org, xingtong.wu@siemens.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] platform/x86: simatic-ipc: add another model BX-56A/BX-59A
Date:   Mon, 31 Jul 2023 15:14:23 +0800
Message-Id: <20230731071424.4663-1-xingtong_wu@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHp79qX8dkyjkSBw--.38597S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4fKry7CFWrtF4UKF1kGrg_yoWkArb_Ca
        yjk34Ivr4rXa4qyay09FnxX3y3GrWkZF18AF1xtrnIg3sIyF18JF12yrW5u3WUWryrAryI
        vayDWw1Sk343JjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0hmRUUUUUU==
X-Originating-IP: [39.144.138.187]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTAy90GI0aPhNnQAAs7
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

These are patches adding features for another Simatic IPC model
BX-56A/BX-59A, features for led and battery monitor are involved.

Based on:
 [PATCH v2 0/3] platform/x86: move simatic drivers into subdir
 [PATCH v2 0/2] leds: simatic-ipc-leds-gpio: add new model BX-21A
 [PATCH 0/2] platform/x86/siemens: fixes for CMOS battery hwmon

xingtong.wu (3):
  platform/x86: simatic-ipc: add new models BX-56A/BX-59A
  leds: simatic-ipc-leds-gpio: add support for module BX-59A
  batt: simatic-ipc-batt: add support for module BX-59A

 .../leds/simple/simatic-ipc-leds-gpio-core.c  |  1 +
 .../simple/simatic-ipc-leds-gpio-f7188x.c     | 42 ++++++++++++++++---
 drivers/platform/x86/siemens/Kconfig          |  1 +
 .../x86/siemens/simatic-ipc-batt-f7188x.c     | 37 +++++++++++-----
 .../platform/x86/siemens/simatic-ipc-batt.c   |  3 +-
 drivers/platform/x86/siemens/simatic-ipc.c    | 12 +++++-
 .../platform_data/x86/simatic-ipc-base.h      |  1 +
 include/linux/platform_data/x86/simatic-ipc.h |  2 +
 8 files changed, 80 insertions(+), 19 deletions(-)

-- 
2.25.1

