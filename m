Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D0078E55C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbjHaEOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239176AbjHaEOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:14:00 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253D595
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:13:58 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7926a450a0aso16559139f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693455237; x=1694060037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vaJsFxcc54aKDjeZFqWnxCfZZrtvtGhXsmAHrJGXgeE=;
        b=EudSmn7Bd9AiZewh+MbJBAM0DFP1s9EV/2JFBsnyWQq4gxnvbBD40TrAAuCGYRsYg9
         vc0neb3044Qm/nRPfeOLLqtxrANHxNZtsogT9goGqkFo8NbLZAd2r3SxApU2Ni5TDLx+
         AA2IxHm9PdNpNaG/jnA6WfG+7T9jJedkT1qYNT8Pt1c5WGKMofKuF9ogPkwgE2lJfwMX
         p/8RQGnh2oclX+IzfDXEZFJrQmKRos9zsETEkna/EHFbxC5OehEZzurH9pSc2aY1jFQP
         lqqh6q7JA0dMVYXfgyAsDHQkbQ4dMafgwbtzUadCAlsMV78kHpOMzZ6DfX19ZECQAPCj
         O+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693455237; x=1694060037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vaJsFxcc54aKDjeZFqWnxCfZZrtvtGhXsmAHrJGXgeE=;
        b=RI2nWLAXd+ctc+muuXqgLOtAjz17qIxaddVgdrqa/WaJ1950f46s/UpsNBRcpyXHWD
         261fjaGyKFa3M+qQ2ScsKFgCI66Pr2IaHab+HnlZdaNXXeOyeCY/inwpmHdW5RskXwr+
         v9FCIEHofNDpfJ1an6Y4QZ4g+90dRsPIfOfeaL8mGi4kYvXV69kMmNkjsjG+npCx7zl2
         ZtsiA2RE8zActTW0l71mmJVQiyWZf0Na9RR/vrnPwsthD7oyJRyclj32JPvx3FJd+eoW
         zq/uMIAGpatT262ufhhPiepbwb8FGH/JtHsn3GQDsMT87gRpRuUQS+enJEgG5Udy5RyV
         7hBw==
X-Gm-Message-State: AOJu0Yx3CfQENFsLGN9dc0z3qMKznqazS2hI55rXFT+YFP3WuMSs6+qD
        aCvywi7iXY4dfH4v71F8OlPgAmsYuVq+0w==
X-Google-Smtp-Source: AGHT+IHKD1SQoAob/NBLnSIfg33mE2VlPQUCwMmnVJY4dwq+izR7qaPh5vVv6hOFEAJ5YjYCsYgtAQ==
X-Received: by 2002:a05:6602:3b9a:b0:790:6629:b222 with SMTP id dm26-20020a0566023b9a00b007906629b222mr4850561iob.5.1693455237439;
        Wed, 30 Aug 2023 21:13:57 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
        by smtp.gmail.com with ESMTPSA id i19-20020a5e8513000000b007870289f4fdsm196479ioj.51.2023.08.30.21.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 21:13:56 -0700 (PDT)
From:   SSunk <ssunkkan@gmail.com>
To:     michael@walle.cc
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, pratyush@kernel.org, richard@nod.at,
        ssunkkan@gmail.com, tudor.ambarus@linaro.org, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
Date:   Thu, 31 Aug 2023 12:13:44 +0800
Message-Id: <20230831041344.4653-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1c04bbe2a65f13b9815ce465cc8dcdd5@walle.cc>
References: <1c04bbe2a65f13b9815ce465cc8dcdd5@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hi Michael,
>>> Since this is the first time I've submitted code to the Linux 
>>> community, please forgive me for some of the missteps that I've made.
>>> I uploaded the incorrect patch file.
>>> In a previous e-mail you said：
>>> XMC parts seem to have SFDP tables and they should work out of the box
>>> without any patches with the generic spi nor driver [1]. Therefore,
>>> you don't need any entry at all.
>>> 
>>> I think it is related to the PARSE_SFDP flag.
>>> The XMC flash part supports SFDP, so i don’t need to add 
>>> NO_SFDP_FLAGS() macro.
>>> drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
>>> 1 file changed, 13 insertions(+), 4 deletions(-)
>>> 
>>> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>>> index 051411e86339..e78bf11792d9 100644
>>> --- a/drivers/mtd/spi-nor/xmc.c
>>> +++ b/drivers/mtd/spi-nor/xmc.c
>>> @@ -11,11 +11,20 @@
>>> static const struct flash_info xmc_nor_parts[] = {
>>> 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>>> 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> -			      SPI_NOR_QUAD_READ) },
>>> +		PARSE_SFDP },
>>> 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>>> -		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>>> -			      SPI_NOR_QUAD_READ) },
>>> +		PARSE_SFDP },
>>> +	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
>>> +		PARSE_SFDP },
>>> +	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>>> +		PARSE_SFDP },
>>> +	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>>> +		PARSE_SFDP },
>>> +	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>>> +		PARSE_SFDP },
>>> +	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>>> +		PARSE_SFDP },
>>> +
>>> };
>>> 
>>> const struct spi_nor_manufacturer spi_nor_xmc = {
>>>> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
>>>> all the information of the flash_info table is pulled from the SFDP
>>>> tables, except for the part name. Therefore, you don't need any entry
>>>> at all. The flash should just work out of the box. Are you using the
>>>> latest kernel?
>>>> 
>>>> -michael
>> --
>> Hi Michael,
>> 
>> According to you, does this piece of my code still need to be modified?
>
>You don't need it at all. The flash will work as is - that is without 
>that
>piece of code.
>
>-michael
--
Hi michael,

If these entries are not added, the flash part name is unknown and our customers cannot see our flash part name on the kernel log.
So,I think it's necessary to add these entries.

Thanks
