Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3CD7C6839
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378187AbjJLICi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343727AbjJLICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:02:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C630990
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F5C433C8;
        Thu, 12 Oct 2023 08:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697097752;
        bh=TU9F1gc/e0XOseODiaVPTLHxcbpq+z20xh3tqdq7DK4=;
        h=From:To:Cc:Subject:Date:From;
        b=JtPYDdCfs/GuiYbvGrbUfwg+i4X2w9+xe5yPPini5aLkDC7zUmoUAcflCbRaw06ew
         R/ZJSQDaRQpoCLssfgaW2lHF2h5BeJVOJHGl9ar5oYuCCNsj9cg4NUFUMY1/wllhxL
         gd1HZs+g5oJ2w3f4bNYjqKtzrlAVTiOK7H3qO9Uzbvg2dPDoNjL4T81VG7BR/44drE
         EG5XBMLWWUbcUlILCsnQoBIovlDfKqhnQaWP6H9HMnO5EDlpBpmWajXPIetLuZvytA
         fJPtCeH09x5tDuQxpCr+dZmAIjkkQPwf84hkahR86gPALwlomCTU15anIol/m4Nk2M
         1QaC9PujV9wrQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qqqeq-0001Co-2a;
        Thu, 12 Oct 2023 10:03:00 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: defconfig: enable drivers for the Lenovo ThinkPad X13s 
Date:   Thu, 12 Oct 2023 10:01:55 +0200
Message-ID: <20231012080157.4616-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

Enable some more drivers for Qualcomm sc8280xp based machines like the
Lenovo ThinkPad X13s so that sound and EFI variables work with the
defconfig.

Johan


Johan Hovold (2):
  arm64: defconfig: enable Qualcomm sc8280xp sound drivers
  arm64: defconfig: enable Qualcomm UEFI Secure App driver

 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.41.0

