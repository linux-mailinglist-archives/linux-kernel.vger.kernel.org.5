Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD257DC3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjJaBks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJaBkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:40:46 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D492DC1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:40:43 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so4267330a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698716443; x=1699321243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64mrlYipVDfpqqW0TyXpVfizLVY1ZzmCuiacYi22cc0=;
        b=Z8NjJXC5dJGSFuwexAmfLBojsJrn6SaJX0Eow3g8X793msbB2YjaMgg6SvWPWtgzD9
         jfROhuvKVdEds+qC4sEmr20F6hX7cXCWTTMZieiqyeE4/O/HfT5Zxo2WD3V32hm5O4fu
         wnnyDEWRG/cX3dnWcI6dHZz1H0LoHUHR2ihON4/QYP3TOnOkDJcKtDP7OXeeYHXkys6O
         UKiqN7+w858kDRLYvkh9PbqDEHqI1kITnvnPmsjKUQMZzQ6KmuHoFPiG8TV1itEw+gnY
         hBjiuRsa4J8EIJceXuCTd7Arl+ADjvH42nIudqHu9q5dTMFLmnDeXNzyoZ1QNfqHK3wU
         cS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698716443; x=1699321243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64mrlYipVDfpqqW0TyXpVfizLVY1ZzmCuiacYi22cc0=;
        b=pTBAABKL4qHAXlJXbEfLwB9mnv9mLiTuW9BnEl0DUJll915y+fh7ij0HrZ659i3aFf
         0eAoYtxkBQ2urX5EBwQ8a+yXZzpPlv4mFPdTXbJ3UpEqnQxXTuvHo6mEASZO/DH6bJXG
         PuH2dCEcEE6zK4JpWCyOgs14eFEKxlqEajWwpF9YfwMnCwedG52cKLV5EryipVcqjS8G
         VdKLQu+EXPmPyLOFwJyiewae3FaV/BrIX8cKvArLInuTEg5lrmuTYtqWcA4UowBL6Wh4
         3onAksz5LI+TmtMRqIGFPDPJb8xx+VJQ4dUO7O6UKQqzuk0ZrbI/t9byeCtPgbIBMXhK
         eptA==
X-Gm-Message-State: AOJu0Yw7aVeXFmu3p7ru86+omxKZNqPDEMNNn0qTHCGdLojK6AX88TMM
        J9Uzg7aWS2l1mT9Hn15K0GY=
X-Google-Smtp-Source: AGHT+IEvrNYG6hQld7LubT7fDaaVwaIBlKrDHjEmZ9dZh9hJJLC8YSDSIOVCiXRT3PlPKnC0Mp4dmA==
X-Received: by 2002:a17:90b:354b:b0:280:5e66:a1e2 with SMTP id lt11-20020a17090b354b00b002805e66a1e2mr3802057pjb.22.1698716443244;
        Mon, 30 Oct 2023 18:40:43 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090a2dce00b00274b9dd8519sm102151pjm.35.2023.10.30.18.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 18:40:42 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 18568966763D; Tue, 31 Oct 2023 08:40:37 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dorine Tipo <dorine.a.tipo@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] .mailmap: Add address mapping for Tomeu Vizoso
Date:   Tue, 31 Oct 2023 08:40:00 +0700
Message-ID: <20231031014009.22765-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=bagasdotme@gmail.com; h=from:subject; bh=4b8AKL8yN3tWe791zi6Z17vJTtmzA/4rnTlJJvkf3YI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkOUc5vomUYV/sfnZGkbi/L+/LJtP8uTko9m137Fqe+X bDrnrhGRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACby9DDD/1rN37vWSghlXIwI q1p+JSfHxmNbXMa5Wrd9ZjOVPrQw2jH89/p3NXV3juXkc75NF7S2KBZdj3PgfTvbZOm6tLd6J4x msgMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

He's no longer working in Collabora (and his email address there
bounces). Map it to his personal address.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 I was triggered to do this mapping after I review Dorine's (checkpatch?)
 patch against DRM subsystem's CI [1]. I Cc'ed Tomeu (using Collabora
 address, as the file author) and relevant maintainers list from
 get_maintainer.pl. My review to him bounced (address not found).

 Tomeu, would you like to give an ACK?

 [1]: https://lore.kernel.org/outreachy/ZT5n-5hSfD0MqsnT@debian.me/

 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index b325732e31eb9f..27beb64673b8d2 100644
--- a/.mailmap
+++ b/.mailmap
@@ -567,6 +567,7 @@ Takashi YOSHII <takashi.yoshii.zj@renesas.com>
 Tamizh Chelvam Raja <quic_tamizhr@quicinc.com> <tamizhr@codeaurora.org>
 Taniya Das <quic_tdas@quicinc.com> <tdas@codeaurora.org>
 Tejun Heo <htejun@gmail.com>
+Tomeu Vizoso <tomeu@tomeuvizoso.net> <tomeu.vizoso@collabora.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Körper <socketcan@esd.eu> <thomas.koerper@esd.eu>
 Thomas Pedersen <twp@codeaurora.org>

base-commit: 407744af8384dc12b5813d8946855dc4789d78a3
-- 
An old man doll... just what I always wanted! - Clara

