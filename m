Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518F78096FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444151AbjLHAPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHAPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:15:20 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1285171D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:15:26 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35d3b220b64so5571975ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701994526; x=1702599326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XotGOMdMWL2Wx6JLKR+G2CshqnSL/C5sZTdbly7Et1Y=;
        b=WMAfTHykMuJxAD1wTOnfwNyIl5rDC7YDgxLlmBCECYUb4/WAqrScs2HpcQaCbtueF/
         VQJGXlrldXTfdqc2RGWMy/lavjv8ucVbHvzC5oe9J1VRSXZgMHOUMoBaYx8peprI89Xl
         z/rUTvL870qCtutBtGDNNma7zg6OWqoGJvq9JYTk8PhCLqZXqHbQgEQKqON97o5LGLqN
         HX82wrO7H6+D6n2z+QOW0ltVxkG63dhNwi1XPNehd5axZ2HWgAlCwT6T73S4uPaUOMG8
         y25I5EDjLFBxVjQsExxrevYzt3FwWrN4M4WnIAPZIfCNxfi+SUe0hOmzRNwBJaAfrXik
         NVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994526; x=1702599326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XotGOMdMWL2Wx6JLKR+G2CshqnSL/C5sZTdbly7Et1Y=;
        b=flz+QF/O67jQ/586/L011MSdIQFAaB6R1iORMWnsdYAwAwQJ7NDwvKGfpCHZrj8RDr
         JkWi4eg29Qa35Ec7ELY3DdsIVXoLR+29OMInVARyMgUDnZaZmN0gqrxS7AHt/QITs7Y3
         qZmgJ6kJ9gNUayrqre0Y/ms+/498Pb0MizT3FDfqphbsWZzu2V0F2FKXkAaU0NZRbbTM
         fvSOOVC9hGkkLPo0YAFWDVBpTFLRe35pjHRZBZ1G1H7z7tIc/hcK+QWaQugiV+geIUvT
         JfcOTLhV73vDKnxM44PAI8s20GAGZkBYiscYctwt086n8AkBliH3IhZhsiJWPAOLPkRp
         0vaw==
X-Gm-Message-State: AOJu0Yyuq2ePVgSul6GmBXTyupF2PicWpD0YKTlFlJfnpYGRgAD9O1Nt
        kujJttyLjwoZczUOsGLW8bw=
X-Google-Smtp-Source: AGHT+IH9RLI0HAi21oOZiypr58E6XOtJUgI+wnS7DkrdMqpRZievvLeMuyzuJcISkQmbSJK1zz7xlw==
X-Received: by 2002:a05:6e02:1523:b0:35d:a4a9:7bb5 with SMTP id i3-20020a056e02152300b0035da4a97bb5mr2037968ilu.35.1701994525924;
        Thu, 07 Dec 2023 16:15:25 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id z18-20020a056638241200b004664a0a7f2csm184652jat.177.2023.12.07.16.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:15:25 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     lb@semihalf.com, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
        daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
        jbaron@akamai.com, jim.cromie@gmail.com, john.ogness@linutronix.de,
        keescook@chromium.org, pmladek@suse.com, ppaalanen@gmail.com,
        rostedt@goodmis.org, seanpaul@chromium.org,
        sergey.senozhatsky@gmail.com, upstream@semihalf.com,
        vincent.whitchurch@axis.com, yanivt@google.com,
        gregkh@linuxfoundation.org
Subject: [re: PATCH v2 00/15 -  02/11] dyndbg: tweak pr_info format s/trace dest/trace_dest/
Date:   Thu,  7 Dec 2023 17:15:05 -0700
Message-ID: <a41db07f2a3abc8835f0585149134d8e46fbef71.1701993656.git.jim.cromie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701993656.git.jim.cromie@gmail.com>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com> <cover.1701993656.git.jim.cromie@gmail.com>
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

Remove the space between 2 name-halves.  This is just as
human-readable, and more narrowly greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 07c377924160..fc94f09b20db 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -874,7 +874,7 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 			return -EINVAL;
 		}
 	}
-	v3pr_info("flags=0x%x, trace dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
+	v3pr_info("flags=0x%x, trace_dest=0x%x\n", modifiers->flags, modifiers->trace_dst);
 
 	/* calculate final flags, mask based upon op */
 	switch (op) {
-- 
2.43.0

