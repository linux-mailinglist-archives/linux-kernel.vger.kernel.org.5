Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD887F0962
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 23:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjKSWQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 17:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbjKSWQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 17:16:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7305D5E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:16:08 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e2308198dso917575a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 14:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700432167; x=1701036967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HmufOMefniw7+AgeLkrs+Ikau0t9ZA3t0+CpI9Zt9o=;
        b=OSawzK9MM0yHXLGHizrS/yiHP7qhrNnyEZU29pFkC0oP/kYvAwIUKb55VWef1VJ0yi
         fGcEqId6Hz0t88JnV4tMcRqFzINwZiXCOYDxzPkIAvdkbRF2lyk3Ft7ABuVB9CQuf2SD
         0XA0sz4yDrC/yxitH+U0H5e0RxPpuVsbEnZN+gIuMOth2//pJkHo1esF5zYJ9vQM4e5u
         ufLMZLojR88+pCg2IGTabAiY6eqdXFt9WWqUQ8d//C/Ode1yuVnQfisI+uUYXBnN8sOY
         vEMgnCLOh4mLPzDdPjT6J2Oax2HTdGTw21uDbjN8rjDyYNxxcFE4qDNi6xOP1OxRPnkb
         YZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700432167; x=1701036967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HmufOMefniw7+AgeLkrs+Ikau0t9ZA3t0+CpI9Zt9o=;
        b=oplgF9xxHN3r7ZzGAE8ZOxr0bDYzY5xOZhKCRxSP/kj+5EMJd/c+WpyHw1DQB6NcX+
         avWOLmr8SJNqbkgW9GyB4QbO3RA8649qpZYq/nCr4+sdJ+AAdfOoYhgW5tlpO/pe3La7
         Ij3ho3mph63tfltMx4Zknej5OrZIiqZ+a8iYl0rLNxKTviJQVbBLOcqyfXlt3jV0aFgc
         X/uzG6wM39qj8sR6dAGX6qOM+K82UB1MD+XOmmmosqv2LfYjqmHy5PwGPB9Xg+bbdjlD
         oOFGrI58uC3qpYrAr8A3alOsNYI4cwH3bWkMcIM38pSfsGMsZ7NUoLMXvNZXHE/nqwjs
         j97w==
X-Gm-Message-State: AOJu0Yzikb+NUMMfULqC0IgSswJHfuN78LeYc54LGcrb9LP58Rw5i3xb
        Nb0dZB/5aUjQ+4yhW8irObw=
X-Google-Smtp-Source: AGHT+IHjAlXs0jAQBfqT+IGd9CwZfA7CKwOfC9O51NUT5aj1JIAg3IYCZ/EbBCQNSn75DkyUE9zJMw==
X-Received: by 2002:a17:906:5191:b0:9e6:69d:46aa with SMTP id y17-20020a170906519100b009e6069d46aamr4332511ejk.6.1700432167102;
        Sun, 19 Nov 2023 14:16:07 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b0099ce188be7fsm3215485ejf.3.2023.11.19.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 14:16:06 -0800 (PST)
Date:   Sun, 19 Nov 2023 23:16:05 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] staging: rtl8192e: Remove unused variable
 bss_start_channel
Message-ID: <a13a8421d43ef1baa2077af1d4955059eba52d79.1700431464.git.philipp.g.hortmann@gmail.com>
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

Remove unused variable bss_start_channel.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/dot11d.c | 1 -
 drivers/staging/rtl8192e/rtllib.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/dot11d.c b/drivers/staging/rtl8192e/dot11d.c
index 9ec112e00e38..d51d4afff61e 100644
--- a/drivers/staging/rtl8192e/dot11d.c
+++ b/drivers/staging/rtl8192e/dot11d.c
@@ -25,6 +25,5 @@ void dot11d_channel_map(struct rtllib_device *ieee)
 
 	for (i = 12; i <= 13; i++)
 		GET_DOT11D_INFO(ieee)->channel_map[i] = 2;
-	ieee->bss_start_channel = 10;
 }
 EXPORT_SYMBOL(dot11d_channel_map);
diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 820951602fb0..77ae259eab35 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1324,8 +1324,6 @@ struct rtllib_device {
 	void *dot11d_info;
 	u8 active_channel_map[MAX_CHANNEL_NUMBER+1];
 
-	u8   bss_start_channel;
-
 	int rate;       /* current rate */
 	int basic_rate;
 
-- 
2.42.0

