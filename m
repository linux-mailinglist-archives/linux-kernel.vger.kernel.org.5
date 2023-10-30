Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E987DBBAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbjJ3OZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjJ3OZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:25:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C40EA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:25:23 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc5b705769so3562545ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698675923; x=1699280723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jt806A/h/pV/BeW2VlS6sXkVuDoNBG9hayDEQkcjUS0=;
        b=Avs7any7yT+pm+lEd1oj4bq7O5077TUClHoDCmnWXomAOUUlv4Ff+TzugB6SdsRygz
         LdmdyGjF9+HrCnAq4H46VrRYI/4fJ0Gb7ULBePyvgnMDn2ZKxbbVbqoo95kje1eRNxSi
         7rZPzQhgO2G5oxvWp1XhmOdYnQw/HhGzeR9XxBINQ3WFs6SH7F3HZHCcrF1lG+2VnPzq
         b5OAOaaYN2EradPnXjpUFbziDg8UqkFHsTJ7l+4XSU/dmiuR8pqlZRHuAXKrT1IAC4o6
         /U+KfyMJQPLgiQedCpKv7PE5FjUMIklRanTePees1KcvjFrI22am/Cv2ZezuvNCe/KeB
         jU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698675923; x=1699280723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt806A/h/pV/BeW2VlS6sXkVuDoNBG9hayDEQkcjUS0=;
        b=IpKRl6s6v46zeD/9sqrfKJmVaSFg6YztO+qVXx5KH8ooQY2G4Pa07M6z1FY3qCdfce
         mTxsTk2U1mVLWF8mSICDB/DEdw73K9hL8xXGEJbFCD/gtoM1LIHFSzgE0Lcdqj1cu3y/
         yZ/z9OezNrhureSH48/Hhp4YpwEi4dX4+BVl5bMHrsfMWJCik+lPOyr/eRGkJ8n3JEn9
         C618H6Uj8tT62fDLdWKU3fEmZyB81ZUui2Ib15ZOe7+TvtfDp2pk9NHAaH+S74gUI5vN
         SLDOLX0XpeNcus5gg5imprehNMO0fkFBZagk306GC6yC5grjgsRYWCq0mOL0/KWtlZgF
         JLgg==
X-Gm-Message-State: AOJu0YxGymeqlWfzH4bg47episSqVE0k/S1Be7oczcFNNDC4MpfABNjt
        5hjeuSriQB4LIzu65pgAHRM=
X-Google-Smtp-Source: AGHT+IEnkml8Z5aDEEbVyfZj4FDSxuxZv3DACJ8xxmvlmhfH76hSSligWZayzK2eR4kP0EmjfOiUzg==
X-Received: by 2002:a17:903:11cc:b0:1cc:5549:aab2 with SMTP id q12-20020a17090311cc00b001cc5549aab2mr1488041plh.36.1698675923205;
        Mon, 30 Oct 2023 07:25:23 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id ju19-20020a170903429300b001c74876f018sm6416695plb.18.2023.10.30.07.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:25:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 41D3B9423797; Mon, 30 Oct 2023 21:25:18 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Benjamin Poirier <benjamin.poirier@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] .mailmap: Map Benjamin Poirier's address
Date:   Mon, 30 Oct 2023 21:24:55 +0700
Message-ID: <20231030142454.22127-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1367; i=bagasdotme@gmail.com; h=from:subject; bh=Ug+okUH6LKu3Ij6zcCtCh1oENtsDNpOmFdKcC7oN4Wg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKn2e9YcPNor5K+m9ahc8W/d6atz7ghuOGUXtIst8OOBw 2fXaPI0dZSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiBVkM/12+nL6dm7X8nFb2 l8Rrrf4Nj//N6/xbWx7A6NH0XkFWazHDP4W9Ffrx52M1FWo392+zqDVVkzirxfC+1VaFYe+JhPJ vHAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map out to his gmail address as he had left SUSE some time ago.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 I first contacted him when reporting tx-nocache-copy regression [1],
 I emailed to his old SUSE address, but bounces. Now, he submitted
 qlqe removal [2] using his gmail address.

 Ben, can you give an ACK? I intend to route this patch through mm or
 driver-core tree.

 [1]: https://lore.kernel.org/lkml/2bf06faa-a0a7-4dee-90cd-a054b4e4c947@gmail.com/
 [2]: https://lore.kernel.org/lkml/20231020124457.312449-1-benjamin.poirier@gmail.com/

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 2643b7203a7452..34103d66c0372f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -95,6 +95,7 @@ Ben M Cahill <ben.m.cahill@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <ben@bwidawsk.net>
 Ben Widawsky <bwidawsk@kernel.org> <ben.widawsky@intel.com>
 Ben Widawsky <bwidawsk@kernel.org> <benjamin.widawsky@intel.com>
+Benjamin Poirier <benjamin.poirier@gmail.com> <bpoirier@suse.de>
 Bjorn Andersson <andersson@kernel.org> <bjorn@kryo.se>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@linaro.org>
 Bjorn Andersson <andersson@kernel.org> <bjorn.andersson@sonymobile.com>

base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
-- 
An old man doll... just what I always wanted! - Clara

