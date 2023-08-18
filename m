Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BDA780562
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356196AbjHRFKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354040AbjHRFJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:09:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABF13D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:09:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-77a62a84855so17963039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692335384; x=1692940184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIpMh1ckMPp0pwSG3jz+S16SYpjeiHVjbokVOUrNcHs=;
        b=cWAoEPd4TGNOFoByoR9+1njrd8xoYo9sqkpyr4IZIUE7ieengL9XoGcs02d643PTqm
         NjMfH3Bgh+3G+w8cnYbKSlu8TJsSoxsoV1n4ens+sYPc4bY3YD3B1P3B3HotZQS9Yf9X
         cZxSMe3BjSKJX4hif3IoBIKtYMd3GuWRtr+bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692335384; x=1692940184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIpMh1ckMPp0pwSG3jz+S16SYpjeiHVjbokVOUrNcHs=;
        b=ayvPrga9x3l/3kVMWCWnAftTNV/cgyHpogjSjTmCghoSigbhD6L6YVY4Nb1wAAfC8v
         6y1OVHqLmUt1UReWDP0WcS3c9H+GZVXasrAgB4MP/elCOFnmwGIPv9/UmCUnQ7ic+n4o
         PjMCzPh8tAQ3bpPuWYUuMpya/L4ezHdYWZe9smnDSmGYvWWSG1s+MYVtl1logqlrukDn
         zRcNGPZB1JD2qJnUbS5sIcuH5ODmIMWJFyBtMmoWUVyOToMz+QvRgXct8JhyyPeVhW4m
         A8lQzk6jMrbd+a4UVmfUQX//qin24Wg5N2zG/H2vdwanK3vwfmnnnoEJW5JBtjU/SC3/
         hFsA==
X-Gm-Message-State: AOJu0YwTDNQKSAl/8j0WNztMZHYr3nKpB2V15zTDm3J5T4BtMIf+wpVF
        SnsHgKOJPV6C9UJ+TzQl/GQMCgXXSOLYS2naITM=
X-Google-Smtp-Source: AGHT+IFvdieOZULnG0M5XJh81sXcdla7s/wkQkMzoTGT3J4E74Tr2dAipNgxjWyFursKV1LhvD+AsA==
X-Received: by 2002:a05:6602:3049:b0:783:47cd:27b5 with SMTP id p9-20020a056602304900b0078347cd27b5mr1868036ioy.3.1692335384044;
        Thu, 17 Aug 2023 22:09:44 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id z8-20020a02cea8000000b0043193e32c78sm293085jaq.152.2023.08.17.22.09.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 22:09:41 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77a62a84855so17962539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 22:09:41 -0700 (PDT)
X-Received: by 2002:a05:6602:22d3:b0:783:5452:e343 with SMTP id
 e19-20020a05660222d300b007835452e343mr1848533ioe.14.1692335380847; Thu, 17
 Aug 2023 22:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230717173934.1.If004a6e055a189c7f2d0724fa814422c26789839@changeid>
 <CAC=S1nhFP6+fo-OU86PzCMtK77x+X23C1O4Bt=hxOsC+xzVGig@mail.gmail.com>
In-Reply-To: <CAC=S1nhFP6+fo-OU86PzCMtK77x+X23C1O4Bt=hxOsC+xzVGig@mail.gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 18 Aug 2023 13:09:04 +0800
X-Gmail-Original-Message-ID: <CAC=S1njm0ExE3DvWZQyPBm7LC8P_aJXX0xVY=fPuGBe1BKVmwg@mail.gmail.com>
Message-ID: <CAC=S1njm0ExE3DvWZQyPBm7LC8P_aJXX0xVY=fPuGBe1BKVmwg@mail.gmail.com>
Subject: Re: [PATCH] spmi: mediatek: Fix UAF on device remove
To:     Yu-Che Cheng <giver@chromium.org>
Cc:     James Lo <james.lo@mediatek.com>, Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just to float this up. Any feedback on this?


On Tue, Jul 18, 2023 at 2:57=E2=80=AFPM Fei Shao <fshao@chromium.org> wrote=
:
>
> On Mon, Jul 17, 2023 at 5:41=E2=80=AFPM Yu-Che Cheng <giver@chromium.org>=
 wrote:
> >
> > The pmif driver data that contains the clocks is allocated along with
> > spmi_controller.
> > On device remove, spmi_controller will be freed first, and then devres
> > , including the clocks, will be cleanup.
> > This leads to UAF because putting the clocks will access the clocks in
> > the pmif driver data, which is already freed along with spmi_controller=
.
> >
> > This can be reproduced by enabling DEBUG_TEST_DRIVER_REMOVE and
> > building the kernel with KASAN.
> >
> > Fix the UAF issue by using unmanaged clk_bulk_get() and putting the
> > clocks before freeing spmi_controller.
> >
> > Reported-by: Fei Shao <fshao@chromium.org>
> > Signed-off-by: Yu-Che Cheng <giver@chromium.org>
>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>
