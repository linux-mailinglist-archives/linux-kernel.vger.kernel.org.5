Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A89796EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjIGCBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjIGCBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:01:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6612D19A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:01:02 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68a3e943762so455086b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 19:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694052061; x=1694656861; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1vewNX7v9Jsogj+AcffyXezNkGsw817ei7jyYCtcy/M=;
        b=Kh7SgQuF2L0DolvS8HG3UzZBSY2hVmkPnqDluPpBiZS3+Ee4PNbxL43c1qYi59Usbw
         vF5VG5kT8NCiioUoVSuuMF3ztLUy5c8BR//qvTfJsfmnZZSmVluxkz6VT191fpkaaPjZ
         yAxByLZZNi+WwPVMZxC2RKVZRlrxMxogcVYxh73ydiAX+kBLFtztb57fD0G/APVLJyJO
         B587HuLM8ec0ybc0ZJt7djPXs1QA++Omoa7XaD/iwCtwCYezc6VY1c/IMAhMOhwiGKK/
         uSSTnSK0eJSccinERBJCJAULSqHju1CC0nIQYj7nY8TpFIKUxiYYJ+8zaTSqTjREvvF2
         4AOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694052061; x=1694656861;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1vewNX7v9Jsogj+AcffyXezNkGsw817ei7jyYCtcy/M=;
        b=HQw8otxZYI5zYHycjs7cgpbw1dX8PwHk9nIlvI076xYAa0WT91ygbuZGknHNxk2/R+
         NrKOA7BWXp6gtubiH2dUrxJ38Ch1EGgMJlYrFsybg104KOML0ibIb9UW9PGhLBBsfQax
         ogW0EhVlN7ERxHwvxO3vtuDajMkMMJ1ZL4wkEDnPfA/8dZYW8FvJ2Qs5Ctfay/1g7EAA
         ImQD/C9ZaGSbsPiE823lpDsGWnq8+KrcLgikwByh3sMPQVrUWwgh3ic581OB3hylBYpU
         p8Ec08zfhMZ9pV67VPopTiKrc/m9VKAYjG8q+29x2PA2lyuaxC6oM/351xNbHZZFRxNh
         8BSw==
X-Gm-Message-State: AOJu0YzchvIsiiOyqNmyN0j07bq1C3l+hpMIiGdf+N7P0LAklsUZHZFr
        tL5wzWOIJG7TK5HuTAk7wikfvl3Ia20=
X-Google-Smtp-Source: AGHT+IHceUUoZG5LCctYCX8aJdipsimumNOe8uKkWOWovio35NejQo4+wc0xoeEkmmog5fgmMJGyog==
X-Received: by 2002:a05:6a21:71cb:b0:13e:e053:1050 with SMTP id ay11-20020a056a2171cb00b0013ee0531050mr19528449pzc.56.1694052061501;
        Wed, 06 Sep 2023 19:01:01 -0700 (PDT)
Received: from midnight ([2001:8003:6434:b000:c30f:d88d:412c:6e9a])
        by smtp.gmail.com with ESMTPSA id fm14-20020a056a002f8e00b0068c6889e146sm11685890pfb.98.2023.09.06.19.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:01:00 -0700 (PDT)
Date:   Thu, 7 Sep 2023 12:00:57 +1000
From:   Angus Gardner <angusg778@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: wlan-ng: Removed unnecessary parentheses in wlan-ng
 driver cfg80211.
Message-ID: <ZPku2UC5g99ILEI3@midnight>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/wlan-ng/cfg80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
index 471bb310176f..d7d8a99adf52 100644
--- a/drivers/staging/wlan-ng/cfg80211.c
+++ b/drivers/staging/wlan-ng/cfg80211.c
@@ -351,8 +351,8 @@ static int prism2_scan(struct wiphy *wiphy,
 		msg2->bssindex.data = i;
 
 		result = p80211req_dorequest(wlandev, (u8 *)&msg2);
-		if ((result != 0) ||
-		    (msg2->resultcode.data != P80211ENUM_resultcode_success)) {
+		if (result != 0 ||
+		    msg2->resultcode.data != P80211ENUM_resultcode_success) {
 			break;
 		}
 
-- 
2.40.1

