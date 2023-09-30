Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3997B7B41A9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjI3Pcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbjI3Pcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:32:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE05B3;
        Sat, 30 Sep 2023 08:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696087943; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EzDfYjObrv7eAVvEWSe4cUxXc6HDtnAuIZMaNQunV5I3CQM3pWmEY4pVTUNCh6ah4z
    VnHsvv2Fmm0f6VloQR5H/+eGVHdyenMQ/KYmcPOYNlHLe/8zmrBcdkHdub556At+6Lnj
    A4wcTFRBqn/nLzWG3gYVChmP3Ao1i/1wILovxu9+1GPcW1a7O5j1nYUpxbO8qMjIdMpt
    GXRYE0SegWU9beIZ4uZ2i2/n1WFUgr/ySx9KxYnSj7uEl8bvgNdkGyoW+h2RtMWfx6iJ
    MxkJpZ5lllgQQgt/FO+mCxg2j24SEWG0zrUgw1Wv0CIvZY/RfGuxmV1TyfSZJTD9aCjQ
    Fp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6l4sSBuOid2O+DeyXWU0cuVZjm2bNtNdRN3QEMvBqhM=;
    b=X0WImQtqmnU72STgbrjlPbNbTi2UR0wB6C25g/buKSya5lTIZVk3wXFK2RD/a+DIwh
    rwsGFdpCNnZ1Z5tngu8Cw+hJT0F4crFUz92Lb6t0AfLvjbK4INO7WxwcWVRRM0cAa0L2
    TE20TBmJjidEohHzjbvlRZU8irXVmoAsfqCCCKuX6tTo+hVczzkBfK4vmbteTj5YhObk
    CSA9nIYjqwY2zjvhM6bAaFAPeTRsR6znyr4eAyjxO7azqCbkjDzZvt4ssFiR+F/wUjUg
    ZwCYYRv4Od7L8NN56TxLeIboq2Y4eZQCNdRa6i7w8wqhRBN6uEQ404Otqwfn25lyOJtB
    uo7w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6l4sSBuOid2O+DeyXWU0cuVZjm2bNtNdRN3QEMvBqhM=;
    b=heUIkhZYqBj8wkXrFgeO45pyLS8WdgGtnojm5W63ra4suhB1ePZz7We2raTfYKdTH5
    xQLeJLCzwasqlVADSiWO5QrdTSb3WHtgYcbjWLiquJ/YxGF8oUHOlnWdAQkGdS7RZv1I
    QbKvNJ9sWXVm7kkfz8kcDr0ekrtr0sAzMSpEP0J+FzQpIxbYWqlnrM31J4Aa+fx5WwKl
    dxNfILLlsjRyPXA14NpwMash3bvE65a6xvbnq3I7l+8W6WM00Uf8P4l6jOGN8oyxXjyi
    Y7hkNxETHT/ZpClvjbG3PBm/ulgSClimKMWWWbQ9HDBUYbxiIN7Up5E8ngtsZZiCdCxl
    4TqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696087943;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=6l4sSBuOid2O+DeyXWU0cuVZjm2bNtNdRN3QEMvBqhM=;
    b=Junswc9RKwhxxZkCb3CwCnvCgynS8442NrnLU60WSKkZyvrhZ9+Hx67PDDIVV5+gS+
    qCn1Gf2ZqmRMyzyFmzBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8UFWMtXQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Sep 2023 17:32:22 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 0/2] Input: add Himax HX852x(ES) touchscreen driver
Date:   Sat, 30 Sep 2023 17:31:59 +0200
Message-Id: <20230930-hx852x-v2-0-c5821947b225@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8/GGUC/zXMSw7CIBSF4a00dywGLvblyH2YDmy5FBIDBhqCa
 di7WOPwPzn5dogULEW4NjsESjZa72rgqYHFPNxKzKragBwlH0THTB5azExeRq6w76VEhHp+BdI
 2H9B9qm1s3Hx4H24S3/VHjEL+iSQYZ+MiaNa6lR3Nt5WC8U91drTBVEr5AJaYLMSeAAAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema and driver for the Himax HX852x(ES) touch panel 
controller, with support for multi-touch and capacitive touch keys.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- dt-bindings: Swap required:/additionalProperties: (Krzysztof)
- Use dev_err_ratelimited() for error in IRQ thread (Christophe)
- Use dev_err_probe() consistently (Christophe)
- Improve error handling of hx852x_power_off()/hx852x_stop() (Jeff)
- Add linux/of.h and linux/mod_devicetable.h include (Jeff)
- Fix %d -> %u in some format strings (Jeff)
- Fix other small comments from Jeff
- Link to v1: https://lore.kernel.org/r/20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net

---
Jonathan Albrieux (1):
      Input: add Himax HX852x(ES) touchscreen driver

Stephan Gerhold (1):
      dt-bindings: input: touchscreen: document Himax HX852x(ES)

 .../bindings/input/touchscreen/himax,hx852es.yaml  |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/himax_hx852x.c           | 499 +++++++++++++++++++++
 5 files changed, 598 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230816-hx852x-3490d2773322

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

