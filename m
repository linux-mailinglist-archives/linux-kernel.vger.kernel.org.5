Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3854B769010
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGaIYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGaIYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:24:31 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DAFB11C;
        Mon, 31 Jul 2023 01:24:28 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-583b3aa4f41so45454677b3.2;
        Mon, 31 Jul 2023 01:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690791868; x=1691396668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9aBHCaVBve/PqXGtBjK3ffvPKhcImg3qkI2In3ZhF4=;
        b=XMkJKINBc9dC70yNRJVeY4bWAgD6J4rSXig/yzLmlHc9fFl4ZL80kzOb4/omuKrCUq
         NGSzFZ5O9114KatZZlHfL4a0dIn7v69UfiOPmJDQ2ljFT4oVMrHtvCbE5I102Ffjcv8s
         ZpREaQynYtrErrdbVLZzDHUdZqp10YWrsEAuRv28DAMSRaLwV0SXTL2FqnizKaC66EY9
         mhuEhdHv3HBXtLRZ96MVlv50XA6PLinB5Epmgjz1ANl8SmmlruiE82tEKae10c4Xtjk0
         Y32aNmJUxLdW8Tq17H34CL7vP5pxjUVZ+tQeVztEnCrmMcMhA4WDNBQDiiR/+AckP7zH
         6WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690791868; x=1691396668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9aBHCaVBve/PqXGtBjK3ffvPKhcImg3qkI2In3ZhF4=;
        b=fmxwRpl2ayNt2575pLwgIeqY9+6Xd6K8aQKbhfqN4l4R6rqBro2Reh284e4LaduZyx
         TipZTR2f1TveLWWeLn6BXgIHEill8uJ+OhOMt1ZEPOt4MTKdXVN32bDLD8MDd5u01eGv
         ewQ7Q+30UbCwfDdIlxKZzpRpSnyDAyaPXB2UiJ9ByOWvL276NqhuB5fJ6F7tnxHQnG/l
         IzU3bZDAZX7tY2aYNEM4CE6Nq9RMJShcyPCfNwUPtPUVIlq2kQS52e6g3Les77shFBnA
         Gcnn1BV1gpFtSzS/XWeQ+V60e96GIvGWMS8OkhFBfoWYflkXsL9/98oH8EyPurJol1uN
         0QVQ==
X-Gm-Message-State: ABy/qLa2/mgNI4K67tf3vV7mUu8cAEHRVGnLsImymYnuPjLqQNQDWJXR
        Zlz/3opDYqm32Iv55vvz43UvI2T24qODBIo50l4=
X-Google-Smtp-Source: APBJJlGwNdAn69QYMnsHfJ7RFvsipGf3S/askUMaCMz5yLPThPs4U5a97T2VneH6yiUn4Dz/eTvEEZYa6DUA6xUEY7g=
X-Received: by 2002:a81:838a:0:b0:576:d65d:2802 with SMTP id
 t132-20020a81838a000000b00576d65d2802mr9913666ywf.3.1690791868068; Mon, 31
 Jul 2023 01:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230727125125.1194376-1-imagedong@tencent.com>
 <20230727125125.1194376-4-imagedong@tencent.com> <CANn89iKWTrgEp3QY34mNqVAx09fSxHUh+oHRTd6=aWurGS7qWA@mail.gmail.com>
 <CADxym3YhjMv3Xkts99fiajq-cR-BqxDayKFzFZ1L49BNfFXkdw@mail.gmail.com>
 <CADVnQynQ1Hw+Jh7pjdNw_Mo4tWZV8V_sA+L-o=O4uV+9Gv7Prg@mail.gmail.com>
 <CADxym3Zqb2CCpJojGiT7gVL98GDdOmjxqLY6ApLeP2zZU1Kn3Q@mail.gmail.com>
 <CANn89i+WnwgpGy4v=aXsjThPBA2FQzWx9Y=ycXWWGLDdtDHBig@mail.gmail.com> <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
