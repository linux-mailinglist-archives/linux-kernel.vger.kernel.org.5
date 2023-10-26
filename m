Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F897D8334
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbjJZM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjJZM5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:57:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A21A191;
        Thu, 26 Oct 2023 05:57:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso693702a91.1;
        Thu, 26 Oct 2023 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698325029; x=1698929829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAq/h84hoL+UwBKjrluHqm+iW3Vp6ePG/aMBZRWLHC0=;
        b=WsrHlVcX97gZ26IwJlEBLHZDxFdQOjxlQs+3RCmOVsMzvax2Q19GbFPyEUYZKMoosc
         88vIMtPnVy/vN+AxdQsh/D2p1THupDD3+XTPrDuGMbTlpLRYOeaeNQR0K4kMu40RyWnE
         WXxTEVy/xUN4mAGqWqdcm2unZO7ew9ftP19tzJYqvj5o9ULn/ReCB4zSuYuOgpdOpjJC
         NplywUJz1vpBmcKg/HeyeEtWBf5rqRrpYCLFOc5LmhaLrWvB3FmyqFyzt8cmUJ/m1LLz
         FhxrhvUzgw8rn8k1Jv3qU9w/iRGeQyGDCzono5XUZNI7QCem/HGzOYdSrUYf4or4EmdP
         I5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698325029; x=1698929829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAq/h84hoL+UwBKjrluHqm+iW3Vp6ePG/aMBZRWLHC0=;
        b=B+6ksZ4PL7lXnsbhwH8/Y3kklj/IHVQj7KoByMLlKrzgjJ2g1XriI4Z5SnBsj6bfhT
         HHgFBzGG6JqyuTv+sL2zcPX5GrXKWptxDeU57Yqq3685Kgv6hPC/BEFXDBdR8rDCoUSB
         MZmR1Q5eyCxc0bS5NYRFd7TZFJWPq/3k0BZBD+qoGkJPB6+JJYFTL7CaVgOn4lXmzvmL
         cPQITNPSEal2mHii6W82qfboSz82f3KAThZFPv+ZSXyHQSujkz/IkpTQOclPtyA7fKVO
         xaaKVaemW8yEZf4LWlr+akvdUWPlDx/0CsQAOFkvDBNgVNZQRshkMq0kBIrGx9AEuGN3
         u8sg==
X-Gm-Message-State: AOJu0YzOrLLhpVWnhHC9aEB3L0KR4JGNCwpwNCYcKrlAmuvOpuW7EK06
        GGM9eevOiFZJGwjAkvR8DOcUpnflBc5OeQ==
X-Google-Smtp-Source: AGHT+IF6Zjz6CCP32+qe+ctnaMcuAFd07y2irysyeokfPZ6D/F458guLdKgInFI2yQDBd2b73WDJ6A==
X-Received: by 2002:a17:90b:5287:b0:27d:1c70:23d4 with SMTP id si7-20020a17090b528700b0027d1c7023d4mr14494564pjb.44.1698325028805;
        Thu, 26 Oct 2023 05:57:08 -0700 (PDT)
Received: from brag-vm.. ([2409:40f4:13:48d5:f085:e875:d528:fe4c])
        by smtp.gmail.com with ESMTPSA id g2-20020a17090a714200b002777001ee76sm1565513pjs.18.2023.10.26.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:57:08 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     reiserfs-devel@vger.kernel.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-kernel@vger.kernel.org,
        syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com
Subject: [PATCH] reiserfs: UBSAN: array-index-out-of-bounds in direntry_create_vi
Date:   Thu, 26 Oct 2023 18:26:16 +0530
Message-Id: <20231026125616.1859-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deh defined as an array of type __u16[], and issue is
triggered when it's trying to access an element at
index 1, which is out of bounds because the array
has only one element at index 0.

Reported-by: syzbot+e5bb9eb00a5a5ed2a9a2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e5bb9eb00a5a5ed2a9a2
Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 fs/reiserfs/item_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/item_ops.c b/fs/reiserfs/item_ops.c
index 3a5a752d96c7..ccf547c5e8e1 100644
--- a/fs/reiserfs/item_ops.c
+++ b/fs/reiserfs/item_ops.c
@@ -484,7 +484,7 @@ static int direntry_create_vi(struct virtual_node *vn,
 				  vn->vn_mode);
 		dir_u->entry_sizes[i] =
 		    (j ? deh_location(&deh[j - 1]) : ih_item_len(vi->vi_ih)) -
-		    deh_location(&deh[j]) + DEH_SIZE;
+		    deh_location(&deh[j - 1]) + DEH_SIZE;
 	}
 
 	size += (dir_u->entry_count * sizeof(short));
-- 
2.34.1

