Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F37A778EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjHKMKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 08:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbjHKMKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 08:10:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E92D7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:10:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe2d620d17so53915e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 05:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691755814; x=1692360614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xu6DZKYIwcsD4P+y8KEh5Oi6UU6dKLHkbw3fU+376V4=;
        b=b3F2DFZnBbFO/7vPJ28nBXOzqpvZCaE9wy2WUsCqSu09y9FlggCT6dXiHOVBh9K0U9
         nkBOb4hTl3daLgOLy+b7OOlSwKpO5NP2mX2npn2/YZauBmcI29PyE/ARANBY+EvL3Fbq
         FvAnfMWBFQEKA4RfWf7TxCCccE5aLhOx169GxKaZETGpGAO9HlA8UsnAhcpHP/hzMLm3
         dhpr7UtDqSjiymytSB2iVsFruS1Di2EB2lHpzPdVfRFPNp/AfcUx5vpdr/yXMJEgnbEj
         k0aOmzZK8d65/2f9tU3F5Ei0lsfBcmI4UUBABsg0tHwIcXmuqkmAFDBxD3wEHydlaLJd
         6LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691755814; x=1692360614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xu6DZKYIwcsD4P+y8KEh5Oi6UU6dKLHkbw3fU+376V4=;
        b=jZhrbsV5QjVUHJzeDjYDc/gkaXMLEb4rD9cfM6qkkcA/pyHGB7H7pDvLNmulHu98L/
         Rtz8L77QmfNOpnDBgccR/xMKgN+aUmWpKznPOApG04Clksf7ssMRVyjCId6kf3lD/YUG
         tTJCwYi5yfZNZs6om7x7HU0JlmNT2bs3r2HEanjCxxeqX1TWVrFwA4a0a4mChqtpq1m0
         8HqIzH4aLKh3H1MRhmIdrLmPaKch78xRPpBdRzUqTt2gSssbBzV1cfODZayYoXrr8kvd
         lxe/6zdnga1q828XLfUajWDwSpwJhcIR3XFq46WtNTRe3P/oLBoh/9CNDXyt8X0rdNcx
         eq6Q==
X-Gm-Message-State: AOJu0YyFbkJ1Y8EvoEbCNFdj9gOKU5WiBVSm6KU/qBw7zoLOeo3mg9en
        CdgKsAPLgsXJXGxQ66dUuoXi1AQqgHtugABr+9HAkg==
X-Google-Smtp-Source: AGHT+IHA/tBLdHYzKZapNH78vQKHpICoHHjLFPUsBiFvxpQU7tUAfjDvJxz6zxirAzK0+twmMwanIindDPmjAJ1gzpg=
X-Received: by 2002:a05:600c:3ba2:b0:3f7:3e85:36a with SMTP id
 n34-20020a05600c3ba200b003f73e85036amr71114wms.7.1691755814134; Fri, 11 Aug
 2023 05:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b35ea205ffc35fe1@google.com> <000000000000efbc2306024b74cf@google.com>
 <CANp29Y6ow1PS1NaiX-aSpRqGJQv0bE2QhzCBuhO-vEJa8RgjAw@mail.gmail.com>
In-Reply-To: <CANp29Y6ow1PS1NaiX-aSpRqGJQv0bE2QhzCBuhO-vEJa8RgjAw@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Fri, 11 Aug 2023 14:10:02 +0200
Message-ID: <CANp29Y6LeRCG=6p7OsJa3TCoVvuMeomMiAtC7=ZvyUPoJV3T_g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in validate_mm (2)
To:     syzbot <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, jonathan.cameron@huawei.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luca@z3ntu.xyz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: mm: validate the mm before dropping the mmap lock

On Mon, Aug 7, 2023 at 2:11=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com>=
 wrote:
>
> On Mon, Aug 7, 2023 at 3:49=E2=80=AFAM syzbot
> <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com> wrote:
> >
> > syzbot suspects this issue was fixed by commit:
> >
> > commit ef513aa7aa5038d2f53e9f2932af5006f37ed0b6
> > Author: Luca Weiss <luca@z3ntu.xyz>
> > Date:   Thu Apr 13 23:17:49 2023 +0000
> >
> >     dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-scaling
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11aeb085=
a80000
> > start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git=
.ke..
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df5e1158c5b2=
f83bb
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D70b97abe3e253=
d1c3f8e
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1511d490a=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D130e5cfb280=
000
> >
> > If the result looks correct, please mark the issue as fixed by replying=
 with:
> >
> > #syz fix: dt-bindings: iio: adc: qcom,spmi-vadc: Allow 1/16 for pre-sca=
ling
>
> No, that's wrong. Please ignore the email.
>
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bise=
ction
> >
