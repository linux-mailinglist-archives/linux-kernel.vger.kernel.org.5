Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9F7B5993
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238432AbjJBRxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238607AbjJBRxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:53:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B8BE3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:53:42 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so4188163a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696269220; x=1696874020; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qji/asc5BFgCecowyKzRvOvxJoUOq3ag30EUXlyRUKs=;
        b=WB1A3lKHbsWAToLvQKhJtUowmzIqkCpmswIISA/5Akx/N7ZJF4WrrVLXXEFn+xpVof
         9uLg8GTZLj6lrwJjS/UXPZ4Luf93stZllt7amlPPoqvz7ih33dDkYexdHF81T19jz3Rv
         aAn3vW0e8PGVvTGn4GVL5qyL5/49CnxF6VphTWg1Q4LQzsRaK+ItsnP4pej6c67G8i6s
         xe2r5Ymq5zh52Em/8bXd94INMcJSkfGvAMW1KRxAwZpJ/ozAI4iORJ9rOZd44YtJyadF
         1iOAjBNP4djmsO+qGhqf089RRVP9bIqNyaSY5Q0VTaGnQ74MjUlubXiYSFK8c2mGs4fq
         ZOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696269220; x=1696874020;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qji/asc5BFgCecowyKzRvOvxJoUOq3ag30EUXlyRUKs=;
        b=OmAVaZb4IJhFFlakieb+axCuBmhRnPceWy5s2XW4BAyfMe0gFS7FUxQRrdUO1+u9Rn
         R5tvRlaNLEM4NkK5vow3UJWEY/9Ft2vbzW4l41Wr0A0HkhBc5uPCBMpgbAIu1TwKOi9r
         z2M/zHt23L9oJueKTQs6gueZE0YMZkfLDtRMhjWT/M+5QNA8swXu+d72kt8NwqujPhB6
         3qOEIZZEKn5mP4zg64bEexQ2RjP/orvPQk9YXrld1CilTiQ69L/NfFj2SSO8utj91TWZ
         rpx5WgPl62g3k7YoYVUu+Vmb3mgGKnSiPKBTMyedOb/2zkMVFMpO8CrITMuubdlUnKLN
         EVFQ==
X-Gm-Message-State: AOJu0Yy50LsBgk+XS7XH2ysRrcPOTlZm6N2X4N2VTdBW3JQyAVSldLau
        cQsaEHjCLqKcHyyCaEkVzvYqNYghhEQ=
X-Google-Smtp-Source: AGHT+IFByP88id4SK3YuKR3PUATH7q6MIR68JqtgsgQiF8X0mqXbh27Oq3G+tLIZ8mrYaBWZTQ8jmw==
X-Received: by 2002:a05:6402:2802:b0:523:37cf:6f37 with SMTP id h2-20020a056402280200b0052337cf6f37mr12123619ede.4.1696269220639;
        Mon, 02 Oct 2023 10:53:40 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id es9-20020a056402380900b00536275c28dbsm6886221edb.94.2023.10.02.10.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 10:53:40 -0700 (PDT)
Date:   Mon, 2 Oct 2023 19:53:38 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] staging: rtl8192e: Remove unused variable
 rfc_txpowertrackingindex
Message-ID: <20a1f7b8297e93e2f0e593f3ddd772ff10d1fecb.1696266965.git.philipp.g.hortmann@gmail.com>
References: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696266964.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rfc_txpowertrackingindex is initialized to 0 and unchanged. Remove dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c4688c273f4b..1f3a2bee247f 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -752,7 +752,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 	priv->bcck_in_ch14 = false;
 	priv->cck_present_attn = 0;
 	priv->rfa_txpowertrackingindex = 0;
-	priv->rfc_txpowertrackingindex = 0;
 	priv->cck_pwr_enl = 6;
 	memset(priv->rtllib->swcamtable, 0, sizeof(struct sw_cam_table) * 32);
 	priv->rx_ctr = 0;
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index deb707dfa443..922231274f4b 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -344,7 +344,6 @@ struct r8192_priv {
 	u8		rfa_txpowertrackingindex;
 	u8		rfa_txpowertrackingindex_real;
 	u8		rfa_txpowertracking_default;
-	u8		rfc_txpowertrackingindex;
 	bool		btxpower_tracking;
 	bool		bcck_in_ch14;
 
-- 
2.42.0

