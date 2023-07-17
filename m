Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890E6756492
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231749AbjGQNWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjGQNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:21:46 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EB111C;
        Mon, 17 Jul 2023 06:21:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8bd586086so36098505ad.2;
        Mon, 17 Jul 2023 06:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689600092; x=1692192092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2+TqzzMMJ8tIs0YiQkQJBe8T5oRWHDzcE3x8WKO+0g=;
        b=LGoroM2Fs7bytsFkuU9SMW7CiFdWXh0kCW7DfmzMVRcTyX6jK4jjiqM1U8AhvXXFgH
         mCUEvEJJghTOAw5YLrY8JCR0VdI8n69FbnpXcCbEddBNV4NK8w6lZmDauCMi4Xqw0LJ8
         I+yo2+ek91pwDd0B2Z8oLD19VW32bKkk+3Yzie0/KW8x8mMT5gP0S8Ywcmc1djn4RsOD
         lONvcL7XHWgu93rksXiQ2GYRTdfXujpCemWLon+eNttNOzS1vfzivPDJkzXycS66JzWz
         ldFq3LSL+iDcZOOd5FRv1RZkuUGrAVSJSDEQBat3eCdHx8xycHY0GaQWlvxZI64TipYN
         8/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600092; x=1692192092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2+TqzzMMJ8tIs0YiQkQJBe8T5oRWHDzcE3x8WKO+0g=;
        b=IsJmWE+sDyix+h7ujXGeC/WjnKNP+sNZj8FC3Bb6Rxk8vasVnW5KmtpbLmSmqMEtQm
         7oEEOMnj3w72701AAMSjw4I7JT25HrHsiqe3zSGEcQhpz5/zW5Xv7/SJoZqE16OPz1Tv
         ObRAVa5f9xCUEzXYhRCg2Uj0zreKqy8gfQ/A9Fpf+pRprGZDMh6y7CuPmVk9cjgTCRhb
         sD/1A8/5MQ2a6GzZc1sOHNPbdpUqxOiPNFjX3FDUWfnnIueMXgUMqUm/MKUw5s/pl5z6
         BqfZQQzjlfTOphy1XDOCrXDISYTDwpBe4LMfrBr3tlilxa8dSzldUS/QAiBwzjlObtQi
         NCrw==
X-Gm-Message-State: ABy/qLbdRytOeBwGHPTdvt+WgeisqshZtjEzjI1y2YgDXMzy2PfFM+58
        JFxXh50Gs1pbuaZiAP4lR3uxmD/FehtVu4KlmSk=
X-Google-Smtp-Source: APBJJlHqjpsNqE2MbqN0SJFcETqZDMlqUnoOdBLQnh76NNmR/LEL3VNeuq+aK3qLOMmXmme0QKsEao4F7OYcG5BJ+OY=
X-Received: by 2002:a17:902:d507:b0:1b8:5bd0:fe12 with SMTP id
 b7-20020a170902d50700b001b85bd0fe12mr14958744plg.16.1689600091991; Mon, 17
 Jul 2023 06:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230311180630.4011201-1-zyytlz.wz@163.com> <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org> <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com>
 <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru> <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
 <CAJedcCydqmVBrNq_RCDF2gRds39XqWORFi32MV+9LGa5p28dPQ@mail.gmail.com> <20230717130408.GC1082701@google.com>
In-Reply-To: <20230717130408.GC1082701@google.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Mon, 17 Jul 2023 21:21:17 +0800
Message-ID: <CAJedcCw4oLmc3PgOjo-wf92KoPv0hDFvgT7ZFxXtcrS+QoEgTg@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8817=E6=97=A5=E5=
=91=A8=E4=B8=80 21:04=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, 16 Jul 2023, Zheng Hacker wrote:
> > Zheng Hacker <hackerzheng666@gmail.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=
=8816=E6=97=A5=E5=91=A8=E6=97=A5 10:11=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Hello,
> > >
> > > This bug is found by static analysis. I'm sorry that my friends apply
> > > for a CVE number before we really fix it. We made a list about the
> > > bugs we have submitted and wouldn't disclose them before the fix. But
> > > we had a inconsistent situation last month. And we applied it by
> > > mistake foe we thought we had fixed it. And so sorry about my late
> > > reply, I'll see the patch right now.
> > >
> > > Best regards,
> > > Zheng Wang
> > >
> > > Sergey Shtylyov <s.shtylyov@omp.ru> =E4=BA=8E2023=E5=B9=B47=E6=9C=881=
6=E6=97=A5=E5=91=A8=E6=97=A5 04:48=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > On 7/15/23 7:07 PM, Zheng Hacker wrote:
> > > >
> > > > > Sorry for my late reply. I'll see what I can do later.
> > > >
> > > >    That's good to hear!
> > > >    Because I'm now only able to look at it during weekends...
> > > >
> > > > > Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
> > > > >>
> > > > >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> > > > >>
> > > > >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> > > > >>>> For better or worse, it looks like this issue was assigned a C=
VE.
> > > > >>>
> > > > >>> Ugh, what a joke.
> > > > >>
> > > > >> I think that's putting it politely. :)
> >
> > After reviewing the code, I think it's better to put the code in
> > ravb_remove. For the ravb_remove is bound with the device and
> > ravb_close is bound with the file. We may not call ravb_close if
> > there's no file opened.
>
> When you do submit this, would you be kind enough to Cc me please?
>

Oh sorry for my rudeness. I use reply to all in gmail and it didn't
add new people from conversation.

MBR,
Zheng
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
