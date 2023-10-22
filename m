Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966547D22B0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjJVKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJVKme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 06:42:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24BA7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:42:32 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-577fff1cae6so1541511a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697971352; x=1698576152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ytqp4yNQw6UYpoau4Yu6tPgcTfKhaPGEv4GOXMbKcHo=;
        b=EkQzAywl/EmFcwx+vVKyxBhMoqR9dzeS/f5MdhVqx4SVGYsoLQIIiQwk+jkiq5K6cs
         BfT3g+keDOyB+KaeWiP/0m4kVJ7aUt8dNDa9N/dnUnyGsjI8Gb7hsepszolKLxbmpttA
         g6CLDupvjQVMkHED0I9CkXHgMZOH2Hrp6sgsEl7uFoJBVlR+qUjS63huiIda505lfwx4
         3mY3EBBFWdhvrQX+KTBeA60AuPkE9nrYK/lHQBuQT2a/edIX8N6VY0SOkBtmUWhUVE0l
         YETBfsuizuK2HR9dVnPUUgMvwpV9ttEYU0Hltnr6eXnNw65fDtJJkDYOOsYj1qRJ4Wu5
         Hmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697971352; x=1698576152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytqp4yNQw6UYpoau4Yu6tPgcTfKhaPGEv4GOXMbKcHo=;
        b=NN/JHJcL8ZbQimanfeKLGast1HhC53ouudEaF/kVHoRrNxkFXnd8Bpq3eNc9ndj8FE
         symX7toSNfCWGVWd2EiYdxeGY1yxvPYaMQAm6kP40fdbrqU2KNj7lwFjGzt3U5zdG3+c
         cydE6A7oEk8xfNb+pq6IGKJZgRUXL79HkCPJE3r7W2OkDPDXIiMuhlS1vcuL7JEd79ah
         w+epClL+xvg27oHCynKECGPvS2gXGv4fg+0Fx0/JnaKri0iW0lJxJiADToNJ15xZZr9R
         zaWuspG7KpTanBops2i4sR83mj7jGTd9E3f6FHKGb+eiv2N8Ct15W7D76I+owfv7xlop
         7IzQ==
X-Gm-Message-State: AOJu0Yybry3ogFLHSJHzGCLWzHJ/0IU97oV5rksUIBfIO7PlHHEBZ0Oe
        9P2Vhypa63Olq28Everb7wE=
X-Google-Smtp-Source: AGHT+IHrw4gIaCM3FljDQJo9ciCCj4OiFXfzKFtUS0ANYKs8SoGdtBOJTU/EcVAiD+emNOG7IHMhMg==
X-Received: by 2002:a17:90a:ab82:b0:27d:886:e2d2 with SMTP id n2-20020a17090aab8200b0027d0886e2d2mr14005323pjq.7.1697971352250;
        Sun, 22 Oct 2023 03:42:32 -0700 (PDT)
Received: from ubuntu ([122.171.143.200])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001a80ad9c599sm4269872plt.294.2023.10.22.03.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 03:42:32 -0700 (PDT)
Date:   Sun, 22 Oct 2023 03:42:26 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 3/3] staging: greybus: fixed prefer using ftrace warning
Message-ID: <cade10d4b94127900a015e0b2ab94da5dd8c2c63.1697969950.git.nandhakumar.singaram@gmail.com>
References: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697969950.git.nandhakumar.singaram@gmail.com>
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

