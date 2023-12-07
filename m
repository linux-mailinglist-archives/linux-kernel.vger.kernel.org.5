Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC5A80845C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378495AbjLGJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjLGJIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:08:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856C10D7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:08:13 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db084a0a2e9so926710276.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701940093; x=1702544893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HcBBD4Ve+EnK0sA+7Oy5D//EjO8x9y3uJFnX5ru4dqg=;
        b=R1k2KInWwMKp3FaZeicuPuxjpIC4omF+lvWnZW9xb+o4TPOC4cXMSm3JoOPI7ehZho
         4dgwpFwpuTCCcEmQQSHk2Glin72Z5peq152L29i6Mt69wJaGrCxj6i9A5Xa9L0Skd5Wr
         4neiygWZXaQ5OGo//MS4YXkBRFzSxNK5PoumRff9Mf3QIZaaIF4TYyUeS3SEONe0j5xu
         5szVzDv7jOAUMllrGRVvx/4TnrkkwYnGGUL5e4A2MIktGyvoNWQg9Cn+DtI4fqQSOaq4
         wYijLzP8G18+HbLj33Du/XQPV5MURAyl40cRpYpfPuEBCQZDSd2wBR9h1+QkByFFNIoR
         sOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940093; x=1702544893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcBBD4Ve+EnK0sA+7Oy5D//EjO8x9y3uJFnX5ru4dqg=;
        b=EAwuOTM2pw7J6xrL1hNPgKdWLSk+DJTCbWhosZgmyt08GEYhJvFvDtBrUKO8f+eSDE
         DEFRYFWSs0jnu+lAegYnv4Yu58zwP3V+NELYcv58ZgMAxWOSOojx22VzkGC1xkXljq5M
         CclZdRlsa4bRreFF53ZK6QeH0K089uUvuu30a9d5kgzn7l2ywu6/G7OkSDvEgQw5LvKV
         FVSXPBEBfdODZdcbZqYrxQ5NR1g9fTHKadsTiUpIZqHg+hiizGaDPbO3tuDRyKj3Iuin
         Gw7aXWfJ5nqlY/vhfrL84v+bhSsRAxrOyFcDI1yAPIX74NIJTAos5UTomh0tBFgYKk6Y
         O9kA==
X-Gm-Message-State: AOJu0YxdsDydG+AFI+xwSYxZ2kFG7R/hu1IMA/TvYdscuyhCSOFi3gKK
        C4/ntA46Ux0aJ36CAMgQgjjTX2GzNbXd8ig=
X-Google-Smtp-Source: AGHT+IEqB/j07MaxmdfrGiH6cpjewMzzjxAe0aX1PjsLmlRZovJi+MS6ODabqF7RJKBqphBvuoBj2o30uU2WZ9g=
X-Received: from rdbabiera.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:18a8])
 (user=rdbabiera job=sendgmr) by 2002:a25:ca92:0:b0:db5:47c1:e82d with SMTP id
 a140-20020a25ca92000000b00db547c1e82dmr25759ybg.6.1701940093019; Thu, 07 Dec
 2023 01:08:13 -0800 (PST)
Date:   Thu,  7 Dec 2023 09:07:40 +0000
In-Reply-To: <20231207090738.15721-12-rdbabiera@google.com>
Mime-Version: 1.0
References: <20231207090738.15721-12-rdbabiera@google.com>
X-Developer-Key: i=rdbabiera@google.com; a=openpgp; fpr=639A331F1A21D691815CE090416E17CA2BBBD5C8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=rdbabiera@google.com;
 h=from:subject; bh=Go8QEr2NQzBwcUwozRZWWtLanmmY65Hze1InDnkaM4E=;
 b=owGbwMvMwCFW0bfok0KS4TbG02pJDKmF3XGTak3qtp3775Bx7lDlfW9pvog9Gps3eD66ctWcI
 UTu/wyLjlIWBjEOBlkxRRZd/zyDG1dSt8zhrDGGmcPKBDKEgYtTACaSbc3I8D56Tv+fy5e8F1y8
 UHys9lNUUx1X6rJnZ1dtesd5oCVKKJPhn62M8nfGR7/9De/2LjC8UpU5w/h/+G3xeLMbPhP/rL8 XyAUA
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231207090738.15721-21-rdbabiera@google.com>
Subject: [PATCH v1 09/10] usb: typec: altmodes: add typec_altmode_get_cable_svdm_version
From:   RD Babiera <rdbabiera@google.com>
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net,
        gregkh@linuxfoundation.org, pmalani@chromium.org,
        bleung@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     badhri@google.com, tzungbi@kernel.org, utkarsh.h.patel@intel.com,
        andriy.shevchenko@linux.intel.com,
        RD Babiera <rdbabiera@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add typec_altmode_get_cable_svdm_version to return the cable's negotiated
svdm_version.

Signed-off-by: RD Babiera <rdbabiera@google.com>
---
 include/linux/usb/typec_altmode.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/usb/typec_altmode.h b/include/linux/usb/typec_altmode.h
index 4d527d92457d..1ad581c5a930 100644
--- a/include/linux/usb/typec_altmode.h
+++ b/include/linux/usb/typec_altmode.h
@@ -156,6 +156,16 @@ typec_altmode_get_svdm_version(struct typec_altmode *altmode)
 	return typec_get_negotiated_svdm_version(typec_altmode2port(altmode));
 }
 
+/**
+ * typec_altmode_get__cable_svdm_version - Get negotiated SVDM version for cable plug
+ * @altmode: Handle to the alternate mode
+ */
+static inline int
+typec_altmode_get_cable_svdm_version(struct typec_altmode *altmode)
+{
+	return typec_get_cable_svdm_version(typec_altmode2port(altmode));
+}
+
 /**
  * struct typec_altmode_driver - USB Type-C alternate mode device driver
  * @id_table: Null terminated array of SVIDs
-- 
2.43.0.rc2.451.g8631bc7472-goog

