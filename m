Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE047816FD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244561AbjHSDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244554AbjHSDKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 23:10:34 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD5E4216
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:10:32 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-34bf0b97811so38505ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 20:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692414631; x=1693019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKp6btYT5XRVMc9aXFSlcjOs7uLPloeW2Zfo5kSwwzk=;
        b=wISqlkVDp4O/Y7uHtMLqMR2wlQfr5NI58scqALE+SkUUr+XPQmGoeIg7pfghR6rfJp
         WPEYt94qCp9uDF/jr2P3/KY/DipaVFGGaFi4fRvtSnlUIhdnkpVSd9u0REx9F7ZG7c3R
         15MTQ4GcUYIaxilL7Nvu67lveVevfCgk6xwyb7/1Q3K7THzW+b7Q7YMWDPVz0pm0RE/8
         ipt1J+IDUz9AUFXEZm6f0OFJcxY/69Cp7YS44LPpbIceB5B0QIobcb8NWmHQ1bp3oxPo
         oqdK6j4fzLSnYZVvDBqPcW88PFUB2R8ubnCrZMtfcKc05CbpQlNs1EbLNTcXI8OQgY8t
         heuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692414631; x=1693019431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKp6btYT5XRVMc9aXFSlcjOs7uLPloeW2Zfo5kSwwzk=;
        b=C1hgiGRbc18zdfc7b1WPSA/N0Yv8k9IDUeu+nGrjbH/hYguGToUEb1DV616SykJ92G
         jZw7LXyZvOPCpfET3rfynWjitG6Yaw4eCuLfAB0BIqkwzQJAnLo4vn72tDBqpFi4jKM3
         b977u0nZTA44YPhePtefHRc/m54WwOhSCz6R7yVW18MoyHyVP0Cspy8LtcYnm2pscrjc
         s8NRiVfcnv5ATK5I/C5ZbZvJU2tAE2Y/FQRX6bddDhoBvnEINNB8hupMETkzVwp1Hiwj
         DBKXo0nmNcwI4DAIjRlfLHpLTwkavonKhwauyNPlY/60Uxy1ZF+NPv/KPS5c6PkwSd4y
         Xh0g==
X-Gm-Message-State: AOJu0YzkLaVDHuzGTG5wTjnRXX1yQrug+PpqzedYdKQwEk0LUggg70zM
        03+Rfd3XqBwKp1kZ3fmFlR4o804Yo83UOjj4JZXQZmO9TYOzPVr8g/g=
X-Google-Smtp-Source: AGHT+IG4bP0F3BUXPOYYG3U0HFeiRW/UGwonFjwbc0HKd8EKeEBeFk0A4YxsVJ22ps5ELA7pZQdp9KpNLknXlv3x1QI=
X-Received: by 2002:a05:6e02:12ee:b0:32f:7831:dea5 with SMTP id
 l14-20020a056e0212ee00b0032f7831dea5mr377963iln.8.1692414631283; Fri, 18 Aug
 2023 20:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me> <20230818185156.5bb662db@kernel.org>
In-Reply-To: <20230818185156.5bb662db@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 19 Aug 2023 05:10:20 +0200
Message-ID: <CANn89iLYsfD0tFryzCn2GbhrX4n+e0CPTXB6Vc=_m=U9Qi_CzA@mail.gmail.com>
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Zheao Li <me@manjusaka.me>, bpf@vger.kernel.org,
        davem@davemloft.net, dsahern@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
        pabeni@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 3:52=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 12 Aug 2023 20:12:50 +0000 Zheao Li wrote:
> > In normal use case, the tcp_ca_event would be changed in high frequency=
.
> >
> > The developer can monitor the network quality more easier by tracing
> > TCP stack with this TP event.
> >
> > So I propose to add a `tcp:tcp_ca_event` trace event
> > like `tcp:tcp_cong_state_set` to help the people to
> > trace the TCP connection status
>
> Ah, I completely missed v3 somehow and we got no ack from Eric so maybe
> he missed it, too. Could you please resend not as part of this thread
> but as a new thread?

I was waiting for a v4, because Steven asked for additional spaces in the m=
acros
for readability ?
