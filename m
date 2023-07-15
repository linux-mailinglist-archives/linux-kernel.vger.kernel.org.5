Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB075484E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjGOKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjGOKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:49:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE33A86;
        Sat, 15 Jul 2023 03:49:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98377c5d53eso384360166b.0;
        Sat, 15 Jul 2023 03:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689418159; x=1692010159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Msya+OeUKFjaaFNFKi9RZdmhf47ggR6awj7JcHGF44=;
        b=TXA2VCYmB6a4U/vUInFYKG7TlY+AVtTjKuD+KP3zKcgdrzlp759XldO4vhbWti9UWi
         /HJ1vqHtUbBIlFykt1kpf28dAcwALFxLGZOXiac+pqbqwiE3LFLQ3x7sNkhdRgHdH7rO
         Cnm0BKEiiIGUcpq8CgQY6QK0xMpLKJ0U1KclbjIaNTTEb1XvEfrlndufTkVjcqVP8hHI
         CiyYJ0kaZK02txAhkc12Sg1Zd/YY1REu/h8NishYTKioEKGcXwl71mutDjusNGeN5BaQ
         I2OxLKolJyNR/wtx4W3jupK7TxyR+qB9vAQK9YnPXMiDWZYFpCJvyiCK1aPLkuSatrhm
         JHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689418159; x=1692010159;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Msya+OeUKFjaaFNFKi9RZdmhf47ggR6awj7JcHGF44=;
        b=KqncbE+f7rzN1xEkFkq0iCGMLzkWWc3YBEoHBmitG71WKapuUu673iPyHeHlCmASAY
         8tPWG4SLVXvm6GzbzNMx2rlmYJVUTNUhiLGNZTXEtjZBYRIcVRBWBQlFYPgErJtV9h3i
         m0MV5GEDBaCk+iMRhwyZ5YH/cAEdkXuoEzpVmRQ6wFZeiOjgF8ecv/BF7+ZlsiJ+Bkcg
         5TTzpavME2kWCFx7PoZbWNgd/AtVasVGja8y3eMsG9UUywd1gkatiA5phxEPD2aHWMOC
         C2VTv7kEzRudb2oImRdXFOS6XjZ0GnHGzTqL+lwlhtjqnDexbt34/554vClOVhSW9LPx
         CK+A==
X-Gm-Message-State: ABy/qLYAPKPE/nlx32RM9kuzVcMPnjTk3zKxUGTRx8L8XzSTd0r93CRB
        8EjIZzn6lQZpRPIzUPYHIGk=
X-Google-Smtp-Source: APBJJlE0jCxwHJaDfSipFXMCIjpsixSBRfEfBBeX6dxD3uNE4NTXk/pNOu6Sss9sA4LNV8RKWntj1w==
X-Received: by 2002:a17:907:2093:b0:991:b2a2:e424 with SMTP id pv19-20020a170907209300b00991b2a2e424mr6408079ejb.76.1689418159698;
        Sat, 15 Jul 2023 03:49:19 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a15-20020a17090680cf00b0099251a40184sm6685749ejx.99.2023.07.15.03.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jul 2023 03:49:19 -0700 (PDT)
Message-ID: <2b0dc481-562f-c8df-545e-dcf6548adb07@gmail.com>
Date:   Sat, 15 Jul 2023 12:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] mtd: rawnand: add nand-skip-bbtscan and
 nand-no-bbm-quirk DT options
To:     miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
Content-Language: en-US
In-Reply-To: <61c84262-cd98-1e60-d95b-9b0492083994@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NAND chip can contain a different data format then the MTD framework
expects in the erase blocks for the Bad Block Table(BBT).
Result is a failed probe, while nothing wrong with the hardware.
Some MTD flags need to be set to gain access again.

Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN option
so that the original content is unchanged during the driver probe.
The NAND_NO_BBM_QUIRK option allows us to erase bad blocks with
the nand_erase_nand() function and the flash_erase command.

Add nand-skip-bbtscan and nand-no-bbm-quirk Device Tree options,
so the user has the "freedom of choice" by neutral
access mode to read and write in whatever format is needed.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Previous discussion:
[PATCH v3 3/3] mtd: rawnand: rockchip-nand-controller: add skipbbt option
https://lore.kernel.org/linux-mtd/1618382560.2326931.1689261435022.JavaMail.zimbra@nod.at/
---
 drivers/mtd/nand/raw/nand_base.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index a6af521832aa..f0fa5c3519b1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5521,6 +5521,12 @@ static int rawnand_dt_init(struct nand_chip *chip)
 	if (of_property_read_bool(dn, "nand-is-boot-medium"))
 		chip->options |= NAND_IS_BOOT_MEDIUM;

+	if (of_property_read_bool(dn, "nand-no-bbm-quirk"))
+		chip->options |= NAND_NO_BBM_QUIRK;
+
+	if (of_property_read_bool(dn, "nand-skip-bbtscan"))
+		chip->options |= NAND_SKIP_BBTSCAN;
+
 	if (of_property_read_bool(dn, "nand-on-flash-bbt"))
 		chip->bbt_options |= NAND_BBT_USE_FLASH;

--
2.30.2

