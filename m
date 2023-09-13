Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4462C79F15B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjIMSqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjIMSpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:45:55 -0400
Received: from smtp50.i.mail.ru (smtp50.i.mail.ru [95.163.41.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C391BDD;
        Wed, 13 Sep 2023 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=VlAwcbr1PJv+/CvDMGSnTL8UEAvraX/AxaiH9ZBa4FY=; t=1694630751; x=1694720751; 
        b=Nen4C6TNSVfisoDtPD2hOSAKrscIVj5j+/vvwJRDyih8AHxSaLXGpYZjOXSE4gMier39Hl5V47B
        fzj1+XuDM3UAUM6NptdQvSQyzEPouurWzULFSuVf23cuMqzf0JAOcDGSDiQ3a+Cq0MBWxGFWBQ9a3
        t1KXV4PSwQ2I84shUos=;
Received: by smtp50.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUrt-0035qJ-1o; Wed, 13 Sep 2023 21:45:42 +0300
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
Subject: [PATCH 2/2] iommu/arm-smmu-qcom: Add SM7150 SMMUv2
Date:   Wed, 13 Sep 2023 21:45:25 +0300
Message-ID: <20230913184526.20016-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913184526.20016-1-danila@jiaxyga.com>
References: <20230913184526.20016-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp50.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CAE547C3CB81491E147B0A519B3A90A1300894C459B0CD1B9FCADAFC12146BA0B77109B367F67D16FD6A2906DA3674A73AF5C6C36E0A87868
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77633BACAB33B9508C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE72AC9FB60380F23AEEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBA789224ABAF5047F16D28B030BD9E2863CC7F00164DA146DAFE8445B8C89999728AA50765F7900637CAEE156C82D3D7D9389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E1113711302FCEF25BFAB3454AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3A09E6C134B021B95BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7BA474C34E03C8BE3731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5640C74D9821470FA031D1C92F0B967683729D7C6F4FA30E4F87CCE6106E1FC07E67D4AC08A07B9B04D3DDB508812D9009C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF9438D6C3C1AAFCD1EF70536961DB6D581DF6077A8BD9B6F182F3ECCA93B9ADBAEC58EB6354A2D53AC4B8F2E8CFB8F571C5E147D6D01543BBD0509EA1E0215B42E4EB81C25D25832B4C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSRcjs8RgJWcJg==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812764E3BEC62920434EFC06FC47E31AA75E6A6BA515280ED4643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM7150 uses a qcom,smmu-v2-style SMMU just for Adreno and friends.
Add a compatible for it.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 7f52ac67495f..47e28945a8a0 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -532,6 +532,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm6375-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
+	{ .compatible = "qcom,sm7150-smmu-v2", .data = &qcom_smmu_v2_data },
 	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
 	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
-- 
2.41.0

