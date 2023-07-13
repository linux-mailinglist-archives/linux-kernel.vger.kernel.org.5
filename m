Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7407527AF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbjGMPt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjGMPtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:49:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434B1BEB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:49:23 -0700 (PDT)
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 30FA13F722
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689263360;
        bh=n3uwF+PhF/LCrAwLUh31M26n0RcXjtVO0HNToCDrTPg=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=APQ809otVSI3WX3X+yq+09SXpH9zTgAC4anQ+E6yL3TMcwWaHV+JdsF/etyrCyzHk
         4u4suupfXVbwFoUTxp2fuX+jnY/sjHeIpP+HcC3SxFzUD2B23DjKvZYpJfHo9CY/0u
         GYTFqicG1XuDAK8IMtTlpZ2FteF+vEi2UYNci+qhUN7yoPtsB2z0iT5JW2NT0/vs1/
         AkvZR54KzQ/4/7JLCOZGbatmNDVSBkio5snNtsRjGRnwwCN6pVPYwlkYzdObUCujlJ
         InDHqE4XTqJDWphIfnLOrglpeiu4lt99rc7hsBa0qJbfjwu51/EtDTE6gRgsCVTFD9
         tw9Teg+uNOi8w==
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55bf1eabe34so475528a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689263356; x=1691855356;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3uwF+PhF/LCrAwLUh31M26n0RcXjtVO0HNToCDrTPg=;
        b=W1nn2i//YaMoUGPzgkKeAsDJrvk8VUsLpJPcpecsgnbgWi17VL3L9Hs3qrryk5NZYN
         VNB2BBYZGqwtxxOFFibAG+u5U22L/G3ZCSTXnX1rIIPl7GgJg+p+QevUhrS6VMpiD/93
         DV2a/DbN0Eh9Bv+wUK5UVe1dr/d3eBmw/dP2pSyAur+iG8KxYWyBN/rpyl3b4YH5mFkE
         X2I/wn1kj+0jqzGOG8ArLGTeM/KQgLDxY0mgUlMTiliJC2aj5PPImhNXIUYd5EUv75wv
         khVzIGuIm3hhuQFUpx571YlkRnGC1h/NNdZXXQwnyVqe8sb6bVYFiLIB+DiRVwzTKIiD
         76BQ==
X-Gm-Message-State: ABy/qLZNwmeUGa4LQcF4NKjkTOtKAufPNHn7ir75M0oE0AbsNelDmHJw
        WDWO4v57l095NqEfw2QmPHK4hhJU+m7/Cq2/mRDpSifms9qGMev7wA70YxsEbIiv/fept9dIXyD
        A28L4d1SoYfbs9kX+0tTwi75sF1CHlatHjgLIdba5wQ==
X-Received: by 2002:a05:6a20:4421:b0:131:dd92:4805 with SMTP id ce33-20020a056a20442100b00131dd924805mr1723888pzb.57.1689263356359;
        Thu, 13 Jul 2023 08:49:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHekTUfrweh/EaRRcrm+KOYQucCEEY8g7tbjF9pWZHmVZklspjSNv/1FrXl4lZg9vwDv9ClSQ==
X-Received: by 2002:a05:6a20:4421:b0:131:dd92:4805 with SMTP id ce33-20020a056a20442100b00131dd924805mr1723861pzb.57.1689263356000;
        Thu, 13 Jul 2023 08:49:16 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b00682b15d509csm5550440pfn.194.2023.07.13.08.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id 3100E5FEAC; Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id 29F6D9FABB;
        Thu, 13 Jul 2023 08:49:15 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Wang Ming <machel@vivo.com>
cc:     Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yufeng Mo <moyufeng@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: [PATCH net v1] net:bonding:Fix error checking for debugfs_create_dir()
In-reply-to: <20230713033607.12804-1-machel@vivo.com>
References: <20230713033607.12804-1-machel@vivo.com>
Comments: In-reply-to Wang Ming <machel@vivo.com>
   message dated "Thu, 13 Jul 2023 11:35:54 +0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24869.1689263355.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 13 Jul 2023 08:49:15 -0700
Message-ID: <24870.1689263355@famine>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Ming <machel@vivo.com> wrote:

>The debugfs_create_dir() function returns error pointers,
>it never returns NULL. Most incorrect error checks were fixed,
>but the one in bond_create_debugfs() was forgotten.
>
>Fix the remaining error check.
>
>Signed-off-by: Wang Ming <machel@vivo.com>

	Seems fine to me; note that almost nobody uses this as bonding
debugfs is hidden behind !CONFIG_NET_NS.

Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>

	-J

>Fixes: 52333512701b ("net: bonding: remove unnecessary braces")
>---
> drivers/net/bonding/bond_debugfs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bon=
d_debugfs.c
>index 594094526648..d4a82f276e87 100644
>--- a/drivers/net/bonding/bond_debugfs.c
>+++ b/drivers/net/bonding/bond_debugfs.c
>@@ -88,7 +88,7 @@ void bond_create_debugfs(void)
> {
> 	bonding_debug_root =3D debugfs_create_dir("bonding", NULL);
> =

>-	if (!bonding_debug_root)
>+	if (IS_ERR(bonding_debug_root))
> 		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
> }
> =

>-- =

>2.25.1
>
>
