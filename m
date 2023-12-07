Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C93280881C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjLGMin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjLGMil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:38:41 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26B10EC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso7971a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701952717; x=1702557517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVBZCf3TgeI02nQQV5CCOYKQC9SbHiL7ittHkRbpBQE=;
        b=UGT3K/P1NseVpJxzpShnooTKmUUr37XaqD4hUw2p4L06Xh+pOvChsxAkGOAj6g6voV
         A05LVHwYykM4jQ+r23gZHManXr/zsPOe5xoVB7DzejApvCjqIqoRPTqrgIliATyS8A7m
         ugTZkdU8a5c7uzTBwlc6LqxLQjvcp39DZop7fdP0IlKzvUHV+vR/QZXYomAzj1wJRic9
         Zd6vODMcofQWZBNMAHqxM1wonQFRyAi6N1E4MQG5rDB22y305NyHGu/yhTG1DxU/5agd
         8uDYOl69hFW/OZvA5pPBhcn4jn3cPoxeOte29Lr9/vsPEdMSzP8Jd/oXFD+yShq3Sbxs
         gMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952717; x=1702557517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVBZCf3TgeI02nQQV5CCOYKQC9SbHiL7ittHkRbpBQE=;
        b=iL5qGjui5oAhTJ80wM2tUS0Y+tGd3F3755GfOgH5Lc2EQFfb7E20EXsy6FhK+j9g9g
         nuAkiLWonn3Akj+qJPkCkphfoQiytaWPDJNSKBoSMXm3bw6t/5/fQN2lpQHkH62z8eES
         rKzJVUD0GNwFxnvZXsLw2638W4eiNMCzBQW266JLjhYc/FQOLzv0hFHT+GfFJJGGXXjT
         5lbBwgBo+3qlpe7l3rK453vW+hVW+jDcUbW/NphKy9nc6IF3gf+L/9+qBusiaf0TrV0w
         013+bXRi0/LeBDsedndWpP51dZbzc/53dupWGibq15BRxTQZhUZEf8rxsRCLt+wp/JGQ
         fxHA==
X-Gm-Message-State: AOJu0YwUq9+QDgIT2zO0tvKsTpZhYdrqwrikuxpSKJ7/NXewAc6qwqWA
        HTynRhx6bnpt6xky6s3c2jJJ2RNfoZK3F7TpffdZSQ==
X-Google-Smtp-Source: AGHT+IG108n6oOMzARf8k0VvhVx8+XyO7y+V7XEYJAEa6UVaZ3jz/wxRl4dG8SXDRH1FMfMjTv8qr5GWK68QDnSvnAU=
X-Received: by 2002:a50:c35d:0:b0:54c:79ed:a018 with SMTP id
 q29-20020a50c35d000000b0054c79eda018mr240271edb.2.1701952716962; Thu, 07 Dec
 2023 04:38:36 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLwn2wOR-OG5fG1eS5Az12S15Tf8GbWVut5xtFj-SsOnjw@mail.gmail.com>
In-Reply-To: <CABOYnLwn2wOR-OG5fG1eS5Az12S15Tf8GbWVut5xtFj-SsOnjw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Dec 2023 13:38:23 +0100
Message-ID: <CANn89i+KiP+=WzXJvqTjRt1a3GNr1iyn+BTAJ0puYbOLkC+cHA@mail.gmail.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipgre_xmit
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syoshida@redhat.com,
        syzbot+2cb7b1bd08dc77ae7f89@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 6:03=E2=80=AFAM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello Eric.
> I reproduced this bug with repro.c and repro.txt
> HEAD commit: 815fb87b753055df2d9e50f6cd80eb10235fe3e9
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
f711bc2a7eb1db25
> as the same in https://syzkaller.appspot.com/bug?extid=3D2cb7b1bd08dc77ae=
7f89
>

I think the patch has been merged in net tree, thanks.

commit 80d875cfc9d3711a029f234ef7d680db79e8fa4b
Author:     Shigeru Yoshida <syoshida@redhat.com>
AuthorDate: Sun Dec 3 01:14:41 2023 +0900
Commit:     Paolo Abeni <pabeni@redhat.com>
CommitDate: Wed Dec 6 10:08:05 2023 +0100

    ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

    In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() retur=
ns
    true. For example, applications can use PF_PACKET to create a malformed
    packet with no IP header. This type of packet causes a problem such as
    uninit-value access.

    This patch ensures that skb_pull() can pull the required size by checki=
ng
    the skb with pskb_network_may_pull() before skb_pull().

    Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
    Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
    Reviewed-by: Eric Dumazet <edumazet@google.com>
    Reviewed-by: Suman Ghosh <sumang@marvell.com>
    Link: https://lore.kernel.org/r/20231202161441.221135-1-syoshida@redhat=
.com
    Signed-off-by: Paolo Abeni <pabeni@redhat.com>
