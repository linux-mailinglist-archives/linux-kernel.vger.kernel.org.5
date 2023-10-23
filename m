Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2A87D2C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjJWIZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjJWIZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F2BE0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698049476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9hWqXpcum8UpgdtzYDc5SfWpjkSwHlgNWkRpARUv+ls=;
        b=f99mqQ4UBfKmmigO9jzJjGrE5gSOjpQ4AzMqLT2WFAsdqHsdeLhN0mI8qx2sHP+uC5utpz
        3Cd1XnipOOClt2IM1FXSgWZyJ7x4jO20aprxJW2/yHG4o5jt0wnjQpp4IJkX/XueAdVCRH
        KWJvn2N6MuceeTQz5UoY0o7lLnjvusM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391--bZFSdP5OKyj-r4Ll5ZVbQ-1; Mon, 23 Oct 2023 04:24:34 -0400
X-MC-Unique: -bZFSdP5OKyj-r4Ll5ZVbQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-53faa428157so580282a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698049473; x=1698654273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9hWqXpcum8UpgdtzYDc5SfWpjkSwHlgNWkRpARUv+ls=;
        b=soifOxGtSTtY+c37lO5rGyzynXn17mdb50rKCrAy8Duu/PPHlUG/ALmCngI11JLig6
         bB4POWkGu9fPD+0wwj4W8Ss9QrSz0bjI38uZatparH/puknACWXZNDcieNfOdWYtBPBo
         yrr9dU6ynd0AwgsMsHVzOP8oYIgfZ8kPs1f6MNYo8mEhTwkkolppw7VnolLQtOBBhj17
         HlHk6ixZ5WDTFrAMnDA3uptkkDzdkqYwflxBnlzwPsMdbOpOLq685IxdZfse9geK9hZG
         IZt7wM3IgMIlyzjg/mFRJNfLIGCGcqWvrQjfcAVnHcTpLBx/mzpDr9KL0DwCS77YAYkF
         /SHA==
X-Gm-Message-State: AOJu0YxbINlQM7YDv7vecuO36k9Ywil7Gr6PDA/ZX8BFWK3VUwl4lYeo
        R57rP+AMJW1JRz8+WyaBGTXjUJerZ58c4gdbsoB2W+ppywRd2JdN1dqxbJY0voo+gwJBNzTVSV+
        12y7kxsZD/pnHPHT2ym0bxSD9
X-Received: by 2002:a50:d799:0:b0:53f:92a8:652d with SMTP id w25-20020a50d799000000b0053f92a8652dmr6596704edi.1.1698049473694;
        Mon, 23 Oct 2023 01:24:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJHeeajUrPiZJZx1l1P9zk9Vmy7Oa1duTYSDEAey2AJMST6Y6TjSVGV+Bu8MEIw2ThxwR76A==
X-Received: by 2002:a50:d799:0:b0:53f:92a8:652d with SMTP id w25-20020a50d799000000b0053f92a8652dmr6596683edi.1.1698049473236;
        Mon, 23 Oct 2023 01:24:33 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-0.dyn.eolo.it. [146.241.237.0])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b0053da3a9847csm6061880edb.42.2023.10.23.01.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 01:24:32 -0700 (PDT)
Message-ID: <f9bc6eb8fb9c0771d7fff0b4da1a75528c5d6c07.camel@redhat.com>
Subject: Re: [PATCH net-next 00/17] Change cork to a pointer in sockets
From:   Paolo Abeni <pabeni@redhat.com>
To:     Oliver Crumrine <ozlinuxc@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net
Date:   Mon, 23 Oct 2023 10:24:31 +0200
In-Reply-To: <cover.1697989543.git.ozlinuxc@gmail.com>
References: <cover.1697989543.git.ozlinuxc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-22 at 12:19 -0400, Oliver Crumrine wrote:
> This patch changes the cork field of both the inet_sock and inet6_sk
> structs to a pointer, reducing their size.
>=20
> Oliver Crumrine (17):
>   Make cork in inet_sock a pointer.
>   Allocate and free cork in inet_create and inet_release in file
>     net/ipv4/af_inet.c
>   Change cork in ipv6_pinfo to a pointer.
>   Allocate and free cork in inet6_sk.
>   Change occurence of cork in inet_sock to pointer in include/net/ip.h
>   Since cork in inet_sock and inet6_sk will be a pointer, they don't
>     need to be referenced in this function in include/net/ipv6.h
>   Change occurences of cork in inet_sock to pointer in file
>     net/ipv4/af_inet.c
>   Change occurence of cork to pointer in file net/ipv4/datagram.c
>   Change instances of cork in net/ipv4/inet_connection_sock.c to
>     pointer.
>   Change instances of cork to pointer in net/ipv4/ip_output.c
>   Update occurences of cork to pointer in net/ipv4/syncookies.c
>   Change occurences of cork to pointer in net/ipv4/tcp_output.c
>   Change instances of cork to a pointer in file net/ipv4/udp.c
>   Update usages of cork in net/ipv6/ip6_output.c to pointer.
>   Modify occurences of cork in net/ipv6/raw.c to use a pointer
>   Change usages of cork to pointer in net/ipv6/udp.c
>   Change instance of cork to pointer in net/ipv4/tcp_ipv4.c
>=20
>  include/linux/ipv6.h            |  2 +-
>  include/net/inet_sock.h         |  2 +-
>  include/net/ip.h                |  2 +-
>  include/net/ipv6.h              |  4 ++--
>  net/ipv4/af_inet.c              |  6 ++++--
>  net/ipv4/datagram.c             |  2 +-
>  net/ipv4/inet_connection_sock.c |  6 +++---
>  net/ipv4/ip_output.c            |  6 +++---
>  net/ipv4/syncookies.c           |  2 +-
>  net/ipv4/tcp_ipv4.c             |  2 +-
>  net/ipv4/tcp_output.c           |  2 +-
>  net/ipv4/udp.c                  |  8 ++++----
>  net/ipv6/af_inet6.c             |  5 +++++
>  net/ipv6/ip6_output.c           | 10 +++++-----
>  net/ipv6/raw.c                  |  4 ++--
>  net/ipv6/udp.c                  |  4 ++--
>  16 files changed, 37 insertions(+), 30 deletions(-)

Could you please explain the rationale behind such changes?=C2=A0

As the cork struct is still allocated for each inet/inet6 socket, the
total memory used by the the now smaller socket struct and the cork=20
struct will be greater then the memory used originally by such socket.
And the double allocation/free will be slower then the original one.

This also adds a bunch of additional pointer de-reference in the xmit
path.

Finally the above change will probably conflict with the goodies
introduced by:

https://lore.kernel.org/netdev/20231017014716.3944813-1-lixiaoyan@google.co=
m/

I'm sorry, but this looks really a no-go.

Before future submissions, please read thoroughly the process
documentation, including the netdev specific bits in maintainer-
netdev.rst: there a bit of issues with the process here (the recipients
list does not include a lot of relevant ones, there are typos there,
the patch series is too long, it breaks the builds ...)

Cheers,

Paolo

