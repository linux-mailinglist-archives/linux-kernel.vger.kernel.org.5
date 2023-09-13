Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC179F174
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjIMSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjIMSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:55:24 -0400
Received: from smtp30.i.mail.ru (smtp30.i.mail.ru [95.163.41.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2739170F;
        Wed, 13 Sep 2023 11:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=Bdqu4s7ncA4QNWSmchcpgNA7AzGHQshXAsqWrNvVCTM=; t=1694631319; x=1694721319; 
        b=NTYvK2aW5GgyVJQYcdEjFCvo22++uRu+vAepCASfaFqEnfihQgDP+Huv6HtV0j3XFcNDFMyZnkh
        2dD07VsyJGtLtcp6axeblAany09F5Z6ERL06JaN8EF+7QKl6iVSloGAtr56SZPI0l24giZqYd/TQD
        5DTrGf/mF2WYTaseWP4=;
Received: by smtp30.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgV1A-00Bqzx-1a; Wed, 13 Sep 2023 21:55:17 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH] arm64: dts: qcom: pm8150l: Add wled node
Date:   Wed, 13 Sep 2023 21:55:14 +0300
Message-ID: <20230913185514.21840-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp30.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CAE547C3CB81491E147B0A519B3A90A1300894C459B0CD1B97E8814247698D33C30661C66D29D2DC8A5703660123B0E3439E8B8BCDB49C505
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78E88BD1CA827EF00C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE76ABD3380F320B62CEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAA11B5CEE892613ACE2D41390E4B507A7CC7F00164DA146DAFE8445B8C89999728AA50765F79006377C70927E34808485389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8C6602A96AF88C695F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CE3786DD2C77EBDAAAD7EC71F1DB884274AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C3457234DA37CC1B30BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE758ECEFFC28DC0EE1731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5A3892C2D7FF39EF814F48A8AF2C0D2F36316C517E94E872BF87CCE6106E1FC07E67D4AC08A07B9B082B967D547A19D2F9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A092FFDA4F57982C5F4CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFDB79098084455A7C7C2B888197BDEC4B1BC404F1A5301E99C01D86FD553629AF08FC8DA71D385488C4B8F2E8CFB8F571ADE2B3FACB4F0A92C813EED9329642026E346BF9FA413E554C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSSmvwuM+wqblA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B1AC1201EBCD528A24F77F4D91D93CDC0090337874FE1BEF643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WLED is used for controlling the backlight on some boards, add the node
for it.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index b1686e5777b8..ac08a09c64c2 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -132,5 +132,15 @@ pm8150l_lpg: pwm {
 			status = "disabled";
 		};
 
+		pm8150l_wled: leds@d800 {
+			compatible = "qcom,pm8150l-wled";
+			reg = <0xd800>, <0xd900>;
+			interrupts = <0x5 0xd8 0x1 IRQ_TYPE_EDGE_RISING>,
+				     <0x5 0xd8 0x2 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ovp", "short";
+			label = "backlight";
+
+			status = "disabled";
+		};
 	};
 };
-- 
2.41.0

