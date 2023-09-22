Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BED7AB8AE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbjIVR4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjIVRz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:55:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B12114
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c4194f769fso21008755ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405216; x=1696010016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ESOLZsY8LzKb8U8Ne5A0p04ejS/jT09yNraZRlcFPA=;
        b=LVj+3II8JJfFP2xTT0R27ZSmh4Epdt0wDi4mqj/DpI2PK5FYwNcweVpfOBpvzSBDjj
         UzMEhg2mEV4mXKJ5ueDDxfwPb1blfYQHbcM8PdybWlWdwjfFj2IjSl1o78XrPah5irJw
         CA1GFwHXxbBHrr6arE7TT6bYO18q9Jt69uPhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405216; x=1696010016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ESOLZsY8LzKb8U8Ne5A0p04ejS/jT09yNraZRlcFPA=;
        b=n7HRgV8/iqjBSDBAl3SUlq4XOU9X6D77XVqFiqgQg0soHHLlW/F0SCo222J1kz1ogk
         4H0aiK5yifAEMuGEBg/AVQFNe2++BfeedTTNNlLzY7iJX9cA0w91ozy7U/Ugq0zreNyu
         p8kTLgbqjE8DYSehuaFwy1k0SWeZ2c7JyhLJu5KlOlc7XbDzRj1ujAsGcTZfK4JiVKsO
         wb1j7CZxEMD9WOv+kDlltECKTP7jgphL4XRqBuERfP48Y0/QJvqtBrKkF6cADdpY+i0j
         qIqEHHRv1l7CIW0KvHAoe0lXVNwZOvcucK0t8HBXBNp5VIaiROTwuofycNQf45rF2V7U
         RyJA==
X-Gm-Message-State: AOJu0YxFeqmGGbKYYZcTf0G893yysoampPSi9BSQShWGE5ulFs6fkEb0
        vzz9h0mLVVwUthxUwHQxHjLgWA==
X-Google-Smtp-Source: AGHT+IGA6b1K40k8NOZBF7/MYO6Cl8Ivzqv96Q9v0Q5p74UYCloHq1IDltxXKSseH3rgQcC3dxPQiQ==
X-Received: by 2002:a17:902:d502:b0:1c3:1c74:5d0a with SMTP id b2-20020a170902d50200b001c31c745d0amr257725plg.34.1695405216432;
        Fri, 22 Sep 2023 10:53:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709027d8500b001bfd92ec592sm3753380plm.292.2023.09.22.10.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:53:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     Kees Cook <keescook@chromium.org>,
        linux1394-devel@lists.sourceforge.net,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] firewire: Annotate struct fw_node with __counted_by
Date:   Fri, 22 Sep 2023 10:53:35 -0700
Message-Id: <20230922175334.work.335-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=keescook@chromium.org;
 h=from:subject:message-id; bh=9IvQGv8Ld8cTigYPfagXmK/WvkbkZXS8rrCLNOUMCoE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdSehVrabBM4sbb8Z4pDeRCLv7o6lEF00+KVr
 vcvgJtKuoiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UngAKCRCJcvTf3G3A
 JuXlEACFIcVdQ5RlHQbHTtQ9ay043utxenzIISiQP52aJ1w0fcS9QwkUjl+2VobSgaeZFhUOom6
 lna7qmCRDRlUXlUYueUdesqU/mTityiOfmh98rYxQ9tMcwjxBv7IE8OC774oB5lrddTA+gRAxFe
 C+SfcSmcI7TfXTifFKKrxJ+k55lPP8foiB7pEDF7PMdLYFwkNOHdFbQbkjcwnMDCDumGrChUN/y
 +4arvqJVdo5mIiSAZsmTrTVbg1cK29YkvuftCM/ixlCqo3zUKR60DfJETE+hcTM7ltzTz+UOsmR
 XuQnfP58J+tusioqlbfH0OZ4Kgfi5f27RQaH15DIxflDKR/n0OYMY3D3I1mWt0qIiV5TUT+EjWd
 CO/Ek0FD2yBgyk64xjKr5zQjdPq8lxRGpfT70KVDXAVUk6/qhb56XBZbnPFvviBS6kiaJut3Ojk
 yV2JvVclR+1hRNc9Czfd1Lx192tyn0TdkNSz7If/qhmuPoiPy0lo/lmrEk6icN5lYm2dSkM7ZBZ
 OIry3h7lFA3Uj/Xvh0RwrKay5IOCfhcPsvCxCvtib0Yy7qg/R71NGva4LDmd8fTpOCsXpJbpYjU
 ki4IL/FwzdYkGZvMWs7NZfbIwdP2uokgxuLxmpyDH/UJLF5BamS2Lc8JTKxs1r1vR8XOskV11qg
 9r/Fji7 4PHB7dRQ==
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
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct fw_node.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/firewire/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index 2a05f411328f..95c10f3d2282 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -191,7 +191,7 @@ struct fw_node {
 	/* Upper layer specific data. */
 	void *data;
 
-	struct fw_node *ports[];
+	struct fw_node *ports[] __counted_by(port_count);
 };
 
 static inline struct fw_node *fw_node_get(struct fw_node *node)
-- 
2.34.1

