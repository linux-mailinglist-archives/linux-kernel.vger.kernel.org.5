Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7CA755A65
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 06:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjGQEAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 00:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjGQEAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 00:00:18 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996081BC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:00:16 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3457157a164so16743955ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689566416; x=1692158416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rane9LymWOzuf5nVdxKmicrrVi/5Plm4e1af1OJmuGo=;
        b=DeAi7UPa7J5RPMLgaBGKipqwjcPkkqSSXuEc9ftX8/pT3LdEynyXPvvXHsoBuoweVK
         K+W20Bcm8gviQ+3+cgoCbuF6wacfW34Xhqm1f6UBpwkNqVso9STiOkM+PAE+xBh3g41G
         CWCN3iqWakKicn8hjXfGA88G1V9z0WWvgkFxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689566416; x=1692158416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rane9LymWOzuf5nVdxKmicrrVi/5Plm4e1af1OJmuGo=;
        b=HP9vusFK8dqKbFHrXHzyQYTGRZSHgG2ZGb0YIYIdtOufpkSeKqEUBinKoOdtqgHBqX
         EVAtecicqsexE8spgGHIFmxuprEYdWQEETHj2EK+pLoCLN8So4SBjO3wLrgc+wss331S
         4MhISc0XLcvQb/0lmgNcq5TZVBkIEwso5njxrVd5vmeyPPCp0Hyzn76G6Or3bZQWAD7t
         c6+zheE/YxBdvx42rldfd8chZcs39odjW16KRQT8kBcfr0K9edUkVZEf5f8CZwjbHyB/
         jH1/lg3otV9bKsCpByhkPKTDlOfFmz5m3RXbXoHHlGVLn31RlrQP9YR64Y36wdLTdYYC
         HcHw==
X-Gm-Message-State: ABy/qLYYjr5pczs20D/oe3YtKJapSpkq7UyOhSwl/NmMgpsAVmwhxLwU
        cQfX1/8TP4n85/7IGV+aOnpcbKpRftGAh6m5zmw=
X-Google-Smtp-Source: APBJJlG9qbO0HuuEdkj+rchi5URr7GKN8CbMY1sND4AYhW0Z5oTd4AELs2VmcOmqdigxUdFqEzoCBQ==
X-Received: by 2002:a05:6e02:1410:b0:345:b923:971b with SMTP id n16-20020a056e02141000b00345b923971bmr9519578ilo.3.1689566415776;
        Sun, 16 Jul 2023 21:00:15 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id s10-20020a02cf2a000000b0042b37dda71asm4127582jar.136.2023.07.16.21.00.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 21:00:15 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-78360b822abso160889939f.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 21:00:15 -0700 (PDT)
X-Received: by 2002:a5e:890a:0:b0:77e:288d:f3c1 with SMTP id
 k10-20020a5e890a000000b0077e288df3c1mr9803357ioj.6.1689566414860; Sun, 16 Jul
 2023 21:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230421021609.7730-1-nancy.lin@mediatek.com> <ae96299cffaacdbf51beae96e3a257c95a04ac95.camel@mediatek.com>
In-Reply-To: <ae96299cffaacdbf51beae96e3a257c95a04ac95.camel@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 17 Jul 2023 11:59:38 +0800
X-Gmail-Original-Message-ID: <CAC=S1njEG2sV28XAWDw8FoQ0p5w=-sU4i+D-ESfapHMQC1ZW3Q@mail.gmail.com>
Message-ID: <CAC=S1njEG2sV28XAWDw8FoQ0p5w=-sU4i+D-ESfapHMQC1ZW3Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: fix uninitialized symbol
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

On Fri, Jul 14, 2023 at 5:27=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89)=
 <ck.hu@mediatek.com> wrote:
>
> Hi, Nancy:
>
> On Fri, 2023-04-21 at 10:16 +0800, Nancy.Lin wrote:
snip
>
> In line 566, the statement is
>
> if (nodo) {
>         comp_pdev =3D ...
> }
>
> The comment says that only ovl_adaptoer has no device node, so the
> checking should be
>
> if (type !=3D MTK_DISP_OVL_ADAPTOR) {
>         comp_pdev =3D ...
> }
>
> and later it would return when type =3D MTK_DISP_OVL_ADAPTOR,
> so there would be no problem of uninitialized symbol.

That sounds fair, but IIUC what Nancy tries to resolve here is the
false-positive Smatch warning.
How about this: given the `if (node)` block was exclusively added for
ovl_adaptor in [1], plus the init function will immediately return
after that in this case, it should be safe to do the following

```
/* Not all drm components have a DTS device node... */
if (node =3D=3D NULL)
    return 0;

comp_pdev =3D of_find_device_by_node(node);
...

if (type =3D=3D MTK_DISP_AAL ||
...
```

which is equivalent to adding a `node =3D=3D NULL` check before [1].
This should suppress the Smatch warning because `comp_pdev` will be
(again) unconditionally assigned to something, and the `type =3D=3D
MTK_DISP_OVL_ADAPTOR` line can be dropped also (optional?).

[1]: commit 0d9eee9118b7 ("drm/mediatek: Add drm ovl_adaptor sub
driver for MT8195")

Regards,
Fei
