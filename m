Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35D07C4883
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjJKDmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJKDmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:42:07 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0AD92
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 20:42:06 -0700 (PDT)
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qqQ6f-0006gO-0x;
        Tue, 10 Oct 2023 23:41:57 -0400
Date:   Tue, 10 Oct 2023 23:41:53 -0400
From:   Rik van Riel <riel@surriel.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@meta.com, Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] execve.2: execve also returns E2BIG if a string is too long
Message-ID: <20231010234153.021826b1@imladris.surriel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document that if a command line or environment string is too long (> MAX_ARG_STRLEN), execve will also return E2BIG.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 man2/execve.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/execve.2 b/man2/execve.2
index 0d9582492ad1..c1a359d01872 100644
--- a/man2/execve.2
+++ b/man2/execve.2
@@ -449,7 +449,7 @@ The total number of bytes in the environment
 .RI ( envp )
 and argument list
 .RI ( argv )
-is too large.
+is too large, or an argument or environment string is too long.
 .TP
 .B EACCES
 Search permission is denied on a component of the path prefix of
-- 
2.41.0


