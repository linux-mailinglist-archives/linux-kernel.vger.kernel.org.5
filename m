Return-Path: <linux-kernel+bounces-139793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576158A07CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D19521F2563C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6F13C9D1;
	Thu, 11 Apr 2024 05:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="UVEA5coY"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B513B7AA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813793; cv=none; b=kMVFmQ2yr+asADYuzatf0Xh6wrgjyuqoNqI3Mrexp0a7tOj74mZvnsVeXo7zE7IR3J1ONoaBvuhGyQHDpVe4so2CO+FCzJ9US0HS7qCJ2HmNZm1E2X9NOlaQ1oHm2B5yKXeWvZuNDyPQ6cZ4KgX0zH+ddCRQp3bnoxMWcO4EaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813793; c=relaxed/simple;
	bh=9Pa5OXbNJf9HL7UJhH3JcFa5n8z2BXnqXldXUMG2phA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHlcrs5atHAZPSnZ6jZ9+nZ1EVNBgTSQL5TbqOVbZx9YJ8dt+VTVQfl049BPg9UuE7ZYkn3QkkoAojmP1p/yDUoIQy4z0+ZiXKNoqcBAvo9TblX0r38WLGzh6W9OV4xNJwlZVbcYABBvtozyblxLpijHyrI9xHm8goEvT2wC9eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=none smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=UVEA5coY; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=daynix.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-434c695ec3dso16727241cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712813790; x=1713418590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=UVEA5coYYeRS8uJ/hQdFaOIXudpCoLobLBTccakXm0Jyi/CMcxJbV87hXhB+g288IO
         nO1t0+AtE6NoMd7ULm8mDKJPUBZXvqwSqAoQhKL49YJ9qNJ4iS8UYX90YNH8RmLsGeG9
         uiduuU9TNk/JEWgebJZFhmsYyXGobYyK7TynOxqkYXy0GmkTSIAzf4twCCQMTp7ewm1O
         bGTSinl2jts3Rpw1r3D+9y29/a/mqzNqcj3eq+vdswTpfffeJc109bJRVnY2QqD+F99H
         DGRDReEpKwQCihIaGfXHOjVN90Z7epVBaScEyer1BXHuG5fEAoTgpxjsASGC565C+eNb
         EVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712813790; x=1713418590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O5BYI4OdHldRtjTHclfiNrTCLX6On9bTqWbaBCK7vA=;
        b=RRlEzhOIj9TC6sZzehF0FLFWGotMPCvl4h1bu4hdf239tAnZvwYOkoRwH2GLP75GMk
         UihMhG0TMMcXmV4EqaLK6bgdNLU4zPAaTT//ee1hxmww7PvuecGqCXCJIsJVXCXQgRu6
         MwqYcy4QSBI3xoIrw/A+mbgDIB+jvLZaTiequt7Rn79U+i4Ba55wHR+/9i/Sx28fb04+
         yvVjje/KILsDdpAfwYQIiqRyL+RrtPbfVS/ihbOvBJjljl5kclnEzDpkyarNPM9PoKN4
         HPRdXGp5R9rf+9xp8hl76FkcUDPOHu2ez4A7+pm1tGMRt+5QR/yLSDtVwRJVjoHeFc55
         Q8/g==
X-Gm-Message-State: AOJu0Yxw4yyr5p8YhjN5LbJWdUF6vKHQSvtzMZyHBhWlNixwb7kzpTBk
	BD7EYrLuULEQoDJgmd7hUZCQ2BdT/YFRA+nyef3wpAQkqimy7bTGVO14JhWmYxiBsa2jTH7D8tP
	eKQz6VxmxgjfaAc9PmfUTyDNPDYYOfelZBwLErSP+fHz57Bb7
X-Google-Smtp-Source: AGHT+IHXub++9CumsI9Ywnl2w4/5t7+EuZITPbvJVWOGFVEzJbCVmljtvqkv2l8ii4JKL3C+bb02heSSmwmSGs85R3Q=
X-Received: by 2002:a05:622a:130f:b0:436:5951:6005 with SMTP id
 v15-20020a05622a130f00b0043659516005mr1527116qtk.22.1712813790711; Wed, 10
 Apr 2024 22:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411051124.386817-1-yuri.benditovich@daynix.com> <20240411051124.386817-2-yuri.benditovich@daynix.com>
In-Reply-To: <20240411051124.386817-2-yuri.benditovich@daynix.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 11 Apr 2024 08:36:19 +0300
Message-ID: <CAOEp5OdiSW9ddv53JQHY57fCTwGc3eq-uWstSGcYFsMaW-FtOw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net: change maximum number of UDP segments to 128
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, yan@daynix.com, andrew@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've just fixed the 'Fixed:' line and extended the commit message.
We can continue the discussion in the previous email thread or move it here=
.

On Thu, Apr 11, 2024 at 8:11=E2=80=AFAM Yuri Benditovich
<yuri.benditovich@daynix.com> wrote:
>
> The commit fc8b2a619469
> ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation")
> adds check of potential number of UDP segments vs
> UDP_MAX_SEGMENTS in linux/virtio_net.h.
> After this change certification test of USO guest-to-guest
> transmit on Windows driver for virtio-net device fails,
> for example with packet size of ~64K and mss of 536 bytes.
> In general the USO should not be more restrictive than TSO.
> Indeed, in case of unreasonably small mss a lot of segments
> can cause queue overflow and packet loss on the destination.
> Limit of 128 segments is good for any practical purpose,
> with minimal meaningful mss of 536 the maximal UDP packet will
> be divided to ~120 segments.
> The number of segments for UDP packets is validated vs
> UDP_MAX_SEGMENTS also in udp.c (v4,v6), this does not affect
> quest-to-guest path but does affect packets sent to host, for
> example.
> It is important to mention that UDP_MAX_SEGMENTS is kernel-only
> define and not available to user mode socket applications.
> In order to request MSS smaller than MTU the applications
> just uses setsockopt with SOL_UDP and UDP_SEGMENT and there is
> no limitations on socket API level.
>
> Fixes: fc8b2a619469 ("net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validati=
on")
> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> ---
>  include/linux/udp.h                  | 2 +-
>  tools/testing/selftests/net/udpgso.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/udp.h b/include/linux/udp.h
> index 3748e82b627b..7e75ccdf25fe 100644
> --- a/include/linux/udp.h
> +++ b/include/linux/udp.h
> @@ -108,7 +108,7 @@ struct udp_sock {
>  #define udp_assign_bit(nr, sk, val)            \
>         assign_bit(UDP_FLAGS_##nr, &udp_sk(sk)->udp_flags, val)
>
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>
>  #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
>
> diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftes=
ts/net/udpgso.c
> index 1d975bf52af3..85b3baa3f7f3 100644
> --- a/tools/testing/selftests/net/udpgso.c
> +++ b/tools/testing/selftests/net/udpgso.c
> @@ -34,7 +34,7 @@
>  #endif
>
>  #ifndef UDP_MAX_SEGMENTS
> -#define UDP_MAX_SEGMENTS       (1 << 6UL)
> +#define UDP_MAX_SEGMENTS       (1 << 7UL)
>  #endif
>
>  #define CONST_MTU_TEST 1500
> --
> 2.40.1
>

