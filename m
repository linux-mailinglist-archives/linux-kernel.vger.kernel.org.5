Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210D7754D31
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 05:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGPDO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 23:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGPDOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 23:14:54 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6F1989;
        Sat, 15 Jul 2023 20:14:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-55adfa61199so2559397a12.2;
        Sat, 15 Jul 2023 20:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689477293; x=1692069293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICMSSVeiBrVofCGkySAb9Cekr6bX8g3asYFKdXXFpN0=;
        b=Kbj+eHlBHCJDVIJnt09T7h8pnyEXeJd6L9Y1H7OZoi1fznb+R4g1+j8gOuWdBgw+BH
         0ROJRs3m4kTBM3MOSDqxhHysiZb40ojeYwCCQEy2ZaiCfOY6+6OEFmlu8a40IMccf1A+
         ab2mI7rPtkQZqvo272+108tyoYgw5SRBRbyRDafiAnP2X12XSENBxbVD7VqgxdK76aqB
         ZGXGmZDjWYgnnFUQtkHDP3Wl+k4tFAFQJbvMNtljccZoqKSWhDJm2Nj8S5Cls2ojVOxK
         tw69Z4wo5VAceZDZvRViotnhR2huQWqdHHDfqkiqJGVz15J3TZU9RbhAzsX1IXxx9vtl
         ZOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689477293; x=1692069293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICMSSVeiBrVofCGkySAb9Cekr6bX8g3asYFKdXXFpN0=;
        b=JJRO8Nho174SGqq806UHGozO1s6LiybND2MPVuHi9+E+JkZRgiihkzoddHMo3OTiuS
         Dzt+eMVP1gn4OhP/rxGjEam0N/zySMK+j2tCRtyismOuBKrO4O8vMPa0KxuiSzpWZjNP
         C1uCJdZ5oC0Rg3Rb1n5fZZYbHNf5SzRpnedw5Vb7iSTNDHXKckL+ns9Y3atk8inLC7Pc
         UqdP4jooIwZQVananByd0l01QpmhQLRiX0OUoJ0r5v5iMzz2siJiBpgiHJj6aXOGJY4b
         C8Rwb3lbGQhqH8qtXawNoL/iLyOLxVx46iYOaUMQsRgg75Vzet55i4dVLx/XhNuSYLQz
         1vrA==
X-Gm-Message-State: ABy/qLYFodP3b48zqzEkw2Z/iOZnRpou/zy75JeApJER9IWaZmv1xBIb
        r6LEcdQY5ISxc42zlBWPP68wdCkPv6AqeToU0cw=
X-Google-Smtp-Source: APBJJlFeF0LRa/YszX4TpbE6cZ2c8YvBpz8DqiZq8aKOjvNyD5vKSucyq5t/qi0sbAsnsYiyGButsrZtokWjy4PFPqQ=
X-Received: by 2002:a17:902:e5cf:b0:1b8:aee8:a21c with SMTP id
 u15-20020a170902e5cf00b001b8aee8a21cmr11354241plf.31.1689477293095; Sat, 15
 Jul 2023 20:14:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230311180630.4011201-1-zyytlz.wz@163.com> <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org> <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
 <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru> <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
In-Reply-To: <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 16 Jul 2023 11:14:40 +0800
Message-ID: <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Zheng Wang <zyytlz.wz@163.com>, davem@davemloft.net,
        linyunsheng@huawei.com, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After reviewing the code, I think it's better to put the code in
ravb_remove. For the ravb_remove is bound with the device and
ravb_close is bound with the file. We may not call ravb_close if
there's no file opened.

Thanks,
Zheng

Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=8816=
=E6=97=A5=E5=91=A8=E6=97=A5 10:11=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> This bug is found by static analysis. I'm sorry that my friends apply
> for a CVE number before we really fix it. We made a list about the
> bugs we have submitted and wouldn't disclose them before the fix. But
> we had a inconsistent situation last month. And we applied it by
> mistake foe we thought we had fixed it. And so sorry about my late
> reply, I'll see the patch right now.
>
> Best regards,
> Zheng Wang
>
> Sergey Shtylyov <s.shtylyov@omp.ru> =E4=BA=8E2023=E5=B9=B47=E6=9C=8816=E6=
=97=A5=E5=91=A8=E6=97=A5 04:48=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On 7/15/23 7:07 PM, Zheng Hacker wrote:
> >
> > > Sorry for my late reply. I'll see what I can do later.
> >
> >    That's good to hear!
> >    Because I'm now only able to look at it during weekends...
> >
> > > Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8812=E6=97=
=A5=E5=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
> > >>
> > >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> > >>
> > >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > >>>> For better or worse, it looks like this issue was assigned a CVE.
> > >>>
> > >>> Ugh, what a joke.
> > >>
> > >> I think that's putting it politely. :)
> > >>
> > >> --
> > >> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> >
> > MBR, Sergey
