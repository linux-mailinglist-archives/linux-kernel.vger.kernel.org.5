Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F57C83B5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjJMKub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjJMKua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:50:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DC883
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:50:28 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-325e9cd483eso1881652f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 03:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697194226; x=1697799026; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzdTvuk9Hpz7O7qnXQ4bc4hZomimkE/Cg90sCGqX5lA=;
        b=SS6qgNAS3+mRnOA3HzwBO2KL0ttcxYXPFqbglvYLiQWEP1MMoFaaUN6Af+FRITAELz
         CxA6hezY5JZsB9Z2ocCLm/UINZlyvv7VyAvk1c5pnlQh76V5hdaTRFlDCO+wNhtcTET2
         5LCERvHUu82c8kzPLCIdU5+b8dG+vxa95j0nVOsWrfbsmArxh0ooW9ENBqMfe6fRNrag
         JOqjbkn3YmA2r+Tcte88BkpUv5dCGJn0ajRzrU0gL+tjfw5qqPSyni/yOSirns+TorrC
         dbYNfKUOPo5uwf1VzFOabdlg6WWNwQvknlbj2COMHUvL3e7uAxMJDGoGAswctxo7Pfzc
         vAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194226; x=1697799026;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzdTvuk9Hpz7O7qnXQ4bc4hZomimkE/Cg90sCGqX5lA=;
        b=lvrksE8/1bIfdIM3rsD2TlegBAauRiRZ63R7oViQGGZUUC0aEU2eXcq8YQqDVlReZ4
         60pvdz0aUvPMYZ7LMU9Qbsjb8BwKRPK39ACiObCDCL/y/k0ywGM0ozh/pSJ382QfLs4v
         vf0P3E3kQxYT1NZjNT88UyK1MrxBfXRY2QKEeWlnAsLm2o547R8zLjJagnPtGY9pwkel
         TM+5g0inym9BhNapxTQORapeuzWurjw69sZ2Ab1WBWMP0H4JLrnialH0vSJ1e0NypwSe
         MBuhNlncc0zWqPQTEGFmjS/BbtoWDSW1HEhlBqFKJ0Jm8rSZ107HylD51wN5eNfQiT+n
         NFCw==
X-Gm-Message-State: AOJu0YyNCad7p0VeaxGWe4EZjsCxXMXFJr8yD6M0DijKlDw3qW3+ve/N
        O951Ex4yQW9NMVbe+myeJN8qthKc7E85kg+f
X-Google-Smtp-Source: AGHT+IF4yurNdEXNXLR59vun98D5vmMYOMZtup4CqnaDK2jPYQ3tIYnAM9ZbpJT3VejdIEBvS9x29A==
X-Received: by 2002:a05:6000:109:b0:320:9e2:b3a2 with SMTP id o9-20020a056000010900b0032009e2b3a2mr23669871wrx.33.1697194226107;
        Fri, 13 Oct 2023 03:50:26 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id p4-20020a5d68c4000000b003232f167df5sm20520851wrw.108.2023.10.13.03.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:50:25 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:50:23 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: wlan-ng: remove helper function
 prism2sta_inf_handover()
Message-ID: <ZSkg7y2Y2T3midXB@lab-ubuntu>
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

prism2sta_inf_handover() function basically calls pr_debug() to print
a literal string. This can be done by the parent function directly.

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
Patch version v2:
	- Replace pr_debug() utility function with the module specific netdev_dbg()

 drivers/staging/wlan-ng/prism2sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2sta.c b/drivers/staging/wlan-ng/prism2sta.c
index caeceb89c9fa..cf07cf04e20c 100644
--- a/drivers/staging/wlan-ng/prism2sta.c
+++ b/drivers/staging/wlan-ng/prism2sta.c
@@ -1697,7 +1697,8 @@ void prism2sta_ev_info(struct wlandevice *wlandev,
 	/* Dispatch */
 	switch (inf->infotype) {
 	case HFA384x_IT_HANDOVERADDR:
-		pr_debug("received infoframe:HANDOVER (unhandled)\n");
+		netdev_dbg(wlandev->netdev,
+				"received infoframe:HANDOVER (unhandled)\n");
 		break;
 	case HFA384x_IT_COMMTALLIES:
 		prism2sta_inf_tallies(wlandev, inf);
-- 
Calvince Otieno
