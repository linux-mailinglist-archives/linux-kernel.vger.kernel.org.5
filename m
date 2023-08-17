Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698767800DB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355663AbjHQWKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355720AbjHQWKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:10:47 -0400
Received: from smtpcmd01-sus.aruba.it (smtpcmd01-sus.aruba.it [62.149.158.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACDC35A6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:10:14 -0700 (PDT)
Received: from localhost.localdomain ([95.47.160.93])
        by Aruba Outgoing Smtp  with ESMTPSA
        id WlBwquBOoN2T6WlBxqMz6o; Fri, 18 Aug 2023 00:10:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1692310210; bh=J8jfJ0RzNsW4jhKzvwbAmd/aMuoHDSUnfSRuflqG+Gg=;
        h=From:To:Subject:Date:MIME-Version;
        b=JqbtqjFK1ufXWg+rAayEz5tesReTrJnzzWKuU406O8jReOIPCaD4QdOJXEDxCS+/U
         9Uxj6BJXRBYwg0vgjrJoytpAcNjLEXky1b1Ms8yd0gMtrmaVux3zbRar9dIkXjSl0L
         PhCK09iA+qtGVYa4O+zm0ekjUHcWvWmFC+rmZoUFJtesThexRI5yE2UAUm8zKEkhHU
         f9R2PH5os3pnQbw1qx4NGyoHAXktLrYxhuhebYDDnGO2IDjsTXu6j8xAfebmHX0DeB
         DS1gYICMItTvZOLSaAr3o6Yt8lLnKj38XjCIQSqiyTk97/lJ9QWxq2rIR6eTqQP24a
         QPdDXGQtjpF3g==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [RFC PATCH 1/1] docs: submitting-patches: Add Sponsored-by tag to give credits to who sponsored the patch
Date:   Fri, 18 Aug 2023 00:09:57 +0200
Message-Id: <20230817220957.41582-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
References: <20230817220957.41582-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfE6wQE6kGkVBDnYihfYyk6qCcg8M7ck6lhVz1ptVj0ZPv9oJ7lK+bOcQ+FWZTdm2DwVHqNa/yM75VLK2w4jshVOtar00GgEO1k/OdjJ2E/2eQgKgJLVZ
 R/T3tVEumhiiBDr7UvGdzYYrVvoVMkQcX/HA1KeuAW/DlW2JgRzSQrh8K1o9aOZI96kfX12LzBVNgPiznf+WJcqZ+7QSzNn7zBSHShZDJeec+7rU/Od4BU8i
 g6fFRp35lwHgXp+I/vrRRsEL3A1CuacfS219tvaMmZFlMOdz53POFT3ZARVOsNzZleFRTY4mb4zeUE6+ZLBKbhDyL4Q3Wpmfywtoowy+GTlgB1uQSMf8L/N4
 JavA3UdwAheeimnhJOQQTlJluhjwmN6UF6fbT41Pr4enVcnf8ys=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes it happens that a Company or a Physical Person sponsors the
creation and/or the upstreaming process of a patch, but at the moment
there is no way to give credits to it. There are some commit that include
a sort of tag "Sponsored by" without the dash to avoid
scripts/checkpatch.pl to complain but a real standard has not been defined.
With this patch let's try to define a method to give credits consistently
including an acknowledge from the sponsor. The goal is to improve
contributions from companies or physical persons that this way should gain
visibility in Linux kernel and so they should be more prone to let the
work done for them for to be upstreamed.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 Documentation/process/submitting-patches.rst | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index efac910e2659..870e6b5def3f 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -600,6 +600,44 @@ process nor the requirement to Cc: stable@vger.kernel.org on all stable
 patch candidates. For more information, please read
 Documentation/process/stable-kernel-rules.rst.
 
+Using Sponsored-by:
+-------------------
+
+A Sponsored-by tag gives credit to who sponsored the creation and/or the
+upstreaming process of the patch. Sponsored-by can contain a company name or
+a physical person name. If a company sponsored the patch this is the form::
+
+	Company Name <mail@companyname.com>
+
+where the Company Name must be a valid Business Name at the time of sending the
+patch until the confirmation of the Sponsored-by tag, while the e-mail can be
+either a generic e-mail the company can be reached out or an e-mail of a person
+who has the rights inside it to confirm the Sponsored-by tag.
+
+If a physical person sponsored the patch the form must be same used in
+Signed-off-by tag::
+
+	Physical Person <physical.person@mail.com>
+
+In both cases, to prevent fake credits, either the company or the person should
+send an Acked-by tag placed right under Sponsored-by tag using the same form
+described above. So for example if the patch contains::
+
+	<changelog>
+
+	Sponsored-by: Company Name <mail@companyname.com>
+	Signed-off-by: Developer Name <developer.name@developername.com>
+
+The result including the answer from the sponsor must be::
+
+	<changelog>
+
+	Sponsored-by: Company Name <mail@companyname.com>
+	Acked-by: Company Name <mail@companyname.com>
+	Signed-off-by: Developer Name <developer.name@developername.com>
+
+This way the sponsor agrees to the usage of this tag using its name.
+
 .. _the_canonical_patch_format:
 
 The canonical patch format
-- 
2.34.1

