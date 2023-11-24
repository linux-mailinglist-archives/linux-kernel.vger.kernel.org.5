Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579C7F706F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjKXJta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345336AbjKXJtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:49:22 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4775C171D;
        Fri, 24 Nov 2023 01:49:24 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-6d67d32adc2so979968a34.2;
        Fri, 24 Nov 2023 01:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700819363; x=1701424163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsZ2syQkN7b/+BhmaudchsewzHQR6d5b9l8NcgLfGfQ=;
        b=nRL/HmOAtuIt/rMuTXz0XTbu13/axxKQ8RLTkSGXZzj2XJH3tz85pnM8ttBQ8Muowv
         yD4KxQNU3FUBouVoUg0xahyf6aLT+MxVWN33R4p+biOgVXa70HXQwSrCKyIJw0S0ze37
         oXpZ9+GY7sjejw04krs7l0mCL12qKcs4IrUFqH4T3+kXITnAkBKoJ8jnGYs3Z6BzpzkR
         JMz70JaEWAHCKpGV4Xy7wi21L8U4n1GPu2S8L7D/coCuqYMcBQC3jI4ce3FsmHj5LXML
         97hmoUZ3mAjJ8zBJKO0CUCbV0gCq55nysIJIQNu7HpJYSwordSbaPsE1haM9t0WmyvdV
         t2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700819363; x=1701424163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsZ2syQkN7b/+BhmaudchsewzHQR6d5b9l8NcgLfGfQ=;
        b=KM5k6z9meQw+V/CbNtAfpak5FpCBgTWA8HxOUZbsnJ8k2/p5ZU7rXvDzcDui/13RJt
         ll2qFnG2ThCj4bns9ZivNnr7Lx5OOZkdF441BjKH6VWww3eXlBA7VDjcguZ/eqgUYwt8
         NbLuUlJIGlX68iqFzC95PCcHen8iU2SZyrPT4SAScpycqeYLMwYsnjl1epLNc64yjdUl
         U0ovYpVS8zF5FyBmwqYc2WHW4xnV8pa9NNkFayiqKQGcIIbPDB59w96ToNPCiGbgoLFY
         5KGAPvz5p+YWWjeunPQdeLJATZoLTnNrwF8nK2z8QYGtDrlVfqnGW3njCJp6dsB3BpoE
         ianw==
X-Gm-Message-State: AOJu0YzNV1QivbEL05XGl9DQM8nMgkXQQ+g/uDOOwDwiE8YsqREggnv6
        CwXzEhH2z7dFL6mqRbIyOks=
X-Google-Smtp-Source: AGHT+IH7Vd1g372rkLqzXtqjliNavK+tYJSmafG8nHox09dWq9LBGcabBsS8fyADkJkDBwfAcmdiog==
X-Received: by 2002:a9d:735a:0:b0:6bd:ba2c:fbbd with SMTP id l26-20020a9d735a000000b006bdba2cfbbdmr2337284otk.20.1700819363523;
        Fri, 24 Nov 2023 01:49:23 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t22-20020a634616000000b005c215baacc1sm2734242pga.70.2023.11.24.01.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 01:49:22 -0800 (PST)
From:   xu <xu.xin.sc@gmail.com>
X-Google-Original-From: xu <xu.xin16@zte.com.cn>
To:     tung.q.nguyen@dektech.com.au
Cc:     davem@davemloft.net, jmaloy@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn,
        ying.xue@windriver.com, zhang.yunkai@zte.com.cn
Subject: RE: [RFC PATCH] net/tipc: reduce tipc_node lock holding time in tipc_rcv
Date:   Fri, 24 Nov 2023 09:49:19 +0000
Message-Id: <20231124094919.2043838-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <DB9PR05MB9078FE84F8244C627FDCFA2888B8A@DB9PR05MB9078.eurprd05.prod.outlook.com>
References: <DB9PR05MB9078FE84F8244C627FDCFA2888B8A@DB9PR05MB9078.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>Could we please solve the problem mentioned above by adding spinlock(&le->lock)?
>>
>
>No, you cannot do that. As I said before, the link status (including l->state) needs to be protected by node lock.

Why can't use le->lock instead of node's lock to protect it in tipc_link_rcv.

>What I showed you were just 2 use cases (link reset/delete). There are more use cases (netlink, transmit path etc) that need proper locks.

The same. We can also add spin_lock_bh(&le->lock) to protect the link in other places where it changes the
link status in addition to 'reset/delete'. Because using node lock to protect the link in tipc_link_rcv is
really wasting CPU performance.

>
>>For example:
>>
>>(BTW, I have tested it, with this change, enabling RPS based on tipc port can improve 25% of general throughput)
>>
>>diff --git a/net/tipc/node.c b/net/tipc/node.c index 3105abe97bb9..470c272d798e 100644
>>--- a/net/tipc/node.c
>>+++ b/net/tipc/node.c
>>@@ -1079,12 +1079,16 @@ static void tipc_node_link_down(struct tipc_node *n, int bearer_id, bool delete)
>>                __tipc_node_link_down(n, &bearer_id, &xmitq, &maddr);
>>        } else {
>>                /* Defuse pending tipc_node_link_up() */
>>+               spin_lock_bh(&le->lock);
>>                tipc_link_reset(l);
>>+               spin_unlock_bh(&le->lock);
>>                tipc_link_fsm_evt(l, LINK_RESET_EVT);
>>        }
>>        if (delete) {
>>+               spin_lock_bh(&le->lock);
>>                kfree(l);
>>                le->link = NULL;
>>+               spin_unlock_bh(&le->lock);
>>                n->link_cnt--;
>>        }
>>        trace_tipc_node_link_down(n, true, "node link down or deleted!"); @@ -2154,14 +2158,15 @@ void tipc_rcv(struct net *net,
>>struct sk_buff *skb, struct tipc_bearer *b)
>>        /* Receive packet directly if conditions permit */
>>        tipc_node_read_lock(n);
>>        if (likely((n->state == SELF_UP_PEER_UP) && (usr != TUNNEL_PROTOCOL))) {
>>+               tipc_node_read_unlock(n);
>>                spin_lock_bh(&le->lock);
>>                if (le->link) {
>>                        rc = tipc_link_rcv(le->link, skb, &xmitq);
>>                        skb = NULL;
>>                }
>>                spin_unlock_bh(&le->lock);
>>-       }
>>-       tipc_node_read_unlock(n);
>>+       } else
>>+               tipc_node_read_unlock(n);
>>
>>        /* Check/update node state before receiving */
>>        if (unlikely(skb)) {
>>@@ -2169,12 +2174,13 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
>>                        goto out_node_put;
>>                tipc_node_write_lock(n);
>>                if (tipc_node_check_state(n, skb, bearer_id, &xmitq)) {
>>+                       tipc_node_write_unlock(n);
>>                        if (le->link) {
>>                                rc = tipc_link_rcv(le->link, skb, &xmitq);
>>                                skb = NULL;
>>                        }
>>-               }
>>-               tipc_node_write_unlock(n);
>>+               } else
>>+                       tipc_node_write_unlock(n);
>>        }
>>
>>        if (unlikely(rc & TIPC_LINK_UP_EVT))

