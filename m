Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D34578BDB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjH2E40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbjH2E4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:56:25 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A41F1A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:56:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34cacab5e33so13929705ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 21:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693284974; x=1693889774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56RQyKIWsd8kpcaxGIljWlOIf/R2gwH1nmqcYMjfge8=;
        b=jQKq+OLkMrlIpEcrq5CSyptHHLDPZMI4hUcG/7Jcxsb58he671zk0zvgSI52h/8E5P
         VRKEZBR9rwMum+R5P/OUwz0W85iCVWShOcHPN2pV8wnOAA1Vvil5LeDwlXmwreca55tb
         gqvyOSBdoCeFtLfDGV3j+ilKs4+sMz2EnIvK7gzft0txvPR3FVrJzi2fbrgBYTHyrmka
         9w2gYJidZcaj0T3LoD3oLtSIEtGkU9bWD4FoT1/2s32byzLlW2XXYI5yR0smkpBrSPon
         6at21CsQqoBg2wNVPJ1IXpFlYso/vh5GUPsbWJB1jeUC0Crk69p7jkivPELnx0d6IDz2
         R8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693284974; x=1693889774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56RQyKIWsd8kpcaxGIljWlOIf/R2gwH1nmqcYMjfge8=;
        b=KxJsP0eYTX2eiuqnDybTQp+Mh8+RmCg29/MSjzcQJNJq8DE4d0Ge5+lW7bVgjHj4hz
         3yl9Q5lGi1jTr7m/iHCzKy5yKLZ8EC+4X6MiOKeLq3BmD93hc/q9XLrML+QoQTj6bARr
         OTsj0hEt3MOeZZtj6yAI58U2379SVOMpM5gP7KSpv2YGyl/8EMOaaAV6W81rPD+ZdEAi
         z4bUX5wJfbkO0zZoewkG9rEyZnOrbyzmBKITZS7JKE/rUAzmqojxvcbg81X9saLOiDu8
         imSt5YylaDs1nFGqrRy+zDn/5zji6XMs58RgIaTnSYKAL4hVNe2oP+NVKv4eWwDdfowQ
         Yc6A==
X-Gm-Message-State: AOJu0YwDq7ia3I2c9mULv2BvRU18Q+DqOqlG5yHDoHgUqCZAYDHHyoN8
        d9qfRYjEdpyeJQK6bc7Jl9A=
X-Google-Smtp-Source: AGHT+IEHMR6LmyvlNvHDGgy5W+SLGvFUf0xRqottL/TYP7YVWzKH8m2bPsr9ZU1J0RlXulwI8aALaw==
X-Received: by 2002:a05:6e02:e08:b0:345:fbdc:bb78 with SMTP id a8-20020a056e020e0800b00345fbdcbb78mr16896466ilk.29.1693284973893;
        Mon, 28 Aug 2023 21:56:13 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id c1-20020a92cf41000000b0034ca3b29c5asm2868605ilr.57.2023.08.28.21.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 21:56:13 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     ssunkkan@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        michael@walle.cc, miquel.raynal@bootlin.com, pratyush@kernel.org,
        richard@nod.at, tudor.ambarus@linaro.org, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
Date:   Tue, 29 Aug 2023 12:56:00 +0800
Message-Id: <20230829045600.5254-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2F4A4D23-1C71-42B9-8B2C-06496F773BDA@gmail.com>
References: <2F4A4D23-1C71-42B9-8B2C-06496F773BDA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Michael,
>Since this is the first time I've submitted code to the Linux community, please forgive me for some of the missteps that I've made.
>I uploaded the incorrect patch file.
>In a previous e-mail you said：
>XMC parts seem to have SFDP tables and they should work out of the box
>without any patches with the generic spi nor driver [1]. Therefore,
>you don't need any entry at all.
>
>I think it is related to the PARSE_SFDP flag.
>The XMC flash part supports SFDP, so i don’t need to add NO_SFDP_FLAGS() macro.
> drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>index 051411e86339..e78bf11792d9 100644
>--- a/drivers/mtd/spi-nor/xmc.c
>+++ b/drivers/mtd/spi-nor/xmc.c
>@@ -11,11 +11,20 @@
> static const struct flash_info xmc_nor_parts[] = {
> 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
> 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>-			      SPI_NOR_QUAD_READ) },
>+		PARSE_SFDP },
> 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>-			      SPI_NOR_QUAD_READ) },
>+		PARSE_SFDP },
>+	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
>+		PARSE_SFDP },
>+	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>+		PARSE_SFDP },
>+	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>+		PARSE_SFDP },
>+	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>+		PARSE_SFDP },
>+	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>+		PARSE_SFDP },
>+
> };
> 
> const struct spi_nor_manufacturer spi_nor_xmc = {
>> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
>> all the information of the flash_info table is pulled from the SFDP
>> tables, except for the part name. Therefore, you don't need any entry
>> at all. The flash should just work out of the box. Are you using the
>> latest kernel?
>> 
>> -michael
--
Hi Michael,

According to you, does this piece of my code still need to be modified?

Thanks,
Ssunk
