Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A97624F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjGYV4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGYV4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:56:03 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8A1FE6;
        Tue, 25 Jul 2023 14:56:02 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4814bea10e0so2241347e0c.1;
        Tue, 25 Jul 2023 14:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690322161; x=1690926961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=volTAAeL8fKmMhSVDeFyV0ZoI3X0kFdQ4vEkodcC4os=;
        b=aPfoBPRnQhWQ2T9EzFVNum8zlrhaNbwkP4cUQoofLJYJ24jlKvcUpTEGPl73BvsB9w
         +/wHawbHaVoRAqXAkoe+e7N66jWegqcpCGhGHfNmjbJLP7kegofOmRNSFuKPzLv1r5zS
         7asIYDgODM0udnr1i6GkFY4SunbJDIb2EL2RmnMMnOPrnyRBdtL5orw+SndgAY665wbk
         UKCVx5iZgohjHdehGk6plJKSDdRd7V0qKw/RrGfrbF66UvUWtU5BhVr3YRy0peF/wO5Z
         aeo1JOB8VDhT3z56HaSBfIdX0lczj2PXON82KA8ywR6WaNv0kZLT3OZJK9Tukqwz81oP
         aL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690322161; x=1690926961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=volTAAeL8fKmMhSVDeFyV0ZoI3X0kFdQ4vEkodcC4os=;
        b=VZ4ZLDzFak9nER4UjbzCvWsmAiP+4PZf/uqF1gCXKCKyNhj/LL61OzUVjJV8yGcpFr
         vybSXGC4Hy7+WZM517Yblih3EunRMLED9ouw6p5CFxecUXGfPCjjh9fDdkCHnW3OH3AR
         3EAZ+FVdZKoWaEVy1v/aZ//w9QssILzYXeI20BG3JvQRMyd9ij541gdPypBRBa4O8ta2
         Vq1Z/qiyxpEzsXMvpHkKiI5j6XS4jWL87NIjE/xE5md3iH/ao4gSWO/GCXckibIqu5ih
         +I8xMpUIaEuNf4a9seHgKwhSHgVNkIHeOi2qHBdrvl4qI4NSP/yt4E0EQRoj1nti8GNI
         vU9Q==
X-Gm-Message-State: ABy/qLbh8jrQ61FyrYCllSTvQDWzgCGGNTcYPDJFwSgiWcCnHsBWimna
        PxVBY/ImNZjGVuNzREISjiXX4ZflCRmCjzFBouq7ak/f+Co=
X-Google-Smtp-Source: APBJJlFrZXsEVlYjvUdXZadZoz1nNgOSknSdQxqfQtqPBmWiZfPtnvvcE8DUans9nthQr12q3SVEZSnMXq13Bx4wbWM=
X-Received: by 2002:a1f:45c9:0:b0:486:3e05:da14 with SMTP id
 s192-20020a1f45c9000000b004863e05da14mr372750vka.12.1690322161172; Tue, 25
 Jul 2023 14:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <cyninzffkwhc7mqbxpwhhpm7bav67tp7a7rqkpeu5bh3kafbyo@wx3q2x5nm3he> <20230725214628.25246-1-pchelkin@ispras.ru>
In-Reply-To: <20230725214628.25246-1-pchelkin@ispras.ru>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 25 Jul 2023 17:55:39 -0400
Message-ID: <CADvbK_eUm0KF1GOSkOu5HRO91yr3BSD8Ha9kh3b+Omd=pPNdvg@mail.gmail.com>
Subject: Re: [PATCH v2] tipc: stop tipc crypto on failure in tipc_node_create
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 5:46=E2=80=AFPM Fedor Pchelkin <pchelkin@ispras.ru>=
 wrote:
>
> If tipc_link_bc_create() fails inside tipc_node_create() for a newly
> allocated tipc node then we should stop its tipc crypto and free the
> resources allocated with a call to tipc_crypto_start().
>
> As the node ref is initialized to one to that point, just put the ref on
> tipc_link_bc_create() error case that would lead to tipc_node_free() be
> eventually executed and properly clean the node and its crypto resources.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: cb8092d70a6f ("tipc: move bc link creation back to tipc_node_creat=
e")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> v1->v2: simplify the patch per Xin Long's advice: putting the ref on erro=
r
> case would solve the problem more conveniently; update the patch
> description accordingly.
>
>  net/tipc/node.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/tipc/node.c b/net/tipc/node.c
> index 5e000fde8067..a9c5b6594889 100644
> --- a/net/tipc/node.c
> +++ b/net/tipc/node.c
> @@ -583,7 +583,7 @@ struct tipc_node *tipc_node_create(struct net *net, u=
32 addr, u8 *peer_id,
>                                  n->capabilities, &n->bc_entry.inputq1,
>                                  &n->bc_entry.namedq, snd_l, &n->bc_entry=
.link)) {
>                 pr_warn("Broadcast rcv link creation failed, no memory\n"=
);
> -               kfree(n);
> +               tipc_node_put(n);
>                 n =3D NULL;
>                 goto exit;
>         }
> --
> 2.41.0
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
