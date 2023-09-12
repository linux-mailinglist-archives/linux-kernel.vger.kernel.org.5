Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3582C79D130
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjILMhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbjILMhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:37:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9518D9F;
        Tue, 12 Sep 2023 05:37:47 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403004a96eeso35290275e9.3;
        Tue, 12 Sep 2023 05:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694522266; x=1695127066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ia4qpsc0kAQCExjGVk+ALPebqpFev4o6vOaP85jCENk=;
        b=H4iMhXgEFzO6paPDTUMwWHFcmZtntcmdl6S+gVmfc8GdHp9wITNioJWOEagfHPIDCt
         j9X4iVjSzxy+p2dkSHRARlM2cO692mytRNRDA+Q6qt+LlA6lSDNYLbaYycPuVZ3OqvZm
         siQNcBY+hYMQkZ5S4aSkkFoFneFz7qN0FD4EEAm5o3AYFD7MKhCLGyiQNG2PQm7oe/nL
         zCPOOnlggMeZZ0hIRES7AmIsJGUGlyBg8d1Vrt5VssNjY6pP4fdfrcov0k4lXwk6oApE
         M07JQ2CXMwDp9mULHFvKlw0hpSGT7VrklJ7ifI2k6hyd2GD4a3TcsWRiQ9zLo+kllQey
         1+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694522266; x=1695127066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ia4qpsc0kAQCExjGVk+ALPebqpFev4o6vOaP85jCENk=;
        b=mAB0noxF8vRVCBEJjb3VX65cX+Cc+g/lmlQYQzj9/FJOAgTo9oHnafAEdWNrNFInld
         A/ms8D05sorzkjMCMD6Olv/Ab+p+6p7U/JzDi4z8WzQa5PqyWuISyHzBctV/iK6amxso
         lal38Ter49oUAfwjIGcrd23x6Tr1PylHJ+3amiZWPeXyfT1OMuq8KznUeyvuwPg6Mf4g
         /d3RTz9+I71fDIq55gEg0MyHTDds7XK84nakbxufxmSB3RrkIy67wwRRIgFCaLIqdjwc
         dcKGEFWEZGh0bYTfnLDIeesw3Yovat/fVc13Zq23bf5Ad+g45i8h9GSaqSixYc3bpRS+
         SnFg==
X-Gm-Message-State: AOJu0Ywz8jwr3sLuTip/KbBu4EelUFOwKJc+z67KZDyKDS3ce8r6a/79
        Y9AGmBQCkr36KGuk7fd/9h/KYM/YaBQOAw==
X-Google-Smtp-Source: AGHT+IG8kKLIvYwMChbHgwSqCS6Dvbhjkf0Dy6qr4pSzksZuJJKn21NB6O1cFPUT0kr65ZDfTCibUw==
X-Received: by 2002:a5d:4944:0:b0:317:3d6c:5b27 with SMTP id r4-20020a5d4944000000b003173d6c5b27mr9411793wrs.46.1694522265730;
        Tue, 12 Sep 2023 05:37:45 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b0031accc7228asm12706194wrt.34.2023.09.12.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:37:45 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>,
        linux-bcachefs@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5][next] bcachefs: clean up some redundant assignments
Date:   Tue, 12 Sep 2023 13:37:39 +0100
Message-Id: <20230912123744.3929609-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up some redundant assignments and variables based on warnings
found by clang scan build static analysis.

Colin Ian King (5):
  bcachefs: remove redundant initialization of pointer d
  bcachefs: remove redundant initialization of pointer dst
  bcachefs: remove redundant initializations of variables start_offset
    and end_offset
  bcachefs: remove duplicated assignment to variable offset_into_extent
  bcachefs: remove redundant pointer q

 fs/bcachefs/btree_update_interior.c | 2 +-
 fs/bcachefs/buckets.c               | 2 +-
 fs/bcachefs/disk_groups.c           | 3 +--
 fs/bcachefs/fs-io.c                 | 4 ++--
 fs/bcachefs/io.c                    | 1 -
 fs/bcachefs/quota.c                 | 3 ---
 6 files changed, 5 insertions(+), 10 deletions(-)

-- 
2.39.2

