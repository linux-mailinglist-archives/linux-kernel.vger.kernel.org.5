Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4087592F9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjGSK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGSK2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:28:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03539C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:27:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so11011842e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689762452; x=1692354452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n6s5SrkIW3zsO2FEvrxZq3cuVjdTqq4OShcwOMwX6KA=;
        b=S+QkuDPSFBv4z9MlEhu2i3AKz0dysahmqjHPIX/c5AYzo8wToHKKZ4SOdmclNmfJaK
         hsM3h3+0xkq2VVcW04rcwMlBWpOqRj6wz8CIV3UaNm1Cx9/no2RwN9tkU9PNzAJQHquw
         fQN/OS+btoEt7z2R/tBbj+KpPLIFyaWK5DbzDBvF9dKz9Ja6v20/IN0ZjU46TFhp2qIf
         cEOayoGNRkCDvXFTcOACdLZ76BzuX/uXeGBn4QV5ugBbYFGsQXLMJRn8JAfkTPjuAe2U
         GGHVR+6Beq/gBCruX9oPbR7UVIeG24x02AMHvnmrwyp3KqRm34wMjH2tQDD8tD6XzpZe
         PZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689762452; x=1692354452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6s5SrkIW3zsO2FEvrxZq3cuVjdTqq4OShcwOMwX6KA=;
        b=lBJxlPPN3gysYPFHu/pI+YQY2i1YQPl3Yof2jfwgZSX9xasMAm8eiLuybsM6h/0seJ
         0KlqBaPq00I9zEgtk+v3ddLjEyhoGl8fFtm6qCx2KQuZJ1AkCH0zPlb7UtNrlvIrf9bS
         33KATQ1ln2cvqSN4/bq+ib1LliIjZ7vAy9sdopLyY7+f6FVl3fGRWB0Apd3KKZuDOknZ
         XW4b+cQtprNqM8XBmKeggIfPWLdxRHfDWc6GwlJBqBcdvtrBXp0aQCBbYNbD9j+gvqDD
         sC7nTlqcBa1Uo/nh7r9jM+N67xiqEIcmdASFnChrSxaulUo20rwCVmrbkilfpd3DdcFV
         UUhg==
X-Gm-Message-State: ABy/qLYI2wHXDlajVMPwQu1FW2fZE5QkMu7IJdqT44Fdo1SX2l61f1i4
        b0oW8MzZsFu77w9M1UQ3Jbw=
X-Google-Smtp-Source: APBJJlHgdTKUFmqUc7TCXDuOECrlQyOEt3lkttQoW93OSH4c8h7aiql2N24BI5SlqdUz8kiTvsZjuw==
X-Received: by 2002:a05:6512:e84:b0:4f8:7055:6f7e with SMTP id bi4-20020a0565120e8400b004f870556f7emr2035616lfb.44.1689762452265;
        Wed, 19 Jul 2023 03:27:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:c844:242b:b300:215:5dff:fe9c:4c81])
        by smtp.gmail.com with ESMTPSA id b17-20020a05640202d100b005217412e18dsm2520457edx.48.2023.07.19.03.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 03:27:31 -0700 (PDT)
From:   Matus Gajdos <matuszpd@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Matus Gajdos <matuszpd@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/panel: ilitek-ili9881c: Add TDO TL050HDV35-H1311A LCD panel
Date:   Wed, 19 Jul 2023 12:26:13 +0200
Message-Id: <20230719102616.2259-1-matuszpd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch updates the DT documentation and the second is the
update of the ilitek ili9881c driver.

Matus Gajdos (2):
  dt-bindings: ili9881c: Add TDO TL050HDV35 LCD panel
  drm/panel: ilitek-ili9881c: Add TDO TL050HDV35 LCD panel

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 194 ++++++++++++++++++
 2 files changed, 195 insertions(+)

-- 
2.25.1

