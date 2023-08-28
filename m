Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF978BAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbjH1W0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH1WZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:25:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387113D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:25:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7814efcccbso4588919276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693261553; x=1693866353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UULv7dEfmxkqrWSwHKGjuNFOLz/KrJvgWNb6lbuCs=;
        b=2kejcxIi3hXJKdZ1GkMysAMauwtVpiO3wB0YJXxm7YLfO/aBFv5JnmffdBZJEtO1n4
         vYy3Nj/ny3dFOO26EZvSSF7ssb/5RCa1/gNfHjWztYGwYMST20i5OgA4xd0Q9ZSLTEZe
         8E05Pcd2zETrYDm76HD4gD/UW+wi0++6YhbZkcC/WK9cY5tbs1gwSyk6qlJ/v+jXbGGu
         23sfZf9CyO1lVUYs5JUujdvX0fLdYXcDqwDu0VPZFbs0UiAaPzba4FXw59jipxriO6bp
         aurqy2AcFS9uSKPfYLzJs0CXRpTAiBQWRDczqiBKps2GMFGa6eVLlGmKJN4I+0pV2Ywu
         HErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693261553; x=1693866353;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4UULv7dEfmxkqrWSwHKGjuNFOLz/KrJvgWNb6lbuCs=;
        b=CYmPCtdN9Pponi0wvSCetlmvMM3kld2dUR5ZG1XAUGj5yhMl1i8iJ7YETPm9nQKzgQ
         epTxG5PYAAi5naEQ5HyvSXIGY9286xO0elH04O2oAEB22Tokc82FBFYfxEl6+Z50D3EA
         4zBo33aBlbkkZlRlCNfNiOU053lVETupXaWIjT/CjyXQDiJeCAZbKOKmWSuIf6ru8RUL
         DS8y4q2FZAQ98Bp5buKabK+MkrUoZo9fQt36sKsid7/FY0546PP4w4ahZPAM33WoQmuf
         zyxCHJ10XLWXzA/3KfbdGnkvuzjSbMpAMF6BiCDTHeiB64VxC5TshkhbvclYjYRT8Ro1
         oc+Q==
X-Gm-Message-State: AOJu0Yz9IrR5UpHlb8MVru4Ika7lM4hfXHWoHwVNy7MLZQUkBCYJZkAF
        IyRCvVIyTv4TEEP8ZMq4p/kNu7DHLCic/soUEGY=
X-Google-Smtp-Source: AGHT+IHebjexSi29sxNXIEYT2we/AIAJmtzB8YnCDOBzFlC85j7fdHzaoXP6O7kQ+CL4Fb+jcj+UYQmnlgWna+E5nYI=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
 (user=ndesaulniers job=sendgmr) by 2002:a25:ce44:0:b0:d72:8661:ee25 with SMTP
 id x65-20020a25ce44000000b00d728661ee25mr835131ybe.2.1693261553140; Mon, 28
 Aug 2023 15:25:53 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:25:47 -0700
In-Reply-To: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
Mime-Version: 1.0
References: <20230828-scsi_fortify-v1-0-8dde624a3b2c@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=eMOZeIQ4DYNKvsNmDNzVbQZqpdex34Aww3b8Ah957X4=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693261549; l=2310;
 i=ndesaulniers@google.com; s=20230823; h=from:subject:message-id;
 bh=Ftz8IPZZMe52YKzLHVvnEUhXYdkgyGJWBaj7UgdHpqk=; b=iH/FxqmBBcMZZaaHpoka8f2O5LUsN1gUPcfI94im4BVVB2bk2tNsg449r71D9h0uE967DIv+l
 StL9iHKe4jeDQkraBppk0fVa0b2INXDjY9hVIKt4WfTZ/GlkIPGiKOW
X-Mailer: b4 0.12.3
Message-ID: <20230828-scsi_fortify-v1-1-8dde624a3b2c@google.com>
Subject: [PATCH 1/2] scsi: myrb: fix -Wfortify-source
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Tom Rix <trix@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang-18 has improved its support for detecting operations that will
truncate values at runtime via -Wfortify-source.

Fixes the warning:
  drivers/scsi/myrb.c:1906:10: warning: 'snprintf' will always be
  truncated; specified size is 32, but format string expands to at least
  34 [-Wfortify-source]

In particular, the string literal "physical device - not rebuilding\n"
is indeed 34B by my count.

When we have a string literal that does not contain any format flags,
rather than use snprintf (sometimes with a size that's too small), let's
use sprintf.

This is pattern is cleaned up throughout the file.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 drivers/scsi/myrb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
index ca2e932dd9b7..c2bdff36a6f1 100644
--- a/drivers/scsi/myrb.c
+++ b/drivers/scsi/myrb.c
@@ -1767,7 +1767,7 @@ static ssize_t raid_state_show(struct device *dev,
 	int ret;
 
 	if (!sdev->hostdata)
-		return snprintf(buf, 16, "Unknown\n");
+		return sprintf(buf, "Unknown\n");
 
 	if (sdev->channel == myrb_logical_channel(sdev->host)) {
 		struct myrb_ldev_info *ldev_info = sdev->hostdata;
@@ -1890,7 +1890,7 @@ static ssize_t raid_level_show(struct device *dev,
 					ldev_info->state);
 		return snprintf(buf, 32, "%s\n", name);
 	}
-	return snprintf(buf, 32, "Physical Drive\n");
+	return sprintf(buf, "Physical Drive\n");
 }
 static DEVICE_ATTR_RO(raid_level);
 
@@ -1903,13 +1903,13 @@ static ssize_t rebuild_show(struct device *dev,
 	unsigned char status;
 
 	if (sdev->channel < myrb_logical_channel(sdev->host))
-		return snprintf(buf, 32, "physical device - not rebuilding\n");
+		return sprintf(buf, "physical device - not rebuilding\n");
 
 	status = myrb_get_rbld_progress(cb, &rbld_buf);
 
 	if (rbld_buf.ldev_num != sdev->id ||
 	    status != MYRB_STATUS_SUCCESS)
-		return snprintf(buf, 32, "not rebuilding\n");
+		return sprintf(buf, "not rebuilding\n");
 
 	return snprintf(buf, 32, "rebuilding block %u of %u\n",
 			rbld_buf.ldev_size - rbld_buf.blocks_left,

-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

