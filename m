Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D69808DED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjLGQbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjLGQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:31:39 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AE2132
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 08:31:45 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b2e330033fso834128b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 08:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701966704; x=1702571504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zn8K1lVkiTBHzzSJdwxeXndnaYotdMjB9/nFMDKUAWk=;
        b=AEsmDBADY1h1xi3KQIYZQ2HCVO2BBexEDw8A4IrGMz+f4d5EDmFEehtZjnWwQ6U2os
         XhIpLKZwTly7ANCI3HkGkl+Ms5u6FyVXZlEb+VdMqFlJu1sJu3Mfcnf+pK2nhbEd7F2J
         hzCavz5yUtjyYYJVzRpZrxwIn6Ydvss5xi+lKP3eIvhUnmZq3eY5nduPk02Z4KXvjxgH
         NqmrQCF2E3Dste6kt6siDfeYGUVXKD+xfiuU7UXhOas5sdrqlEYbxCyplhLBF2i4Yubg
         Za+PyvwI1YZ8ofBWELNUSpcatiB6lLKeKlhg/18vqyWkWsy4QckXitI/cbOf8oCPI+1F
         URDA==
X-Gm-Message-State: AOJu0YzxV/mqxhALzwWNeBIVrTXDXWXs1ze8HpldGl7jmgLZZeEeKeCs
        WKB+bMVbCc1Kw8prowp5lQ==
X-Google-Smtp-Source: AGHT+IHIAKwSb70DdtwDxG0Z68ujLcP6Lg29+Ex1HFOIAp/Si6ofrl7222kfr/Wfd+9ky8Lic9H74A==
X-Received: by 2002:a05:6808:1248:b0:3b2:db24:6384 with SMTP id o8-20020a056808124800b003b2db246384mr3740083oiv.38.1701966704654;
        Thu, 07 Dec 2023 08:31:44 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 7-20020aca1207000000b003b2ef9778absm8844ois.46.2023.12.07.08.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:31:43 -0800 (PST)
Received: (nullmailer pid 2710902 invoked by uid 1000);
        Thu, 07 Dec 2023 16:31:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Nikhil Agarwal <nikhil.agarwal@amd.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cdx: Explicitly include correct DT includes, again
Date:   Thu,  7 Dec 2023 10:31:27 -0600
Message-ID: <20231207163128.2707993-2-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231207163128.2707993-1-robh@kernel.org>
References: <20231207163128.2707993-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT of_device.h and of_platform.h date back to the separate
of_platform_bus_type before it was merged into the regular platform bus.
As part of that merge prepping Arm DT support 13 years ago, they
"temporarily" include each other. They also include platform_device.h
and of.h. As a result, there's a pretty much random mix of those include
files used throughout the tree. In order to detangle these headers and
replace the implicit includes with struct declarations, users need to
explicitly include the correct includes.

CDX was fixed once, but commit ("cdx: Remove cdx controller list from cdx
bus system") added another occurrence.

Fixes: 54b406e10f03 ("cdx: Remove cdx controller list from cdx bus system")
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cdx/cdx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 4461c6c9313f..d84d153078d7 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -57,7 +57,10 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/idr.h>
-- 
2.42.0

