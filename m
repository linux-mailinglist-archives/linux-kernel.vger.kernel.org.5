Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D897A31C7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbjIPSA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 14:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjIPSAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 14:00:03 -0400
X-Greylist: delayed 85137 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Sep 2023 10:59:57 PDT
Received: from smtp40.i.mail.ru (smtp40.i.mail.ru [95.163.41.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E31CDE;
        Sat, 16 Sep 2023 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=SiE4TVuudP1RJrzTt2gfHflU0M0+FW4WngCT3P1dtbI=; t=1694887197; x=1694977197; 
        b=zA5T1u7RcGC+UuFH05XQ/L2yHc+oDiGd7snJgaVPComf+SY/7YjaBcH+teDhbFzw2okHPqClNIO
        iUUMCX86l5lfEWxFqgvLmf+4FNZHjL7FTXbFTeiVUGa6NfXzbmnB1PfGbf8LBvHS1rDRllHkkwnoN
        moIP7iULb5KGIQhgx9Y=;
Received: by smtp40.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qhZaE-006d7F-3C; Sat, 16 Sep 2023 20:59:55 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 0/2]  pmdomain: qcom: rpmhpd: Add support for SM7150
Date:   Sat, 16 Sep 2023 20:59:50 +0300
Message-ID: <20230916175952.178611-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp40.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9FD052C19707CBA10E5239867C9872289190DCF2900D488F000894C459B0CD1B9B603AEB3AAF802F7C9EE25353626C12731D7BEF43F7B604A8957A5FC6A3222B0
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE73AE950808E78B47CC2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE7F87C043BA75DB4CEEA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BE5CCB53A13BC8DBAA6001DE9653A5DF237707AFAD8E65942CC7F00164DA146DAFE8445B8C89999728AA50765F790063741F7343E26298569389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC85FF72824B19451C6F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CA6C7FFFE744CA7FB6E0066C2D8992A164AD6D5ED66289B523666184CF4C3C14F6136E347CC761E07725E5C173C3A84C34B6590F86FB8E8FBBA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE78DD9044B304389D4731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5692724D5374B5FF2147C0D302D6FBB8367725044FBC5C6C9F87CCE6106E1FC07E67D4AC08A07B9B0A7DFDF579AB090EF9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF6248BB1476E8094561A0DCFF050BEC72F7A2ED4B95F80A136F2C9D6285638422673DC415E80A8BD9B3573C328C294A3D29DEA10AE49BBCA38474C3896FBBA94121BEC6C0C71ED4F84C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojwfkaTmrWlawbDrT2f4i+ZQ==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498126E16CB1D4F8C9A0114C490EE5FFF8C44DBE9103A410A6E9643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
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

This series adds RPMH support for Qualcomm SM7150 SoC.

Changes in v2:
- Use generic RPMh PD indexes.
- Link to v1:
https://lore.kernel.org/all/20230915182054.113839-1-danila@jiaxyga.com/

Danila Tikhonov (2):
  dt-bindings: power: qcom,rpmpd: Add SM7150
  pmdomain: qcom: rpmhpd: Add support for SM7150 rpmh clocks

 .../devicetree/bindings/power/qcom,rpmpd.yaml  |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                 | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

-- 
2.41.0

