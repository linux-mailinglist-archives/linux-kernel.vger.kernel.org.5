Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0379877420F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbjHHRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjHHRcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:32:07 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA25591B09;
        Tue,  8 Aug 2023 09:13:58 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3788hxCN028357;
        Tue, 8 Aug 2023 11:31:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=83QRB91
        XCqta7aA5qIWy8kb1H0qqy7Rwoo1ofNsLR0A=; b=0BFEHaPb5VvDLCN55jfK81o
        Y/Ai4OeTiM8RpgUfu3uQMNA1RcHCP6G2RDoiwWknASfDrhk/onqDZ4qhMy6StjC2
        gQrEYFkGD1ZuH4M8oNMhclPm3kKIEG8EbCY4jQ8LbnrO5fVx8MQSZBZv4cpgsbmH
        1aFMDY5RLw+U2qazJniyxRSYbbUEjGjG0y/eB6QHq1PaQD8G8+LCLwjDAzyCekvf
        HwKIMJiNUgmyyXjGrWhnHq0MgB6Zyf4847IpNnbVQVJt5NRNByHfD3ZtjvSukOYi
        cgUA7RS09N5iyW7B2FVyxNH1k4XkFawJgj8YtJ9Pvm3MuHxtRF8xOh85s1kUJOQ=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sbjf38bde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:31:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 02B38100062;
        Tue,  8 Aug 2023 11:31:38 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D7049216850;
        Tue,  8 Aug 2023 11:31:38 +0200 (CEST)
Received: from localhost (10.201.20.38) by EQNDAG1NODE4.st.com (10.75.129.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 8 Aug
 2023 11:31:38 +0200
From:   <patrice.chotard@foss.st.com>
To:     <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.torgue@foss.st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 0/2] Add gpio_ranges property for stm32f7
Date:   Tue, 8 Aug 2023 11:31:17 +0200
Message-ID: <20230808093119.714224-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_08,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Add missing gpio-ranges property for stm32f7 based boards.

Patrice Chotard (2):
  ARM: dts: stm32: Add gpio-ranges for stm32f746-pinctrl
  ARM: dts: stm32: Add gpio-ranges for stm32f769-pinctrl

 arch/arm/boot/dts/st/stm32f746-pinctrl.dtsi | 44 +++++++++++++++++++++
 arch/arm/boot/dts/st/stm32f769-pinctrl.dtsi | 44 +++++++++++++++++++++
 2 files changed, 88 insertions(+)

-- 
2.25.1

