Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A7D7A31C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjIPSAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjIPSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:00:04 -0400
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [95.163.41.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41ACDF;
        Sat, 16 Sep 2023 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=YrifPwskNxrQdfy3L7DLk8vRETToPCtVQMofZTYkNpc=; t=1694887199; x=1694977199; 
        b=CjNKbV4e96s8uGl4F3Kc/zUCCHEkXKYVkDNOXiLk0AO9LnOBlHSloeQSCCyoI4nr+6s6Mh1aXEq
        jhFobTlw/lFQ7S4GBd3gjKlS5OW3LoqhJNzx8Hg30Yvkwa3Di9kbE83YLowBp3wNhVn6UliiRTIr8
        MLZEZADByV6dzzcym9E=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhZaG-006d7F-2W; Sat, 16 Sep 2023 20:59:57 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 1/2] dt-bindings: power: qcom,rpmpd: Add SM7150
Date:   Sat, 16 Sep 2023 20:59:51 +0300
Message-ID: <20230916175952.178611-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230916175952.178611-1-danila@jiaxyga.com>
References: <20230916175952.178611-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FD052C19707CBA10E1DF9AC9639ABFCAB37C07C62C377C8700894C459B0CD1B9668506490178D1C369A416DF12FDE73931D7BEF43F7B604A54C85456B1E49444
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78ECF34BFCFFD7E95EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EA9DEEAA3ECF8E948638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D822A69EAE61C65876ACC9B0486499BCD4117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCEA77C8EAE1CE44B0A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA9E0F2381F647739FAD8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3A6C7FFFE744CA7FB6136E347CC761E07C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006373568875668442E59EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A560DF82330AAEA04E147C0D302D6FBB833A6B84EFDB8A853EF87CCE6106E1FC07E67D4AC08A07B9B0A6C7FFFE744CA7FB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFAF3CE06A86885C3B7044904F9652E9A7DE0D0487A4DB1CFB6AF7350BAACEB569025CA78FE36D2257B3573C328C294A3D2ED1D9BC1CF2ACC8CACAF375EFDCB8E121BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwfkaTmrWlay7lKRWgyHm0Q==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498126E16CB1D4F8C9A0D657727510EA009B955FF3E630B0E941643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for SM7150 platforms.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 9b03c41d3604..53886f02d98a 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -46,6 +46,7 @@ properties:
       - qcom,sm6125-rpmpd
       - qcom,sm6350-rpmhpd
       - qcom,sm6375-rpmpd
+      - qcom,sm7150-rpmhpd
       - qcom,sm8150-rpmhpd
       - qcom,sm8250-rpmhpd
       - qcom,sm8350-rpmhpd
-- 
2.41.0

