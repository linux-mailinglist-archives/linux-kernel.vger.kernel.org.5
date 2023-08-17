Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D06377FF9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355205AbjHQVPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355196AbjHQVPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B16358E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:33 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bdb801c667so2210315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306933; x=1692911733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8UofhjPFvRG631Ccgv2qHcV06RmLtv8X8B/5+W9lIA8=;
        b=TlEkdA0aHIpDhWACKGHLrkm5y9e4OB90g6PTzJ1l+cbGyrClX3h4fGqMnA+W3GTIHy
         lP+KdB7wLx+G2GYF76W564NATtk5HWp+4Rx8DoU5rzUBnYjtV1BE+7EJ2YTSjwpgYMph
         +5OXcqEe8DeO2ald44h2rUXsRTA4LQAQWdiso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306933; x=1692911733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8UofhjPFvRG631Ccgv2qHcV06RmLtv8X8B/5+W9lIA8=;
        b=hEW3wkuhZxo+/C1F9pFGggP+7X62i+0wK6Lv6e0QSJUss8aExZaIyQqQxROA/ZdReN
         ZpqFuO97BqsVWrSmE9FBbCpYNDHTZXIGInWHbv/C0tf23wT1OQRBs0+D2aoU6SD2NbY7
         dwe2p58SM+NrCYeCXiwMDU+3eC8KqvTehIEbPxRO5pz8Rh24sBlouIEIbqATbOev2caQ
         EIRaHTCc4645rMf9hs0L5SgRT99ZkmZasw77ZLxiVQuYBLRUkH2fwDrUzUICbOA3vm4b
         07eVoylO+25yksnI+Z9sRLyGluA/2OkmulVU4mCOlCAjQQzNVsJLWsSl7LvnB9j+dcDV
         3Lyw==
X-Gm-Message-State: AOJu0YxPuhKdQbxFzWrk1zUJXiCX61Lmqm5ci8XqHqMW2f0vg2SJrE8O
        MLpMHURjlMqCTgkd7WazhF6xmg==
X-Google-Smtp-Source: AGHT+IFBZSHNzPvyZlBzEtJLJA9BTz4aD5fj9A34rHRZOf7eSuRvseMrGYRyhAolhTW3rZ+WlLEk7w==
X-Received: by 2002:a17:902:bd45:b0:1bb:cf4e:ccd with SMTP id b5-20020a170902bd4500b001bbcf4e0ccdmr659710plx.28.1692306932698;
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x17-20020a170902ec9100b001bf35144a18sm110378plg.221.2023.08.17.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 1/7] wifi: cfg80211: Annotate struct cfg80211_acl_data with __counted_by
Date:   Thu, 17 Aug 2023 14:15:23 -0700
Message-Id: <20230817211531.4193219-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104; i=keescook@chromium.org;
 h=from:subject; bh=HsEe1uS2p7u7BP7jBH38t6GAsv3eC9u8U8u9k4LTzrU=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3xUjzj9KXDcTFQvsN8IUNrW4GzDUUcLTOTR
 F6R3fE9BVaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JnzYD/0Z4jrC3Qoel0vy3g8ZrUKOYnJtNXSA5nwtWIj/WJ95o2nAw5Wff1y7uP0tXHAQ5QzlFeK
 20SmedYHn+kj1uvTJ9++OVMMtOrTDd6LcBKdByskoSipgJo+bpwPNcNsiMVC3vMU8SlQ1U3dPOZ
 BRpQyecFwffX+Su5Ma7m86dMjcI6/nXrm5EIm0fZAyPYhyEG1zyT/J/eAgbL0YKVISQNO9ibybT
 Eklf8pHUlVduSjjwLcmiZfLYsrv1PHzybiHx9wQO0XEoVXCO8Gxt4Q7ZD7mOcrkKjkG4hOtyDi5
 wkLn3BSk6LLpTrX9MX4TkhPLtZPKl+tdHSvxrvcjN1GzrJRAcMrClNRfjaR6Ay2JfQ6Xn7UC4vp
 DCygVQsJkaeGeQ1r7fFH6M0xfeORZqtRnmaBxSDI6q0RXDVdu5xv7BQ714R0gsNkcXh9vS8Wko1
 5I9TUIDwHmobFmBmY0mw0GxI8Ni9en3PAjKZ7OroncsXcBRzTcC+sryyIONTsRjY2gIfV+bqgjv
 O8VqOlRAFVmMs0qXGLRaVWEo1Lcv2fmD0MqqjHoOFSpfO6/OYGLTKLSqfC26N8w2zi8U0KRcmLP
 wgh+mcdIpLnFW1fg6WtwoCbOuvmLYIMlmN381VG18LaUKFGiYEwo7gdcx2Rh2edzb2NaZ6p7LSZ tvcl7/UTEgnKl2Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct cfg80211_acl_data.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/nl80211.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d6fa7c8767ad..eb73b5af5d04 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1282,7 +1282,7 @@ struct cfg80211_acl_data {
 	int n_acl_entries;
 
 	/* Keep it last */
-	struct mac_address mac_addrs[];
+	struct mac_address mac_addrs[] __counted_by(n_acl_entries);
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8bcf8e293308..80633e815311 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4889,13 +4889,12 @@ static struct cfg80211_acl_data *parse_acl_data(struct wiphy *wiphy,
 	acl = kzalloc(struct_size(acl, mac_addrs, n_entries), GFP_KERNEL);
 	if (!acl)
 		return ERR_PTR(-ENOMEM);
+	acl->n_acl_entries = n_entries;
 
 	nla_for_each_nested(attr, info->attrs[NL80211_ATTR_MAC_ADDRS], tmp) {
 		memcpy(acl->mac_addrs[i].addr, nla_data(attr), ETH_ALEN);
 		i++;
 	}
-
-	acl->n_acl_entries = n_entries;
 	acl->acl_policy = acl_policy;
 
 	return acl;
-- 
2.34.1

