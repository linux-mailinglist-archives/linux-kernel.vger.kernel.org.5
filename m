Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251397DFAB3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377346AbjKBTKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5377E12D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698952158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bdm7/bvED6EWh7/6PvHtStwIELZzOBJ3AC8AvoT33XI=;
        b=b2tFjDkpU1hEEIrsNn69R/+g3OhfW5MjDrplnQvcBqB9RT4xp/jbXSwbNDdyE7Ve7//RGT
        aKghZCp4cs4coqUTI9n/sK8DKgvlL8yrHRTKU1qqC+CfjpT9LSG64DAU4aGSDNcT5ZYV9M
        OG7L1PmexbhiHBQhzpmNxOYQb0Be3a8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-h1ZbNPDDNi2siAjRkcrHqw-1; Thu, 02 Nov 2023 15:09:17 -0400
X-MC-Unique: h1ZbNPDDNi2siAjRkcrHqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40778b52dbaso1584755e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698952156; x=1699556956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdm7/bvED6EWh7/6PvHtStwIELZzOBJ3AC8AvoT33XI=;
        b=kqEpa5p+AwegDeZGh4C7+NDYhHBAyK4oWBH4jMz12g6QG2wwmnHu9OEZdRoYiS/xvn
         Svbdtqu7axod3h1jfOuhpoq4+2PSRVdOFdubNrMCjxckEt/F1Qc4rFhYjjbMmgzQT/5J
         EeSjgC7amyQ2JGUNTBWWFkeUXxu0lDVjAB88xNq+B+3tuwgID+OLT6jcYgbr8qF+uahu
         Gm87RSFobqKF/y+VM+e4HQ2im7FlUeYhsWD9PP+D6UCIK6RheBZhfWqOSIXkw+lQpJhx
         XZsghgh366q/s5xmikgyX3odBlw/BSc6i9cwp2P/f9ICNlXCztUJSu9DfnHP+7269zNz
         +xAw==
X-Gm-Message-State: AOJu0YzGviaJoh7wrTEn0yqfEWjEr3NZuOBdViOB2wT66uCUcPPc5oPN
        RvlFaZ5nawXgwF8HAfutI5ZHabpB34erF/rA48X3Nsy5qVKsmTVn/1OD2FRFDzz5L7oqwt4sA3Q
        cV7Rc80wf5cYSLY7QyzvddbP7
X-Received: by 2002:a05:600c:1c93:b0:405:358c:ba75 with SMTP id k19-20020a05600c1c9300b00405358cba75mr15946229wms.0.1698952155924;
        Thu, 02 Nov 2023 12:09:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJrzWe7MBj283jM/1mID2x28ZH2dU5/4xyXj/BRIv0E3jBYof7010FqRU03ZQ9teuOTm+nmQ==
X-Received: by 2002:a05:600c:1c93:b0:405:358c:ba75 with SMTP id k19-20020a05600c1c9300b00405358cba75mr15946207wms.0.1698952155591;
        Thu, 02 Nov 2023 12:09:15 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c5:d600:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c458d00b00406443c8b4fsm73278wmo.19.2023.11.02.12.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 12:09:15 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Stanner <pstanner@redhat.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
Subject: [PATCH] drivers/comedi: copy userspace array safely
Date:   Thu,  2 Nov 2023 20:08:49 +0100
Message-ID: <20231102190848.51376-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comedi_fops.c utilizes memdup_user() to copy a userspace array. This
does not check for an overflow.

Use the new wrapper memdup_array_user() to copy the array more safely.

Suggested-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/comedi/comedi_fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 1548dea15df1..1b481731df96 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1714,8 +1714,8 @@ static int __comedi_get_user_chanlist(struct comedi_device *dev,
 
 	lockdep_assert_held(&dev->mutex);
 	cmd->chanlist = NULL;
-	chanlist = memdup_user(user_chanlist,
-			       cmd->chanlist_len * sizeof(unsigned int));
+	chanlist = memdup_array_user(user_chanlist,
+				     cmd->chanlist_len, sizeof(unsigned int));
 	if (IS_ERR(chanlist))
 		return PTR_ERR(chanlist);
 
-- 
2.41.0

