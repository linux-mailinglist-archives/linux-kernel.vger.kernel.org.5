Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA8E79F0FA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjIMSRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjIMSRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:17:36 -0400
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [95.163.41.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A3419B6;
        Wed, 13 Sep 2023 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=37Nttmuoe1Wm/nxFXf6zEo55jJh8cFW7evX+JFP2B+o=; t=1694629052; x=1694719052; 
        b=FJoRVZH96Djm86wbrRj1+zk1NnHCl6vs+dkWAcVc5lcr/yXmI3unU2EsfXQAgn+9yvno9V9EDkC
        ne4l1aaQ2096a3xPTNvTuzzFafqjx//JU4TnQt2/eDBoffa9ECdo1+j/p9KcRuTohDmqKF28ZBi2Z
        KdK1TjfOPmeWtceHYjg=;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUQb-002CNz-2J; Wed, 13 Sep 2023 21:17:30 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add Soc ID for SM7150P
Date:   Wed, 13 Sep 2023 21:17:22 +0300
Message-ID: <20230913181722.13917-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230913181722.13917-1-danila@jiaxyga.com>
References: <20230913181722.13917-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp42.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CF6AE4F281D6047BD48D88D1FA316275E00894C459B0CD1B9C9DC0F71FAB02E15102F48B87C3AF90EE810CAF9E72F1A42C0ACFA3BF7752234
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7353CFE866E745C13EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006373745FD4183B699148638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D877E939179F8B5AC2179576031282D9B9117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC60CDF180582EB8FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751FF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C6D3A1509E11137112D242C3BD2E3F4C64AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C39D0128E0B8962AF3BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7D2B2750C7C54257D731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A55F05040A71FCE57142B845A496872F887F778DF1D6828D26F87CCE6106E1FC07E67D4AC08A07B9B0735DFC8FA7AC12079C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFF6BE6653850BC690FD46CF65E188E6D19197256DB9D5C91A938603DA431A663F329B3AFCBA1AB93DC4B8F2E8CFB8F571E529B3DD490B80AB26C1C18CDE7FECEC6E346BF9FA413E554C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSR2QP2TjoVzqw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981796B0F5A6336A70850E710BF39331DEBB34347D524A1DD16643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Soc ID table entries for Qualcomm SM7150P.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 497cfb720fcb..1f433a941c50 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -349,6 +349,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SDA439) },
 	{ qcom_board_id(SDA429) },
 	{ qcom_board_id(SM7150) },
+	{ qcom_board_id(SM7150P) },
 	{ qcom_board_id(IPQ8070) },
 	{ qcom_board_id(IPQ8071) },
 	{ qcom_board_id(QM215) },
-- 
2.41.0

