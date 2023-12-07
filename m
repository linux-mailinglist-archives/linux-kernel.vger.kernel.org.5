Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61018808A6B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443219AbjLGOXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443216AbjLGOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:23:05 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B022D7B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:20:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so12194a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701958797; x=1702563597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cg+kyvs6whLnp94BpNVRhpcWLXdDwv5DFCjHXa8X9m8=;
        b=hzdNbJ1mORZNZ6W4cIJfjbmvTEFc5XJQTz7NXrjj3Fij+klTwEv6EgPuDJacDxmHh1
         ZNcWM/c0TIogF5o0FnpRtlpp6o9rpYPK7vnQd3IqAfn2QzZAiSfDOuKoWYfKkpf2EXCD
         I/jSBXELtN7jeYJFr/XRRlbMCPvsQijd06h9dKiRQ6qXIvLJIFrBElwC+HreJAhyFW3k
         rWTb24Drjbl5OBZahiHMT4I0eiChgqbceN46bJrrrfrIbyyTmL2joDelAOxaTWb9rjMA
         yijnJMIhSQOq0SVPc91tzpXBRTSyMfrUa8QvtIuHEKPKiU03FX5neMEZvjZUGAmgxdwK
         AZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701958797; x=1702563597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cg+kyvs6whLnp94BpNVRhpcWLXdDwv5DFCjHXa8X9m8=;
        b=CQivT/8MYY38zQCFZZJFY0QGwu1OPAxdye3FC7uVDjvlwGe5jn2AmdZGEzKJkZ+m9H
         d33zgIeOM01iBJPxAQU7Nlr64AVuph1PDedVvvb+xHWoAEC5xnh4G+tPXwzQ4teEUdW+
         xAepWaKBliLsfPeUcHo5i8mtZOZJknHqJutnCqaDVpN3iwRpWj4sH5b4bawJAzqyKPjo
         vQui/nFsfMamanMrnCeSYSIIlRUMEftG1DyPXgr5WCRuaJ6PLahS9QXHFTlI0QcOgUPL
         THG3mofxgiegnRA69s8Ys3pw2D7F/8dzspp2bm9PvxBTGji8jQLoDNkSEKluRU4dIFOw
         QjBA==
X-Gm-Message-State: AOJu0YzglMjAtEIJhg0MrzlJtpHIjlCPNUtSA5tpJV2esC78+DNBjJJ+
        41V+Rgy4f6gc8WSwo8kJhb8eDzt/Zr1BJepeOpUZHQ==
X-Google-Smtp-Source: AGHT+IGXOZOZ4pQiJJUXla1388CP6kL+6w7lkaO8vOiBdOjIpyd8gct1j8GkezTmcPoNx9DJuKrdRMDE1v5jm6Av/Es=
X-Received: by 2002:a50:9f89:0:b0:54b:bf08:a95f with SMTP id
 c9-20020a509f89000000b0054bbf08a95fmr229791edf.6.1701958796595; Thu, 07 Dec
 2023 06:19:56 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
In-Reply-To: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Dec 2023 15:19:45 +0100
Message-ID: <CANn89i+xOT-CPxyBN5nkfHFN_Z78D3BPQCwN8phRur41CTyJSQ@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_tunnel_xmit
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 7, 2023 at 2:27=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
wrote:
>
> Hello,
>
> When fuzzing the latest upstream linux 6.7-rc4,  the following crash
> was triggered.
> HEAD commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
>
> console_log: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90=
c98b6583#file-console_log
> report: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b6=
583#file-report
> kernel commit: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=3D=
ce27066613dacbb6
> repro.c: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c98b=
6583#file-repro-c
> repro.txt: https://gist.github.com/xrivendell7/b41fbc928cd203823783fd90c9=
8b6583#file-repro-txt
>
> In the lasted kernel: bee0e7762ad2c6025b9f5245c040fcc36ef2bde8 the
> [  199.471467][ T8590] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  199.475015][ T8590] BUG: KMSAN: uninit-value in ip_tunnel_xmit+0x857/0=
x3e80
> [  199.478180][ T8590]  ip_tunnel_xmit+0x857/0x3e80
> [  199.480541][ T8590]  ipgre_xmit+0xd1c/0xe20
> [  199.482393][ T8590]  dev_hard_start_xmit+0x247/0xa10
> [  199.484530][ T8590]  __dev_queue_xmit+0x33b8/0x5130
> [  199.486433][ T8590]  __bpf_redirect+0xdd7/0x1600
> [  199.488258][ T8590]  bpf_clone_redirect+0x328/0x470
> [  199.490250][ T8590]  ___bpf_prog_run+0x2180/0xdb80
> [  199.491997][ T8590]  __bpf_prog_run512+0xb5/0xe0
> [  199.493691][ T8590]  bpf_test_run+0x482/0xb00
> [  199.495215][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  199.497026][ T8590]  bpf_prog_test_run+0x6af/0xac0
> [  199.498701][ T8590]  __sys_bpf+0x649/0xd60
> [  199.500029][ T8590]  __x64_sys_bpf+0xa0/0xe0
> [  199.501411][ T8590]  do_syscall_64+0x44/0x110
> [  199.502757][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> [  199.504463][ T8590]
> [  199.505159][ T8590] Uninit was created at:
> [  199.506344][ T8590]  slab_post_alloc_hook+0x129/0xa70
> [  199.507690][ T8590]  kmem_cache_alloc_node+0x5e9/0xb10
> [  199.509191][ T8590]  kmalloc_reserve+0x13d/0x4a0
> [  199.510411][ T8590]  pskb_expand_head+0x226/0x1a00
> [  199.511657][ T8590]  skb_ensure_writable+0x3d3/0x460
> [  199.512905][ T8590]  bpf_clone_redirect+0x17f/0x470
> [  199.514135][ T8590]  ___bpf_prog_run+0x2180/0xdb80
> [  199.515325][ T8590]  __bpf_prog_run512+0xb5/0xe0
> [  199.516479][ T8590]  bpf_test_run+0x482/0xb00
> [  199.517580][ T8590]  bpf_prog_test_run_skb+0x14e5/0x1f20
> [  199.518901][ T8590]  bpf_prog_test_run+0x6af/0xac0
> [  199.520015][ T8590]  __sys_bpf+0x649/0xd60
> [  199.520996][ T8590]  __x64_sys_bpf+0xa0/0xe0
> [  199.521949][ T8590]  do_syscall_64+0x44/0x110
> [  199.522926][ T8590]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
>
> and I notice the problem is reported at 2018/2020 and seems fixed twice.
>
> https://syzkaller.appspot.com/bug?id=3Df62d236e2fceaeb104f4e8f77d2324ef9d=
a4b41b
> https://syzkaller.appspot.com/bug?extid=3D4a2c52677a8a1aa283cb
>
>
>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

I think a fix was merged into the net tree yesterday, please double check.

80d875cfc9d3711a029f234ef7d680db79e8fa4b ipv4: ip_gre: Avoid
skb_pull() failure in ipgre_xmit()
