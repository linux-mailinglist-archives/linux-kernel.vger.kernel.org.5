Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B27CB26E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbjJPSXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjJPSXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:23:43 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA14E8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:23:41 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-417f872fb94so33985891cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697480620; x=1698085420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=slLQdIKd076Wd/jcmKbWiuJysNgl1PI1tXfrw1I/2ns=;
        b=RFypY+mwC6t9sbo9JHt5O+rjkefCfBzGS49N5fFZj8PUbzoS3S6Aj6MwA2jbzru8lR
         DLNX0alfgU7cg9eQW0ro2+bduCFveSQnesQXwTo6TqNx2LxdyIRvEnQuvijKJNSlQRHk
         y/afqiecl0K5CmfBjUpNmHQSASw0J1+8XluEByDF52F+Ykdi838LVuTgMB8MxwFMzBm0
         NyN8e8PiyeYg+/sZqV+ggJITbWRUDz0zVBlSkSxMImTO8ehOworSAxAN3acOFEhJvr4F
         9o2C/6cnlNKgMW+mpapWsizs39HaygxZL7uZZfsRJAzkJNd4D1Ttyz7Xxp+p98L5oZjA
         xI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480620; x=1698085420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slLQdIKd076Wd/jcmKbWiuJysNgl1PI1tXfrw1I/2ns=;
        b=FIksqEDlsZXr9JQXKDu+FQsISx2ALUIvSGqlhiFqIiDd0177UOPg4ulll67X0O48QO
         goxzt6Y/bMSxr3JGU5hpsmuvjTnFbjUYAPkJkQFKhTudnMzdkfMqODMtIjexjBXCuZkE
         Wz9K/4MSXVQ9DU5dWInBQaj4lxRFlH9fY/sw7HezWRFtUnxUvLdt6c9PPV04EqWuJHVW
         UK5roB4WfFJ5XhiI0/gI7fAlE6UqekwepQ/PX5piJJFURMo5ofE6sugpRjfuR3Nd0ifP
         /ozmgEGJc3gKM76TlVABLHegz8vkLGl3Z2irKQSVpyXCc8ZLiHz/TWfshFQseTVhFEbv
         wjYw==
X-Gm-Message-State: AOJu0YzCUYfAknfCYsZdzn6Sc51zjs3cput6S0/oaC3H3t/OkY9NNscE
        uQ1mNzJch/w0hAHH3AOFPrwhiA==
X-Google-Smtp-Source: AGHT+IE9m6qZCIFd9+yWOJ5ESCvJa4O2jE3aDP2pNfipsaG168iLj05O0ysZ6/OU2HA3fAy3U3Motg==
X-Received: by 2002:ac8:5916:0:b0:418:163b:c5d7 with SMTP id 22-20020ac85916000000b00418163bc5d7mr55277qty.58.1697480620673;
        Mon, 16 Oct 2023 11:23:40 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id kq19-20020ac86193000000b00405502aaf76sm3218093qtb.57.2023.10.16.11.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:23:40 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:23:38 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: [PATCH v2 net-next] ipv6: avoid atomic fragment on GSO packets
Message-ID: <ZS1/qtr0dZJ35VII@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSO packets can contain a trailing segment that is smaller than
gso_size. When examining the dst MTU for such packet, if its gso_size is
too large, then all segments would be fragmented. However, there is a
good chance the trailing segment has smaller actual size than both
gso_size as well as the MTU, which leads to an "atomic fragment". It is
considered harmful in RFC-8021. An Existing report from APNIC also shows
that atomic fragments are more likely to be dropped even it is
equivalent to a no-op [1].

Refactor __ip6_finish_output code to separate GSO and non-GSO packet
processing. It mirrors __ip_finish_output logic now. Add an extra check
in GSO handling to avoid atomic fragments. Lastly, drop dst_allfrag
check, which is no longer true since commit 9d289715eb5c ("ipv6: stop
sending PTB packets for MTU < 1280").

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
Suggested-by: Florian Westphal <fw@strlen.de>
Reported-by: David Wragg <dwragg@cloudflare.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv6/ip6_output.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a471c7e91761..1de6f3c11655 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -162,7 +162,14 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last gso segment might be smaller than actual MTU. Adding
+		 * a fragment header to it would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021)
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
+
 		if (err && ret == 0)
 			ret = err;
 	}
@@ -170,10 +177,19 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 	return ret;
 }
 
+static int ip6_finish_output_gso(struct net *net, struct sock *sk,
+				 struct sk_buff *skb, unsigned int mtu)
+{
+	if (!(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
+	    !skb_gso_validate_network_len(skb, mtu))
+		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+
+	return ip6_finish_output2(net, sk, skb);
+}
+
 static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	unsigned int mtu;
-
 #if defined(CONFIG_NETFILTER) && defined(CONFIG_XFRM)
 	/* Policy lookup after SNAT yielded a new policy */
 	if (skb_dst(skb)->xfrm) {
@@ -183,17 +199,14 @@ static int __ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff
 #endif
 
 	mtu = ip6_skb_dst_mtu(skb);
-	if (skb_is_gso(skb) &&
-	    !(IP6CB(skb)->flags & IP6SKB_FAKEJUMBO) &&
-	    !skb_gso_validate_network_len(skb, mtu))
-		return ip6_finish_output_gso_slowpath_drop(net, sk, skb, mtu);
+	if (skb_is_gso(skb))
+		return ip6_finish_output_gso(net, sk, skb, mtu);
 
-	if ((skb->len > mtu && !skb_is_gso(skb)) ||
-	    dst_allfrag(skb_dst(skb)) ||
+	if (skb->len > mtu ||
 	    (IP6CB(skb)->frag_max_size && skb->len > IP6CB(skb)->frag_max_size))
 		return ip6_fragment(net, sk, skb, ip6_finish_output2);
-	else
-		return ip6_finish_output2(net, sk, skb);
+
+	return ip6_finish_output2(net, sk, skb);
 }
 
 static int ip6_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
-- 
2.30.2

