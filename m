Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392B279F0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjIMSRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:17:32 -0400
X-Greylist: delayed 1270 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Sep 2023 11:17:28 PDT
Received: from smtp42.i.mail.ru (smtp42.i.mail.ru [95.163.41.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2419B6;
        Wed, 13 Sep 2023 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com
        ; s=mailru; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
        X-Cloud-Ids:Disposition-Notification-To;
        bh=W9JGMoPFPXMkSf4UYnYVsPP/a6ZBsBJHVJVEnoIzgoM=; t=1694629048; x=1694719048; 
        b=ReqjgoUhH09jzXPIZyoDmz92k7aK/r7gEgJFWJxlpryjpOoVStfjPO/wcgXlJxjx60Oiba1eKIh
        chXhWgQuLNBSU2HsXV14J+t6WPR2ClB1Sw14oRS3TavYo4zzTfQTQBJoApf+W4fYynuyYT6D9QX9L
        sRerAJyBm3a2st7rNRw=;
Received: by smtp42.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1qgUQW-002CNz-2y; Wed, 13 Sep 2023 21:17:25 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2]  soc: qcom: socinfo: Add SM7150P ID
Date:   Wed, 13 Sep 2023 21:17:20 +0300
Message-ID: <20230913181722.13917-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp42.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD927CFE6CA1630A10CC7C637228D9AC5849E3361C131A0BCD300894C459B0CD1B9EA37E3C1DEA3CDF812E2907643693695E810CAF9E72F1A4271C70EC916F3F42B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE727FD6E7FC3A8F857EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377CC130305260E47D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D83AD9A91DF818CDB60591FB868C59A0117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC55D5BE2F85BDEC5FA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735201E561CDFBCA1751F2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE4B6963042765DA4B28F6BDBBAB179F4ED8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE368E4D7E803FA7AD5C0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637A33AF67571422614731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A5AE340BF9E998A78642B845A496872F882E5E8D42E22D1635F87CCE6106E1FC07E67D4AC08A07B9B08ED1AC82D843A2BB9C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A0997E3FB2386030E77
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CFD9413153F9493B6132B4CEC344CA3ABB17CF3CBB77DADEF3A1964E96C1933445ACCA692FBCDC96C2C4B8F2E8CFB8F5713A23E06EBA107BE72E4EEC99511919C66E346BF9FA413E554C41F94D744909CE4BCAC77546666B612CC0CD5AA9A1B9887EE09F5AAA95A50543082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojoMTWofjSWSQGtLx7gbZW0Q==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981796B0F5A6336A7084CF0F33EB09DA5F02FE1B90895D89C7D643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds ID for Qualcomm SM7150P SoC.

The SM7150P does not have Qualcomm IP Accelerator (IPA), unlike the SM7150.
And also has a different SoC id. SM7150P is used in
Lenovo Tab P11 Pro (lenovo-j706f) for example.

Danila Tikhonov (2):
  dt-bindings: arm: qcom,ids: Add Soc ID for SM7150P
  soc: qcom: socinfo: Add Soc ID for SM7150P

 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)

-- 
2.41.0

