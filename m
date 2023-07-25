Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CCF76052E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 04:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGYC0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 22:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGYC0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 22:26:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD29FCD;
        Mon, 24 Jul 2023 19:26:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7680e3910dfso538196685a.0;
        Mon, 24 Jul 2023 19:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690251974; x=1690856774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TehF5S5/JfahrMU4aaOoZH7A4B9KyduEfvtKt7cNHIo=;
        b=rJ10GbD3//nGpTe9w3MNfRM2UQWvQqKclUq7RGKrUV/jxmFCkXYLAlKtselijB6wVl
         KOeFJiIhmLykBWETdLEk109D5kQThrifuqVKQA20WJ4+mFmHzHRykrUvZwaLRnRgdzgm
         L5HfwE7a9VDK8IEZ6KKlMS/Wg1jzam2Sdiz/7bLsy0dHpVjBLuNq9tAfjmvB6QeKw1lR
         v2nOLdPx0HOFsKBZ38lS9jWjkKb/DkslUREn5GWZjqRvxQHi59j6ygfAPbrSieut0sN2
         vINrY83GzT9lKejL/NBqQ3mpDpnuqcDlp/9aCrzaGaPbzUD4ULTRv23C8PIErJsLzN4D
         /ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690251974; x=1690856774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TehF5S5/JfahrMU4aaOoZH7A4B9KyduEfvtKt7cNHIo=;
        b=TD5mB3vPhMHQkucaVWkLgj2KuAAB/E/uDmSmMPUdg2qHpilZ5yvBoA0YA4Ixc9aLqA
         hJaxVl4jRk5vuXhLSSm7bzzPDZXW67mH3MXb75F9w5ekY+L8rfXaDFPvupQv6j6BIHjl
         U9feDRDx0HsTjQsnZoBc/PFrYTA/Z5ktptG/GWNu0Uw9PCWIDQwcpSEQj8llrnE546YY
         ebi5ipVROhE7mok2CsZO+2B/eA9pVsSrS/YUP52NxX0u+VKHnMdOFF1sqc5xzS7ESEAo
         17Kwl1I0TZiaNldzz+flDlB3NCicyqqZ7uYKagpK5fYI78VJhQMyNSFhW7qspPPYn2iF
         bwgg==
X-Gm-Message-State: ABy/qLb7D9G6yVhnoNmC5EDJo/yPvmvm0RfNqUtTexgO4couH+0Zg7d0
        wPqAgjuva9+SV6uTZfEBBsxkRdEPe4sgMXTfbF0=
X-Google-Smtp-Source: APBJJlFYxvvv2jrRLg6RQxmXWtetuQy0EACAabJAoi6cVXPJLtqX+cuOh8ickvhv/01nB4+siEnWeCINZfEW2UvYBd0=
X-Received: by 2002:a05:620a:4549:b0:765:22d4:b267 with SMTP id
 u9-20020a05620a454900b0076522d4b267mr2234791qkp.52.1690251973593; Mon, 24 Jul
 2023 19:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230311180630.4011201-1-zyytlz.wz@163.com> <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org> <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
 <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru> <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
 <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com>
 <20230717130408.GC1082701@google.com> <20230724092055.GB11203@google.com>
In-Reply-To: <20230724092055.GB11203@google.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Tue, 25 Jul 2023 10:26:00 +0800
Message-ID: <CAJedcCzrLMVGKmTR-21Uk2EVRhX5fRmEZ95btg_XOpsN33UU6A@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ravb: Fix possible UAF bug in ravb_remove
To:     Lee Jones <lee@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jakub Kicinski <kuba@kernel.org>,
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

Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8824=E6=97=A5=E5=
=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, 17 Jul 2023, Lee Jones wrote:
>
> > On Sun, 16 Jul 2023, Zheng Hacker wrote:
> > > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E5=91=A8=E6=97=A5 10:11=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Hello,
> > > >
> > > > This bug is found by static analysis. I'm sorry that my friends app=
ly
> > > > for a CVE number before we really fix it. We made a list about the
> > > > bugs we have submitted and wouldn't disclose them before the fix. B=
ut
> > > > we had a inconsistent situation last month. And we applied it by
> > > > mistake foe we thought we had fixed it. And so sorry about my late
> > > > reply, I'll see the patch right now.
> > > >
> > > > Best regards,
> > > > Zheng Wang
> > > >
> > > > Sergey Shtylyov <s.shtylyov@omp.ru> =E4=BA=8E2023=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E5=91=A8=E6=97=A5 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > > >
> > > > > On 7/15/23 7:07 PM, Zheng Hacker wrote:
> > > > >
> > > > > > Sorry for my late reply. I'll see what I can do later.
> > > > >
> > > > >    That's good to hear!
> > > > >    Because I'm now only able to look at it during weekends...
> > > > >
> > > > > > Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8812=
=E6=97=A5=E5=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > > >>
> > > > > >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> > > > > >>
> > > > > >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > > > > >>>> For better or worse, it looks like this issue was assigned a=
 CVE.
> > > > > >>>
> > > > > >>> Ugh, what a joke.
> > > > > >>
> > > > > >> I think that's putting it politely. :)
> > >
> > > After reviewing the code, I think it's better to put the code in
> > > ravb_remove. For the ravb_remove is bound with the device and
> > > ravb_close is bound with the file. We may not call ravb_close if
> > > there's no file opened.
> >
> > When you do submit this, would you be kind enough to Cc me please?
>
> Could I trouble you for an update on this please?
>
> Have you submitted v4 yet?

Sorry, will do right now.

Best regards,
Zheng
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
