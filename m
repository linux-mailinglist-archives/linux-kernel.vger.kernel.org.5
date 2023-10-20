Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA4E7D0F7A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377346AbjJTMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbjJTMQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:16:01 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFEE9E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:15:59 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7af20c488so7970307b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697804158; x=1698408958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeRAWwn+GIOAPONO5Nd1FGLFR4N0zLDGXgNu8ADyK6g=;
        b=oK7D2fUBOW/C/Pd9y0bJVEnJreKhQNYt95tK+z9yJuHddfW1U0W4ZN61QiEvp3BDAp
         5oQu0lgPqebSlPN/pm5v+jIfgbv2X8cD8InjK1ACUWd36Parcs8fHxClto179t2eGIvh
         BtvXSPNfqAkv86eloPOFOHl+DRn53HMXIjHM5RBhcuP2ye5Mxqb94/rc58fIV5godTHA
         G5bzxoLsZrf53k6l5dEpUsej1Vjh4lf28nxKny5McLYrSrq6DZqgKUhpEGfHPkuU6gqV
         wE39crLkoG/C9kZK+DNJesHEvP+mta8hsIPHFbaaizcugTI/HxXfU+XVrw/8R04Y69TO
         Kz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697804158; x=1698408958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeRAWwn+GIOAPONO5Nd1FGLFR4N0zLDGXgNu8ADyK6g=;
        b=Uk6a/TQ5CtW0/i39j5IdQXGcEew8X7yA+m6fGGLfOXaL4279rzvSHbYdkcs1e/gmNP
         P/xhi3fMuWe3PVP3EYbEOowhua6Tj3VS+x5/dGbPzJym0VBBZSyVe5NkdtCp1J77r3uf
         N923flglvEJmTimircXn+7Z0q4xJ3E7JyDbuVJBoedBNtJn3sscGYqVPeF/6so1G6t11
         bMYJCw3x/N2P0Z8KqwsdRX1TdAr4n3mMMhpU3OS6bKrX1vBqrPRT1b/c9dL0twbRr9Bd
         lzmi+wCmuTU3iQBYdhrXTESZ0mu6HQj857OVRSsJM1KZHXzvoFYyXFiRUhGrwBz0MBrJ
         8w9A==
X-Gm-Message-State: AOJu0YyWi/FfX/OPkLv74aggYEZTJLG9IKG1yW+joX/IXspbrZLtvy4q
        prLrzmyGwmC+s3bouKfgj40Rh9N7XD/zy0u0Dh97YQ==
X-Google-Smtp-Source: AGHT+IF1EziqpMrk7QV2Fpyaa0sgD98EyxZGn/78LgVc6xQbqFiUqjMe4cD2Nl2kNoj6uyDxBKuhFVKLR+9QTPyeTMk=
X-Received: by 2002:a25:8290:0:b0:d9b:fd8a:871c with SMTP id
 r16-20020a258290000000b00d9bfd8a871cmr1576413ybk.16.1697804158570; Fri, 20
 Oct 2023 05:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231020061158.6716-1-hkelam@marvell.com>
In-Reply-To: <20231020061158.6716-1-hkelam@marvell.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 20 Oct 2023 08:15:47 -0400
Message-ID: <CAM0EoMkawLKubMdrTOAcOhYq8Jicc5XuXuytBVi-yy-_QgiTuA@mail.gmail.com>
Subject: Re: [net-next] net: sched: extend flow action with RSS
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, sgoutham@marvell.com, edumazet@google.com,
        pabeni@redhat.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:12=E2=80=AFAM Hariprasad Kelam <hkelam@marvell.co=
m> wrote:
>
> This patch extends current flow action with RSS, such that
> the user can install flower offloads with action RSS followed
> by a group id. Since this is done in hardware skip_sw flag
> is enforced.

Our typical rule for TC is we need s/w equivalence for offloads. How
would this work in absence of offload?

cheers,
jamal

> Example:
> In a multi rss group supported NIC,
>
> rss group #1 flow hash indirection table populated with rx queues 1 to 4
> rss group #2 flow hash indirection table populated with rx queues 5 to 9
>
> $tc filter add dev eth1 ingress protocol ip flower ip_proto tcp dst_port
> 443 action skbedit rss_group 1 skip_sw
>
> Packets destined to tcp port 443 will be distributed among rx queues 1 to=
 4
>
> $tc filter add dev eth1 ingress protocol ip flower ip_proto udp dst_port
> 8080 action skbedit rss_group 2 skip_sw
>
> Packets destined to udp port 8080 will be distributed among rx queues
> 5 to 9
