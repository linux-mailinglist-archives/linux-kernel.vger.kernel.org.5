Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4070E808A81
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjLGO1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjLGO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:27:44 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977A10E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:27:50 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-59063f8455eso390433eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701959269; x=1702564069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=450M0AQxIxgaM1VLNXLyeZJkmjwkJaCjk2V9n5tnm28=;
        b=kk5oat6gdB8cR3bg0bMPW0YFsiFkhaucDYzuccd2B8V1SR6ME7tvw1nGj5YmRIQlSc
         biV5owuOHZE0sphcLFsWXgj3db8gJybGk/xyrRZtS2ikFmJfa7abJ9R/O2FW8Aom6cOa
         hEwnpotpuNKbbZpYsVM8vm/mMXM7pvHRM4b/0uSuu2sXn85MPcHZyR2772y6vncNWtfw
         lMsOwdJANMlKrCA7+Dqlagpyw2EVlZ9nZ2QubEFHfL65g6d0N4qrGDXmsVvXAns8QySU
         fL7N/CPsBVOb/ID9PKAmc7bueax0DXDbUsYDdRkKn2DgrvHvKskoHEw4VYNfRKKyurkH
         p6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701959269; x=1702564069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=450M0AQxIxgaM1VLNXLyeZJkmjwkJaCjk2V9n5tnm28=;
        b=v4yPnWK0dzObz2T6BgZHZU/kDUJKPREyLrOjk+Td5qBP3MQGOOpAgC5jTbLwEQjBkQ
         bbFyA440Fr2H6jANq8OtvGntKmRIF8MNn20JX9uqkoouDAa+WkOYbPNuEfwa9jNkt+6m
         Bvkles6ZiKyGR9w59VYABOGv7vAEI8EnjWe6uYalNbaaofUx3eoiZ0gzk3JXvnY/0yZy
         PBIWtRduIytIu5WIS1R0tpMmA2Vfz9Ppwr/SsStckKObQOk6sKZwXXYRJjVxWssUoHdZ
         BH6STFCUqfeiJd6sYBg8IyCu6pD495XUPdv7Lo7wd6RHWE2g2FPxhxsc6TtA8mX6uNTm
         7a8w==
X-Gm-Message-State: AOJu0Ywew0531S0hiTRdamSLuY4lfivJOnREa08lYh3jxVk2ExaiVpP9
        yXoj4tDYBAUpZzZexk+/TwHfJ7HvXuy3br0N+27Wtw==
X-Google-Smtp-Source: AGHT+IFsS8ZotwJYg7hGsduC5QWUllce5/gQ2SPETv47QZsDRcQ1x+VKt0XD8FZpXJiSii0SSYq5G2EarHyPUgheHKw=
X-Received: by 2002:a05:6358:7581:b0:16d:b577:e9f1 with SMTP id
 x1-20020a056358758100b0016db577e9f1mr2934420rwf.9.1701959269433; Thu, 07 Dec
 2023 06:27:49 -0800 (PST)
MIME-Version: 1.0
References: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
In-Reply-To: <CABOYnLyH=PmSoP8=PdkyK5VG1vhiG8fHKg2Xie4oBrVeYbdhHw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 7 Dec 2023 15:27:10 +0100
Message-ID: <CAG_fn=XnFw0756BNQSVXUwCh7-JjzTgfp6jCvut41++PSJ9oeA@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in ip_tunnel_xmit
To:     xingwei lee <xrivendell7@gmail.com>
Cc:     davem@davemloft.net, dsahern@kernel.org,
        Eric Dumazet <edumazet@google.com>, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        syzbot+4a2c52677a8a1aa283cb@syzkaller.appspotmail.com
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

On Thu, Dec 7, 2023 at 2:28=E2=80=AFPM xingwei lee <xrivendell7@gmail.com> =
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

In the future, please consider symbolizing your reports using
syz-symbolize before sending them upstream.
