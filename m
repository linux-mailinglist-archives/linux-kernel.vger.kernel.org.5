Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BFD8020C4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 05:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjLCEvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 23:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCEvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 23:51:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61DE114
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 20:51:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE563C433C9;
        Sun,  3 Dec 2023 04:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701579098;
        bh=PMGhfJKILDRGAquDVmC5ECWv+atrPXjObH+Arp7fiXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PmwWiRZf06siAYWOH7J/IWFLdXE5GLQpOuligc/9BJo83QdqQ+haOxC9f127YvjNG
         Jym4dGZ/000RjENSxEzvvxB3Y+Rueu4Tyr6/Nr3M9+rtGJoHsEriy6t/r95CX49b2i
         nM5ET0MpaiRJw+DLzEzU1N1lT/93y9OWnNBmXEhw68JsbbtjyNUbJ2BqhAYhSNhM4E
         dTGJFwI2CqQRgHFM4JsywfR9fI+Qfz8T6jurfrrJfYgphqGmPERmjwp6IelVOIKF8K
         DQRIwWEBcE+FXMMG8VX8YNCnJ8kddmr6l/TaYnUdB5CW0nfGjInZL0gy+DKR6S0vn3
         VznCPgpt1lH3g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avinash Philip <quic_avinashp@quicinc.com>,
        Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
Date:   Sat,  2 Dec 2023 20:54:29 -0800
Message-ID: <170157925799.1717511.7839634771829753246.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012160509.184891-1-abel.vesa@linaro.org>
References: <20231012160509.184891-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Oct 2023 19:05:09 +0300, Abel Vesa wrote:
> According to documentation, it has increments of 4, not 8.
> 
> 

Applied, thanks!

[1/1] soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
      commit: 03970d2fa35497d5a5812d67ce94ca5836335159

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
