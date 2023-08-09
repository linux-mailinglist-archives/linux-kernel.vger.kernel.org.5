Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706E3776548
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjHIQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIQol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:44:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD06A1BD9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:44:40 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso11112392e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691599479; x=1692204279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dvZWMfKD3uROvQU/6PxiCYOjv+W/HoBcFXzvThGeONY=;
        b=ZXwmOb5gSrPO/xCKrYiNyB2W3zMPoCL76wKi844wN9ujue83DM2/0DnzNhTLeQFZd4
         MGGe22shwDSxWLPA+M4yni41epmMeHp0ELY2UPQk0K+nS2gQUGsCgrftb1e2Du7lf1I8
         wKnaY2o4dzzFZ4tIyVTfs9UMg70fhHIrZ0vEkeccYJiNPW7NEkUGjAlCY10/MH3puA/5
         mz2+QgQLunzA9BFzBSf+ZtjtWtAGqroR2ba2zm6rMjSf/i1/dO6QKUOpgTc6UVQWrUUq
         FGxwjzI9JDwQwhBYObBHzTDvZBWimQgeht7b6BAnErZaNKF0lblOuC/IgN2jNmuPlFeY
         Jsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599479; x=1692204279;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dvZWMfKD3uROvQU/6PxiCYOjv+W/HoBcFXzvThGeONY=;
        b=CYswsN8d6pCwGAInTCc6h/KIlSXeLPqcBXE4zb3VMQsfzG+Yb8M4aqPNJ+ekgIpKQd
         jBN6axzpazRRQDwuAOO0Xj9fCClkzwickJEitvxa58T7uEku2R1bZkOzgh8RUxLMHjyX
         PMJQQ2Y6T4nYlR65Uz33iVSUsxEAShwVZklxDKLvcsUIzlHQw10kqO8+yylBnKajt6R6
         7IxhysNMBLor43igOIe25auFxjpMlGxA/0uZ5SIHRsDKqt77sBrRrVt0BESTgV0Is9x9
         wLrYrJ87DmTZ8QMg/J55Z5K02JYQn9t0fXyZC/rKzWXiWv/yiEPLSU6uZnbesQWOP38r
         hr+A==
X-Gm-Message-State: AOJu0YxjG88urCWgeCwG9HkRdfesTua/KUhtLPldoLKiuqh+j8LQk9CI
        41Zqb4Y4zTgyoUye8D7Zo3/+Fig0sA==
X-Google-Smtp-Source: AGHT+IFeGv5FckWQCT5XNdLLFQlYD50SC3yx92yT5eVNQEmt6sUtBZS8no6LmV10GYAzhsQfto2oTg==
X-Received: by 2002:a05:6512:3d1d:b0:4f8:5e21:a3a9 with SMTP id d29-20020a0565123d1d00b004f85e21a3a9mr2840673lfv.45.1691599478362;
        Wed, 09 Aug 2023 09:44:38 -0700 (PDT)
Received: from p183 ([46.53.253.54])
        by smtp.gmail.com with ESMTPSA id h4-20020aa7c944000000b0052369aa9956sm878850edt.26.2023.08.09.09.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:44:38 -0700 (PDT)
Date:   Wed, 9 Aug 2023 19:44:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86: delete 2 unused forward declarations
Message-ID: <c2e7de3d-1b94-49cd-a199-8b98d76ac804@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe those were necessary at some point, but they aren't necessary
any longer.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/x86/events/core.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1995,9 +1995,6 @@ ssize_t x86_event_sysfs_show(char *page, u64 config, u64 event)
 	return ret;
 }
 
-static struct attribute_group x86_pmu_attr_group;
-static struct attribute_group x86_pmu_caps_group;
-
 static void x86_pmu_static_call_update(void)
 {
 	static_call_update(x86_pmu_handle_irq, x86_pmu.handle_irq);
