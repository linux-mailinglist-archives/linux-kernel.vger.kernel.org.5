Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4352D7F51C6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjKVUez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:34:54 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC8199
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:34:42 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c8879a1570so2633591fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700685280; x=1701290080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aT8OFhVl8TBs1abByDkd5WUKDE2+T4rWWdG/lRLax1U=;
        b=AYmv0Zty5xBWCa777E4b/8i7r/vkmEci2HfAErqPmyv06Xycw+jKGTIJL/rghzHfp5
         8XezGMJNh46Ezp+lZyBaP5r6COKF2qkjrT33HFdGhvai+rxKoWVKrakNi7sk3WmlDVpz
         xpmAbGSbn1KmL8aq9IzdFnRs6eKO/OWFdsUhULdbNT2WHSbAz91WSGzvYnUZfXy8xtmq
         VnQMCWiDG8YUpkgtYkBmyURQwPWN6xxRDXl9FJ6rHRF3sKH3dEBE1qdA4as6apcFZgn5
         2j4AzLXJHiiHF2MP0rFRVxVX8OSi7EPoBMdg/Edp6FCGnc/wVEOXREVVCIYd13W39IhT
         faYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685280; x=1701290080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aT8OFhVl8TBs1abByDkd5WUKDE2+T4rWWdG/lRLax1U=;
        b=AkugdrAZFmT8NS4PQfqA3DczwsTdMI/0xSS2+wrTXtLAh16PQtcr/aZkCauJFaknTF
         5GNSjW4gFPiYKXGtUnXh14n1FomhDD5ulKwBAzPc7f61F4REuhR5XRUx2/yurgVzw7Sc
         /QHCfvkqc2SKBGia+82YVDTIHa7udENxj7h1naZCmkgjTMAUlk8PuIedcp0vufDZa2FC
         1KfYfKyHDwu/ckE6tIq6SZWIz/lbIo/DK0TuS90z9iTh2RJE2pb/iQP+54tMtoJ+PWDo
         WQ/gIa8vZ+uoR8ybBlyRb9EfvgoAdotZweXlNnrps10Dw/Sio6ajotRj3uPHXLHm+JWr
         ImTw==
X-Gm-Message-State: AOJu0Yw3ld/aFxujOyNzuqifo8pH4l187eBploW+FI1SlXl6eezuFoyp
        Zeiy4t1AVaRlx46Jsxn2Weg=
X-Google-Smtp-Source: AGHT+IHrD5wd/Ap01i51y/xgtpKzuV8wjlG/KxSC7uBROCzgFpU/bvDbAxjHpBuhx9ZgJAMoHZTTfg==
X-Received: by 2002:a2e:7214:0:b0:2c6:ef19:465c with SMTP id n20-20020a2e7214000000b002c6ef19465cmr2286494ljc.7.1700685280291;
        Wed, 22 Nov 2023 12:34:40 -0800 (PST)
Received: from localhost.localdomain (cpc69390-oxfd28-2-0-cust941.4-3.cable.virginm.net. [82.17.191.174])
        by smtp.gmail.com with ESMTPSA id m3-20020a05600c3b0300b00405959469afsm452556wms.3.2023.11.22.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 12:34:39 -0800 (PST)
From:   Emilio Perez <emiliopeju@gmail.com>
To:     minyard@acm.org
Cc:     Emilio Perez <emiliopeju@gmail.com>,
        openipmi-developer@lists.sourceforge.net (moderated list:IPMI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ipmi: Use regspacings passed as a module parameter
Date:   Wed, 22 Nov 2023 20:34:28 +0000
Message-ID: <20231122203433.443098-1-emiliopeju@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regspacings parameter is currently ignored and the platform data uses a
default value of 0, this has been fixed by setting the appropriate field
in the platform data.

Fixes: 3cd83bac481d ("ipmi: Consolidate the adding of platform devices")
Signed-off-by: Emilio Perez <emiliopeju@gmail.com>
---
 drivers/char/ipmi/ipmi_si_hardcode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_si_hardcode.c b/drivers/char/ipmi/ipmi_si_hardcode.c
index ed5e91b1e040..0c92fa3eee88 100644
--- a/drivers/char/ipmi/ipmi_si_hardcode.c
+++ b/drivers/char/ipmi/ipmi_si_hardcode.c
@@ -80,10 +80,10 @@ static void __init ipmi_hardcode_init_one(const char *si_type_str,
 	}
 
 	p.regsize = regsizes[i];
+	p.regspacing = regspacings[i];
 	p.slave_addr = slave_addrs[i];
 	p.addr_source = SI_HARDCODED;
 	p.regshift = regshifts[i];
-	p.regsize = regsizes[i];
 	p.addr = addr;
 	p.space = addr_space;
 
-- 
2.39.3

