Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1527CE3EE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjJRRGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjJRRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:06:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD29113;
        Wed, 18 Oct 2023 10:06:14 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79fd60f40ebso175705639f.1;
        Wed, 18 Oct 2023 10:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697648773; x=1698253573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=IgdE6n+/3UVBCYY69nNGAeV+47UVRuVW8VDB3DzVcceYRePwyvQayI6i9dLm4RSps+
         3jSeVsRqv+U3YXjMEqECoEvyZZzCcLZPAJfmrUwoebExXtyEw5ilL8hU3eeZCR7dgkpc
         f9i3R6f348y1z9kqneuY46X66NfgbXvvZnbKOXFesAvMH2HZdl53sFfbDMF1XHYqRwSX
         8z4HG3dkSY3mkaHQL2r9twsKFlU+TAIBKtS4jMAlK3gA9tFj9pOqcGggjuYPw6Ox4vG0
         jVdNFFh0JZ/rRmtC+JAuw0IxBBVbIUc5fvAme/it+mxFC6icGI0U2PHOtoD1fWZR9MIT
         UBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697648773; x=1698253573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1C+2NMg1JH09l8lpRwB0Ubzh+mfktnl5vVkwETAlRt8=;
        b=UYV2IJkbkXkwMOjDQFKDfCXJ0mIZnD3Ll+vIV0Q+u/4SwN/wtJTIscU+AxmXdQh/RF
         sZ6ucb+YrLjpVj3K5120nUuRAo99mNfvYeRX4Ba3nuh/oV/MChZ82xgLk75jcuBlziC/
         J9YpMmtRMFpRLcVjX1RLnjf39Z9juxKfwr7m73QGn7WfnNdDQQUTOXXALQQ1ILHyADe9
         oyDq+sbQ3QmY/I+tfwjewhX0FtANImNDPCYY+nA3PbVFHQAJ7lRG3nwyajXVVM70+Jah
         cH40MK5U1hu3EjNGe+Z9GgtnSyDfw8WPs2USdMxCjGNniJVAK4P3VZxdmOKWzne5BtEX
         HcKw==
X-Gm-Message-State: AOJu0YyyycPbX5gFt7tO3XBZNr2xAefxZp5+yRGTV4CtnOHfXk8wMZDd
        BEbv5XaYYgZYjxVL7Zxg+JS1sf8NfFBgwg==
X-Google-Smtp-Source: AGHT+IHC4qfEU9tiSYAxK9P1UlIGyXdQhT0HhIP6RQL7IWtMjBWJEVhbKCGk1E5v8O6KifE2BTCJNw==
X-Received: by 2002:a5d:9da6:0:b0:787:8cf:fe82 with SMTP id ay38-20020a5d9da6000000b0078708cffe82mr5775684iob.8.1697648773211;
        Wed, 18 Oct 2023 10:06:13 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id n4-20020a5d8244000000b0079fa1a7cd36sm1228944ioo.30.2023.10.18.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 10:06:12 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     lb@semihalf.com, linux@rasmusvillemoes.dk, joe@perches.com,
        mcgrof@kernel.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com, groeck@google.com, yanivt@google.com,
        bleung@google.com, rostedt@goodmis.org, linux-doc@vger.kernel.org,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v7c 03/24] dyndbg: make ddebug_class_param union members same size
Date:   Wed, 18 Oct 2023 11:05:43 -0600
Message-ID: <20231018170604.569042-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018170604.569042-1-jim.cromie@gmail.com>
References: <20231018170604.569042-1-jim.cromie@gmail.com>
MIME-Version: 1.0
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

struct ddebug_class_param keeps a ref to the state-storage of the
param, make both flavors use the same unsigned long under-type.
ISTM this is simpler and safer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 2 +-
 lib/dynamic_debug.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..5231aaf361c4 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -124,7 +124,7 @@ struct _ddebug_info {
 struct ddebug_class_param {
 	union {
 		unsigned long *bits;
-		unsigned int *lvl;
+		unsigned long *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ceb3067a5c83..b984ce338921 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -796,7 +796,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	case DD_CLASS_TYPE_LEVEL_NAMES:
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%ld\n", *dcp->lvl);
 	default:
 		return -1;
 	}
-- 
2.41.0

