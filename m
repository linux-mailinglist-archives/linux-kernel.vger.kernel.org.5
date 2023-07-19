Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A561C759964
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGSPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjGSPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:20:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7619E;
        Wed, 19 Jul 2023 08:20:15 -0700 (PDT)
Received: from johnny.home (unknown [IPv6:2a01:e0a:212:79f0:c8e5:afad:333a:7f73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7543E6606FCE;
        Wed, 19 Jul 2023 16:20:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689780013;
        bh=z+ogJ9n6eVKxhL88T+iiOwnuLjSShxFXaTt/FLDI9c4=;
        h=From:To:Cc:Subject:Date:From;
        b=nnCxvicjSGFTOAsGooJ/PQCJffm48/T2BaYQvwsbCmgyN3D/3xtSiSbWYcDL7iE+1
         7xjTQJy3QCn5hVevO1dyDrsfjDdMTyhR8OlHCLLN2AwrlDLmFLYzj156fRP3R0zK/X
         R32b6YmQWDc4hT8BXlzel7zn/sAQZ5vVPNvhJfMURFRPrQCFLQeH7Qg9VSiN5PgS19
         c+XfIeK07xrREY8zb5LQcD/mY+DX5W3OCUccHx7ZtXQmU1BRigr0abOsHojY5R3xH0
         D3ck9dv1R3T4qkdk4zMJsd2Vwyc2Sg5SC3+ke8Qim6/87Ba6sfe2txew4cu734fdGi
         6ddFpNgdinwNQ==
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v5 0/2 RESEND] Add driver for Novatek NT35596S panel
Date:   Wed, 19 Jul 2023 17:20:05 +0200
Message-Id: <20230719152007.197710-1-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support for Novatek NT35596S based JDI FHD panels,
found in Xiaomi Mi Mix2S mobile phones.

Notes:
- I'm taking over this series as the original submitter is no longer
  able to work on/test those patches.
- Re-sending as I messed the1st attempt by not including the mailing
  lists; sorry to those impacted by the noise

Changes in v5:
- Move changelogs out of commit messages.
- Wrap comment/text lines around 80 chars.

Changes in v4:
- Correct numeric order of the items in binding.

Changes in v3:
- Embed the support into existing driver (panel-novatek-nt36672a), as
  these two IC are similar with different initialization commands.

Changes in v2:
- Correct items order in Makefile and improve failure handling.

Molly Sophia (2):
  dt-bindings: display: panel: Add Novatek NT35596S panel bindings
  drm: panel: Add novatek nt35596s panel driver

 .../display/panel/novatek,nt36672a.yaml       |  21 +-
 drivers/gpu/drm/panel/Kconfig                 |   7 +-
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 251 ++++++++++++++++--
 3 files changed, 251 insertions(+), 28 deletions(-)

-- 
2.40.1
