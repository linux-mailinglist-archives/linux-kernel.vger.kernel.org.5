Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D054575A4B3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjGTDRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTDRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:17:10 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B819A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:17:09 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yXf6KxszBRDrC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:17:06 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689823026; x=1692415027; bh=IM9mBbnkWDvSQtfl523MKJBAc0A
        ufM/2UqDWiGJB27E=; b=j3jmJHB072C5BSveW8eRaQnc7qPmCxfPN/cru3T1WMZ
        vSUMZIBkaERnmfMvqxK7DRvVMc9lomxIvROvi0mDXfW2bhRI+rSkbCg0kuJbww0J
        A2z2LT6QPYUC38xvDfp70IyYXMCKZdfkTXp8q2pn3QUEn6LWKFFtbr1fD43nF/6D
        aVN/99xkC5HmwgBweh7X0SxqAxnbvPju/OJnFNDPtkewWLSfaOdh/w929OxH8cY9
        uplHcAMmnywzjyzQGqlZCZ7fM++pnRXu/qlevuOePTF+Dcw/3luNYpfeKBmrmdT5
        +2woW5NiiEdGuONdkxt6hxjGrzqr4JxbOIlUIdiPJoQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id omf8lc3ox4NS for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:17:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yXf0QjYzBR1P6;
        Thu, 20 Jul 2023 11:17:06 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:17:05 +0800
From:   sunran001@208suo.com
To:     krzysztof.kozlowski@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] w1: add missing spaces before '*' and remove spaces after '*'
In-Reply-To: <20230720031545.1702-1-xujianghui@cdjrlc.com>
References: <20230720031545.1702-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f848628eeaec2a6613c2da4f5d235577@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: "foo* bar" should be "foo *bar"

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/w1.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/w1.h b/include/linux/w1.h
index 9a2a0ef39018..70188da81d04 100644
--- a/include/linux/w1.h
+++ b/include/linux/w1.h
@@ -304,17 +304,17 @@ int w1_reset_select_slave(struct w1_slave *sl);
  int w1_reset_resume_command(struct w1_master *);
  void w1_next_pullup(struct w1_master *, int);

-static inline struct w1_slave* dev_to_w1_slave(struct device *dev)
+static inline struct w1_slave *dev_to_w1_slave(struct device *dev)
  {
  	return container_of(dev, struct w1_slave, dev);
  }

-static inline struct w1_slave* kobj_to_w1_slave(struct kobject *kobj)
+static inline struct w1_slave *kobj_to_w1_slave(struct kobject *kobj)
  {
  	return dev_to_w1_slave(container_of(kobj, struct device, kobj));
  }

-static inline struct w1_master* dev_to_w1_master(struct device *dev)
+static inline struct w1_master *dev_to_w1_master(struct device *dev)
  {
  	return container_of(dev, struct w1_master, dev);
  }
