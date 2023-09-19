Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425167A64C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjISNV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbjISNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:21:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35454F5;
        Tue, 19 Sep 2023 06:21:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b703a0453fso94298211fa.3;
        Tue, 19 Sep 2023 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695129705; x=1695734505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4YCtSaeKIOsVXX/9czvJJANn7hd+Dn1kophFmS6+Ck=;
        b=m6Cd//8KVvylAaB6pQJ48W9XvdquSz1XF8JAdKKxWnV0Id+FDZVbEP1+UtQM2tcQ5V
         V6wAgMBI1Otp+GKVBREqh0DmlvKzSvYwqybWogzvkpiquRiHtf/PyFC6U7nplu9hNI1Y
         0KEZ9EjQXT9SuSRTpJf+ckpX5HVaoOWO+Y1clUpKRBXYdanzYWG0cMXKTrCctJLuS5o3
         Dl3aHfmt1Ysx1kRlZM6dNOpjGeiBOTX2sjmXZAALpAOfUDpGHP/oiiiN2UPRqI1vPtuc
         dMk5xstdIm5EV6FLiwm5Cf3gwwpNgPS0pqTmBgZKdHk41fK6PpjVxz4YVmknBXhcboZ8
         aVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129705; x=1695734505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4YCtSaeKIOsVXX/9czvJJANn7hd+Dn1kophFmS6+Ck=;
        b=SWrieq/Vy2aHB3VDuxFMa+lwL3heau8M8Hv2U7DwHt9zpAcVQVy3iAM3lhDpWicY3q
         f7Y4Ugbl8apgCvIrahSqU90oI9I3Py/czSObztOmBxA50+9E5H7NjT5fsWwy0JunhFts
         RiWIGeWIhCtaBrcF0xhybV0lpVCr9g8fV/79eq3Ra7Z21yal4s8fvb8VmwuNO+2bM6Ba
         mGLU2qpe3kOWkYBsrK75NSRftVpdK+theK2WUvTQLKmkdks+a4VwUqQqqot9yau/JXEF
         rGqc5V5V/ynUn1H4j2Ou+5gi9tBuw0n83NIoloBl2xXm6CW+iFAkYurB8WD71TDBWO+t
         XHqQ==
X-Gm-Message-State: AOJu0YzjsCkRmVxFuZscWFM4H2Z/SgN5z+V8fSzmfZx1Od/erLUT03wv
        55UnbW75D0iNSk2AWBX/nF5ZJOEUz101t0+WKQfqqzIRPvsYVw==
X-Google-Smtp-Source: AGHT+IGwIDNKxuJMER6QtB2u+JbqXBdDTTB4wiUqOdzU3OsfhtVnBLn852uucjrJzC+13x+ndSD11x+lxWQaMPFY91E=
X-Received: by 2002:a2e:7308:0:b0:2be:5b09:553b with SMTP id
 o8-20020a2e7308000000b002be5b09553bmr10527479ljc.8.1695129705150; Tue, 19 Sep
 2023 06:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
 <ZPfPfyIoVxw5L6El@debian.me> <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
 <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
 <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com> <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
In-Reply-To: <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
From:   Brian Pardy <brian.pardy@gmail.com>
Date:   Tue, 19 Sep 2023 09:21:33 -0400
Message-ID: <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
To:     Steve French <smfrench@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Paulo Alcantara <pc@manguebit.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 1:36=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> Does the attached patch help in your case?  It avoids starting the
> laundromat thread for IPC shares (which cuts the number of the threads
> in half for many cases) and also avoids starting them if the server
> does not support directory leases (e.g. if Samba server instead of
> Windows server).

Hello,

I applied the 0001-smb3-do-not-start-laundromat-thread-when-dir-leases-.pat=
ch
you provided against the 6.5.3 kernel.

I can confirm that it resolves this issue - no laundromat threads are
created, and the reported load average is as expected, not falsely
high.

This appears to fully fix the issue in my case.  Thank you very much!

> On Mon, Sep 18, 2023 at 10:00=E2=80=AFPM Steve French <smfrench@gmail.com=
> wrote:
> >
> > Paulo and I were discussing the laundromat thread at the SMB3.1.1 test
> > event (at SDC this week) which is now going on - will let you know
> > what we find.
> >
> > One obvious thing is that it probably isn't necessary for cases when
> > the server does not support directory leases, but we noticed another
> > problem as well.
