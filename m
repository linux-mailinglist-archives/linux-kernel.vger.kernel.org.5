Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2277754514
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 00:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjGNWpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGNWpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 18:45:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DE30FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:45:07 -0700 (PDT)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9AF7E3F723
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689374705;
        bh=FP8NFo5ttl/GuZaVvQMiK1O2vkwG6/VwhootU2UrwC8=;
        h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
         Content-Type:Date:Message-ID;
        b=r+rXyLF7jsf2GuBfJrSdhn8efT8sA85PXz5nUtexayV55R8ScRxL+ZU0w1iiEKOEc
         UmbeIc5OPCpHLdga69o1SGGinA5elbklAzIZKFBzBs+k68gRXysUSwZhXBuKFLEYbI
         RLeO59VVTbUDe5UuCdwLerajwG+KxsakUw/7yjXu3sYGboRU21hjPGZbIBlFdkbHrK
         N5ym46qYfY6ZBOAcgMRSHVF8rkKJysS7QD8L+91UcVeLWl0dPOxSaeFA9E2sHirBcV
         7vm3m2v1X6G6hjXgnvLS5WCA26oo/6HJ/v2jnwe6nxMURPK3es89t5nkX625Ktrf9W
         F2aGcuWwZa6qA==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-55c79a5565aso1215475a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 15:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689374704; x=1691966704;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FP8NFo5ttl/GuZaVvQMiK1O2vkwG6/VwhootU2UrwC8=;
        b=kCtdaeA0uEwShDraoBwd6Fw3DY/yi6tEULCq7+A51Utuam58U1+fPxf/Q6R1EXUgsz
         +IuehgWwgyfTNDkYJbtCED1BSC+UHg7krt4gkzYD+/L1nqpLZ5PYGwwfBhh+pcD3X8qi
         IKjQhxYy9EAjtrUkDQkpygUZmA0n+Z/oXbNtCq81udNgjRQpDb8CVBXrmTwpIwvAafVE
         NurVe/tFiuGrQmqzYH/4ANfRXfmJWpVE3wb/V8QP7elES5IfBTQ1Xl99G7j7EdRGeuJ9
         j8fq3A+FrNtb2nti+l1kSmq2X0KgO2wQx9awAnto9b9Jp8V2X17d1OWpUtoYO2J1JhFe
         TZtg==
X-Gm-Message-State: ABy/qLbRzcJxcQkf9M4IOldjBZqlCyg4D5Fbmba2FY1TPB3G4sfIQP4n
        /7TKZQjP1NBsGXm96VVYrkQqK+0on/swj0j1egQJ7eF7/gQREZeHbWTwSckjLu6YjTsMD7rVlWk
        RDRgr+3UMEKRiHxvYYK9Nqla+aGdpRwtcfD/iIp61Fg==
X-Received: by 2002:a05:6a20:1451:b0:132:e1ec:796f with SMTP id a17-20020a056a20145100b00132e1ec796fmr5071576pzi.26.1689374704095;
        Fri, 14 Jul 2023 15:45:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgjpMNALXZnAKw+OgXUuJ3hVL/R2N+iBUFv3O9Iq5/ifwPwKWAZjErpko1jUdHuH4DijWuQg==
X-Received: by 2002:a05:6a20:1451:b0:132:e1ec:796f with SMTP id a17-20020a056a20145100b00132e1ec796fmr5071566pzi.26.1689374703660;
        Fri, 14 Jul 2023 15:45:03 -0700 (PDT)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id g7-20020aa78187000000b00659b8313d08sm7638033pfi.78.2023.07.14.15.45.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2023 15:45:03 -0700 (PDT)
Received: by famine.localdomain (Postfix, from userid 1000)
        id DDB3D5FEAC; Fri, 14 Jul 2023 15:45:02 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
        by famine.localdomain (Postfix) with ESMTP id D65DC9FABB;
        Fri, 14 Jul 2023 15:45:02 -0700 (PDT)
From:   Jay Vosburgh <jay.vosburgh@canonical.com>
To:     Jamie Bainbridge <jamie.bainbridge@gmail.com>
cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tcp: Add memory pressure flag to sockstat
In-reply-to: <a35a5881c3280bd7a4fd1943a8b40b890e3bf280.1689316697.git.jamie.bainbridge@gmail.com>
References: <a35a5881c3280bd7a4fd1943a8b40b890e3bf280.1689316697.git.jamie.bainbridge@gmail.com>
Comments: In-reply-to Jamie Bainbridge <jamie.bainbridge@gmail.com>
   message dated "Fri, 14 Jul 2023 16:39:53 +1000."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30996.1689374702.1@famine>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 14 Jul 2023 15:45:02 -0700
Message-ID: <30997.1689374702@famine>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Bainbridge <jamie.bainbridge@gmail.com> wrote:

>When tuning a system it can be helpful to know whether the protocol is
>in memory pressure state or not. This can be determined by corresponding
>the number of pages in "net.ipv4.tcp_mem" with the current allocation,
>but a global variable already tracks this as the source of truth.
>
>Expose that variable in sockstat where other protocol memory usage is
>already reported.
>
>Add "pressure" which is 0 in normal state and 1 under pressure:
>
> # grep TCP /proc/net/sockstat
> TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 0
>
> # grep TCP /proc/net/sockstat
> TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 1

	Isn't this already available in /proc/net/protocols?

protocol  size sockets  memory press maxhdr  slab module     cl co di ac i=
o in de sh ss gs se re sp bi br ha uh gp em
[...]
UDP       1472      7       6   NI       0   yes  kernel      y  y  y  n  =
y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
TCP       2512      5       1   no     320   yes  kernel      y  y  y  y  =
y  y  y  y  y  y  y  y  y  n  y  y  y  y  y

	-J

>Tested by writing a large value to global variable tcp_memory_pressure
>(it usually stores jiffies when memory pressure was entered) and not
>just by code review or editing example output.
>
>Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
>---
> net/ipv4/proc.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
>diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
>index eaf1d3113b62f7dc93fdc7b7c4041140ac63bf69..f4c5ced2de49d5c6d7f5d7ccd=
aa76c89dcf8c932 100644
>--- a/net/ipv4/proc.c
>+++ b/net/ipv4/proc.c
>@@ -51,16 +51,17 @@
> static int sockstat_seq_show(struct seq_file *seq, void *v)
> {
> 	struct net *net =3D seq->private;
>-	int orphans, sockets;
>+	int orphans, sockets, tcp_pressure;
> =

> 	orphans =3D tcp_orphan_count_sum();
> 	sockets =3D proto_sockets_allocated_sum_positive(&tcp_prot);
>+	tcp_pressure =3D READ_ONCE(tcp_memory_pressure) ? 1 : 0;
> =

> 	socket_seq_show(seq);
>-	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld\n",
>+	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld pressur=
e %d\n",
> 		   sock_prot_inuse_get(net, &tcp_prot), orphans,
> 		   refcount_read(&net->ipv4.tcp_death_row.tw_refcount) - 1,
>-		   sockets, proto_memory_allocated(&tcp_prot));
>+		   sockets, proto_memory_allocated(&tcp_prot), tcp_pressure);
> 	seq_printf(seq, "UDP: inuse %d mem %ld\n",
> 		   sock_prot_inuse_get(net, &udp_prot),
> 		   proto_memory_allocated(&udp_prot));
>-- =

>2.41.0
>
>

---
	-Jay Vosburgh, jay.vosburgh@canonical.com
