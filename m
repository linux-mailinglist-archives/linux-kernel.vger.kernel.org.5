Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56B3752DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbjGMXGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbjGMXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D643A8E;
        Thu, 13 Jul 2023 16:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A412861AA2;
        Thu, 13 Jul 2023 23:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C9BC433C9;
        Thu, 13 Jul 2023 23:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689289568;
        bh=pjd75VNJos/sK1Tcoj09WPoZgEiv1FnSHnLzbAkRI+M=;
        h=From:To:Cc:Subject:Date:From;
        b=ZGWIWsz/1USSO1C53KwCJnNh+6Wg7tbIaRf/E2GulgdFIIVZNrPh1Af5g0WjqzxD8
         gD282qfNB/u/92ga3C6vFAJF1GzTGHaDtQ5ZNtmqJ9ZFB6PKW6x8dRV9TSTvnsaLTI
         zQe+mhpFDPvsrtpQxaEgMTEEU+MLiuYTNTUD0UI0ysFpUildORe4AiySuQeZvN/3U7
         E4SK1ofMit0zX4TLf89lRDDao/pBio7sWR5uUX3ezWTktXuAEfXJuDrcn9h+3zaBM9
         4FcmUgxyMPMV1gZvxEOQ1KE1OZja3re1/Ydk/B63UkJoMRybbKyEcvZk6EDMMDVjAA
         4pE2r1asxsktA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH docs] docs: maintainers: mention tag -s for signed tags
Date:   Thu, 13 Jul 2023 16:06:06 -0700
Message-ID: <20230713230606.1505458-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation talks about -u and how to configure the default
key. It does not mention that once the default key is set one
should use the -s flag. Which is likely what most people end up
using.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/maintainer/configure-git.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/maintainer/configure-git.rst b/Documentation/maintainer/configure-git.rst
index ec0ddfb9cdd3..a054de0c50dc 100644
--- a/Documentation/maintainer/configure-git.rst
+++ b/Documentation/maintainer/configure-git.rst
@@ -7,9 +7,10 @@ This chapter describes maintainer level git configuration.
 
 Tagged branches used in :ref:`Documentation/maintainer/pull-requests.rst
 <pullrequests>` should be signed with the developers public GPG key. Signed
-tags can be created by passing the ``-u`` flag to ``git tag``. However,
-since you would *usually* use the same key for the same project, you can
-set it once with
+tags can be created by passing ``-u <key-id>`` to ``git tag``. However,
+since you would *usually* use the same key for the project, you can
+set it in the configuration and use the ``-s`` flag. To set the default
+``key-id`` use
 ::
 
 	git config user.signingkey "keyname"
-- 
2.41.0

