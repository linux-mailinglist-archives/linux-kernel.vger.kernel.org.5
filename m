Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624107B74A9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjJCXS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232636AbjJCXS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:18:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D12C4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:18:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690f7d73a3aso1179388b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 16:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696375103; x=1696979903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XM09kEc8Kp8BRYEzLwAFk6cBdvMXUL/+IkaIgbusPU=;
        b=DgV33KWRjRyaG4hdlHqFwxcF+xsTY7MMOrQ8lp+fjpgkLw6S7tyTwNeXvDKeTuXC+q
         dDKHZN530ZZrgOxJ1IzrxdaZNyPgHY39l9hYVEpz14lyZ8O22vHvntA3g1TiC89UlV7l
         Mtzpm9+vXgIyrQpHe5yzxDmIzJ+ftDUXc857o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696375103; x=1696979903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XM09kEc8Kp8BRYEzLwAFk6cBdvMXUL/+IkaIgbusPU=;
        b=m0UWSzhphY1YycbGiy/SA3AzhpUQ1LUHhn0UNbvqXAsegbl7zDt4lMsGZaHZO1w/6Q
         4eR7OOWod0t0neFvccCFXwGUWx+MRQMNGmjlcGfA66wsnOdxKobtkrx6Z2ErYEGbh7MV
         slOS13yTGhgvqEo3sUlFXm3YK8ABT9y2OF6YZ4ov1bS+nkT+lZ4jtSJF90jwUzSsyXjf
         BecgJa22m+GVu+LnFbU7OlTRi87oegLbi0WrzvK6GH/0GELEu3lpUqjFqqOHLAhERjaX
         4+pzb7p66RVG4pkKzxi0AYaSzNSNBrgcVsNdCQuI3OHxq0zmolgmI3RpW1H9eilKxtmG
         eAhg==
X-Gm-Message-State: AOJu0YxEz30JlY+rQ/5hjdj9qN24WsPAWkOaFhRGIwD7+Rkvu4W78TqK
        fIBflK3ngaeWpWEVxc3ou7Jzfg==
X-Google-Smtp-Source: AGHT+IEwKOi2g91/6+3PVOksMMOBXjtZ6RUc8kcIOjZ3+jcu3YOHO3VrVuRhXQygmft0K82aoguc4g==
X-Received: by 2002:a05:6300:8001:b0:153:5832:b31b with SMTP id an1-20020a056300800100b001535832b31bmr692118pzc.53.1696375102984;
        Tue, 03 Oct 2023 16:18:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c23-20020a62e817000000b006933c582ed8sm1897059pfi.20.2023.10.03.16.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:18:22 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     David Ahern <dsahern@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, netdev@vger.kernel.org,
        llvm@lists.linux.dev,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] nexthop: Annotate struct nh_notifier_res_table_info with __counted_by
Date:   Tue,  3 Oct 2023 16:18:18 -0700
Message-Id: <20231003231818.work.883-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AjwLE9p8WGopinEsMtaz3ddOS1mI0qnJXpq5C0mCIUo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlHKE6FRvS+TBAwxc+K9caUt8f5xq1QuruutNKl
 6rvdNKdQguJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRyhOgAKCRCJcvTf3G3A
 Jo+FEACDuxBwqD2j1hWN5SQMxl3AwTJawunug8XKcPvJfIFp/RTGo5A8ClW1vELUc4+BpLeROLv
 H119H972/sNz7cDkp2Nlo60Yk9V4jEhyU5mUpqiXjhUR8nnTZPJijFiH/wkyilrzoR+laOjaIX+
 y5iEpgcZYGU04GWtAJDfObUCyEqkPhKfXtQQNri4Lm5pwvaKoAxprAufBtOY+xfselLRdr3M9K2
 8rJ+IBolsSlAXKH1DftdiFSBjG9EmwKydkha47kSrOeMG4EMTWOfNlOj+YdBWoOvgg6r6B6hobI
 II7hEMTRvU5zBkb9jMAiE1MUR41bJFcMSSWInv3uIPQGQImd+PM2F+16cpUGdVWqMi/zY4MWl4d
 ZkNf3hGG2jsfcjW260crWJ3B3c/f7ik61m2RqIvv9gTXKwwzriycjijPvJ56VWzAkBjzHYz1Equ
 4BzfYYzNpowHL2EVmsFWkwOLFOkg6f0OvU671kIkH7nJollSOeArKap+mtlpo2ZtSiR6nKgq2MM
 KCXt4zv+CZYnTmDaL6RXHJwY6D+HQRHjxXm/4W7pJviek1bH2cFpF90D3HVYkkFbds1nHi0mTyX
 8f4hhCx3uO86L40eqe8XCihbEkXxUIKOk4u136dDDUmMByv6kH2SP/Ns/K9u/bhM7VW0tdp5jvj
 UIdLPZZ 1WOpGYgQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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
nh_notifier_res_table_info.

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Tom Rix <trix@redhat.com>
Cc: netdev@vger.kernel.org
Cc: llvm@lists.linux.dev
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/nexthop.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 09f9a732e640..8f5a2ab45920 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -200,7 +200,7 @@ struct nh_notifier_res_bucket_info {
 
 struct nh_notifier_res_table_info {
 	u16 num_nh_buckets;
-	struct nh_notifier_single_info nhs[];
+	struct nh_notifier_single_info nhs[] __counted_by(num_nh_buckets);
 };
 
 struct nh_notifier_info {
-- 
2.34.1

