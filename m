Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D8A79F0FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjIMSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjIMSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:18:19 -0400
X-Greylist: delayed 1298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 11:18:15 PDT
Received: from fallback21.i.mail.ru (fallback21.i.mail.ru [79.137.243.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AC619B6;
        Wed, 13 Sep 2023 11:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=7V7fgWewNPhaoafpaVwA8Q3E6JLlDZh/BU6Y8rgxinM=;
        t=1694629095;x=1694719095; 
        b=VR0pPNrsYqsJ/fZVI9B50Nc+JT7QzYny8papghMo7Z4NKVh7zcfQr6Z/RIUU0lp3FEekQxatdLMVHneB5nLkOaqrgyIFcATjrEfLkyQPo1YR1sfC6va1hpyGkZ3I8h439EZ5ncTs9kSkHi+z+o0eoVhjG7E2mvcZ3oFUvNkL5iA=;
Received: from [10.12.4.15] (port=35676 helo=smtp40.i.mail.ru)
        by fallback21.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1qgU6N-00Fs6p-Pq; Wed, 13 Sep 2023 20:56:36 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=7V7fgWewNPhaoafpaVwA8Q3E6JLlDZh/BU6Y8rgxinM=; t=1694627795; x=1694717795; 
        b=kTMC7Q2VxXxGCQIEGeiZeSFO7kaACSk64ClEooWRbrIGk+KjcCNbzMy0u9ldLax10ZsleDxZqi8
        oq8QyGKeqBbZxgi4UC/xiCOf+plrZTvJylhKiEFQ5S3ZYhXc+qtV3Fw+Q86r+YkoRdNjMhEDLn4mx
        dvO+vGHNhBnisV6su0s=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgU62-009eHm-1D; Wed, 13 Sep 2023 20:56:15 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, vkoul@kernel.org,
        quic_tdas@quicinc.com, dkatraga@codeaurora.org
Cc:     danila@jiaxyga.com, adomerlee@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clk: qcom: gcc-sm8150: Fix gcc_sdcc2_apps_clk_src
Date:   Wed, 13 Sep 2023 20:56:11 +0300
Message-ID: <20230913175612.8685-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CA056C88976AC17650012AE68F2FF28C300894C459B0CD1B97671123999B959D22C506DC8172E2629501B2FA9F0FF42E1424FBDF045C422AE
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76D34FAA3D8B31588C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7C2204D4F9A221771EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAF04F44DFBD239A49D8F576AEE60187B1CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F3E38EE449E3E2AE389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC821E93C0F2A571C7BF6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CDBD6BAFA574C8444C0837EA9F3D197644AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C390DD3ED15DE76207BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7464A38C3DB54FF7A731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5BD7A6635C31D49E6F02C1F4858285CAE3FE6D546EE1A1C12F87CCE6106E1FC07E67D4AC08A07B9B01F9513A7CA91E5559C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFE439756843D9CD0821AABF7E60D9C6A7842409843C015F9A15A7B32FEF9B5A6EAE7801A017AB3E4AC4B8F2E8CFB8F57124344E548B300FD2CA67E0404E2B444304DA52CF61C1B8024C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXgEdfe8YzmBg5d2bTk6IuVE
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981A9073215D3F65785E204FA114A373AF3A02093AA449391CF643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4CCFDD92D2340B86DAE84E8624EAA1CB8D92F4515634B556D049FFFDB7839CE9EA21101AE4D7A6B829DFF42F0DA616BF4912090F4AD4902AFC6914ADF4A538DBC
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdaloFI76w+pKBqvRsLl5dbw==
X-Mailru-MI: C000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
Tested-by: Arseniy Velikanov <adomerlee@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/clk/qcom/gcc-sm8150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 41ab210875fb..05d115c52dfe 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -774,7 +774,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parents_6,
 		.num_parents = ARRAY_SIZE(gcc_parents_6),
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.41.0

