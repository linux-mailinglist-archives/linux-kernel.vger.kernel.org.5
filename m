Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F375776799
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjHISqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjHISqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E910D4;
        Wed,  9 Aug 2023 11:46:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EA13611D5;
        Wed,  9 Aug 2023 18:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F390C433C7;
        Wed,  9 Aug 2023 18:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691606795;
        bh=Um8a+x8zH6+ISCWLsHPay+8YxzqXFDUhzAQSK7LjmM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8aF5whmRU21o9ivGxIz7/0T53ExzQ/qIT3hY8thUnGgBrHmUvfZmLVIqPCgr7W0h
         HRyC5B7H9tJn039Yeqo9H1L/xFsn1ZMkwcxcdjEDE7PSOB9tSehKbYEdRHQ2r+WRiK
         83ew3ZaEuYoaE5Dk3d+1eAF+mfdIQyd5pJibCW08u1pb9yMtOOljfzbXT//xGTUPdi
         B+SK6iKb0KaHcMCsSLB5FditWjuVnSDkqK9j4l3s5EslLtCTq/g1F+Z+BlOYhfq7OU
         dJ9uzWe0FEQuYISw+OMClAv+SYV2pgJfS0uqMKznN7lUlDMjxfE1Wubu3CZenR86+M
         wTFy6zwab40ug==
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        William Qiu <william.qiu@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v1 0/2] StarFive's MMC nodes support
Date:   Wed,  9 Aug 2023 19:46:25 +0100
Message-Id: <20230809-bogged-untamed-2c106d5ca10a@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230809013917.81674-1-william.qiu@starfivetech.com>
References: <20230809013917.81674-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=680; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=FQc3FS1DP6Zqa0ZQlMffIHgL7THZeM1l8qkWeMIVyr0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmX7/0X8ti0p+2w+AXXVs66hr3xPef+x5vsfabbk/+J6 cZVtpV+HaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZjI9YkMfzivRvH+tZh+P7Xq 9ducvmV1/9c6K6emvOH9unr70unRlbsYGZ4qel/lkfP5LxVSvO2yuViq6Rrxv9tfuPK5X2iYFPB 2OicA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Wed, 09 Aug 2023 09:39:15 +0800, William Qiu wrote:
> This patchset adds dts nodes for the StarFive designware mobile storage
> host controller driver. In device tree, we set mmc0 to eMMC, and set
> mmc1 to sd card.
> 
> William Qiu (2):
>   riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060
>   riscv: dts: starfive: Add mmc nodes on VisionFive 2 board
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060
      https://git.kernel.org/conor/c/7dafcfa79cc9
[2/2] riscv: dts: starfive: Add mmc nodes on VisionFive 2 board
      https://git.kernel.org/conor/c/b127dbf9e1eb

Thanks,
Conor.
