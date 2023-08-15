Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56D577CBE9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjHOLnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjHOLmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:42:33 -0400
X-Greylist: delayed 723 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 04:42:14 PDT
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:400:100::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954B1FE8;
        Tue, 15 Aug 2023 04:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1692099005; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N/tMZQXGF94jY4PM/7LwlDMaYaSPAE+Uvk36HIabKvBc22ejafm7henAJmdrHtBaj8
    V+gZm54BOrdAaZvDctZ6TCUf1zOzHpS9oTKyQKuZN82BWCRo4iRzOoRG98a4EauwjYFg
    2Tv5GmURapsAi0OMHXTZ19yDuuHI6CjPviL+f9AjXQm5MvB+awckzo5OkobzZmaPiWp5
    H967VbhjI476QiCEpryJwhpx2qeGxTodDA+AD+qDbZp+NB7rjI8oO1pnFAubtQ2MUf7G
    yxg/fE6KGSRVSqO5k+MEjQ0HA+tRI4wbVijYcxj68R2MdAF1EAwLA7G6bdJoS9hpxVbA
    AWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1692099005;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0fArIV/skXXqwvM6vu5sx+WDXinHkC9gAI6MI712b8g=;
    b=Y62S1fBOzIHkg+kxAoN6IHHxgov9CS3gVAd02EFgHuSSaR4MNtLWG+DABqCJ0/O2pw
    BSLaid1ipLhFm75/D6N6ufqgA/xUbwrR3JgXhXZvGuMNIvzrbI6YqYXxmtN2eVbVrXlO
    k6KLLPDvwMo7TVi818I8fPh6mCYy4btqp6ZIkqwRi5rhWNULLeFvtq/Wyhpxw+38SYis
    l9Q25XY0BTeBbJjZpRiYSkgumPqYMp+hdeO6ETuUa+ei9emqeGjzaQKSViCvlvMammU7
    jH7GQX6Rud1Pq5hiNn8eq/o5P6ITLr4U+nbXBhPBOysxsYx05Fm/9QPx/jBB29ksDfI4
    7x+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1692099005;
    s=strato-dkim-0002; d=thson.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0fArIV/skXXqwvM6vu5sx+WDXinHkC9gAI6MI712b8g=;
    b=QHwwvnr6dCsvZilLvr2M0jFuHnyZyhHTa2DDyq3bgAj5EpiFzxVRI0AOrmsZcgQp2k
    cBXuK0WV/2Bxt94FUoDdoZAIQ1ca9t0JItUaBzocB6s0krI2E7YMZXzhyYAVZw75gcdj
    rZrr8M2fa3v1sBdIFCVSzBMu5BB7gYBEyQzv6BaBBkK42m0QdQ2M7MmIE2TqPQzUbVQZ
    14LNF+rslo5i4GCkEX3w3+paUqYlMlMMQ2ExFSj0T9EgwFKgaeOCnIwiAUx8F4uXKOq1
    qvxFvMVgLLWwAvpsZpl6dPxQJLJnSXIZ/RNFFDz0yCgWLZTIE7rTNV+FWoPszVB6FREM
    5oqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1692099005;
    s=strato-dkim-0003; d=thson.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=0fArIV/skXXqwvM6vu5sx+WDXinHkC9gAI6MI712b8g=;
    b=9GOt/JgphwB1P22CbzR7UHsC72OJx4YSCFTYhsKaYus/t2EiGqzVFV0YbIgamjzsPe
    9R2FAcpIkuJ5fu7jlyCw==
X-RZG-AUTH: ":PHkGeUmrW+uCZmxs998QJRUX30nOwJd7nOD9sw/xoau6coP/7eWf7ZtI5bftmbs="
Received: from USER-PC.adm.ds.fhnw.ch
    by smtp.strato.de (RZmta 49.6.6 AUTH)
    with ESMTPSA id jd2f5az7FBU3Des
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 15 Aug 2023 13:30:03 +0200 (CEST)
From:   Thore Sommer <public@thson.de>
To:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thore Sommer <public@thson.de>
Subject: [PATCH] X.509: if signature is unsupported skip validation
Date:   Tue, 15 Aug 2023 14:29:42 +0300
Message-ID: <20230815112942.392572-1-public@thson.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the hash algorithm for the signature is not available the digest size
is 0 and the signature in the certificate is marked as unsupported.

When validating a self-signed certificate, this needs to be checked,
because otherwise trying to validate the signature will fail with an
warning:

Loading compiled-in X.509 certificates
WARNING: CPU: 0 PID: 1 at crypto/rsa-pkcs1pad.c:537 \
pkcs1pad_verify+0x46/0x12c
...
Problem loading in-kernel X.509 certificate (-22)

Signed-off-by: Thore Sommer <public@thson.de>
---
 crypto/asymmetric_keys/x509_public_key.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 6fdfc82e23a8..7c71db3ac23d 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -130,6 +130,11 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 			goto out;
 	}
 
+	if (cert->unsupported_sig) {
+		ret = 0;
+		goto out;
+	}
+
 	ret = public_key_verify_signature(cert->pub, cert->sig);
 	if (ret < 0) {
 		if (ret == -ENOPKG) {
-- 
2.41.0

