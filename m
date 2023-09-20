Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB3E7A89DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjITQ6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjITQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:58:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B039F;
        Wed, 20 Sep 2023 09:58:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D7EC433AB;
        Wed, 20 Sep 2023 16:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229106;
        bh=8pjONRCMisuRQhJ6dW460Z5GvXj5RYGrdBXEe70ROXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyPfLo6yrhwY1QqFdiJDyGHggil0a9vS46jG2tvyZup2wa7vMDQhnqvBKSi1MUiWR
         P9MfwQH3uf90jNYVxZZEMkvBLL5ngQdBKdqIEVjkIhnrsHiS/F8ORbF/zkyQhd+nKm
         7+qEZ5goaxE3kwMYJCmaLJleJjkgQzhjnz3gvywYKbXii/qj3D5HJf7+P8mJZhh0cj
         D8sWYwkpIJVYlqiGOaEB2yvYj8vVDO4rSyxFcT/M3Aq/XkN+gsecRteLACw6DdXitt
         IUkcn9eqjVdQlBDvfdRw5Xlq/YyQHbzwd58kPleFPKrsCvGNp/jD0gIn/nJYLh8W06
         1r+zTNOPHXV7Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org,
        Vignesh Viswanathan <quic_viswanat@quicinc.com>
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
Subject: Re: (subset) [PATCH v2 0/2] Fix tcsr_mutex register for IPQ6018
Date:   Wed, 20 Sep 2023 10:02:29 -0700
Message-ID: <169522934567.2501390.1112201061322984444.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
References: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 05 Sep 2023 15:25:33 +0530, Vignesh Viswanathan wrote:
> IPQ6018 has 32 tcsr_mutex hwlock registers of 0x1000 size each.
> The compatible string qcom,ipq6018-tcsr-mutex is mapped to
> of_msm8226_tcsr_mutex which has 32 locks configured with stride of 0x80
> and doesn't match the HW present in IPQ6018.
> 
> This series fixes the following:
>  1. Fix the tcsr_mutex register size to 0x20000 in IPQ6018 DTSI.
>  2. Remove IPQ6018 specific compatible in hwspinlock driver so that it
>     falls back to pick of_tcsr_mutex data.
> 
> [...]

Applied, thanks!

[2/2] hwspinlock: qcom: Remove IPQ6018 SOC specific compatible
      commit: 823313068617bf2414c6067504b4e2ce5768e601

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
