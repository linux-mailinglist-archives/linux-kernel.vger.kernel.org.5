Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F77C7E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 08:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjJMGw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 02:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjJMGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 02:52:57 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A062391
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:52:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3226cc3e324so1681290f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 23:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697179974; x=1697784774; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1fwSnEb/oGascEkxYNcgQ1DoI1EHky2CUmiF3z/VGsc=;
        b=GYlopn326+7oIKGsv5aOk3rwQt+B2C9Segb05eeyTYefmmkOKySTR60+DS3l0yjHaw
         iAF3a4W3Ear7ActfzBJPN5uMIyCQVGL1Km5Jepn/isS5ohGqvakfBKYGorY4+tScabPy
         4xqiP8OsC555O/yqZR7wPvuc2n52CbHP5Dno8ApSnHjylmLsRndMqybQv4Yo2QIkerlB
         AdwBdFNQGwDcWkFLCCQpcUJB86ysC+GhHg0rvQL+dUzrL3arRepfh+u+qF//IgmD/0Ts
         Te8BfwxrUoDTEYtum2RwF7APurj5TDzeZKNwG9uSfukbDZqUgl7mgbha/v8/hA6MAnAh
         LKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697179974; x=1697784774;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1fwSnEb/oGascEkxYNcgQ1DoI1EHky2CUmiF3z/VGsc=;
        b=rSMV2hel3DMhZbaOL16y6Pi6sMYm1Bqxx2b0Wx/ChEgBLYUm+PUv3G8xX2FyPhwuJP
         KONvk2FNdVW4WkBszUKjQu6CnMEmZsXEzvbSFIdLIVV2y/cUILN2ruwPye8qlvxT8Q6E
         FXYFJFME3sIUlxr8tjcLdvfbR1kgPAFpyt5rjk3/m5PAPV7eUA4sUy6/1jRd11ZriTeW
         fb5qWSBI/Bq6A4eLQDPuuVNpqSE8vsb/LFb0C5QZvxy0KN6v9VFihUUzTNIeqqnJBvno
         nL2HsbrmWXkYR2yuRISdgVHi3vJPlb/SNI/9bAueABoMKEl9r+LAS9lYjklEtfdqNv8x
         tTZQ==
X-Gm-Message-State: AOJu0Yzm8avp9nljTvYSxrsRf8AiTo5f+r9/aAV/YJknbIbjfO2I1W/u
        oEXLRVokvzNM5Z7W5gtJWfVyGHOEQDByPs7Y
X-Google-Smtp-Source: AGHT+IGMvyjlULk/r5LkFCrZSMyEp4or+xvVuLLJOmX7A/O77IAh6ozNhv8iIiCmMKKwFR0y5b4qsQ==
X-Received: by 2002:adf:f449:0:b0:32d:9daf:3f94 with SMTP id f9-20020adff449000000b0032d9daf3f94mr536713wrp.53.1697179973479;
        Thu, 12 Oct 2023 23:52:53 -0700 (PDT)
Received: from lab-ubuntu ([41.90.69.21])
        by smtp.gmail.com with ESMTPSA id a1-20020a056000100100b0032d9efeccd8sm377463wrx.51.2023.10.12.23.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 23:52:53 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:52:50 +0300
From:   Calvince Otieno <calvncce@gmail.com>
To:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>,
        Calvince Otieno <calvncce@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: wlan-ng: remove unused functions
Message-ID: <ZSjpQlUcyOoYv4Yh@lab-ubuntu>
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

The following functions were defined in the prism2mgmt.h file but neither
declared nor used anywhere. It is recommended that they be removed.

	- void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
				      struct hfa384x *priv);
	- int prism2mgmt_set_grpaddr(u32 did,
		                   u8 *prism2buf, struct p80211pstrd *pstr,
	                           struct hfa384x *priv);
	- int prism2mgmt_get_grpaddr_index(u32 did);

Signed-off-by: Calvince Otieno <calvncce@gmail.com>
---
 drivers/staging/wlan-ng/prism2mgmt.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.h b/drivers/staging/wlan-ng/prism2mgmt.h
index 083a055ee986..8c3f1ac35913 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.h
+++ b/drivers/staging/wlan-ng/prism2mgmt.h
@@ -78,14 +78,6 @@ void prism2mgmt_pstr2bytestr(struct hfa384x_bytestr *bytestr,
 void prism2mgmt_bytestr2pstr(struct hfa384x_bytestr *bytestr,
 			     struct p80211pstrd *pstr);
 
-/* functions to convert Group Addresses */
-void prism2mgmt_get_grpaddr(u32 did, struct p80211pstrd *pstr,
-			    struct hfa384x *priv);
-int prism2mgmt_set_grpaddr(u32 did,
-			   u8 *prism2buf, struct p80211pstrd *pstr,
-			   struct hfa384x *priv);
-int prism2mgmt_get_grpaddr_index(u32 did);
-
 void prism2sta_processing_defer(struct work_struct *data);
 
 void prism2sta_commsqual_defer(struct work_struct *data);
-- 
Calvince Otieno

