Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68BF7BBF7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjJFTFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjJFTFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:05:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F099DF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:05:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9ae65c0e46fso98998366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696619109; x=1697223909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=frWFn5a7WskkCNBBns5qHFEWZyzl6mTq0HND4RnFXso=;
        b=mwVDpUvxDlAVx81FARIDNZ6YeAJXsET5mQygZV42hsVULI+tnRewgM8ndkhttzhhuR
         APSErj734lGk8yzUY3mVqSjI41/C/mk6ca5LQIgNUvVm2gVRgmJgDPp6DrRBMjcTtmpz
         w0e8+mxbsuOHqVF4r0UqHB9DiTKpjIIElzHj/0XKOBFQ9Mpnw0k6kS1tHxDRey4L/92X
         kyFueZ7F0iARtPj6+R2aQj41HTJVdqV5nZMLuJJAFAgcWLETKDRKxjwwKWYl0fC7diVk
         qhNfWCQQ3yKd5Yq77aQXjlDrZjY9DVQHBJgoSuN3iUALoavoQfTo8ftQX3uod/uRNmBV
         WWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696619109; x=1697223909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frWFn5a7WskkCNBBns5qHFEWZyzl6mTq0HND4RnFXso=;
        b=cpU6u6L5yjeeqYvqoEgUIDnir3+DLqm78S7REP6v/vVHqozFxz2QV7zY0Ze8E5opkR
         llsvXDp5FUwVN9dHxC2XqI44ulZ7P/oyvPRkX1aKIoo1bGqiDDobyRfo8NjI1/OkwEkf
         /dQnXvfrKTZqCMwOUFVwokrItcvMNsoPH09xnKPOKHFdXZlTyh0lMPEzDxPBmOWOcFGG
         I+lgO71dE7x7yr7Ighl6Y/JgTWozqgE4kmqr0r8aNFE1z+Y3hM8IGtRyDM4D1bkopzR4
         wsqJmUlx4z21zFjLTfm4UDP5jMM8KTuiuaYqsyPFwPmMAtWtuOkjGBHVzweu2zE8LseL
         QlVA==
X-Gm-Message-State: AOJu0Yy+hdtIA2z8FcKd0nf+pcWf5q5itI2p67IR9s111QSRz5JEGkg0
        XmlvN2HKY35bdJ+bqkPwFJY=
X-Google-Smtp-Source: AGHT+IElU1Lkaos/3KQRc7F70agUsD4OHvfRx5rL1+pRjH3SdB3TUUx/0dLm38nyPZ2EAbQLkb8how==
X-Received: by 2002:a17:906:2255:b0:9a1:be9b:c935 with SMTP id 21-20020a170906225500b009a1be9bc935mr7672676ejr.0.1696619109546;
        Fri, 06 Oct 2023 12:05:09 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170906ae4800b00992e14af9c3sm3326901ejb.143.2023.10.06.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 12:05:09 -0700 (PDT)
Date:   Fri, 6 Oct 2023 21:05:07 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] staging: rtl8192e: Remove constant variable ps_force
Message-ID: <ecebc90415c202e4e465bfb5b10c54be8b42e684.1696548527.git.philipp.g.hortmann@gmail.com>
References: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696548527.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove constant variable ps_force as its value is always 0. The equation
results accordingly. Remove dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c   | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 4b2ee1684dac..d4e998cfbefc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -263,7 +263,6 @@ struct r8192_priv {
 	short	promisc;
 
 	short	chan;
-	bool ps_force;
 
 	u32 irq_mask[2];
 
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index a4da11627199..44a9fe831849 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -181,8 +181,7 @@ static bool _rtl92e_ps_set_mode(struct net_device *dev, u8 rtPsMode)
 {
 	struct r8192_priv *priv = rtllib_priv(dev);
 
-	if (!priv->ps_force)
-		priv->rtllib->ps = rtPsMode;
+	priv->rtllib->ps = rtPsMode;
 	if (priv->rtllib->sta_sleep != LPS_IS_WAKE &&
 	    rtPsMode == RTLLIB_PS_DISABLED) {
 		unsigned long flags;
-- 
2.42.0