In-Reply-To: <CADVnQy=OumgmsbsQ8QLhUiyUNN95Ay2guVjgGVVLH93QXanBSw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Mon, 31 Jul 2023 16:24:16 +0800
Message-ID: <CADxym3YyMiO+zMD4zj03YPM3FBi-1LHi6gSD2XT8pyAMM096pg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: tcp: check timeout by
 icsk->icsk_timeout in tcp_retransmit_timer()
To:     Neal Cardwell <ncardwell@google.com>
Cc:     Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>
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

On Fri, Jul 28, 2023 at 10:25=E2=80=AFPM Neal Cardwell <ncardwell@google.co=
m> wrote:
>
> On Fri, Jul 28, 2023 at 1:50=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
[...]
>
> In that packetdrill case AFAICT that is the ZWP timer firing, and the
> sender sends a ZWP.
>
> I think maybe Menglong is looking more at something like the following
> scenario, where at the time the RTO timer fires the data sender finds
> the tp->snd_wnd is zero, so it sends a retransmit of the
> lowest-sequence data packet.
>
> Here is a packetdrill case and the tcpdump trace on an upstream
> net-next kernel... I have not worked out all the details at the end,
> but perhaps it can help move the discussion forward:
>
>
> ~/packetdrill/gtests/net/tcp/receiver_window# cat rwin-rto-zero-window.pk=
t
> // Test how sender reacts to unexpected arrival rwin of 0.
>
> `../common/defaults.sh`
>
> // Create a socket.
>     0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
>    +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
>    +0 bind(3, ..., ...) =3D 0
>    +0 listen(3, 1) =3D 0
>
> // Establish a connection.
>   +.1 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
>    +0 > S. 0:0(0) ack 1 win 65535 <mss 1460,nop,nop,sackOK,nop,wscale 14>
>   +.1 < . 1:1(0) ack 1 win 457
>    +0 accept(3, ..., ...) =3D 4
>
>    +0 write(4, ..., 20000) =3D 20000
>    +0 > P. 1:10001(10000) ack 1
>
> // TLP
>   +.2 > . 10001:11001(1000) ack 1
> // Receiver has retracted rwin to 0
> // (perhaps from the 2023 proposed OOM code?).
>   +.1 < . 1:1(0) ack 1 win 0
>
> // RTO, and in tcp_retransmit_timer() we see the receiver window is zero,
> // so we take the special f (!tp->snd_wnd...) code path.
>   +.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>   +.5 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +1.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +2.4 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +4.8 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
>  +9.6 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +19.2 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +38.4 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +76.8 > . 1:1001(1000) ack 1
>   +.1 < . 1:1(0) ack 1 win 0
>
> +120 > . 1:1001(1000) ack 1
>  +.1 < . 1:1(0) ack 1 win 0
>
> +120 > . 1:1001(1000) ack 1
>  +.1 < . 1:1(0) ack 1001 win 1000
>
> // Received non-zero window update. Send more data.
>   +0 > P. 1001:3001(2000) ack 1
>  +.1 < . 1:1(0) ack 3001 win 1000
>
> ----------
> When I run that script on a net-next kernel I see the rounding up of
> the RTO to 122 secs rather than 120 secs, but for whatever reason the
> script does not cause the socket to die early...
>

I think I know the reason now. Without the 2nd patches that I send
in this series, the ACK can't update the rwin to 0, as it will be ignored
in tcp_may_update_window().

However, you can send an ACK that acknowledges the new data
to update the rwin to 0. I modified your script, and it can die as we
excepted:

// Test how sender reacts to unexpected arrival rwin of 0.

`../common/defaults.sh`

// Create a socket.
    0 socket(..., SOCK_STREAM, IPPROTO_TCP) =3D 3
   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) =3D 0
   +0 bind(3, ..., ...) =3D 0
   +0 listen(3, 1) =3D 0

