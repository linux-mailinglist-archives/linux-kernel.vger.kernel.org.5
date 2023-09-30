Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245C7B4463
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 00:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjI3WOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 18:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjI3WOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 18:14:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F6DDD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 15:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aP2s06dac8Kke2n85yYimc4oYXDVxU4N/03q6sN5cII=; b=zl++siT0YaxtfWI4CKmqkQXGYF
        08dm0BbNG/qvN4tIusr5TUczr19i/G/LFm2LyX7+VI8RCJBgxIm0lD+Da60eHdfkFCwbg66EA95lY
        alLBKSHjp0+hIEjibiAwpF5E/a9WiHLHGWagqsF68Ceg0btpkNvE2bem7lXDRWacaMlcLvBoA/Wtr
        ALmJaeNss4JRivYxLb1KCeyuXjNsXVOljIZgwuIRuSpgajxnNnObgF4UILxdLOIDfYAFBB3zwrXDc
        R/uqg8qNBdYRedWlu6fjO7YHHcOhnepjVE9CzQkNfneA0Mt6rE1ue31w8dl1qspYcYAzaM48qIfGz
        w0qrtJXw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qmiEI-00AAxS-0C;
        Sat, 30 Sep 2023 22:14:30 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] mei: fix doc typos
Date:   Sat, 30 Sep 2023 15:14:28 -0700
Message-ID: <20230930221428.18463-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230930221428.18463-1-rdunlap@infradead.org>
References: <20230930221428.18463-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix grammar and punctuation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/mei.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff -- a/include/uapi/linux/mei.h b/include/uapi/linux/mei.h
--- a/include/uapi/linux/mei.h
+++ b/include/uapi/linux/mei.h
@@ -14,8 +14,8 @@
  * FW Client (given by UUID). This opens a communication channel
  * between a host client and a FW client. From this point every read and write
  * will communicate with the associated FW client.
- * Only in close() (file_operation release()) the communication between
- * the clients is disconnected
+ * Only in close() (file_operation release()) is the communication between
+ * the clients disconnected.
  *
  * The IOCTL argument is a struct with a union that contains
  * the input parameter and the output parameter for this IOCTL.
@@ -51,7 +51,7 @@ struct mei_connect_client_data {
  * DOC: set and unset event notification for a connected client
  *
  * The IOCTL argument is 1 for enabling event notification and 0 for
- * disabling the service
+ * disabling the service.
  * Return:  -EOPNOTSUPP if the devices doesn't support the feature
  */
 #define IOCTL_MEI_NOTIFY_SET _IOW('H', 0x02, __u32)
@@ -59,8 +59,8 @@ struct mei_connect_client_data {
 /**
  * DOC: retrieve notification
  *
- * The IOCTL output argument is 1 if an event was is pending and 0 otherwise
- * the ioctl has to be called in order to acknowledge pending event
+ * The IOCTL output argument is 1 if an event was pending and 0 otherwise.
+ * The ioctl has to be called in order to acknowledge pending event.
  *
  * Return:  -EOPNOTSUPP if the devices doesn't support the feature
  */
@@ -98,14 +98,14 @@ struct mei_connect_client_data_vtag {
  * FW Client (given by UUID), and virtual tag (vtag).
  * The IOCTL opens a communication channel between a host client and
  * a FW client on a tagged channel. From this point on, every read
- * and write will communicate with the associated FW client with
+ * and write will communicate with the associated FW client
  * on the tagged channel.
  * Upone close() the communication is terminated.
  *
  * The IOCTL argument is a struct with a union that contains
  * the input parameter and the output parameter for this IOCTL.
  *
- * The input parameter is UUID of the FW Client, a vtag [0,255]
+ * The input parameter is UUID of the FW Client, a vtag [0,255].
  * The output parameter is the properties of the FW client
  * (FW protocool version and max message size).
  *
