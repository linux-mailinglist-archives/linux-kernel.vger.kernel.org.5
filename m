Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEBD7DDA42
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377097AbjKAA1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376971AbjKAA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:27:09 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1744136;
        Tue, 31 Oct 2023 17:26:43 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7a956887c20so230583739f.1;
        Tue, 31 Oct 2023 17:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698798403; x=1699403203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XXimEcMUHLKcy89kdpmOcYiRa3Yj2O0YL1kh5UVcGE=;
        b=Pqxf9Y4/3csbx2uazrPvoo/Dw+Dz+Z9fZOvhqd+WQ7hh0DFm2cfJtO3vpW7JNedMU7
         AxaVPrhL+8Sklvfwkh6Rq+26tTjAamb79keN1i+PEyp4fNenH9tRVg777poEZHN1Jkk5
         IX17RhHSbJO4xphQjk5czMiJByqMOD/rbSo6Pi6Hv0091I7PT5E1WxZr27ki59OlQDTY
         E/mK2LkNBTowMHo8MZLiJi4AEVNYKYPr2Cg8jCLPF7fE/cF8Lf6Z+JaFF1FjQSpHdDLR
         GvFi+ELDuOQCoX1sBQXR8gnreYsIAwJ3b96H8ydyxEZ0fCyTIJhT3ZzvzpJR+lqYRw2D
         f9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698798403; x=1699403203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XXimEcMUHLKcy89kdpmOcYiRa3Yj2O0YL1kh5UVcGE=;
        b=YARja0KsvDIJW8vqEB7puc90yFfA3cbEpxsKKqHytBy0W282iOk/r+zZjGBqCBaMlU
         ZLZb7IeZ5IWrU4jeARzaCoud3tGNyzdbFNT6ukO5kXks6/4wLlATbiHvmldxA1l03K8/
         T7Eye8iARqcZD9Zr2Jlj8j/WaRmXJ9zXP4M7Xkj74x7RNChFqvX/cljQij/n9kknWz5p
         dfxsXqqUmjPxero930jJdSAe2LeXi9KPmCRZxAzlKnrIr3zSeeFLi4gs6XxWoJFnVfnU
         PgkASwDhTI3zV/rEjE/Uf9oVUajkuIy+sVCM64+VLFWNAXNPg+Ah0EVWTyD090vVWuEU
         ps0Q==
X-Gm-Message-State: AOJu0Yyya1a9+RxIPZwOXRTibEkZ37Y5O+wgYxw1jgs6P+j/OKjrSETS
        toe2goiqtDW25+31ufhTb6T/qqtcU7SFIw==
X-Google-Smtp-Source: AGHT+IEuxw5w71K77jdcQFb+x0zSRbj1XYX7dWzhjRL84L4L9BuVeF7Xwp09HkHULcT6OFMfMKAQzw==
X-Received: by 2002:a92:c24f:0:b0:350:f352:4853 with SMTP id k15-20020a92c24f000000b00350f3524853mr17133011ilo.25.1698798402979;
        Tue, 31 Oct 2023 17:26:42 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id t1-20020a92c901000000b00357cc8df1d5sm141701ilp.68.2023.10.31.17.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:26:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, linux-doc@vger.kernel.org,
        quic_saipraka@quicinc.com, will@kernel.org,
        catalin.marinas@arm.com, quic_psodagud@quicinc.com, maz@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, mingo@redhat.com,
        jim.cromie@gmail.com
Subject: [PATCH v7d 18/23] dyndbg: reserve flag bit _DPRINTK_FLAGS_PREFIX_CACHED
Date:   Tue, 31 Oct 2023 18:26:04 -0600
Message-ID: <20231101002609.3533731-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231101002609.3533731-1-jim.cromie@gmail.com>
References: <20231101002609.3533731-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve bit 7 to remember that a pr-debug callsite is/was:
- enabled, with +p
- wants a dynamic-prefix, with one+ of module:function:sourcfile
- was previously called
- was thus saved in the cache. NOT YET.

Its unclear whether any cache fetch would be faster than 2-3 field
fetches, but theres another factor; the 3 columns in the __dyndbg
section are highly redundant and compressible, but to get the
compression, we need field accessors, which will rebalance the
tradeoff.

So, for now, its just the bit reservation.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2a7832b1ba5b..4ffddf5e9152 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,6 +38,7 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_PREFIX_CACHED	(1<<7)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
-- 
2.41.0

