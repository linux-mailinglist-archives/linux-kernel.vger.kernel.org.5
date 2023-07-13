Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4738B75267D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjGMPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjGMPQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:16:20 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41C171D;
        Thu, 13 Jul 2023 08:16:18 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DDH7pK010108;
        Thu, 13 Jul 2023 17:16:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=nofwAIVvPZ0S3j2VMiAWCPNbtVC9IengVVKGim+qgc0=;
 b=gh//tTL93vTASGWm5yXRNAH1dDItRdtEohZNA4OBeQACh4QRdVYXrzKT90srbmlHfMv5
 E6YloEKH2IFpM/unLNMDEjhPdEgucTV2v3tvzsZKVe2AY884oE8JNp+HMoZ8sOqnVnEX
 LvxUZZux6ZZ5Q9mIzKMC42ySd5NH9fpU8D+v4rM2cmIC3AHZjdBtGYpUGCHB9xNDoAPG
 LzOAFkViAP2DvzciTRtuTPMa1ZrzAGqS4tavPkExC40WG1udTbI9P35UswkhA5EVONuz
 96nDSCMr2nbUt4/fJBsv0tScS9yI/nJhxvpzCnN2JaL7RLPAh1D5BeKmoEKjFhUlPqbh CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rtedtjfk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 17:16:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EEFE0100056;
        Thu, 13 Jul 2023 17:16:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E651A22A6C6;
        Thu, 13 Jul 2023 17:16:01 +0200 (CEST)
Received: from localhost (10.201.22.9) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 13 Jul
 2023 17:16:04 +0200
From:   Thomas BOURGOIN <thomas.bourgoin@foss.st.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Bourgoin <thomas.bourgoin@foss.st.com>
Subject: [PATCH v2 1/7] dt-bindings: crypto: add new compatible for stm32-hash
Date:   Thu, 13 Jul 2023 17:15:12 +0200
Message-ID: <20230713151518.1513949-2-thomas.bourgoin@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
References: <20230713151518.1513949-1-thomas.bourgoin@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.22.9]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_05,2023-07-13_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lionel Debieve <lionel.debieve@foss.st.com>

Add a new compatible for stm32mp13 support.

Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
Signed-off-by: Thomas Bourgoin <thomas.bourgoin@foss.st.com>

---
Changes in v2:
 - add SoB of Thomas in commit message

 Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
index b767ec72a999..ac480765cde0 100644
--- a/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
+++ b/Documentation/devicetree/bindings/crypto/st,stm32-hash.yaml
@@ -20,6 +20,7 @@ properties:
       - stericsson,ux500-hash
       - st,stm32f456-hash
       - st,stm32f756-hash
+      - st,stm32mp13-hash
 
   reg:
     maxItems: 1
-- 
2.25.1

