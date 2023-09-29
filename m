Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1A7B364C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjI2PEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbjI2PDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:03:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA5141B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:03:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC47EDA7;
        Fri, 29 Sep 2023 08:04:13 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55A5E3F5A1;
        Fri, 29 Sep 2023 08:03:34 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 29 Sep 2023 16:03:06 +0100
Subject: [PATCH v3 17/17] firmware: arm_ffa: Upgrade the driver version to
 v1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-ffa_v1-1_notif-v3-17-c8e4f15190c8@arm.com>
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
In-Reply-To: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=Xm+5FQuOK8ltFjmVMKkQ+PdVAQzeFkX0aF6wk6FDOU0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlFucxGzAT4dtPyO2lxZI7phiqRwrHuueWtGUs8
 eFRbadMVFWJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZRbnMQAKCRAAQbq8MX7i
 mO0MD/0QyHmOb8sV3V0Lb9aSY63l2HnDx4ye1U5oX7byMSasGabyYpk3cw50aYeKQvtEZhS7xfm
 Q43V8PYqoUOlaO36fMHcKOLd9F099mOjConyL3D3iMx80HQ3ZObWJtIQZW2i5bfeA/1rHpYgT3Q
 wfYD5O57fXo2h3Sowfez4r+hgQU44qIySiwBKqf9RX/+YScjbl7uOr1l6kWkaoOn7EO3mAl5szF
 0Ejm09ReyqcCq4IoQToT1jd/drs+PBZjID8AQk9I1sGOjwTqnpxqtedU2Yu0J7vvkvJ0YPH951M
 NCwiajsv43RKWDXk8hTw+s4vdnBKpZFhylt+eNszjkVqRiKwZdUhMNDaCvjjrwU1E6QGKJCCPS1
 +5HkuL+91d2hdJ6XJ/kxwzH01cnxIJlUch2uq4fDnU7/T8q1aaockAuqv6A+2qmQD8nqQhgeKYx
 byBdoChwkIfQjilwuY9zN3cqnH8opvSfqValQlYQVGvy2JHymglxD4NABkqirdLwvB1jwl7Gmfq
 tH7SDYUMjeuvz8mp4B/3C+tTYpnR5SluVnU4IFDs+DhRPMBNADFscKgRdmtaxbmZsJbNi08gFuL
 hdWO1rQn6Hn312S3CAM7tMFulJHzM++KmLTF30lUFuhsMSgftNvuRIuEa8miv5UW6lQV1AVr02o
 5/CLChj1D65pywA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With quite a few v1.1 features supported, we can bump the driver version
to v1.1 now.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 0168e69c495d..e9c6282d750c 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -43,7 +43,7 @@
 
 #include "common.h"
 
-#define FFA_DRIVER_VERSION	FFA_VERSION_1_0
+#define FFA_DRIVER_VERSION	FFA_VERSION_1_1
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 
 #define SENDER_ID_MASK		GENMASK(31, 16)

-- 
2.42.0

