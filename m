Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7E7D297D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjJWEuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 00:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJWEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 00:50:21 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DED5B;
        Sun, 22 Oct 2023 21:50:19 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1eb6c559ab4so371200fac.0;
        Sun, 22 Oct 2023 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698036618; x=1698641418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVzo37tBEpPsCrsuD4r7mYGAnGcAebpTxOiZH6/JXBA=;
        b=dg0uNAg+PZim0errvuRkcQWYtpcgG1SzW9GtmxohbxhYI5vwCV0leBgzu97tQPJ2jz
         3M9TB0FC05e3r3vzGBmpATe6ktfHMWTcHK9qZqgTSCymIaBBrePAMY73IaqHtQRsSPXZ
         gpxgknWNs+7zyx0TBlFpkXAgxxREFhhWt/SfMIRrbDnzm3dievFCGBp3O9KMsyqx7U8A
         N/0Z0sMWIlhWeVFZ7oEFlO4iPcLrYgl/F3m07lPGJHHuDErkdjvsgJXJhXC/2A4mBH8A
         1tron6+MJKhcVZTurgvt/3tldZYrPMbdpvCAJRDIQAM60q7Mi38RPTdLIJwVEOWsdTIY
         mOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698036618; x=1698641418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVzo37tBEpPsCrsuD4r7mYGAnGcAebpTxOiZH6/JXBA=;
        b=QsRX0U0pBxzhNZ4+FecOjm0TTZAtYYepJoPxzYLR2k6XaUBxHuKVox6jLaoecq8hgc
         RnE1chxJ4D6rkeS+irNCL/q4ssffeV7hu8xXT2I/UqoVKw2t+qK2bNwBKZm8H4jZkjMt
         8todHlysUlAKTdsuh5RLlw5dvZSoi8ay/LG7mwA6ZowSA8fZEJR2y/UKgKRXqrrhyJ/Y
         9docSzL4Tvrl89w69Qbsj/4sd2WXBVoyQpkCgJEa87gulN7U0B9n1fVEKapVa0PozXvh
         ZmZosLybSE9xAHmifuBR2AKa1vLzjnuRFSpjIVWtcOp4A6CxOHZDK8+5vT5tIshdNgLC
         MYyQ==
X-Gm-Message-State: AOJu0Yzb5Ko8caj5ajgLeg1vBWEvwt+J5m8+IhdUzMQ+42vSgPt0Nnud
        pxurenZqmvk+hPZu3dkd9zUimIECwyBpSxNQIN6MGAB0
X-Google-Smtp-Source: AGHT+IGDqLguXPrkGwQqaGyLyncWWPNFdgNioQKBzZfkwOQyyznKHNYtvzJcj8zUBjS5/JxsyMDRfr9jAdKQmK8NBEQ=
X-Received: by 2002:a05:6870:12d0:b0:1d6:8b7f:ce89 with SMTP id
 16-20020a05687012d000b001d68b7fce89mr8115608oam.51.1698036618573; Sun, 22 Oct
 2023 21:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231022090633.792831-1-sergio.paracuellos@gmail.com> <1d6804f3-a5e2-4840-a4ae-7cd2632b3b64@phrozen.org>
In-Reply-To: <1d6804f3-a5e2-4840-a4ae-7cd2632b3b64@phrozen.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 23 Oct 2023 06:50:07 +0200
Message-ID: <CAMhs-H8Stk8_xWLFu2sozjXPgy2GjJMOCP2bwAH0FXxmYRr-=w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of the Ralink architecture
To:     John Crispin <john@phrozen.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 22, 2023 at 4:33=E2=80=AFPM John Crispin <john@phrozen.org> wro=
te:
>
>
> On 22.10.23 11:06, Sergio Paracuellos wrote:
> > Its been a while since I am making contributions to this architecture.
> > Hence add myself as maintainer.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>
> Acked-by: John Crispin <john@phrozen.org>

Thanks, John!
