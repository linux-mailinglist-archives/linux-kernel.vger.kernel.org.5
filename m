Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3D4811A15
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbjLMQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378953AbjLMQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:51:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F38E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1c6dad2dd0so223974166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702486317; x=1703091117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eXXlT7BTSZdbME0dg+FI046fx4EL208vm6bp8OzrrlY=;
        b=hCeeZDLoNdsrCJlJ1KhLdTBsh1JRB5SWGxtnEhqIhVm32BxXu3VAum+PQiSR6tevk7
         a7nkU+xJETzbu5oP7MVXtA9FFML398l8NQ+PQ+qZ9PdBG0b5zDsIssMguM/EyGuy/SOG
         EiL0vQ66l/P5Pf9Tl2FFCUtASEVCdQR1KzwrGyaWIVnXgITQJeWEXyl+Vfffbu8/xkLg
         jCLDTNpvnEVCB5iYyyjfWoVPun5V2jX8jjPp0NEXAz2xkzCf+b9OqBSUqUZRgYqmyyCn
         Mrf9x4UMKAxzFa7xmZLfAekeWGoNhXVGEUfCPL9icZie7T+wvEjXyWAHbyBMDZb9qEeS
         Ff7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486317; x=1703091117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eXXlT7BTSZdbME0dg+FI046fx4EL208vm6bp8OzrrlY=;
        b=ivGJ3QfYgHvdMC2pB8+Z1q8i+XVIXJ7tMjaJoOJxLuaN7Hm5LqyPs3+aFdmcutNQr5
         u0AcHRQUGxvCVPrhqpDPIiY46zQfYVLu2VY7nuQFvrEm1zO9OpcLJalhYQy5eAhDNjzA
         t/+1n0nLwqTuFz9Bpx2el+WYLHjgFygWXkG/Y3+iudRauWF/5SKR3yF8u3ZC12wU/hLz
         HxiGUHF0GRuqvnRCVXQ0mNjXw1dztgSSPHvVnIlkS6URkJE5p5IakQSsZBW6LQF9Hiou
         oJQMGrvrsgfwYQy8YT2/7RlwxgbbD3QEL+vs2hheEzKrOZ039Ya3pBt8SFy9Wn/5p/os
         IsVQ==
X-Gm-Message-State: AOJu0YwtC8vTbT4FRHAw6TVARceQ/2E7mRnQ2Qtlu4EKCUbfapZfxEjU
        KMa9LNErdx4I0DAVWf1qHa2ckOpb3ZA=
X-Google-Smtp-Source: AGHT+IETY7P9GMKjZx9EPgWPbvimebCoDuiRMS5fO6AQLWeVnzPfKMDY1g6Uc1uE0otAlnpuyx6dCQ==
X-Received: by 2002:a17:907:a789:b0:9e6:c282:5bd5 with SMTP id vx9-20020a170907a78900b009e6c2825bd5mr8721352ejc.3.1702486317003;
        Wed, 13 Dec 2023 08:51:57 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm8044926ejc.3.2023.12.13.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:51:56 -0800 (PST)
Date:   Wed, 13 Dec 2023 17:51:54 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] staging: rtl8192e: Remove constant variable
 self_mimo_ps
Message-ID: <9e1bec657ddb22eec54e441a4341ddbe4ed7568e.1702406712.git.philipp.g.hortmann@gmail.com>
References: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1702406712.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant variable self_mimo_ps and replace it at the place of
usage with the value.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_HT.h     | 1 -
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HT.h b/drivers/staging/rtl8192e/rtl819x_HT.h
index ff0eb0d01022..eb2cfeab97d6 100644
--- a/drivers/staging/rtl8192e/rtl819x_HT.h
+++ b/drivers/staging/rtl8192e/rtl819x_HT.h
@@ -112,7 +112,6 @@ struct rt_hi_throughput {
 	u8 forced_mpdu_density;
 	u8 forced_short_gi;
 	u8 current_op_mode;
-	u8 self_mimo_ps;
 	u8 peer_mimo_ps;
 	enum ht_extchnl_offset CurSTAExtChnlOffset;
 	u8 cur_tx_bw40mhz;
diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index 379934a71f87..71d5b6f32869 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -77,9 +77,6 @@ void ht_update_default_setting(struct rtllib_device *ieee)
 	ht_info->ampdu_factor = 2;
 	ht_info->mpdu_density = 0;
 
-	ht_info->self_mimo_ps = 3;
-	if (ht_info->self_mimo_ps == 2)
-		ht_info->self_mimo_ps = 3;
 	ieee->tx_dis_rate_fallback = 0;
 	ieee->tx_use_drv_assinged_rate = 0;
 
@@ -266,7 +263,7 @@ void ht_construct_capability_element(struct rtllib_device *ieee, u8 *posHTCap,
 	else
 		pCapELE->ChlWidth = 1;
 
-	pCapELE->MimoPwrSave		= pHT->self_mimo_ps;
+	pCapELE->MimoPwrSave		= 3;
 	pCapELE->GreenField		= 0;
 	pCapELE->ShortGI20Mhz		= 1;
 	pCapELE->ShortGI40Mhz		= 1;
-- 
2.43.0

