Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD157BA61A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjJEQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjJEQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:22:03 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EE983DC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:14:15 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c60cec8041so8197125ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696522455; x=1697127255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBF/uFJVvJ7YTUEt6WwDwwpmUQaEEUWvnNqj8YdJfwI=;
        b=J8zL4yRZ2WZ1V44ebqQo+9Xr3VmKtKkY66scP2NRdqwfArYapDjG5HCfOdF0RXt1u7
         iEBxgZFSNdJN0h8l9bFqiYfyWiPkny4l4VsfNkQk/I8uFE14LOBiU7utLFaZ4o8ItxP1
         2/dFWipCtoU4NSPQNDySP6uLrtcyIGyRvaZR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696522455; x=1697127255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBF/uFJVvJ7YTUEt6WwDwwpmUQaEEUWvnNqj8YdJfwI=;
        b=ntuUprTa2gEbFxwc7h6aTk8P/b7ldZRWUaxbqxbHj4mrfCj+D27zR8DGhQNKva/ypr
         lg+CueFhWprTQl9qbiukX8Y0GZVoHuIGmf+9AaM+Fx4aZOTs3NXUlYnlxRYt7gbBoPpQ
         Mg76g1eIMo5V/uxm0vacS/SXdRDWboBxE+AAXuviLDcukN5+PB0Fih/DQV28kwx1vDWi
         b9wrS0t7m1q8aLeqgsRxUMQAEpaCTouLxp4CvDC1W764chsNqVj7fBGOaFHWYK9GTm29
         I89TsW/D59ndlS+wHMPZ3YU0QE9+WCYpJ7Gbft0EHs9evusxg6c9CjNWhJ/xbtrbuQQl
         z7hA==
X-Gm-Message-State: AOJu0YwiultQ7n+q/JvFBRAx6EtrPi1RGwWi9/YmZZ8a/y01xKCOf0qs
        +5TrzoP4ntFAzanEmXkW8rr1OQ==
X-Google-Smtp-Source: AGHT+IGEiAWvdJBH7vw0BMgCGCiF3Mgfn0JsxTp7iLsTYooxV9aBdAbTG33uN0QT0rwuirwD86o/pA==
X-Received: by 2002:a17:903:110d:b0:1bb:d59d:8c57 with SMTP id n13-20020a170903110d00b001bbd59d8c57mr6223640plh.18.1696522455224;
        Thu, 05 Oct 2023 09:14:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iw11-20020a170903044b00b001ab2b4105ddsm1908267plb.60.2023.10.05.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 09:14:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     James Smart <james.smart@broadcom.com>
Cc:     Kees Cook <keescook@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by
Date:   Thu,  5 Oct 2023 09:14:12 -0700
Message-Id: <20231005161408.it.584-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/lvW3aKbNdffAyIzlZf6gptKlwtHFiNZjl+aiSSruKE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHuDUOvSUL7xliWcJbrUDOxdv4EUfSnKX5nVYU
 HaIdxE+uD+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZR7g1AAKCRCJcvTf3G3A
 JiKOD/96Q3m/bw8VJQ0KeM2IuPUQ633i3udn5aE3jXFjW+0sbngxXC3XfZhjBPWqskqZeuFQt/7
 C79xRJkXdJad1LJ7YM24WaCnCt+fl97aXOTe9PxxPcb1AcG4vXEGxDvTbNYMLjs8FHj2xqM1YbW
 Dn8wFtBa0znQB2zkit7kGuGEK08HMpZWo9wau5NjzVRERVhH69QRP1XFBi/cyj9ipeOXNK2wsue
 3xBl9/iAexBwfkye17sBM7Tbb/63Vc2tK3VPlS823E7C7v/ZMLL5fRI71scSzDrEJPWlixjK6Uv
 Hwh8dFGSftd5OxMzHhdhZ7QgnCUhvY+q/+6fFjSVDfdYRQ2l3cvFoxxmPh/pKjzj2/CUXCmMCf4
 t01h2bm1zOWaYPqcNG1QcbkujeaIzZ5urnIPANLs7x4rtJ3atmjqBmsdVrtMIPR8jT+MSoWnYlh
 1vHZJeMPKspJrVFDFTUnI0N9CW5yE3ItLGWxYdWQ5g4gnMg1ZadPqj/m4zL3lGZ+mDeUD8cZaC7
 bLE1/1rvg/yhBuLIf/9b9fP2P0eobnoGNccZYVMn7Ca8IGMViNPrd0lV72V9U4mV4blRV2JXAjH
 Q2vFfDlimFZqEizGr9sC+SD368iX6rnr4xv8yXJOKnlr8wcYt20VBySEQfjg4aKu43PgU81/X9v
 guQwQ4r EcbVCq3g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct
nvmet_fc_tgt_queue. Additionally, since the element count member must
be set before accessing the annotated flexible array member, move its
initialization earlier.

Cc: James Smart <james.smart@broadcom.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1 https://lore.kernel.org/all/20231003232511.work.459-kees@kernel.org/
v2
 - move comment to line above (hch)
 - add reviewed-bys
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1ab6601fdd5c..bd59990b5250 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -146,7 +146,8 @@ struct nvmet_fc_tgt_queue {
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
 	struct rcu_head			rcu;
-	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
+	/* array of fcp_iods */
+	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
 } __aligned(sizeof(unsigned long long));
 
 struct nvmet_fc_hostport {
-- 
2.34.1

