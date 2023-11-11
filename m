Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3E7E895F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 06:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjKKF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 00:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKKF4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 00:56:08 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CBB4204;
        Fri, 10 Nov 2023 21:56:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=yilin.li@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vw6WwWY_1699682161;
Received: from localhost(mailfrom:YiLin.Li@linux.alibaba.com fp:SMTPD_---0Vw6WwWY_1699682161)
          by smtp.aliyun-inc.com;
          Sat, 11 Nov 2023 13:56:02 +0800
From:   "YiLin.Li" <YiLin.Li@linux.alibaba.com>
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     YiLin.Li@linux.alibaba.com, tianjia.zhang@linux.alibaba.com
Subject: [PATCH] crypto: asymmetric_keys/pkcs7.asn1 - remove the duplicated contentType pkcs7_note_OID processing logic
Date:   Sat, 11 Nov 2023 05:55:53 +0000
Message-Id: <20231111055553.103757-1-YiLin.Li@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OID of contentType has been recorded in
`ContentType ::= OBJECT IDENTIFIER ({ pkcs7_note_OID })`,
so there is no need to re-extract the OID of contentType in
`contentType ContentType ({ pkcs7_note_OID })`.
Therefore, we need to remove the duplicated contentType
pkcs7_note_OID processing logic.

Signed-off-by: YiLin.Li <YiLin.Li@linux.alibaba.com>
---
 crypto/asymmetric_keys/pkcs7.asn1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7.asn1 b/crypto/asymmetric_keys/pkcs7.asn1
index 28e1f4a41c14..3f7adec38245 100644
--- a/crypto/asymmetric_keys/pkcs7.asn1
+++ b/crypto/asymmetric_keys/pkcs7.asn1
@@ -28,7 +28,7 @@ SignedData ::= SEQUENCE {
 }
 
 ContentInfo ::= SEQUENCE {
-	contentType	ContentType ({ pkcs7_note_OID }),
+	contentType	ContentType,
 	content		[0] EXPLICIT Data OPTIONAL
 }
 
-- 
2.31.1