// Establish a connection.
  +.1 < S 0:0(0) win 65535 <mss 1000,nop,nop,sackOK,nop,wscale 6>
   +0 > S. 0:0(0) ack 1 win 65535 <mss 1440,nop,nop,sackOK,nop,wscale 8>
  +.1 < . 1:1(0) ack 1 win 457
   +0 accept(3, ..., ...) =3D 4

   +0 write(4, ..., 20000) =3D 20000
   +0 > P. 1:10001(10000) ack 1

// Update the window to 0. "ack 0 win 0" won't update the window, as it
// will be ignored by tcp_may_update_window()
  +.1 < . 1:1(0) ack 1001 win 0

// RTO, and in tcp_retransmit_timer() we see the receiver window is zero,
// so we take the special f (!tp->snd_wnd...) code path.
  +.2 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

  +.5 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

 +1.2 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

 +2.4 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

 +4.8 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

 +9.6 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

+19.2 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

+38.4 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

+76.8 > . 1001:2001(1000) ack 1
  +.1 < . 1:1(0) ack 1001 win 0

// socket will die in tcp_retransmit_timer() in the
// "tcp_jiffies32 - tp->rcv_tstamp > TCP_RTO_MAX" code path.
// Following retransmit won't happen.
+120 > . 1001:2001(1000) ack 1
 +.1 < . 1:1(0) ack 1001 win 0
---------------------------------------------------------------------------=
---

I don't know how to check the die of socket with
packetdrill, so I checked it by:
  ss -nitme | grep 8080 | grep on
And I can see the socket die after timeout of the 120seconds
timer.

$ packetdrill ./rwin-rto-zero-window.pkt
./rwin-rto-zero-window.pkt:55: error handling packet: Timed out
waiting for packet


> The tcpdump trace:
>
>  tcpdump -ttt -n -i any port 8080 &
>
> ->
>
> ~/packetdrill/gtests/net/tcp/receiver_window#
> ../../packetdrill/packetdrill rwin-rto-zero-window.pkt
>  00:01:01.370344 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [S], seq 0, win 65535, options [mss
> 1000,nop,nop,sackOK,nop,wscale 6], length 0
>  00:00:00.000096 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [S.], seq 3847169154, ack 1, win 65535, options [mss
> 1460,nop,nop,sackOK,nop,wscale 14], length 0
>  00:00:00.100277 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 457, length 0
>  00:00:00.000090 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 1:2001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000006 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 2001:4001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000003 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 4001:6001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000002 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 6001:8001, ack 1, win 4, length 2000: HTTP
>  00:00:00.000001 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [P.], seq 8001:10001, ack 1, win 4, length 2000: HTTP
>  00:00:00.209131 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 10001:11001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100190 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:00.203824 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100175 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:00.507835 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100192 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:01.115858 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100182 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:02.331747 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100198 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:04.955980 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100197 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:09.627985 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100179 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:19.355725 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100203 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:00:42.395633 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100202 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:01:17.724059 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100201 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:02:02.779516 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100229 tun0  In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1, win 0, length 0
>  00:02:02.779828 tun0  Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 1:1001, ack 1, win 4, length 1000: HTTP
>  00:00:00.100230 ?     In  IP 192.0.2.1.51231 > 192.168.56.132.8080:
> Flags [.], ack 1001, win 1000, length 0
>  00:00:00.000034 ?     Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 11001:12001, ack 1, win 4, length 1000: HTTP
>  00:00:00.000005 ?     Out IP 192.168.56.132.8080 > 192.0.2.1.51231:
> Flags [.], seq 12001:13001, ack 1, win 4, length 1000: HTTP
>
> rwin-rto-zero-window.pkt:62: error handling packet: live packet field
> tcp_psh: expected: 1 (0x1) vs actual: 0 (0x0)
> script packet: 405.390244 P. 1001:3001(2000) ack 1
> actual packet: 405.390237 . 11001:13001(2000) ack 1 win 4
