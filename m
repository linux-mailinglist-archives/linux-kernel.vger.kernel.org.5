Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6C776CF42
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbjHBNyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjHBNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:54:50 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363C72101
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:54:48 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-63d0228d32bso37896426d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20221208.gappssmtp.com; s=20221208; t=1690984487; x=1691589287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=seaD21t4N5iLjVhay/ewPj/1qlbu80teMRMYHWk0A2M=;
        b=iKbRHinaPDB0apNvAl70ixEfMtKDToQw8TPAyW97i52CzP3tCs0GH/wpPed5jrnzP+
         +S8HfCST4xy+zVwtNtrSvQs0UbKoBrnHp9tunzqBB/IlpkVGZnUrmBXqXcKmSn28Fsbo
         MMoHptpE7DXVs9C4eX/23eu2nFnv+8riHQWYX7nZwaSEcmofWLVFm7fK9mnreQ6oidHV
         2SYG+EK3tXAPOQDK/lYZsAzAw99dEiEBft0MWzPhWLVin12hNCUxMJTmyLaNS3HHOtnG
         Ns4QdK/beR3hrY5EEjQZcRMQa4YM/SUj221L0qVBXghAdxx2u/5NoAPN7pCxIe0D9lEq
         TkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690984487; x=1691589287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seaD21t4N5iLjVhay/ewPj/1qlbu80teMRMYHWk0A2M=;
        b=l0ZIEm8PFW1+zBzk9/mghGYQmsarUwyEh8LBV/gxNkxaacHiNHmk5btkutTBTYK4Nr
         yUeFIUj3aJBIsdbiDZ77ZZEgsmXgC72DQSEqmomHP0T1vJy/tH6/hiaHz2ZLCnyitgea
         SwpJ6h3wBWKVWuLWVczZ0PW60LmnPSMCS4TFgBehxUx0oyOup+VNpw0OcUytEHxPBmPx
         ljakYKlju7a/F+sPyuUbOaRncOQKxipKbKHF3p1ZA/rXTathkdGJryH64pNhedGlb3R2
         hdyP35Wy+iP0ufGgHSrhr93TZwyU54RNT1WW5fkUbFFAoOo1IcVsi8hgr0vkXHXjCyJL
         ddcQ==
X-Gm-Message-State: ABy/qLYxZuJzPxNFn8FMcgXDh1nGv40xNxccc2CZ21JYVs6ASalGqiLs
        /IiZIw31dipW9QzYJmwdwKXDUg==
X-Google-Smtp-Source: APBJJlE3RA69LZI+j9QbZ+3RrJWtf+Jc3Y22/Prt/omYJDb+iTH4VFda19/iXaU12Moig6y+VlGZjw==
X-Received: by 2002:a05:6214:154e:b0:634:8a80:230a with SMTP id t14-20020a056214154e00b006348a80230amr14820651qvw.59.1690984487267;
        Wed, 02 Aug 2023 06:54:47 -0700 (PDT)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id o17-20020a0cf4d1000000b0063d0f1db105sm5609493qvm.32.2023.08.02.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:54:46 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Huang Yiwei <quic_hyiwei@quicinc.com>,
        linux-kernel@vger.kernel.org (open list:MAILBOX API)
Subject: [PATCH] mailbox: qcom-ipcc: fix incorrect num_chans counting
Date:   Wed,  2 Aug 2023 09:52:22 -0400
Message-Id: <20230802135222.30754-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Breaking out early when a match is found leads to an incorrect num_chans
value when more than one ipcc mailbox channel is used by the same device.

Fixes: e9d50e4b4d04 ("mailbox: qcom-ipcc: Dynamic alloc for channel arrangement")
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/mailbox/qcom-ipcc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 7e27acf6c0cc..f597a1bd5684 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -227,10 +227,8 @@ static int qcom_ipcc_setup_mbox(struct qcom_ipcc *ipcc,
 			ret = of_parse_phandle_with_args(client_dn, "mboxes",
 						"#mbox-cells", j, &curr_ph);
 			of_node_put(curr_ph.np);
-			if (!ret && curr_ph.np == controller_dn) {
+			if (!ret && curr_ph.np == controller_dn)
 				ipcc->num_chans++;
-				break;
-			}
 		}
 	}
 
-- 
2.26.1

