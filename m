Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641227C6FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379089AbjJLOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378591AbjJLOCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 10:02:04 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545DC6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:02:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso1316107a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 07:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697119321; x=1697724121; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gsmhs5zysW4svCJevlwUFpRCfVEra9CoPzacdufXDbo=;
        b=M+Hw4Lsron44oU/vK88gCFLFpMVeUN8TAmSzrwLwI8qRDxQ/nK1rK/arV0FneEctGQ
         ZII3o4iLTo5jLevOgfEU8zodrRBEt0VVHjeo4IJuhl68FsSLseJ3SR/JupJEQpFL7Pc0
         ALdFtlIaKz5kxBT43wahLvLa3NdpPqyfhS85uoe4GYT8GvVZN2NKi8uNsbf/yS3zOrCh
         YJWVdmUB7x6N2TdHXgA6GniIf2ONoXMQ5TOFgtjJYM5gPKUcTH6V5A+AtchxE3S5AwFU
         5sIFja1EYHprMI5jWiS27NljorWnnS51PvbtX2NrtL5q9bQjpUT/lc6y63HvxJrKJAOC
         SEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697119321; x=1697724121;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gsmhs5zysW4svCJevlwUFpRCfVEra9CoPzacdufXDbo=;
        b=abaxfzfw5zg6ZTiD6Yy7xpWVMc6RUKZ8jOQw3ZKtG3Kcy5ZQZxXAmoYABiEqredBDR
         pthhxdgS83Z1cDoY5vzLIUTsd8MDSCiqieMdHvguLY45SwrtyXviYdpC9PFozWgz3EMc
         o+n6p9U++MLYIEqAFmiaE4D+5zjHq29tClaPz+ol4ZEliPH0peI5gQ27kumhrps4HWI8
         PagI3YbjOyzG3Zp8WrP68OdtN5dhNvIM/qyO3ShjHQ4puyxV3/fsQUvfgjYCXoyG5j99
         MiHnS9I2iFclWDRpIyWNgaVZ0UcMCeQirRb52t+vnzV+7BWsN5psmxyzciIXthz0Tm88
         jWtQ==
X-Gm-Message-State: AOJu0YyBVgJutncIkvBAplIYMDslun7qnt1XCIQqb70aaj2KHoNLgRHS
        owaX37HTUug3UrhXE6WqeMHKaVgvT91T5l/U
X-Google-Smtp-Source: AGHT+IHPpME55p+kfAxxc2RLQIrajNrNQMENzl2pmL/S1Jp3OZkX4/+u0kauk7Cqpe0RQ7QMyDhSKA==
X-Received: by 2002:a17:906:cb:b0:9ae:4eb7:ae8b with SMTP id 11-20020a17090600cb00b009ae4eb7ae8bmr24299904eji.7.1697119320347;
        Thu, 12 Oct 2023 07:02:00 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090637cc00b0099bc80d5575sm10980233ejc.200.2023.10.12.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 07:01:59 -0700 (PDT)
Date:   Thu, 12 Oct 2023 17:01:57 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Archana <craechal@gmail.com>, Dan Carpenter <error27@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging/wlan-ng: remove strcpy() use in favor of strscpy()
Message-ID: <ZSf8VcH8JQ+L+Z/r@lab-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In response to the suggestion by Dan Carpenter on the initial patch,
this patch provides a correct usage of the strscpy() in place of the
current strcpy() implementation.

strscpy() copies characters from the source buffer to the destination
buffer until one of the following conditions is met:
	- null-terminator ('\0') is encountered in the source string.
	- specified maximum length of the destination buffer is reached.
	- source buffer is exhausted.
Example:
	char dest[11];
	const char *PRISM2_USB_FWFILE = "prism2_ru.fw";
	strscpy(dest, PRISM2_USB_FWFILE, sizeof(dest));

	In this case, strscpy copies the first 10 characters of src into dest
	and add a null-terminator. dest will then contain "prism2_ru.f" with
	proper null-termination.

Since the specified length of the dest buffer is not derived from the
dest buffer itself and rather form plug length (s3plug[i].len),
replacing strcpy() with strscpy() is a better option because it will
ensures that the destination string is always properly terminated.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2fw.c b/drivers/staging/wlan-ng/prism2fw.c
index 5d03b2b9aab4..3ccd11041646 100644
--- a/drivers/staging/wlan-ng/prism2fw.c
+++ b/drivers/staging/wlan-ng/prism2fw.c
@@ -725,7 +725,7 @@ static int plugimage(struct imgchunk *fchunk, unsigned int nfchunks,
 
 		if (j == -1) {	/* plug the filename */
 			memset(dest, 0, s3plug[i].len);
-			strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - 1);
+			strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len);
 		} else {	/* plug a PDR */
 			memcpy(dest, &pda->rec[j]->data, s3plug[i].len);
 		}
-- 
2.34.1

