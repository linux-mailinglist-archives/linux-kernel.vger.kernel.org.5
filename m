Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5CB7B6D25
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbjJCP3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjJCP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:29:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4C683;
        Tue,  3 Oct 2023 08:29:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D60C433CA;
        Tue,  3 Oct 2023 15:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696346975;
        bh=Ppt/g3Cl4BHkM08VzrqupcDO3feWwrL0moCYx1utEJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qVm99Fa6ss1iQNSqspl+Urb3rwwwlivA0jCA8aOX7t/Mj27kTtZ+9oW6JEoQU/Hud
         WZsLqwUD+XHvM858bygzJNGZY/OToOnDry2MI5InxY3OBibFZu52ehILb2jIXVmbQy
         1inWPIP4du8YG8DtLuurmK3YK2nIB9weWJxUGYV85lSeocB10FYxNNokA7CLcwZri/
         6TDmJolb02NDKMYarHu+UqI47KsAHf38wuvWIblb7KFwjfOSUO3aSt1UEtnNv5sc9D
         as/WnpfEhq6NwxquezjtLgY1YfwLr2kUjrLQIsMhWNBv8+sbu5VrdfdZQrzQ1qAYMx
         RQTCslknGew5g==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qnhLF-0003uR-38;
        Tue, 03 Oct 2023 17:29:46 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/5] spmi: document spmi_device_from_of() refcounting
Date:   Tue,  3 Oct 2023 17:29:26 +0200
Message-ID: <20231003152927.15000-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003152927.15000-1-johan+linaro@kernel.org>
References: <20231003152927.15000-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a comment documenting that the spmi_device_from_of() takes a
reference to the embedded struct device that needs to be dropped after
use.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/spmi/spmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 7313d4c18a04..ca2fd4d72fa6 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -392,6 +392,9 @@ static struct bus_type spmi_bus_type = {
  *
  * @np:		device node
  *
+ * Takes a reference to the embedded struct device which needs to be dropped
+ * after use.
+ *
  * Returns the struct spmi_device associated with a device node or NULL.
  */
 struct spmi_device *spmi_device_from_of(struct device_node *np)
-- 
2.41.0

