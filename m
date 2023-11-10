Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B87E760F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345500AbjKJAwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjKJAwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:52:36 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403373859
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 16:52:34 -0800 (PST)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5b99683eefbso1425940a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 16:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699577553; x=1700182353;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feNFw85CJmaC+MKGQCYluiLVbcUPAgXKKnEycrysL7A=;
        b=JL3lz23tS06kI7F70PRXgb4wbHYYj1B1hoWwKrrHh6FSZDypLtp86Ulp649QaV9CJU
         iT+v3GS0ehAAVV/35vkXIptZHxAlyhkwhgaueVrC6OprBhs5LnUgU0DcEgRMB4SPEmkZ
         m2A/e2E6xCQyLNSoKiCHV8wklX6yJyRZn/MaccIzIDtFaDa9musBJkRtqySKNE+IWzuH
         yE4FZOIMJV7Ly53h/vPEBZB2/FLEEfQZGd7W68xZPbSNv40z0zAFfTjMa1OaCfC6eVBt
         aY2nxaMpDgaqsKuWP1V8ZTgaP8yWB4+KB/EBJiEA4Mlb58noCLrl0VHeUsTtEXREvnK9
         jNeQ==
X-Gm-Message-State: AOJu0YzmpJkr06Ff2BR5G3KUC1eQnoOMANjWoq4hi+AeZRL+Un/IDmDc
        0Euzycxt8QHR/aR63pUdq3RCUzoZnneURj/qyAtGK06//6IASbs=
X-Google-Smtp-Source: AGHT+IEDCjePRGfFfw62kVezyloQ9BIvHrIs+BFOpwOXmvJLAD/ntFYTJKhuV94OX+jmXVGPgyaAz29wTepV0MsVYEVwjUd8rAz3
MIME-Version: 1.0
X-Received: by 2002:a63:e74f:0:b0:5bd:bde0:54d1 with SMTP id
 j15-20020a63e74f000000b005bdbde054d1mr836752pgk.7.1699577553718; Thu, 09 Nov
 2023 16:52:33 -0800 (PST)
Date:   Thu, 09 Nov 2023 16:52:33 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b97340609c1bc27@google.com>
Subject: Re: [syzbot] [PATCH] test aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test aea6bf908d73
Author: lizhi.xu@windriver.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..6ba43a0369d3 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -738,7 +738,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 
 	pr_debug("Send UI frame len %zd\n", len);
 
-	local = sock->local;
+	local = nfc_llcp_find_local(sock->dev);
 	if (local == NULL)
 		return -ENODEV;
 
-- 
2.25.1

