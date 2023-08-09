Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B523775018
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjHIBHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjHIBHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5881BCD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-583312344e7so79128447b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543263; x=1692148063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6nqOI6OhZk9uVMuCMDveLdue/VtxmtzrsTXPIDYRI=;
        b=ZoQqX5UIeq1jO5/Y5J5W2a7PzzXsb8d0S2K9nNc0sxvuHfEUau2nSLFvWWx5TabJYG
         9AjCKoQscaQ3FibFIL636z6Qkx9MWiHi+jZzcS09eay2ZGG8ou0eqWAgykq7xE935CdT
         Y/BBWwHMbzudYeSVdUcGcDGZAbpW2ULHrvSazCEcoWFyxdgAZRZLgJVtM3QvN5w995cD
         4gKNjSaX2/YVLXjoYMhH6jmDrKOeTQd47uGISSSDdR/wLa+Fr8lRe9HTNHcg+y0+ZlpS
         kC53/iPBs+RI23nXLKLuKb3pyVovbV5P1iJTe8dt2Rr+HJB4qllUtIoJ/lAhndvVoFC4
         KPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543263; x=1692148063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib6nqOI6OhZk9uVMuCMDveLdue/VtxmtzrsTXPIDYRI=;
        b=UbfkbQRWG5Dl81zQc8TJmWBVXNurTHDNKH6PbkEvpKf8cL8AdLnatUMWRI1sQ8HA9v
         bPrDoBwL9QM5RR135skIQxEySGYmfE+VNXNI3I2XV1eJVSNRIX1ZH4/tD8I0YsP4ugq3
         NgAX0SWGdBAn9jlB9wlzOi2DII4l8JXEXTIWlWWyQU94vdMOaCt8tfdpEaz324zUXtAC
         Zh0hPXRgWP5C4yqbCvmJTBm3YwLiL3uBa0mG7oBnkl1HvlzF0lCq8ojE5LeKqVLLMHMB
         Rma15h57vjzBSR0AfKsQVf9QPUAxS8EDe5qWYNOVC1Esw9IrAXidT63KVpP5dPvbI3z1
         p49Q==
X-Gm-Message-State: AOJu0YwOSuiv0uOgEnO3O6E8e0uimNQdBCwwdoROiEeLkvhqKjjS8LKO
        RafMbirg90fLXsacUVHIc8IuUCXk7LwuCYPQqg==
X-Google-Smtp-Source: AGHT+IH5kjZOtu7DJJU2kcy5MUvh/1RM5TDPejbuQtilClG6fsAJ6QcOKvf1F+QzpdoZcY4Uz8jB2YjF0tOQbZPbdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:ab62:0:b0:d4c:f456:d54f with SMTP
 id u89-20020a25ab62000000b00d4cf456d54fmr22714ybi.8.1691543263329; Tue, 08
 Aug 2023 18:07:43 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:07 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543258; l=1342;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=7ETYnKTeQUVzYvHKo3dCw3Fgg8Ju8JACIFGAct1WkOg=; b=vu0OZUT90qel7Bct4/ripVcEolXMpugmp7bRnKPUqOl8EyTjsFcrN5q5j/s4LBuhdPWIHYjOi
 wh7kSdYgds5BsJcyjEsLKuA3/gws5T6+wjRr5B/LR0IzcPd3PBc/Kf/
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-4-5847d707ec0a@google.com>
Subject: [PATCH v2 4/7] netfilter: nft_meta: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer `strscpy_pad` to `strncpy`.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/nft_meta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 8fdc7318c03c..f7da7c43333b 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -185,12 +185,12 @@ static noinline bool nft_meta_get_eval_kind(enum nft_meta_keys key,
 	case NFT_META_IIFKIND:
 		if (!in || !in->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy_pad((char *)dest, in->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	case NFT_META_OIFKIND:
 		if (!out || !out->rtnl_link_ops)
 			return false;
-		strncpy((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
+		strscpy_pad((char *)dest, out->rtnl_link_ops->kind, IFNAMSIZ);
 		break;
 	default:
 		return false;
@@ -206,7 +206,7 @@ static void nft_meta_store_ifindex(u32 *dest, const struct net_device *dev)
 
 static void nft_meta_store_ifname(u32 *dest, const struct net_device *dev)
 {
-	strncpy((char *)dest, dev ? dev->name : "", IFNAMSIZ);
+	strscpy_pad((char *)dest, dev ? dev->name : "", IFNAMSIZ);
 }
 
 static bool nft_meta_store_iftype(u32 *dest, const struct net_device *dev)

-- 
2.41.0.640.ga95def55d0-goog

