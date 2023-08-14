Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC53777C12A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHNUAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjHNUAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:00:21 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D814B10C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:00:20 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56ccdb2c7bbso3301848eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043220; x=1692648020;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLQ0206Zcpd3i8+yXJ7CFiqIkxqP939o39iR3izE8t8=;
        b=RN6gKeP4w0087rNnMmVXoFM/DcIMZ/YmnKoXkr5SJzfx1iO8cyco+ZvTGjP5PepIvl
         NFXvArAkgErGReP7S709cnpJnbjN1LCrnj418QbDowzRZXihJGTIywKqUEEuLUJkbAHB
         JxGP0RNZYILzDXKIHx6DAaGKJ7xu1zOAwZP/70PV+AoSBiiTzvW8oDMc3Oeeipvs3ue/
         2rOmUeY4BIWB0qk/lafxbeh90LWhsKOrhbthbNkkNbtWxZxKI2eapY8l5KqM1LQc294f
         ASD67WhSSFXPWZNAgoVMImYvFEJq1XK8idKtyHJJ14gQr7Wn3L07eyhbbIOdoWZh59zq
         aZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043220; x=1692648020;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLQ0206Zcpd3i8+yXJ7CFiqIkxqP939o39iR3izE8t8=;
        b=AdRdmy1dWGeWzxcGCBU6pe/ckUnPNePGgCdqmpwOETgVvhCTHTPhiav/gnkBJtM6zV
         GhWuMugKVm+OepHHh1BtqqxINLJ9DAMOdP93fIJ0Y4UfxW0jtRJEYxSPTIlO+nruayuZ
         Nx5+EPQdNSSiFx8PIQCjmMHzGhmSnVOznkFlB7olZO0yTAFyl+SbEZ8NEUB1PNhkx5wK
         cIz3s+91lbCDXHiLI+UFMtQzNWkr3xaFHZATDAtyH7rMXnNiTAMsI5FbYhRpx6A0oMLC
         pKxB2Hn+ixlh4pA31H5HDsEVCtEBt+Aac+2ItNHIfR3Wp4YGoYekxU8upJpryKsuXtW3
         EWNQ==
X-Gm-Message-State: AOJu0YyKjOwbz4zK5s8c5VmNAjUwVsk7Ncbwwc3dxzQLGYpLTLwBFVG4
        uVph/UkQXLCUGvQh0E4RuqWvSg==
X-Google-Smtp-Source: AGHT+IEOQJ+jfWN4KtURoiQYtB2tss2wLUdB8eRtQxajAzs5pelAep0/lPLMEJvwccdyM+zv8eNYEA==
X-Received: by 2002:a05:6870:64ac:b0:1b7:2d92:58d6 with SMTP id cz44-20020a05687064ac00b001b72d9258d6mr11323701oab.32.1692043220095;
        Mon, 14 Aug 2023 13:00:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s10-20020a81770a000000b005845e6f9b50sm2965735ywc.113.2023.08.14.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:00:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 13:00:18 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] mm,thp: no space after colon in Mem-Info fields
In-Reply-To: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
Message-ID: <c1edd7da-5493-c542-6feb-92452b4dab3b@google.com>
References: <dc264fd6-40bb-6510-db36-9340a5f01d94@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SysRq-m or OOM Mem-Info dmesg showed (long lines containing)
... shmem:NkB shmem_thp: NkB shmem_pmdmapped: NkB anon_thp: NkB ...

Delete the space after the colon after shmem_thp, shmem_pmdmapped,
anon_thp: as the shmem example shows, no other fields have a space
after the colon in this output.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/show_mem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 09c7d036d49e..4b888b18bdde 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -251,9 +251,9 @@ static void show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_z
 			" writeback:%lukB"
 			" shmem:%lukB"
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-			" shmem_thp: %lukB"
-			" shmem_pmdmapped: %lukB"
-			" anon_thp: %lukB"
+			" shmem_thp:%lukB"
+			" shmem_pmdmapped:%lukB"
+			" anon_thp:%lukB"
 #endif
 			" writeback_tmp:%lukB"
 			" kernel_stack:%lukB"
-- 
2.35.3

