Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305E7DE3A3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjKAPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjKAPRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:18 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DDA2;
        Wed,  1 Nov 2023 08:16:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D90C05C0260;
        Wed,  1 Nov 2023 11:16:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 11:16:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1698851804; x=
        1698938204; bh=rddZh9OfuBWNKiq+20BMvUIm9LU7zYcwtfDISZLYvWY=; b=Q
        q9jCOfz+AgT+pACC4sODldqk/AvvzufVOUZtg1GaPBG0FbWpKG45EXpm/p+ZU319
        z/9q2oYQvrWa19/dgYP501OT+ygaPBqeYTBOq+daI/3SlQe3gvhSkucI3CI2q5ZT
        z+boVVmMA5gs7KQCDh131tYWFXxmY0DRMMkCHoUsM1h59NFw8r8N8QyeEkQfk2ho
        4npqAWpryYgdYFlOULVUm+UxB4C0mfZneX8N1uD6vFxzqT3WiVpW4h03lA/79WUB
        H1UeY2Ms/EaQteT63LlCnHiKxz78e0oWlk+xD+ozMe01qVIlpP6tJOlzuI+1EQlT
        Vctkklk46wKw6XMaHp+dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1698851804; x=1698938204; bh=r
        ddZh9OfuBWNKiq+20BMvUIm9LU7zYcwtfDISZLYvWY=; b=tZYMkhI0FPG6OgmWq
        653YH6f53OJH5H3GzpKrhqIGw9wCv5YBP8OaFd1smtMLGgdz9sNLWw7M6OJ4jpx6
        BUswXWDcLSAgSkhzLs/dxNJgf+b0ccjuQkDcFbaB0lL19BlK0mb+9oG5ZK+Enp1g
        7YDLmM9t2zy0Sbe3BAFODwFy68gJqU2KmBWK8CM3DU73voZ1QyHhmXzZ7vNghxFl
        t1g8aM1KMyaROgbGgtqyiseNX1g4cBLNKGh9iFHVKFVooAqaYslL138LBRy7dtzv
        ddxxCjD9UFYi0BS+4xxnOUUEQsjdGaTO4WkknFU2nqbtahKa4RfaUMtSVhnZG6RJ
        yPauQ==
X-ME-Sender: <xms:22tCZQvDw7dPYLUtTxVNpGm_HeTaJpCp86PKd4hB8D_dQ6hrEKYO_Q>
    <xme:22tCZdcJsL9lMNXhSjmeEE7TJOkXwwGw1rfhVbDjAdXmaxNaBCWyZwkQrzw__LCvD
    PgU6Uo0_w6rVBPy9eo>
X-ME-Received: <xmr:22tCZbyyX0LLU6bXIYmi_vx-Oqk5der04xCIBWhodrfXMLgA0yJEIKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepudffffffhfeuheevhffgleevkeeugeetfeegieeijeehfeekheek
    veduveeigeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:22tCZTNuh0-wdlkofhLcohc9rUCUn7qRec3Fp24XOUWmxlWBt1M7xA>
    <xmx:22tCZQ-C85bwTg1UIj24pj3F0rVbAjiU3THO8zcPgJibmFzmFY5iSA>
    <xmx:22tCZbV2QnXgo64iD6YLb8Pq-4Guo09qsae-b6sH2fPcWh_C3vPdFw>
    <xmx:3GtCZUZlrIYHbN467g5xDt00C2fMbn6oC-B_qaNgG6Lt3HNurxJhGw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:16:43 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH fixes 0/3] MIPS: Loongson64: Fix some long-term issues
Date:   Wed, 01 Nov 2023 11:39:06 +0000
Message-Id: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANo4QmUC/yWLQQqAIBAAvxJ7TnC1OvSViNDaaiE0XIhA+ntSt
 xmGySCUmAT6KkOii4VjKIJ1BfPuwkaKl+JgtLGIGtURY9gkhq6ZVr5JlHarR99quyBB2c5EXyj
 XAD+Nz/MCYDCo+mkAAAA=
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes some long-term issues in kernel that preventing
some machine from work properly.

Hopefully that will rescue some system in wild :-)

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (3):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Enable DMA noncoherent support
      MIPS: Loongson64: Handle more memory types passed from firmware

 arch/mips/Kconfig                                  |  2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |  9 ++++-
 arch/mips/loongson64/env.c                         |  9 ++++-
 arch/mips/loongson64/init.c                        | 47 ++++++++++++++--------
 4 files changed, 48 insertions(+), 19 deletions(-)
---
base-commit: 9c2d379d63450ae464eeab45462e0cb573cd97d0
change-id: 20231101-loongson64_fixes-0afb1b503d1e

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

