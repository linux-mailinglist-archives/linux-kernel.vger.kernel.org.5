Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1465751445
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 01:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGLXOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGLXOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60949271E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC3561986
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2AFC433C7;
        Wed, 12 Jul 2023 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689203647;
        bh=bzq3WHttJpF9JCkXSgypfA3QQJIpnk7D8kHSnBUJiTM=;
        h=From:Subject:Date:To:Cc:From;
        b=us0TM9sBarySL3ac5QHBxWwqrTr/ngTa+CHitP6NTcP8KvreX2XhUASj3wi53DwnV
         wl4uNhb61sZdAlYKGqrj/akCfiwTB3NsySLRZC6cUQJ8PIZi862gGfoVpyeRrUxgDW
         a4rAxqW+fIsUeScbWXCZsYnnzpFMpnJnRHvQ7jh5h16fvjRJkY9tm9fRVIKqullrkW
         apx3xg3+KBwlqmtQsg5KngrgksjCOMVuJPqqfibn+aTfRZ6CsYq0JH7haSiRdDm9QX
         uzx+jyRsNI326XZhwSfhXLOLlUPo/SVPnAVeKzMCUNhKfG95LzPuGOJrBMjMsk4aw9
         l7KFzDnKA0y7A==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 00/10] ASoC: ad: Update Analog Devices drivers to maple
 tree register cache
Date:   Thu, 13 Jul 2023 00:13:49 +0100
Message-Id: <20230713-asoc-ad-maple-v1-0-7d2f35d42b5f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK0zr2QC/x3MQQqAIBBA0avIrBsYDbK6SrQQG2ugLBQikO6et
 HyL/wtkTsIZRlUg8S1ZzlihGwV+c3FllKUaDJmWLGl0+fToFjzctTNqS9T1PpBvB6jNlTjI8/+
 m+X0/6FRJcV8AAAA=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=broonie@kernel.org;
 h=from:subject:message-id; bh=bzq3WHttJpF9JCkXSgypfA3QQJIpnk7D8kHSnBUJiTM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkrzOz2ybmvPRTa27hpNOrapDCRUNq9HtPI6Tna
 EXPoPkpJDqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZK8zswAKCRAk1otyXVSH
 0DUNB/48ygscaJ3UWRpP4INkkCDV63FkejOEoIbWiWzyS7uQEul2Jjjj0MCvw/7kviyeoK3AOFc
 RamkNvYNAyJjdPHc31bbRJ+fso3tWsNTAZ0O3iosxNPrX+jBNWazo+7TJiD0eRdzdO9yo5ijV+o
 fzDbbiWJzNEwB2sOYz/NL81T1Wpv/KLrfK2LrtHTyRjaLIUDfKlpjPr0rX2F30h8gSEWSZug6ZF
 YbSIVYmKZp+D5fSM2ekssFs9hU9nNQSs4u1cMZScYRcns9caYh9zwkKSuaj22t6g2bHofDLv5lb
 NLqSDTUbmapavLUHU5ECvSGDRs+504ctZ/GX/EjvTXETZN95
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree register cache has now got to feature parity with the
rbtree cache, there are some different tradeoffs made and it should be a
better choice for most modern systems.  Convert the Analog Devices
drivers to use the more modern data structure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (10):
      ASoC: ad1836: Update to use maple tree register cache
      ASoC: ad1980: Update to use maple tree register cache
      ASoC: adau1372: Update to use maple tree register cache
      ASoC: adau1373: Update to use maple tree register cache
      ASoC: adau1701: Update to use maple tree register cache
      ASoC: adau1761: Update to use maple tree register cache
      ASoC: adau1781: Update to use maple tree register cache
      ASoC: adau1977: Update to use maple tree register cache
      ASoC: adau7118: Update to use maple tree register cache
      ASoC: adav80x: Update to use maple tree register cache

 sound/soc/codecs/ad1836.c       | 2 +-
 sound/soc/codecs/ad1980.c       | 2 +-
 sound/soc/codecs/adau1372.c     | 2 +-
 sound/soc/codecs/adau1373.c     | 2 +-
 sound/soc/codecs/adau1701.c     | 2 +-
 sound/soc/codecs/adau1761.c     | 2 +-
 sound/soc/codecs/adau1781.c     | 2 +-
 sound/soc/codecs/adau1977.c     | 2 +-
 sound/soc/codecs/adau7118-i2c.c | 2 +-
 sound/soc/codecs/adav80x.c      | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230701-asoc-ad-maple-170068cf0c39

Best regards,
-- 
Mark Brown <broonie@kernel.org>

