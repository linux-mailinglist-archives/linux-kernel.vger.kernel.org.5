Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A0775013
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjHIBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjHIBHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:07:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84487FB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 18:07:40 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5896bdb0b18so8658607b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 18:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691543260; x=1692148060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+tC2OHCgG5XmqiAIey5dLzPjagreIQB12mmbHFSSNo=;
        b=5JRTgmSsbAoRmHzig2ooFuZzDECsMi9JEIoaVYPweJLMD0+XXzlzcJt8H9fsFmsAnJ
         EfCDpuZIUrACTWFeTO+popab/TH0zhMmxgdHI4aqx4VnIEK2ZhCooYIl4kN1hxgYWMC+
         9TX6rmB6YqfYm7DH+iukazZ2O6DXiOG8t2n7/TTdMW2Oa9DNustLZ9yg9+pn50Xahhia
         BbbZZ3Iq4rcAOk1eHuS0ec2RaoJ/1v/BBVcqa1F6TLNvETcA5Z8gJ0JjVwcuaDVBVdbP
         IQczCbssQ/4eAtUSD4VeHNVc1qBo6gUNo//DbTKx490J4SVtBHv+kn3Rw5kbhdebliTv
         2sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691543260; x=1692148060;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+tC2OHCgG5XmqiAIey5dLzPjagreIQB12mmbHFSSNo=;
        b=DYtQVadsWcrkPhsdVYIQRs5Yi0IIx6AQoFiD1MNAkPxWezpqluCr2nWfrxyEqdXErx
         rtwaRMpHlJaZuLhlVkWms06+N+xk/FX8UM5cDpIZMsWM+AGvzhinjZ1Njenc3+eS8p0R
         4DfCdGY0onRR9jyiMCSXkzr3xkjLRIQwcz96MQ7nv0MGZcz1Agp2upYX9ijlvGZ2eQvg
         g31qFowhj+s8zRIwlIb+7kuf9CzlT0bNQHxR4rxL6yz53Ilf4uQ3VSVk1nmcwvegmzoI
         IEOXNr02hM2uam9KnzhY46peDm5hV3Pbg8ICsc0rI1fzg4EVzlAuxUfRFzz4ugPgQjwH
         g5YQ==
X-Gm-Message-State: AOJu0YzdKgAW0PSNETQWfphif6doeDLES8agOArBeW/TlDsN0FWVrBWV
        oIokHEmszKTgivb2od0dTYHneyf/T41dKHyvLw==
X-Google-Smtp-Source: AGHT+IHAHKKVxRaQwri5bImA5eCYOor7HhEmOhhPwntu/m2m67iUQqef+GnQosGvVJ+pwZt7bjuL38qZzTJAEgCL9Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:690c:3512:b0:57a:6019:62aa with
 SMTP id fq18-20020a05690c351200b0057a601962aamr192719ywb.5.1691543259866;
 Tue, 08 Aug 2023 18:07:39 -0700 (PDT)
Date:   Wed, 09 Aug 2023 01:06:04 +0000
In-Reply-To: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
Mime-Version: 1.0
References: <20230809-net-netfilter-v2-0-5847d707ec0a@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691543257; l=1642;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=9CkxZqRZItVdJRKZDRTDHxT2lccsnPMJcsOENM5+Qdc=; b=85tSDIm6bOF0lYA+JmVaeoX1tIRMiVSHTcgdhXNIXdzyciIDHIFVMzodOJMDLgH46wLpyVO/h
 DVLt9rM2ys1DroSaqJdpej95V5f3jE3hmrIH2ifRXpzmpU3fsAWCaNc
X-Mailer: b4 0.12.3
Message-ID: <20230809-net-netfilter-v2-1-5847d707ec0a@google.com>
Subject: [PATCH v2 1/7] netfilter: ipset: refactor deprecated strncpy
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
        SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use `strscpy_pad` instead of `strncpy`.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 net/netfilter/ipset/ip_set_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 0b68e2e2824e..e564b5174261 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -872,7 +872,7 @@ ip_set_name_byindex(struct net *net, ip_set_id_t index, char *name)
 	BUG_ON(!set);
 
 	read_lock_bh(&ip_set_ref_lock);
-	strncpy(name, set->name, IPSET_MAXNAMELEN);
+	strscpy_pad(name, set->name, IPSET_MAXNAMELEN);
 	read_unlock_bh(&ip_set_ref_lock);
 }
 EXPORT_SYMBOL_GPL(ip_set_name_byindex);
@@ -1326,7 +1326,7 @@ static int ip_set_rename(struct sk_buff *skb, const struct nfnl_info *info,
 			goto out;
 		}
 	}
-	strncpy(set->name, name2, IPSET_MAXNAMELEN);
+	strscpy_pad(set->name, name2, IPSET_MAXNAMELEN);
 
 out:
 	write_unlock_bh(&ip_set_ref_lock);
@@ -1380,9 +1380,9 @@ static int ip_set_swap(struct sk_buff *skb, const struct nfnl_info *info,
 		return -EBUSY;
 	}
 
-	strncpy(from_name, from->name, IPSET_MAXNAMELEN);
-	strncpy(from->name, to->name, IPSET_MAXNAMELEN);
-	strncpy(to->name, from_name, IPSET_MAXNAMELEN);
+	strscpy_pad(from_name, from->name, IPSET_MAXNAMELEN);
+	strscpy_pad(from->name, to->name, IPSET_MAXNAMELEN);
+	strscpy_pad(to->name, from_name, IPSET_MAXNAMELEN);
 
 	swap(from->ref, to->ref);
 	ip_set(inst, from_id) = to;

-- 
2.41.0.640.ga95def55d0-goog

