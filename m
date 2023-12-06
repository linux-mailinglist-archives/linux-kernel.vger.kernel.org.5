Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406CC80655B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376296AbjLFDBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjLFDBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:01:42 -0500
Received: from mail-m17207.xmail.ntesmail.com (mail-m17207.xmail.ntesmail.com [45.195.17.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257821AA;
        Tue,  5 Dec 2023 19:01:45 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 703768000C3;
        Wed,  6 Dec 2023 11:01:11 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, amadeus@jmu.edu.cn, andersson@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
Date:   Wed,  6 Dec 2023 11:01:08 +0800
Message-Id: <20231206030108.183402-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <64ea0631-13d9-4661-bf83-05ef21a1611d@linaro.org>
References: <64ea0631-13d9-4661-bf83-05ef21a1611d@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEsdVkJOSxofSEMYSEIdS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c3d127fe7b03akuuu703768000c3
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6Axw4LDwrKAI3Cxc6PgMs
        VhUKFE9VSlVKTEtKQ0hKTUxJT0tPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUpCS0I3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Referencing XO in commit  msg is confusing. Anyway, answer to such error
> is not necessarily change the clock rate. What if it must be 20 MHz? You
> just ignore such requirement..

The downstream QSDK kernel [1] and GCC_USB1_MOCK_UTMI_CLK are both 24MHz.
Judging from these commit [1][2], I think they forgot to make changes here.

1. https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/commit/486c8485f59
2. https://github.com/torvalds/linux/commit/d1c10ab1494f09eb12fa6e58fc78bb28d44922ae

Thanks,
Chukun

-- 
2.25.1

