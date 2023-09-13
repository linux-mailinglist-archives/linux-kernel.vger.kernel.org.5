Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3047E79F158
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjIMSpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjIMSpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:45:52 -0400
Received: from smtp50.i.mail.ru (smtp50.i.mail.ru [95.163.41.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822011BC8;
        Wed, 13 Sep 2023 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=n7C2RNRpLYg9oxctQJZVIc5Oy9GIzOSMxVE9hxRUkwA=; t=1694630748; x=1694720748; 
        b=Ttylh/76AQcirdNzDOm8ErtqUpCE63oIJs9+tEdSlo33KvwICjk7qRJtC/R95UqVwe11YMCqWZO
        jySpmXktJ4LuxNYGjzkrk+U9328Yyn1vylLUqoxnl2fH6AhKlpIlsSD5nj6397YuqUoXW3SkpFtdE
        d7f+ScqXXmtLPJthRBY=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUrq-0035qJ-2J; Wed, 13 Sep 2023 21:45:39 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.baryshkov@linaro.org,
        konrad.dybcio@linaro.org, quic_saipraka@quicinc.com,
        quic_bjorande@quicinc.com, a39.skl@gmail.com,
        robdclark@chromium.org, mani@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Add SM7150 GPU SMMUv2
Date:   Wed, 13 Sep 2023 21:45:24 +0300
Message-ID: <20230913184526.20016-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913184526.20016-1-danila@jiaxyga.com>
References: <20230913184526.20016-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp50.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CA3E66AC44DE3C0271DCEA143A5C2094500894C459B0CD1B9C4A50A6BC0C2AF4028B9EFF5C510BC1FD6A2906DA3674A73B2E6FBEB60789C2A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE751BC6685BC61E6BCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637C3BF94FB392044A18638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83FD68EC804176A1323F74D500C264703117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC60CDF180582EB8FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC65AC60A1F0286FEC43C4D2AE8146675D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3AC7A5202D916A59B040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407978DA827A17800CE705056152E029236E2DBA43225CD8A89F680B5A81FBA2CF50A91E23F1B6B78B78B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A59183FA4105F43FE4031D1C92F0B967687F778DF1D6828D26F87CCE6106E1FC07E67D4AC08A07B9B0B355ED1E20F5346A9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6A5858702F3B4D44583A949434D6BE7564F298AEDEA063018CB1B9828FEDEC16500AA17B1AA25A4FC4B8F2E8CFB8F571F39059D7E9338F1FF9436BD97BB56533E4EB81C25D25832B4C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSS/HwZF3bg65g==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812764E3BEC629204347D11A7A18376657B34347D524A1DD16643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM7150 has a qcom,smmu-v2-style SMMU just for Adreno and friends.
Document it.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index cf29ab10501c..54c333ddf916 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -110,6 +110,7 @@ properties:
               - qcom,sdm630-smmu-v2
               - qcom,sdm845-smmu-v2
               - qcom,sm6350-smmu-v2
+              - qcom,sm7150-smmu-v2
           - const: qcom,adreno-smmu
           - const: qcom,smmu-v2
       - description: Qcom Adreno GPUs on Google Cheza platform
@@ -409,6 +410,7 @@ allOf:
           contains:
             enum:
               - qcom,sm6350-smmu-v2
+              - qcom,sm7150-smmu-v2
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
     then:
-- 
2.41.0

