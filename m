Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01119787A06
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243498AbjHXVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbjHXVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:12:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADE1BEC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:12:47 -0700 (PDT)
Received: from localhost (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26DD86607273;
        Thu, 24 Aug 2023 22:12:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692911565;
        bh=vsZjxZKBlZMhSRXOzu8mrKyj1JWGYCHbK5x56y67Cfs=;
        h=From:To:Cc:Subject:Date:From;
        b=L1LD/DDbOrhOTCIHAKxqBxFTDbW/OGSM0zjW6EDa8awd8bkd6e55N/MTzE3zdswne
         1X7aki+O65K8/+ncgFeuJQNcBPG5IJaISLcO321nUB/GoS3nxrrUdS7m4+htmMsM0N
         sCeEHuVDk/K56MaTi98WE/snahRPZgPQGYZxzUVAHQrkg4TrNvhcdpcqLBy6KZ5bF7
         On6eNcBcsR3OifvT4kL7WfFJFerMTkbe0r9+EQfrnTQWLZP5pzH/bcEPMiyT9K9lVa
         8OB5YycrKji92VRdJBlP7vCEKleAxVh7m/wraKTLRVvvh3Q+K7xfYphQ5IobfV51Ls
         bCiwyXmoitIWg==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/2] A couple of ASoC core fixes
Date:   Fri, 25 Aug 2023 00:12:39 +0300
Message-ID: <20230824211241.388201-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a split version of the initial patch [1], as requested by Mark.

[1] https://lore.kernel.org/all/20230824193837.369761-1-cristian.ciocaltea@collabora.com/

Cristian Ciocaltea (2):
  ASoC: core: Do not error if a DAI link component is not found
  ASoC: core: Rename component_not_find label

 sound/soc/soc-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.41.0

