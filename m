Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC4D7D17BB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjJTVId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJTVIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:08:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB26B10C4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-564b6276941so964687a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697836097; x=1698440897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zu77mdO6sktTxTIEryyom1thHcuDOj/hZWn2X42FV4=;
        b=JQpI4Xq9/jEHrkcm4kJXBDeVRXV60Kerc9XYCSkWFo/LCREekDsJ3DWHm+24nd8KvB
         Lek83Q1Ofp5psUDEumOfu0j+LhCgvU3+DRgrLO/GPOholqm38o1ALoJWgeBIL6Adptcr
         TqLqCMKSbvugU36vN0YCUdzt9neldBO19oHTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836097; x=1698440897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Zu77mdO6sktTxTIEryyom1thHcuDOj/hZWn2X42FV4=;
        b=ScBezmHDnuIl+ykvw7Ll/cJlzB5FhVEP8kQSmy5R3of2mG4JwUH3BygbxPVSrpTkmE
         1AV59S52nNxspwoM1uQK6l5NwlNgQTH6S1my7zafmVA++yeSAkG2JCH+LLgs+Icg8mjx
         +oXGkWV29rjgqQMJ7d6k8q0xQT6DqgMuu5xnfnM6yUCmKj7EQaaI9aVGneNlseVQmv9J
         ttHLp3RBk9VaDjwU76N+9lCLHDGCK6xACcO5IU//ga4SwjAzKNfryg9ZT/sbZjF/f2Lh
         aDYpgz1vPn7EJG/9bA0it2qYGpIQRoeaJoicJOBoaTsJgm2ZdIgFlBbeHiXHJVaT7Jc2
         myrw==
X-Gm-Message-State: AOJu0Yy2XMv33DonLxKFnJQOfG2yoAApWxYIo7k2H3UTjtHQkHrw+Tad
        tW4vXyZBW9Ai9qbIk/t7K6TZxQ==
X-Google-Smtp-Source: AGHT+IFmPo0a3BDvOdl9WUSCn87DM1UjGRco3v8oKH5WLNOwecmjVvp8jXBxPaM4fCiQi2q65KUipg==
X-Received: by 2002:a05:6a20:7288:b0:13a:6bca:7a84 with SMTP id o8-20020a056a20728800b0013a6bca7a84mr3339806pzk.44.1697836097385;
        Fri, 20 Oct 2023 14:08:17 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:c078:ee4f:479f:8486])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7954e000000b00686b649cdd0sm1969278pfq.86.2023.10.20.14.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:08:16 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 4/8] r8152: Release firmware if we have an error in probe
Date:   Fri, 20 Oct 2023 14:06:55 -0700
Message-ID: <20231020140655.v5.4.I5cd5dd190df0826e38444df217f63918a8b4ad39@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
In-Reply-To: <20231020210751.3415723-1-dianders@chromium.org>
References: <20231020210751.3415723-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling in rtl8152_probe() is missing a call to release
firmware. Add it in to match what's in the cleanup code in
rtl8152_disconnect().

Fixes: 9370f2d05a2a ("r8152: support request_firmware for RTL8153")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v5:
- ("Release firmware if we have an error in probe") new for v5.

 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index d10b0886b652..656fe90734fc 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -9786,6 +9786,7 @@ static int rtl8152_probe(struct usb_interface *intf,
 	cancel_delayed_work_sync(&tp->hw_phy_work);
 	if (tp->rtl_ops.unload)
 		tp->rtl_ops.unload(tp);
+	rtl8152_release_firmware(tp);
 	usb_set_intfdata(intf, NULL);
 out:
 	free_netdev(netdev);
-- 
2.42.0.758.gaed0368e0e-goog

