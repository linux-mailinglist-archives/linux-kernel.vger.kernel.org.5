Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF33579D62C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbjILQXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjILQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:23:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0792310D;
        Tue, 12 Sep 2023 09:23:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1d03e124so722697366b.2;
        Tue, 12 Sep 2023 09:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694535803; x=1695140603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XWvMWZ3PfPL63wEwHZjDGh9ALUEehxR7vNe39ic1Lp4=;
        b=mTAJYC2EkCktF4zTiAVFwbXlMCK8Wqmvh33J2hK1eblyM3eKt9u36SKJxOK42lpXjS
         XJ6qbkTTpgS/CMKlrjGQE02jy5ClVGKeEnZQACv62r4bPh5y+NB26fWbwAmYpL+exyq+
         vDlKyFIzqmj78H1tLoVYo/0jQUBVLMHStJmgnQNAXr2Rr/tCvcSi9+yOmH7cjvYx4N21
         LMYGTanzkj08LRe7fP7x4ZN2OCmYEjO7frtMl4CXTNxHBLjpnzx61ulGLvXgDrinSBr4
         1BD3Ge/lcIAWVHzlsBJB0k/hzgDM3c5lU/Rk3Dg2R2BEzuqTx6iTbY2KCJJ8YkOIKg8k
         6z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694535803; x=1695140603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWvMWZ3PfPL63wEwHZjDGh9ALUEehxR7vNe39ic1Lp4=;
        b=G+T94wI4sI7cABR8T9V5W/GtRPpITQPQNEZaFsSZ4Ihiv9c0sdW+HNIYUb9z8Cm1eQ
         U95zn8N5erBKiMBPUcG4poLRHYD1FQOejgp9d4fic/lcoYOgV+YZVH8J13z8aDqUe26d
         d7w7fq+o1qPeYEwxB2CYORLTT6eJ4OuhRqh1kfewmHbBwqbJ3T9bMm14docak3wKgg3i
         g0zoGBn8kwyww77jwd2ZZ1QgMSdteAq5eYKCrHhtH7/wY0sOTGAJpu5SVw/Ep1ahvbqI
         4tbZik/CBG2oPhq54NDyCqqN2ESctmY3PT1ZYIFDRnPS8dzmgZomkItflu5tvm2XMMUY
         58iw==
X-Gm-Message-State: AOJu0YzXOS9NT8KXICjFHsbJSHO3EjtWOAGO31PdjnlEhuzppnaHfKOb
        EHnDIltPwe0MAV8zAC24S/cEmlHy+w==
X-Google-Smtp-Source: AGHT+IGak6rYUKE4vzjvzo3nJZ/TMMEDCk8Vge6/xb70yEOlEamgl0yAG9yioVpJYJW0c9XWwDNIUQ==
X-Received: by 2002:a17:906:7687:b0:9a5:e441:4cf2 with SMTP id o7-20020a170906768700b009a5e4414cf2mr9904342ejm.58.1694535803184;
        Tue, 12 Sep 2023 09:23:23 -0700 (PDT)
Received: from p183 ([46.53.254.179])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906349500b00997e00e78e6sm7119522ejb.112.2023.09.12.09.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:23:22 -0700 (PDT)
Date:   Tue, 12 Sep 2023 19:23:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hardening@vger.kernel.org, David.Laight@aculab.com
Subject: [PATCH v3 2/2] uapi: fix header guard in include/uapi/linux/stddef.h
Message-ID: <b1f5081e-339d-421d-81b2-cbb94e1f6f5f@p183>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
 <202309080910.44BB7CEF@keescook>
 <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
 <97242381-f1ec-4a4a-9472-1a464f575657@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97242381-f1ec-4a4a-9472-1a464f575657@p183>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/uapi/linux/stddef.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -50,8 +50,9 @@
 		TYPE NAME[]; \
 	}
 #endif
-#endif
 
 #ifndef __counted_by
 #define __counted_by(m)
 #endif
+
+#endif
