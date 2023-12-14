Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5038133B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573582AbjLNOzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573569AbjLNOzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:55:38 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E953C115
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:55:41 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67ef9c6745eso11052966d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702565741; x=1703170541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgs8beqFiekckw3WR8YiKzI+yNleMXeH4aOT2b+WN64=;
        b=zg93vykZglFFbm2Z1nl173j4Lx+z4LgOTPy7DPNDDN/n3N7iLfexrr5ymdAmy29gIG
         IdoPqtJuFNlFwZvOrofmuoYuh+yt/2V0U+IV8hc+9dFewlfFLd/XA/azu99ZdzJmGThU
         +eCwbHDH8s2gfB+8rkXnKL1KPumXwy1nWtRFbeVhYU4GaHgXPZeA0/cUkxW24LQddiv8
         snBpkuouOR1lZJNMQ96/QyPrwlrCeljqkDGEZhcJTfkQiiKHdeCDv/JG9yQopnnmnk7K
         OfYVqmhuRcRwyX8LCBfKQhjbraNeaOIsMX7eX1C1cCnlAUmto1bqHgqcUKVkPQRFqGP3
         tgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702565741; x=1703170541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bgs8beqFiekckw3WR8YiKzI+yNleMXeH4aOT2b+WN64=;
        b=l1vQcirMXBDmbMsNHy7rHnta5syN7sZ7eqRe/WlNNZOXAQqvJGW7EXBfHjdXnIe0FE
         YqNIxPjLH1R8jrDct8RDwD6Z3+chog/xLDKHBFWFrlLPpqQJDsnZBgu2SGoNfw6GNwhj
         E/cSBf7pUTovJ/knzjL2bqN5A8rwHdeioX0D1P6QdkjIf2Rbnkqm4X9PrNGmVmP5C50t
         xxxJTJbADMrkVC8cHlpGZEn2FDFqIN9nAy9aHsrTM4KTbpJ/JRVAgxDYDeCcvydPXSRc
         mGlQvH5sAdBqn7KRwFWjsOymbMdoRDebfYsL19TDbr/CSl2c/W1Mak4DtY2106mV6tL3
         2SPw==
X-Gm-Message-State: AOJu0YxY/Gjy/KJcvMFaXt2CMVH3bXualzn7YVMdXOccukoF8aV3OTe0
        efZnh1K0FTxymLe6hUMUwEqDsXxQlXDyzPIGVJL8CA==
X-Google-Smtp-Source: AGHT+IEsLmHEUusvZQFiGgThJYCfYEu5uL9Ur9BmC1h3zHzuSXlUlQi5+C6Xa76eUg2ZzWa4mUxgAR4OBzeNO/8uOFA=
X-Received: by 2002:a05:6214:16cc:b0:67e:ef8f:7978 with SMTP id
 d12-20020a05621416cc00b0067eef8f7978mr4056082qvz.30.1702565740942; Thu, 14
 Dec 2023 06:55:40 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f66a3005fa578223@google.com> <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh> <ZXopGGh/YqNIdtMJ@dread.disaster.area>
In-Reply-To: <ZXopGGh/YqNIdtMJ@dread.disaster.area>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Dec 2023 15:55:00 +0100
Message-ID: <CAG_fn=UukAf5sPrwqQtmL7-_dyUs3neBpa75JAaeACUzXsHwOA@mail.gmail.com>
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
To:     Dave Chinner <david@fromorbit.com>
Cc:     Dave Chinner <dchinner@redhat.com>,
        syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:58=E2=80=AFPM 'Dave Chinner' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Thu, Dec 14, 2023 at 08:16:07AM +1100, Dave Chinner wrote:
> > [cc linux-xfs@vger.kernel.org because that's where all questions
> > about XFS stuff should be directed, not to random individual
> > developers. ]
> >
> > On Wed, Dec 13, 2023 at 11:49:50AM +0100, Alexander Potapenko wrote:
> > > Hi Christoph, Dave,
> > >
> > > The repro provided by Xingwei indeed works.
>
> Can you please test the patch below?

It fixed the problem for me, feel free to add:

Tested-by: Alexander Potapenko <glider@google.com>

As for the time needed to detect the bug, note that kmemcheck was
never used together with syzkaller, so it couldn't have the chance to
find it.

KMSAN found this bug in April
(https://syzkaller.appspot.com/bug?extid=3Da6d6b8fffa294705dbd8), only
half a year after we started mounting XFS images on syzbot.
Right now it is among the top crashers, so fixing it might uncover
more interesting bugs in xfs.
