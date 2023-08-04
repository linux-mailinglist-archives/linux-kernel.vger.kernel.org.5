Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1B777025A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjHDNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHDNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:55:54 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E51990;
        Fri,  4 Aug 2023 06:55:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E9CE5C0140;
        Fri,  4 Aug 2023 09:24:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 04 Aug 2023 09:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691155453; x=1691241853; bh=pJgUfuzwp2Plw
        j/vIlzlhZLLY3But/roBXSqjo4nu/c=; b=1KtCmIz6+wCPyTbyMCiknH/MxS6Tp
        1MqI3ACSZkoIQYejSLXXjmn2piqvZzK67qAi/DM9qLPq/Wr1vZl+Js8aN0082e7+
        fhCdqW6wV7cIcGSdWihNAz/ZZvgtvSi5o30G9d47wMjHfqN0KSq0fnb+eG9omvIS
        4S9vduEUbnHb0aH+zhJem6arkmNOJbfTqR9en5ce70uHjMhk8VsDhzoFrRY2swUf
        STNSAluJGUu6eUnS+aTblWE5ESxsXbjUeZkrARVapRBJV3HmTWkqKuHOgWEMXdSV
        WOJ9oLSKA6QjTnQJWh1hL/ld+OodUx3TUN8op6cjhuc8HuMHaBy/GmBhw==
X-ME-Sender: <xms:_PvMZKysGiyXN0tJxC_5GZvEztQDNwD0Oqs9gYYriwTke3UOaW2P5A>
    <xme:_PvMZGQpBF0nnwXFECqDb_4iq5p06g210OdpB_3R4fszMOkd6jYNRaIPgdQubpajs
    N4zEQ4e_dTOTdM>
X-ME-Received: <xmr:_PvMZMXPhS_39KEi4UnBMO4gSgGX0tXPpl0uyjLP9a-K4E1oOtkuFrLBMreeGDRS5_DObdZFHX4az8gYpcfE76aQsGP-sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvteehheeiieekjeffudekhfdthfevudettdelgeehveegteeflefhvdehieeg
    jeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhlihhnuhigthgvshhtihhnghdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehi
    ughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:_PvMZAjhIxkuv5x6bR_Mi1Ng8r1H5BBpHXMN87BABaCgIWX64oNV8A>
    <xmx:_PvMZMDEF5B6Bv1ht3LqRIUB1SERNZB4GSZQJ9mEL1iysg-eyeF59g>
    <xmx:_PvMZBLiyRYJPWDqNlP31sMR1xGozjZK8uleMU4i4K7V0h7pAA3XbA>
    <xmx:_fvMZI0zjFlKtKPPQuXsnC9a9epchcjdRx1xC_Ct5GQIyIgzG1emiQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Aug 2023 09:24:11 -0400 (EDT)
Date:   Fri, 4 Aug 2023 16:24:08 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Roopa Prabhu <roopa@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] drivers: vxlan: vnifilter: free percpu vni stats on
 error path
Message-ID: <ZMz7+Mk+OYj4q8xe@shredder>
References: <20230803193834.23340-1-pchelkin@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803193834.23340-1-pchelkin@ispras.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefix should be "PATCH net". See:
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

On Thu, Aug 03, 2023 at 10:38:32PM +0300, Fedor Pchelkin wrote:
> In case rhashtable_lookup_insert_fast() fails inside vxlan_vni_add(), the
> allocated percpu vni stats are not freed on the error path.
> 
> Free them on the rhashtable_lookup_insert_fast() error path in
> vxlan_vni_add().
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 4095e0e1328a ("drivers: vxlan: vnifilter: per vni stats")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  drivers/net/vxlan/vxlan_vnifilter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
> index a3de081cda5e..321cd0b450cc 100644
> --- a/drivers/net/vxlan/vxlan_vnifilter.c
> +++ b/drivers/net/vxlan/vxlan_vnifilter.c
> @@ -740,6 +740,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
>  					    &vninode->vnode,
>  					    vxlan_vni_rht_params);
>  	if (err) {
> +		free_percpu(vninode->stats);

This oversight (and future ones) wouldn't have happened if
vxlan_vni_alloc() had a corresponding vxlan_vni_free(). I suggest
something like [1].

BTW, I think the GFP_ATOMIC in vxlan_vni_alloc() should be GFP_KERNEL. I
will take care of it in net-next.

>  		kfree(vninode);
>  		return err;
>  	}
> -- 
> 2.41.0

[1]
diff --git a/drivers/net/vxlan/vxlan_vnifilter.c b/drivers/net/vxlan/vxlan_vnifilter.c
index a3de081cda5e..c3ff30ab782e 100644
--- a/drivers/net/vxlan/vxlan_vnifilter.c
+++ b/drivers/net/vxlan/vxlan_vnifilter.c
@@ -713,6 +713,12 @@ static struct vxlan_vni_node *vxlan_vni_alloc(struct vxlan_dev *vxlan,
        return vninode;
 }
 
+static void vxlan_vni_free(struct vxlan_vni_node *vninode)
+{
+       free_percpu(vninode->stats);
+       kfree(vninode);
+}
+
 static int vxlan_vni_add(struct vxlan_dev *vxlan,
                         struct vxlan_vni_group *vg,
                         u32 vni, union vxlan_addr *group,
@@ -740,7 +746,7 @@ static int vxlan_vni_add(struct vxlan_dev *vxlan,
                                            &vninode->vnode,
                                            vxlan_vni_rht_params);
        if (err) {
-               kfree(vninode);
+               vxlan_vni_free(vninode);
                return err;
        }
 
@@ -763,8 +769,7 @@ static void vxlan_vni_node_rcu_free(struct rcu_head *rcu)
        struct vxlan_vni_node *v;
 
        v = container_of(rcu, struct vxlan_vni_node, rcu);
-       free_percpu(v->stats);
-       kfree(v);
+       vxlan_vni_free(v);
 }
 
 static int vxlan_vni_del(struct vxlan_dev *vxlan,
