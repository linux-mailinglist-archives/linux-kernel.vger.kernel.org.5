Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89262754D1E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 04:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGPCL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 22:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGPCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 22:11:27 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E72926BC;
        Sat, 15 Jul 2023 19:11:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bb119be881so19607365ad.3;
        Sat, 15 Jul 2023 19:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689473487; x=1692065487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn0EIyGnlylaENr4vT9xOVYeZ5S7Jm5TkxJzeurZYWQ=;
        b=NZ/xTRcOMYhG0+RQ3PJONe++H9Xh5IaIN3MNc5WuHJtaExjup07tgqo/vjuGee1lEb
         hdNj9Gofiv3mT3G73B6uic3SOrBI5OHEH8A/2cWbWBEp5IxoxW2BGrVOuWt3nBtTLXkh
         iql+ymEu8Hl6+61ZLq/EDrVTFPbF5jp9eLOxGz1rr7OziVMU7cE1OdtxKZZYOF6VjEyE
         Hb76CZReZyBasF4CgyFPSk2dSDDQpaMp9SWGD9WGokGZviFguvdkqFA+FMpGsfQPn+8T
         gp7s4UZy4iM2uKVXzeQ3N07FlgbPuxO25RnH8pWIrhQhJT4YFIg6LsCTlG0zSQ/vbZ+Q
         rapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689473487; x=1692065487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xn0EIyGnlylaENr4vT9xOVYeZ5S7Jm5TkxJzeurZYWQ=;
        b=jydbpo5tyKItPVuDj7pE6i0mxfhFku4H+zLpdP35Y2Pd5dDL3JjA4CTuEUHzOEasaB
         +i47d4yAfGkB7q6K2P73XQH135/JHQ8eFdFfL0Oitr6D+TOzCZtg25L6o3BXJtgD16dX
         xQAq8eqqvmOhFSEtGNnk9mrChuQvU6fY7XA3hegzAEU8nsp/8eoX0J9vujL9IeDilJcc
         lfHCNNd0Rbant6DD7sMwkpBgMLnHetta/aIlpSdq+fG3lIOmGqOUKiFiW5TDnhVt4Psh
         VfMI95CJVhPyx2pF6J9iW1fUi/+rPcrBdjVo86WvjV7rYz/yRAkRQ+eoHwfrKVMLhyoT
         DQuw==
X-Gm-Message-State: ABy/qLa9Qt9/RGEK0UcpAyZo3koFOihvYatsmOUWOkI2O7JdhQtkYCdQ
        o7tuynVwSSxU/AC98OfKircLfaXONbkYH/qZj/Q=
X-Google-Smtp-Source: APBJJlEWJlam47kOg2xbJSYC5NJ3ot3rjqU13O2YqgfgxkdcdE5HzW2x0Fps3wb2tK3/4Xyo19gGSymRXmk8yTtz/eQ=
X-Received: by 2002:a17:902:aa05:b0:1b6:9954:2037 with SMTP id
 be5-20020a170902aa0500b001b699542037mr8311933plb.4.1689473486566; Sat, 15 Jul
 2023 19:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230311180630.4011201-1-zyytlz.wz@163.com> <20230710114253.GA132195@google.com>
 <20230710091545.5df553fc@kernel.org> <20230712115633.GB10768@google.com>
 <CAJedcCzRVSW7_R5WN0v3KdUQGdLEA88T3V2YUKmQO+A+uCQU8Q@mail.gmail.com> <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru>
In-Reply-To: <a116e972-dfcf-6923-1ad3-a40870e02f6a@omp.ru>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Sun, 16 Jul 2023 10:11:13 +0800
Message-ID: <CAJedcCz1ynutATi9qev1t3-moXti_19ZJSzgC2t-5q4JAYG3dw@mail.gmail.com>
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
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This bug is found by static analysis. I'm sorry that my friends apply
for a CVE number before we really fix it. We made a list about the
bugs we have submitted and wouldn't disclose them before the fix. But
we had a inconsistent situation last month. And we applied it by
mistake foe we thought we had fixed it. And so sorry about my late
reply, I'll see the patch right now.

Best regards,
Zheng Wang

Sergey Shtylyov <s.shtylyov@omp.ru> =E4=BA=8E2023=E5=B9=B47=E6=9C=8816=E6=
=97=A5=E5=91=A8=E6=97=A5 04:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On 7/15/23 7:07 PM, Zheng Hacker wrote:
>
> > Sorry for my late reply. I'll see what I can do later.
>
>    That's good to hear!
>    Because I'm now only able to look at it during weekends...
>
> > Lee Jones <lee@kernel.org> =E4=BA=8E2023=E5=B9=B47=E6=9C=8812=E6=97=A5=
=E5=91=A8=E4=B8=89 19:56=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, 10 Jul 2023, Jakub Kicinski wrote:
> >>
> >>> On Mon, 10 Jul 2023 12:42:53 +0100 Lee Jones wrote:
> >>>> For better or worse, it looks like this issue was assigned a CVE.
> >>>
> >>> Ugh, what a joke.
> >>
> >> I think that's putting it politely. :)
> >>
> >> --
> >> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
>
> MBR, Sergey
