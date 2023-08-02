Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074E976DBC9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjHBXqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjHBXqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:46:30 -0400
X-Greylist: delayed 12000 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 16:46:27 PDT
Received: from 15.mo584.mail-out.ovh.net (15.mo584.mail-out.ovh.net [91.121.62.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01951BF1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:46:27 -0700 (PDT)
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.138.21])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 95B9625D78
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 20:11:14 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-5nhfz (unknown [10.110.103.37])
        by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E69C61FDC4;
        Wed,  2 Aug 2023 20:11:12 +0000 (UTC)
Received: from etezian.org ([37.59.142.99])
        by ghost-submission-6684bf9d7b-5nhfz with ESMTPSA
        id FKtzJGC4ymSUiw0Acuci9A
        (envelope-from <andi@etezian.org>); Wed, 02 Aug 2023 20:11:12 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-99G0032f48329d-2e05-4aea-843c-dc19b2326188,
                    0C641BB37B7CC30D107EA61C426C60CA54BC1A77) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 178.238.172.51
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andi Shyti <andi.shyti@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: i2c: nxp,pca9541: convert to DT schema
Date:   Wed,  2 Aug 2023 22:10:33 +0200
Message-Id: <169100562788.1919254.3881890120063393214.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731163833.319258-1-krzysztof.kozlowski@linaro.org>
References: <20230731163833.319258-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13286181854062971501
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrkedtgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepveevieffieefgfefuddvteelffeuhfelffejteejuddvveekveehvdejgeefteevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpudejkedrvdefkedrudejvddrhedupdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, 31 Jul 2023 18:38:32 +0200, Krzysztof Kozlowski wrote:
> Convert the bindings for NXP PCA9541 I2C bus master selector to DT
> schema.
> 
> 

Applied to i2c/andi-for-next on

https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Please note that this patch may still undergo further evaluation
and the final decision will be made in collaboration with
Wolfram.

Thank you,
Andi

Patches applied
===============
[1/2] dt-bindings: i2c: nxp,pca9541: convert to DT schema
      commit: 696a995b8f8b2611a37a11cffeb67de6d8757b29
[2/2] dt-bindings: i2c: arb-gpio-challange: convert to DT schema
      commit: 54b4b9b74530eec66a6dd2cba33abf0e65a17cec
