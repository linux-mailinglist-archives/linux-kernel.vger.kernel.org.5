Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38D37BE587
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377780AbjJIPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbjJIPwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:52:38 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9859C133
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:52:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5a4c073cc06so47819527b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696866743; x=1697471543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h3tvF9Aa+S+aWzN6tHoBixZGqS5pfUK27UfZ/4HscM=;
        b=reegtI8/fSFEhmh+ioXe3pjz2RLHA52cXT7dF2S/OmVOFmea59SfcT4LNnnna2884e
         Q2c/GwbLoweXWeNkmrcDyDT/8B0vinyGrbv8T7wgtjb2NFwdwHSTO+1rqArjbEOuzokt
         KT/MhwUvC3B1VVY90/MURcqnCyOn6tPwrnNShLvedNEwUggW3+08W4vy9bXVrv3dpyrG
         ogDwW0rGrlTXzveYU1R+vWhiNNvC2ZxivLKVbC0mKehfP78nqATG87wJqunZdqAp60zx
         XalMu2R4An46EuGIDxR38y6elZrASQ3lJXbz7S1/eq6fcAy8+SuRZ46UCbmHhXP+8xST
         7avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696866743; x=1697471543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3h3tvF9Aa+S+aWzN6tHoBixZGqS5pfUK27UfZ/4HscM=;
        b=bFpd1kdsWhc3Q0ci4mgxJQlakt1qe+Ixi83T0C9AzsucdeDHYVr4ust4guG8fqlPk9
         LONZkDIecTQXZ7PQPErsk+7JLTLH9qqAFDAsq0psjEKmzrvjKVgSySx+XjzkRuwYYsgj
         6MgoOpIy7kPBnVjTjEcYDXHkDs207E/I35ZRvrDXaz108hchIbddZlX6IN6bvBlo7D5Q
         dHKaP7h1237nDAw062xOWtkmxCd6sz8S4EsDIjLrfg9dd4tNFoEQd9VgBVIwBxZwvVgG
         E/c9E3kDEvRqP6lv05hW/UyM7hUPfwOoZxzs4cC7tjYx/luq71BQm0w4fwk40FV8PW8O
         864w==
X-Gm-Message-State: AOJu0Yxc00VlgqEJKBfNuTUX89H2qGEthnTRWeAcQFKVwpak9f4BEHpA
        feElp9RmV/kRGJIrfzGIuva9/s6GYQWYRlDi2K9LHg==
X-Google-Smtp-Source: AGHT+IGypqjJw9TIRT94AAlV1oCjigzMKySzqiqVA3kXy30NxJsOcjOuhMztolc9Ql0zVxej7Jt5BmBfJN5wfs3eDBY=
X-Received: by 2002:a25:ad4a:0:b0:d85:ae0d:20eb with SMTP id
 l10-20020a25ad4a000000b00d85ae0d20ebmr7228084ybe.14.1696866742972; Mon, 09
 Oct 2023 08:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
 <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com> <20231009063549.gcehavudj4gxz4oc@soft-dev3-1>
In-Reply-To: <20231009063549.gcehavudj4gxz4oc@soft-dev3-1>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Mon, 9 Oct 2023 11:52:11 -0400
Message-ID: <CAM0EoMkYSs9oX+343OpkYbEFPPFcdEEaa92jnwmyzK2gqdKy2A@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     Chengfeng Ye <dg573847474@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 2:36=E2=80=AFAM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> The 10/05/2023 07:46, Jamal Hadi Salim wrote:
>
> Hi Jamal,
>
> > On Thu, Oct 5, 2023 at 5:01=E2=80=AFAM Chengfeng Ye <dg573847474@gmail.=
com> wrote:
> > >
> > > Hi Jakub,
> > >
> > > Thanks for the reply,
> > >
> > > I inspected the code a bit more, it seems that the TC action is calle=
d from
> > > tcf_proto_ops.classify() callback, which is called from Qdisc_ops enq=
ueue
> > > callback.
> > >
> > > Then Qdisc enqueue callback is from
> > >
> > > -> __dev_queue_xmit()
> > > -> __dev_xmit_skb()
> > > -> dev_qdisc_enqueue()
> > >
> > > inside the net core. It seems that this __dev_queue_xmit() callback i=
s
> > > typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> > > already disabled, but sometimes also can from a work queue under
> > > process context, one case is the br_mrp_test_work_expired() inside
> > > net/bridge/br_mrp.c. Does it indicate that this TC action could also =
be
> > > called with BH enable? I am not a developer so really not sure about =
it,
> > > as the networking code is a bit long and complicated.
> >
> > net/bridge/br_mrp.c seems to need some love +Cc Horatiu Vultur
> > <horatiu.vultur@microchip.com>
> > Maybe that code needs to run in a tasklet?
> > In any case your patch is incorrect.
>
> I am currently out traveling and it would be a little bit hard for me to
> look at this right now. I can have a look after I come back in office
> around mid November.
> But I was wondering if this is stil an issue for MRP as Cong Wang
> pointed out, the function __dev_queue_xmit is already disabling the BH.

Yeah, sorry - should have read the code. Cong is right, there's
nothing for you to do.

cheers,
jamal

> >
> > cheers,
> > jamal
> >
>
> --
> /Horatiu
