Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF90806BAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377608AbjLFKPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377538AbjLFKPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:15:30 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E3120;
        Wed,  6 Dec 2023 02:15:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d7e56f6845so3864849a34.0;
        Wed, 06 Dec 2023 02:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701857735; x=1702462535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlVRZvTWTqjL4cN59keuEr9oGDpPJsnUfds6q3nYQBA=;
        b=ZeEcGMBwlHdXgstLjOB1LX4BQrA5KWKlgePvytdP4kxKpgpa23HZ6lHMR3prYNdN3u
         oGZhXGGDG5Nmc0S2n84myd7GMNpMAbidZ0gO1Y1wB7gM9Antw/NBq7BcSZ6JyIWFT8ZW
         bHar/I0Ni8lg7CQvah2AHYymWmz7SHWe5Txc+xRs0TV01CBAJBS0bvruPiajh1FVgkpN
         QFF7Yw+vtT6CoGPHbrOcoUCxTqZErU802JWTy45dAMDsoRYOsNYjQhOtARxM88EtD2+F
         WBhu8Ca9rFKzeyl+yofVNmwJY9PwK74i5AiG6gPSbfqIbLGcEs93Ec2hZWW6xt/Qu8eT
         ojQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857735; x=1702462535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlVRZvTWTqjL4cN59keuEr9oGDpPJsnUfds6q3nYQBA=;
        b=fGiGo2ZMM3Zqv8iyq1TjpsA128tF0JQnd9bAtvfgB8Im5B7NH554925cD4NNZH/27L
         GP4Teif+cDduXqOLk4C9EBQe4zUmoCZT2TTkpxaUsT4Y7ncKm+8pp6Ot0OsCirT2Cl+9
         JfZeLSzNa0AdMKsYv84jITkd1mxKDiWDJBXN5aB00BnyXJcdxvADow0NHHv6OIej/et2
         wRgicrVMMou7FfdE02woWIcUXlALvC7Urmv5kS+JAVd03d5H5qHnGQtiTVPuS78s4dCq
         ZluRm/RD/SHhLxVszRO4cVCIi8TG9QC3qQRk6aAb8WSxdkIaPdt6qvo4mhA0R1zEkA0w
         SZgA==
X-Gm-Message-State: AOJu0YxpqI1I/CWchthUehcEWLCzhgdFV1+2ixbszJxVrsiYlkZQGfiE
        R7pMQQ/Vc3W9xQyZhMzYVF6wcqCRXNrXW5mImWU=
X-Google-Smtp-Source: AGHT+IHh9PSGnNBnMi6DTCVwD8JCel6UgUH7QunXwVtkykL2RvUG7YrErf5JYS8X6qVNGvdAm05mRYfZ/75YTDKQZv0=
X-Received: by 2002:a05:6830:12d7:b0:6d9:a065:64a0 with SMTP id
 a23-20020a05683012d700b006d9a06564a0mr787792otq.29.1701857735681; Wed, 06 Dec
 2023 02:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20231204085810.1681386-1-daniil31415it@gmail.com> <08ae0a18-669e-b479-94d4-450a7a12efe9@marvell.com>
In-Reply-To: <08ae0a18-669e-b479-94d4-450a7a12efe9@marvell.com>
From:   =?UTF-8?B?0JTQsNC90LjQuNC7INCc0LDQutGB0LjQvNC+0LI=?= 
        <daniil31415it@gmail.com>
Date:   Wed, 6 Dec 2023 13:15:24 +0300
Message-ID: <CABAdP+SHe5XhFVjUauWRoEgGELHm98G=Or+m9V7Lw_rZ57oQ2g@mail.gmail.com>
Subject: Re: [EXT] [PATCH] net: atlantic: Fix NULL dereference of skb pointer in
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, lvc-project@linuxtesting.org,
        Egor Pomozov <epomozov@marvell.com>
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

I am sorry for breaking the mailing list and sending my answer only to
Igor, I've never used emails that much. To make it clear, the answer
was: "Hi Igor! No, it hasn't been reproduced in reality because I
don't have any appropriate device."


=D0=BF=D0=BD, 4 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3. =D0=B2 19:06, Igor=
 Russkikh <irusskikh@marvell.com>:
>
>
> Hi Daniil,
>
> > If is_ptp_ring =3D=3D true in the loop of __aq_ring_xdp_clean function,
> > then a timestamp is stored from a packet in a field of skb object,
> > which is not allocated at the moment of the call (skb =3D=3D NULL).
> >
> > Generalize aq_ptp_extract_ts and other affected functions so they don't
> > work with struct sk_buff*, but with struct skb_shared_hwtstamps*.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE
>
> Thanks for finding this and working on this.
>
> Have you reproduced it in wild, or this just comes out of static analysis=
?
>
> I'm asking because looking into the flow you described - it looks like XD=
P
> mode should immediately fail with null pointer access on any rx traffic.
> But that was never reported.
>
> I will try to debug and validate the fix, but this may take some time.
>
> So for now
>
> Reviewed-by: Igor Russkikh <irusskikh@marvell.com>
>
>
> Thanks
>   Igor
