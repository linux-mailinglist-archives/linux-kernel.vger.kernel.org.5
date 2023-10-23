Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BC97D2A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjJWGku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233578AbjJWGk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:29 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AEBD70
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:27 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9bf941607d4so87940466b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043225; x=1698648025; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O32Xy7uTc0KBQdpx2+7nBOVID0EODs+Xiq0NbRF0/Gw=;
        b=YUNWVEV9QdX5nC5A/iMatTWiMd8TRMrhsN3HElXYUNiD8/0JL7sGZ01VanzYuNWumu
         hQFruK6c3EzUDqojlFixURQE+V3YmyCXj7LqdCirf5OM2EgsP0AdV3AeGF6p+ld2B/w4
         wczq74GWnDiTvlXDgVwRAqZXw2CtamvE40LpocuD0z6mzuL3Jcvz48Vu61dRBS1NUEUb
         KyIOruA2Fz2ZLX25R67ceumKYfn0eEnwlmvuoOW7nMBeW1flWzjtuANqxQykYlOLmjsF
         F16u7Hc15gLrh/lSCXLkNTp8OpOfTYo/N1EQMH2OkGnt2WBGoQxoH8B9TqACueXyoilo
         IkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043225; x=1698648025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O32Xy7uTc0KBQdpx2+7nBOVID0EODs+Xiq0NbRF0/Gw=;
        b=knmPTA2IGySrczntaRkHAEb4SS0VfVlA9GjqYQoLLQwRTAjDRs7re+cjbRvMMvpYFb
         +u0ABIv42jUNgIrA+PzSw7ChmExc8yAyxd5h9sZE7uYcModItiusABepOPMUyb08T20/
         HBOg5uEvIeKHnA5tpqR99WToDX96GGVJW7Fx+WvcOf1XopkdXRNmem1XmSI936+JBWMC
         UnK8dNAYMMfgx+LvwtC+uLOob0Egmr0YsjgcqRRAC2ixtpg3vgOOk57rBA2PlClnkU17
         WivGBnehqeM08Yw5vWZ1mjpMDe1pNVLpB1nN9MIoFXoabwautxzYiSmrcJ7G+0vit9lI
         Vj7Q==
X-Gm-Message-State: AOJu0YwxXc3f5WKod+x2HLZ4nMHT3ybxMJPIW4xrbzvI2ynndPJCPzEj
        Ae6TuhP9kICprfdSesvvQ5M=
X-Google-Smtp-Source: AGHT+IFp6WEqRkJmwd+UcsT/0c445+Pv7mExviTP11F0KCVzyJ9Xpn7PTnhgb8r5XTSrcRUuPIlbqg==
X-Received: by 2002:a17:906:10cd:b0:9be:4cf4:d62e with SMTP id v13-20020a17090610cd00b009be4cf4d62emr6588314ejv.5.1698043225572;
        Sun, 22 Oct 2023 23:40:25 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090668c600b009c7608eb499sm6123817ejr.94.2023.10.22.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:25 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:23 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove unused struct acm
Message-ID: <5cc31651cbf63e11c4172b4e42274dd862a7c310.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused struct acm to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 64a1e6aa501b..9a9ef5fef6e0 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -30,12 +30,6 @@ enum direction_value {
 	DIR_BI_DIR		= 3,
 };
 
-struct acm {
-	u64		UsedTime;
-	u64		MediumTime;
-	u8		HwAcmCtl;
-};
-
 union qos_tclas {
 	struct _TYPE_GENERAL {
 		u8		Priority;
-- 
2.42.0

