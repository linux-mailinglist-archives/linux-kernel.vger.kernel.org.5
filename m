Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4EA7CD90D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjJRKVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbjJRKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:21:25 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43701EA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:21:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c50906f941so74062221fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1697624481; x=1698229281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NQmXh5DgD5FCRDoX7njGdeBFSEHaOg28db7b5cONLI=;
        b=hCWC5qQ3kxsv36wzbYR+1Q5XqtxC7HoTJ4vdsg6fZV94PgP/RUYGTs9JwpWHBGaxRm
         y2nEp7k/x8cwNQpjBjCxNN5BL5iV3OEDqNwLoqxa6YozchIKgXYkiK0aHHoluf7RXP71
         96a0ZBgB3Eqy3o2U9pzmG5+2YNfjuVqv2gXV0D89vFz71ARF/BFVsvWwGgbL1FMBG7UY
         xq97tps4DsR+HjKVGKtasQuS4Rle/ZssfXtUpeRu/HeMsKXUe5Tm+yWC1cvLVRhR3gmf
         BIjKY7VcZeGPG9mwyD9Su/nGMvb5Gv0M0WyPFwxmc8w8UWFnk+6Yqv9gcc/W0LhHNcA+
         VHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697624481; x=1698229281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NQmXh5DgD5FCRDoX7njGdeBFSEHaOg28db7b5cONLI=;
        b=tPDBTtbgrYQf6yKrq+spLkKxHbsjeVn98LVM0/uhBYueUDaBbhhThGIFZRJaTudI6+
         lCwVSQo6sLRBMd3Wey97XGeE68I5VmS6oDpck5x8NdjlpJFcpH/qQzRYq8AxbPbQMa7H
         Pz74959WC6DBROVjCWwRDfkTqJWSUPWd2pKgrypRV9Rk2bezRa08Rjle4iDlKUpDgEmH
         5wOHsPnU0rtCLo4di+Ul5TLiXKOf7SJTVuErzNZ95a5H5s/wKKUKct/xyR/19Nnl2HIn
         bDzMS5vnrQjtJagyVqTGtNwTQh/wbWlsaFVM5RBSU+4lLXUdwWdwKjM5BSmPLcNI2m0e
         MsyA==
X-Gm-Message-State: AOJu0YyM7Nm0vgnZYjMfJMx4H8RuTBUvrUNpm1KHLmS/JFQ1UPck3/Tg
        yh2kW8hERLuG3z9PLuMxYLK5w4D2jugp7bgXUd/K0A==
X-Google-Smtp-Source: AGHT+IHCHzoxf5Bypv8cy8suMlcvN6Q2pNRWjFR44l+m3kMIH8AMxPDEBvhAy0UwdK8hQfqDjSOAB67tIS7ywAzfGIg=
X-Received: by 2002:a2e:8502:0:b0:2be:58f3:ccee with SMTP id
 j2-20020a2e8502000000b002be58f3cceemr3615874lji.41.1697624481214; Wed, 18 Oct
 2023 03:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <202310172247.b9959bd4-oliver.sang@intel.com>
In-Reply-To: <202310172247.b9959bd4-oliver.sang@intel.com>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Wed, 18 Oct 2023 12:21:10 +0200
Message-ID: <CAKPOu+_T8xk4yd2P4KT4j3eMoFqwYmkxqDHaFtv4Hii5-XyPuA@mail.gmail.com>
Subject: Re: [linux-next:master] [drivers/char/mem] 1b057bd800:
 stress-ng.splice.ops_per_sec -99.8% regression
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 5:07=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>     743.57          +334.3%       3229 =C4=85  3%  stress-ng.splice.MB_pe=
r_sec_splice_rate
>   7.46e+08           -99.8%    1373628 =C4=85  3%  stress-ng.splice.ops
>   12433266           -99.8%      22893 =C4=85  3%  stress-ng.splice.ops_p=
er_sec

I think this might be caused by a bug in stress-ng, leading to
blocking pipe writes.

This is how it looks before my patch:

 openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 4
 pipe2([5, 6], 0)                  =3D 0
 fcntl(6, F_SETPIPE_SZ, 65536)     =3D 65536
 [...]
 write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
"...,
65536) =3D 65536
 splice(5, NULL, 8, NULL, 65536, SPLICE_F_MOVE) =3D 65536
 [...]
 splice(5, [1], 6, [1], 4096, SPLICE_F_MORE) =3D -1 ESPIPE (Illegal seek)
 splice(4, NULL, 6, [1], 65536, SPLICE_F_MOVE) =3D -1 ESPIPE (Illegal seek)
 splice(5, [1], 13, NULL, 65536, SPLICE_F_MORE) =3D -1 ESPIPE (Illegal seek=
)
 splice(4, NULL, 6, NULL, 0, 0)    =3D 0
 splice(4, NULL, 6, NULL, 1,
SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|0xfffffff0)
=3D -1 EINVAL (Invalid argument)
 splice(4, NULL, 6, NULL, 1, 0)    =3D -1 EINVAL (Invalid argument)
 splice(6, [0], 6, [0], 4096, SPLICE_F_MOVE) =3D -1 ESPIPE (Illegal seek)
 [...]
 write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
"...,
65536) =3D 65536

Each iteration writes 65536 bytes into the pipe and then reads those
65536 bytes back from the pipe.

After my patch (but "use_splice" disabled manually so the syscalls are
the same):

 openat(AT_FDCWD, "/dev/zero", O_RDONLY) =3D 4
 pipe2([5, 6], 0)                  =3D 0
 fcntl(6, F_SETPIPE_SZ, 65536)     =3D 65536
 [...]
 write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
"...,
65536) =3D 65536
 splice(5, NULL, 8, NULL, 65536, SPLICE_F_MOVE) =3D 65536
 [...]
 splice(5, [1], 6, [1], 4096, 0)   =3D -1 ESPIPE (Illegal seek)
 splice(4, NULL, 6, [1], 65536, SPLICE_F_MORE) =3D -1 ESPIPE (Illegal seek)
 splice(5, [1], 13, NULL, 65536, 0) =3D -1 ESPIPE (Illegal seek)
 splice(4, NULL, 6, NULL, 0, SPLICE_F_MOVE|SPLICE_F_MORE) =3D 0
 splice(4, NULL, 6, NULL, 1,
SPLICE_F_MOVE|SPLICE_F_NONBLOCK|SPLICE_F_MORE|SPLICE_F_GIFT|0xfffffff0)
=3D -1 EINVAL (Invalid argument)
 splice(4, NULL, 6, NULL, 1, 0)    =3D 1
 splice(6, [0], 6, [0], 4096, 0)   =3D -1 ESPIPE (Illegal seek)
 [...]
 write(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0=
"...,
65536) =3D 61440
 --- SIGALRM {si_signo=3DSIGALRM, si_code=3DSI_KERNEL} ---

Just as before, each iteration reads 65536 bytes from the pipe, but it
will write an additional byte into the pipe, because the second
splice(/dev/zero) did not fail with EINVAL!
The next write() blocks because the pipe buffer is already full,
eventually killing the process with SIGALRM due to timeout.

Oliver, am I on the right track here? Is this really a bug in stress-ng?

(I still don't get why the throughput increases.)

Max
