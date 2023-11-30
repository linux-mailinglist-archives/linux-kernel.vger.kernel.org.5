Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDE77FF8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbjK3R4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjK3R4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:56:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BB5131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:56:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A64C433C7;
        Thu, 30 Nov 2023 17:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701366969;
        bh=/Osa1t+yhRR5faIxNKg3+KynX/kd+CAp3SC0ryOoBeI=;
        h=From:To:Cc:Subject:Date:From;
        b=pXkfIq+Yah19RVDik4OkwBI9j2fogy9aIFbj/1BcLEptPLL//HJ09Dw48VHR4jiwb
         OY2shn8wnfQNTdgz4l1oNygNiL/AOyKNhCf6+hTYmr0VZRr+brc+0dGQB4jCpCebKA
         L7jpTvKKOX/Ld3WuG9S4jQ86v7ISnkct0aH3PzjbWX/C+RjfIW0Yv51ObGWJqocN59
         kaRSdgjrPJml+wLIQtFho51K4fgjROVazvq/VZ+m5oG/oGJyzUoAyIA5TrKKxaLQSa
         H2g49mVdIw1Ob5iCXxr2W2CH1UcF0CuIq13Fquz9Bg00EqvZ16yS8luf42uLqVKEYp
         HAafQBKNrRZpg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r8lHG-0003i8-0E;
        Thu, 30 Nov 2023 18:56:42 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] arm64: dts: hisilicon: hikey970-pmic: clean up PMIC nodes
Date:   Thu, 30 Nov 2023 18:56:33 +0100
Message-ID: <20231130175635.14251-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the various SPMI PMIC bindings, I noticed that several
examples were incorrect and misleading and could also use some cleanup.

This series cleans up the hisilicon hikey970 PMIC dtsi which appears to
have been used as the basis for some of the examples.

Note that the binding documents "hisilicon,hi6421v600-spmi" while the
devicetree and driver only uses and recognises "hisilicon,hi6421-spmi".
I'll leave that as is for now...

Johan


Johan Hovold (2):
  arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
  arm64: dts: hisilicon: hikey970-pmic: clean up SPMI node

 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.41.0

