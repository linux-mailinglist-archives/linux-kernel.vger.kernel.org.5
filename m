Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866187F095B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjKSWPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjKSWPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:15:30 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F13FD6C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:19 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9c6f0530929so95633566b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432117; x=1701036917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al0u3qH30iNBj9/dDiymgzw8t9TisYLxCGe0NNyn6Vo=;
        b=ZNYlXT1trT9YRdAIBHi9V5Khg9Zyfi2hIa4weHxqrkqYnOfGDVh/ffugs0jx9tddT9
         j/jrMTfp7ffLYddLhVNtXDCTEFy5u1q7tMHjfmHvSF0uB3W25Jjat8GnkhfZMc55Tl1z
         rwHkOZe2hmNiD6eHjr2YJdIjuGOP/bjcvtCq7ONF2RgWVnuCRWfc6/tA0G2xMq87vTlG
         DU8a4kbqU4qyj1G6PTwF2bqBuZ1UsFbbtmeKCxFpvth6Rt4maCyjG4XtM8uPUH/ikWke
         R8pXf7uVmMozBbKM94Zh36PTXpirMylJ7s58D/nVP5uI211Fpb9uKQKzFaAuhHu9B4Rr
         fgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432117; x=1701036917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al0u3qH30iNBj9/dDiymgzw8t9TisYLxCGe0NNyn6Vo=;
        b=Y5bYI3Tvuw13ckaQ4whVfkGVEk7oZaXLHME7OSv7xShNHx3HMisnLpUE4jKN/s1T4i
         Nzd3mNf9QCQagek0t1v36KIQTBk7e/LT4McRrm/c2E2iAwom0qp48NHlnOQc2qAbojp5
         nsmBhR8MYBRc15BuAlZn4hbARDOHehx05llxLvRB83cNP4EQQcs+TAsJz2Z/1jyn6fnb
         NDeaqcy17GNiXBJVof2Wf0oYvH1F4L6BBe9QY9v4YmANlTHmV8Vw3Knm084TF5wQNwn5
         uiAXIlBmXnDpwX+n5yUAMCy5dSe/1bo6OeD5xdKQQZYu3D+MyT1eaQCC5FJwshCbO+Lc
         nSjQ==
X-Gm-Message-State: AOJu0YwXYZZ6XdE+ddtx1n1FNcobssYeIGyTFzSedVwTypELGlfFtmW4
        oju6kh8iGpYm7ouoGQpUcH9+4KSK9q0=
X-Google-Smtp-Source: AGHT+IECoGGVX3bim/b5hFYAvQ09ui1RZfET09FjgkuCjdk2zBSClznANBlT5U+zi3Kxgo2OfC/hKQ==
X-Received: by 2002:a17:906:1da:b0:9c9:603c:407e with SMTP id 26-20020a17090601da00b009c9603c407emr4142314ejj.0.1700432117481;
        Sun, 19 Nov 2023 14:15:17 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id lh10-20020a170906f8ca00b009fd2028e62csm926964ejb.71.2023.11.19.14.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:15:17 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:15:15 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] staging: rtl8192e: Remove unused function
 copy_mac_addr()
Message-ID: <d157456121388489784ce34e5f3daf91126f80d7.1700431464.git.philipp.g.hortmann@gmail.com>
References: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1700431464.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function copy_mac_addr().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.h b/drivers/staging/rtl8192e/dot11d.h
index fd0a2df189bf..d3da4af4a16b 100644
--- a/drivers/staging/rtl8192e/dot11d.h
+++ b/drivers/staging/rtl8192e/dot11d.h
@@ -44,11 +44,6 @@ struct rt_dot11d_info {
 	enum dot11d_state state;
 };
 
-static inline void copy_mac_addr(unsigned char *des, unsigned char *src)
-{
-	memcpy(des, src, 6);
-}
-
 #define GET_DOT11D_INFO(__ieee_dev)			\
 	 ((struct rt_dot11d_info *)((__ieee_dev)->dot11d_info))
 
-- 
2.42.0

