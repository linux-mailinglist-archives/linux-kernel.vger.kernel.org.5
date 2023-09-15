Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37657A2580
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjIOSVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjIOSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:21:07 -0400
Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569831FD7;
        Fri, 15 Sep 2023 11:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=e7kyerDZ1bFusdPgCRM4oSWttEQ11h8Jz0EXBk5Jw5Y=; t=1694802061; x=1694892061; 
        b=i+BHjDrUtFZGhRv6hkO6b0qz6iul7rMmhvslZAj9CCHx1POqtn0QjWxoKhAyWW8eNBSm4DvZ+ZI
        MlWDgvqTVjUjHwNvCER2KCa53Al0RBUzejdHiaoXieC2L2abOImiup19z86WZKI1gf73OJZltSbbf
        h2MK843Odyk5gPYq3RM=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhDR4-00G5R8-2I; Fri, 15 Sep 2023 21:20:59 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: Add SM7150
Date:   Fri, 15 Sep 2023 21:20:53 +0300
Message-ID: <20230915182054.113839-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915182054.113839-1-danila@jiaxyga.com>
References: <20230915182054.113839-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD902203E0DD57300EC89AAED3EA3F32E92EBA3BF9EE48D578D182A05F5380850404C228DA9ACA6FE2728F79CDDD891EC7BDF2B4C95B75CC9B3993B39A01EECD83683B621EA0271FB53
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7688275994059DE5FEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063790B55F3E386DB9B28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D867E1B1EEBB84AF7F0177D5E1E9EB4410117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC5FC25ED3FCEC3375A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE140C956E756FBB7AC5236E9430F51F07D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE36A1CB4668A9CA5FA2D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637A8A59EE88DA1D479EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5F4B45C4E1D9922426981EF852F3FB5769CA7FDC079330CF9F87CCE6106E1FC07E67D4AC08A07B9B086D40F53BA1922959C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF104E82343679AD000D69A9DD5906C7D0D8BDD1FC0716AB545CC37B0F2EF7D4E17622FCE73A124D83B3573C328C294A3D5F937EF72DE5135B5426C164EAD7B9E921BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwfkaTmrWlazXyzGcAkYccw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812E816679BFB18EEA50023357CE020C06DF76B9B9158B2F3E643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible for SM7150 platforms and relevant defines to the
include file.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/power/qcom,rpmpd.yaml          |  1 +
 include/dt-bindings/power/qcom-rpmpd.h                 | 10 ++++++++++
 2 files changed, 11 insertions(+)

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
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
index 83be996cb5eb..a021907b792c 100644
--- a/include/dt-bindings/power/qcom-rpmpd.h
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -77,6 +77,16 @@
 #define SM6375_VDD_LPI_CX	8
 #define SM6375_VDD_LPI_MX	9
 
+/* SM7150 Power Domain Indexes */
+#define SM7150_CX	0
+#define SM7150_CX_AO	1
+#define SM7150_GFX	2
+#define SM7150_LCX	3
+#define SM7150_LMX	4
+#define SM7150_MSS	5
+#define SM7150_MX	6
+#define SM7150_MX_AO	7
+
 /* SM8150 Power Domain Indexes */
 #define SM8150_MSS	0
 #define SM8150_EBI	1
-- 
2.41.0

