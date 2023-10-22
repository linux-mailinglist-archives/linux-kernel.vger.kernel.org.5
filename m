Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479437D2316
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 14:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjJVMWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVMWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 08:22:19 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F291DDD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:22:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5aa7fdd1420so1177045a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 05:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697977336; x=1698582136; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytqp4yNQw6UYpoau4Yu6tPgcTfKhaPGEv4GOXMbKcHo=;
        b=PZ5ipDXRUbYO4ZtqJeyUYwGEX+rM/vN6AZrUBnHAxkrpTzdWBpOeTbPMSn7u3Jq13M
         5ChhMgqgN+hIPGIPwvOsf4nq5OghKEErnanyJ+t4t0XcxOFhHxRqBKno+NxEtEJKd6XZ
         Vsdz7W9c6u+0D5LHOa89b70o+kErrMvg+i7rQWM/zSc5dwVWH+/NwPzvS5yoYf3+xb3e
         hL35jcIsLun5cGppYB3BIJtTkv31XbxheB7lPXtcTsxInPwPuP1u8DxQFaW7Z1KcofEk
         rN95WX/4mgHoecJZR8E358WsVAiyLA3X6Trk5uuDotO1gOXp9GGJ1twcZpVL2yzmKQn3
         4c/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697977336; x=1698582136;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytqp4yNQw6UYpoau4Yu6tPgcTfKhaPGEv4GOXMbKcHo=;
        b=JhWCVD+VVIPWzwAJ3DN5HPrqMIo67YAtthuiuQtGGFXHMitJWUE7KNFfK4oJDK1OlU
         0Gck53zyxCZW+VAbPJQeTQAqTvg1q7YAg1ksbn/AvWjAcKWCATQrm1iWRjFaYFZaF4xn
         IXfxcZvljzx+LAsroltynSj3j3vsng6pkmmzSQR7XwG9SDI4/71bpc8uE8aGoDMmgr9p
         pshM/Wt5Lg/ZvsnZZ1HMeN5ddyVGmgScoo89t6viv47Ux5vSEm6uIbn3oR0bVrNHyXvx
         ItKkRtlZmXAP3eqTqZCgHEyFfDTGOYg5FqOUQMojzRETYz9SVB26V+GkQACQJy9WH5YM
         JIcQ==
X-Gm-Message-State: AOJu0Yw9dNVUmr2BFrjITcQXFyGVAuJjOOaSkxMDxQy9lBnTM6uO2Fou
        T7mncfthLyB7dHL30d7bHe8=
X-Google-Smtp-Source: AGHT+IF1FBY7sLm9rNomTWAVxhv2/l5Ypb5rjdG1xEhEaWJX2DT9XfTahzDniulHJdMPesFNNO62Kg==
X-Received: by 2002:a17:902:c948:b0:1c9:e0f9:a676 with SMTP id i8-20020a170902c94800b001c9e0f9a676mr5156866pla.6.1697977336197;
        Sun, 22 Oct 2023 05:22:16 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id m15-20020a170902db0f00b001bbb8d5166bsm4341897plx.123.2023.10.22.05.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 05:22:15 -0700 (PDT)
Date:   Sun, 22 Oct 2023 05:22:11 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH v2 3/3] staging: greybus: bootrom: fixed prefer using ftrace
 warning
Message-ID: <39be7bb04ce1362b00aa31a638ebe2e88dd81fec.1697976302.git.nandhakumar.singaram@gmail.com>
References: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697976302.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Reported by checkpatch.pl:
WARNING: Unnecessary ftrace-like logging - prefer using ftrace

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/greybus/bootrom.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index a8efb86de140..79581457c4af 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -491,8 +491,6 @@ static void gb_bootrom_disconnect(struct gb_bundle *bundle)
 {
 	struct gb_bootrom *bootrom = greybus_get_drvdata(bundle);
 
-	dev_dbg(&bundle->dev, "%s\n", __func__);
-
 	gb_connection_disable(bootrom->connection);
 
 	/* Disable timeouts */
-- 
2.25.1

