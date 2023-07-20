Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB13575A4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTDV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGTDVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:21:53 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CAE1B9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:21:51 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yf25j9mzBRDry
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:21:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689823306; x=1692415307; bh=IM9mBbnkWDvSQtfl523MKJBAc0A
        ufM/2UqDWiGJB27E=; b=UE7kl/ND2LJWNezGOKHYn4jGh8C2DsU7pHCovTkm/lx
        NN10uO+wtnmXCUWbW8rSZVvadkJRJz3A/ajkoVEgxvAs5QqY64UXsT/RimleLwYo
        4raqMaYf0x6uPYhhuUTSJlt3ST1gDU+OUip5osWa2LqiZjUFGu6sItFGKs0BGSwM
        rBg/7YRwnm5coya97srivI65Rj7u7NFIqWqGNpypCixg6zLjviQFMp3LZpxJIC1B
        D6izRRdP3Yp12uKa7tFN3asEfFe+RdZs3D78KuuS4V6ZgH2bVbtBCUpbczNFEJjs
        leRI1n59x9FkyzfKJcV8ZloZpAlXQvworKqShCoNp6g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RN8cvsr7yAWp for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:21:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yf23bPlzBR1P6;
        Thu, 20 Jul 2023 11:21:46 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:21:46 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] w1: add missing spaces before '*' and remove spaces after '*'
In-Reply-To: <20230720031545.1702-1-xujianghui@cdjrlc.com>
References: <20230720031545.1702-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <0ed50f990b1b10620f5fdaa123809ff7@208suo.com>
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
