Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EB97A2587
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjIOSVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235841AbjIOSVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:21:12 -0400
Received: from smtp38.i.mail.ru (smtp38.i.mail.ru [95.163.41.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B721FD6;
        Fri, 15 Sep 2023 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=yubnssaxfD0lbd6TG0d2P0qQq9sFqXjqlCWV5TqICCE=; t=1694802067; x=1694892067; 
        b=QegiEaCWGBW+eyTJG+9pDLSYoPOMwfQ/CBQDX+V8Q7mqQchCKB/hQVjxm0rhrF99E0vlsOxhktu
        IYDeu4Q+2Y/owzPJS8upGYKHGXUgUMe1NoAp38TcSvIqwUAIJXDRNaq1pNU6evZwqV6vHY4z6CE9D
        27pcDnTwevztAz+v+qk=;
Received: by smtp38.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhDRA-00G5R8-2I; Fri, 15 Sep 2023 21:21:05 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] pmdomain: qcom: rpmhpd: Add support for SM7150 rpmh clocks
Date:   Fri, 15 Sep 2023 21:20:54 +0300
Message-ID: <20230915182054.113839-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230915182054.113839-1-danila@jiaxyga.com>
References: <20230915182054.113839-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp38.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9FD052C19707CBA10F74D70DBBC233CD7A016A66332CED23000894C459B0CD1B9E4554F032648D9D1018503546C2E8704F642992ABAB832B17078263AA6E0921D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE71288D18ACA28B428EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371AB0416A4896C0B38638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A34ED66D089961930177D5E1E9EB4410117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3A703B70628EAD7BA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F446042972877693876707352033AC447995A7AD186FD1C55BDD38FC3FD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE140C956E756FBB7A985B8ACC81218E19D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE36A1CB4668A9CA5FA040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637A8A59EE88DA1D479EFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5B3F8D1FD892A32236981EF852F3FB5769CA7FDC079330CF9F87CCE6106E1FC07E67D4AC08A07B9B0B355ED1E20F5346A9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF70D518CF6A9128C5C78D694F9CFB33F76FE01FB940F35304C33B8F024D1ADD11ABDA6BB679979B95B3573C328C294A3D3F86EB742601633B5426C164EAD7B9E921BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwfkaTmrWlaxp7GRpC+hDSA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812E816679BFB18EEAC71EAD0F915E2FD0DF76B9B9158B2F3E643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the RPMH clocks present in SM7150 SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/pmdomain/qcom/rpmhpd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
index a87e336d5e33..d48235aa024c 100644
--- a/drivers/pmdomain/qcom/rpmhpd.c
+++ b/drivers/pmdomain/qcom/rpmhpd.c
@@ -337,6 +337,23 @@ static const struct rpmhpd_desc sm6350_desc = {
 	.num_pds = ARRAY_SIZE(sm6350_rpmhpds),
 };
 
+/* SM7150 RPMH powerdomains */
+static struct rpmhpd *sm7150_rpmhpds[] = {
+	[SM7150_CX] = &cx_w_mx_parent,
+	[SM7150_CX_AO] = &cx_ao_w_mx_parent,
+	[SM7150_GFX] = &gfx,
+	[SM7150_LCX] = &lcx,
+	[SM7150_LMX] = &lmx,
+	[SM7150_MSS] = &mss,
+	[SM7150_MX] = &mx,
+	[SM7150_MX_AO] = &mx_ao,
+};
+
+static const struct rpmhpd_desc sm7150_desc = {
+	.rpmhpds = sm7150_rpmhpds,
+	.num_pds = ARRAY_SIZE(sm7150_rpmhpds),
+};
+
 /* SM8150 RPMH powerdomains */
 static struct rpmhpd *sm8150_rpmhpds[] = {
 	[SM8150_CX] = &cx_w_mx_parent,
@@ -562,6 +579,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
 	{ .compatible = "qcom,sdx75-rpmhpd", .data = &sdx75_desc},
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
+	{ .compatible = "qcom,sm7150-rpmhpd", .data = &sm7150_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
 	{ .compatible = "qcom,sm8350-rpmhpd", .data = &sm8350_desc },
-- 
2.41.0

