Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F17788FE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjHKIat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 04:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjHKIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 04:30:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B3030D4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 01:30:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6887E64CD0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB13C433CB;
        Fri, 11 Aug 2023 08:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691742640;
        bh=WzHUQci+rQoiJPSDrUo6T2YYpQBEAZ0dj+iv5L8ZFrM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T5TrNvyjHioFdIVWAqyOG8mihL0eojJWIbTgiH4q+CPEsEPUXuSFcBz8pDfsTeHcn
         cmse2nekiC79wwC7GdOI3LRzgRsZr0QZRVoYDzj07fnl0UEShtKVBvzolKNEXx/GR0
         IaufDcpmE+7OAkmMtWg3VQFv+Zd9jcvSNVUMS/tYhMp2Lxm1Q5j2El740VijHa8NQv
         p6zWJO61thU96t6sBgNJMVnOE6xQ0nHkP19pvfhZ4HIsM1J5l54L4mGtUpdJFJz23E
         JdiwTYubfIh4gxF1zzmpy2faYPV4LY4tBK+GHYcD914S1KC1JcJtdfubADtBT7Ozss
         TPyzbV9xwrKGw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>
In-Reply-To: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
References: <20230810111958.205705-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/4] phy: broadcom: sata: fix
 Wvoid-pointer-to-enum-cast warning
Message-Id: <169174263955.106197.13353447930629943321.b4-ty@kernel.org>
Date:   Fri, 11 Aug 2023 09:30:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 10 Aug 2023 13:19:55 +0200, Krzysztof Kozlowski wrote:
> 'version' is an enum, thus cast of pointer on 64-bit compile test with
> W=1 causes:
> 
>   phy-brcm-sata.c:775:19: error: cast to smaller integer type 'enum brcm_sata_phy_version' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> 

Applied, thanks!

[1/4] phy: broadcom: sata: fix Wvoid-pointer-to-enum-cast warning
      commit: d35c12b7db15e2c1316c32bad24dea2255c5f7b3
[2/4] phy: broadcom: ns-usb3: fix Wvoid-pointer-to-enum-cast warning
      commit: bd6e74a2f0a0c76dda8e44d26f9b91a797586c3b
[3/4] phy: broadcom: sr-usb: fix Wvoid-pointer-to-enum-cast warning
      commit: 2bc00b9b9001329792b14ce20141f334b6debcbc
[4/4] phy: marvell pxa-usb: fix Wvoid-pointer-to-enum-cast warning
      commit: 7451eecf1ef8be9911749e927ce5690262cc9197

Best regards,
-- 
~Vinod


