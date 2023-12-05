Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394BB804D07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjLEJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235506AbjLEJAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B161B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701766838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2VZS95IaK4r6XsUz1E0q2PUldohLpiP4RGb9owLqvas=;
        b=gv68xgT0KBR8X3nLKc4yx9/QOoQYJjCOQGia9+MD6uDvzcg0PyPSyoA43eW/3aBX95/1bU
        Scnv37tE8D+p4jWX3XOor6Ec3Bc6m+xJGNlZelHhXeAEnteNu0AWTGz5YslzITG5+srY0B
        chsISjqVbeAhPnFSmtLLYpuZ1URT+fM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-7W_AL7F6OsiF8QynrB1dWg-1; Tue, 05 Dec 2023 04:00:37 -0500
X-MC-Unique: 7W_AL7F6OsiF8QynrB1dWg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5400c8c6392so3896489a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 01:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766836; x=1702371636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VZS95IaK4r6XsUz1E0q2PUldohLpiP4RGb9owLqvas=;
        b=bPsTkblGLKGyTDPr6QU3J0u5Yvtl6l3WM0tHvllCB4lyLniv7oobhoyyd/NhiEHe7b
         /KCnnN+NQcuY82Jru5ptI1BaCYv1ZN+OqfpdV1pnG4en8Xs6zpxB0zQy/HJYcLXhNcHi
         chHRaxGQTE6WjSWc7+kjUaRX4OtENMqMzF4XZUdXHNecVd9JjvJve3chcvsgrP+k+/j2
         HR5yQkD18yM+YY7P3ev2TT/di9a9amtgl0K7NRwRnRQu6v23pJVg2cUhYWZ+wGXW9V81
         kgBwlXWHZCAfpW0AuXexMNwJCSQKrOXg2VODSIpAmoH/oSpPF5CjiawnJW4w1WQsnET7
         zYCA==
X-Gm-Message-State: AOJu0YybZYU2JjDBhGS1BbkN+/kUF9dzzoFpSNkGOof5/9JKorubBcp4
        sX6nSHYBmFiQCTbzJfVdJqF9LM7+NXxs2FrfSkVHw3Wek15kEjC54h5ecp1PO3OLgXk1xsBaON8
        7Slpg9j2oR7qQmMnbSCJz8wlrnaK17S7C71NledEb
X-Received: by 2002:a50:cd4c:0:b0:54a:f1db:c290 with SMTP id d12-20020a50cd4c000000b0054af1dbc290mr4888957edj.9.1701766836041;
        Tue, 05 Dec 2023 01:00:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFh2TKjelIK/xQGoRVMKwsH4kMIEu1VeGAyx5RhXDvxBars21w6KtujrtA6OrR9/wZyU8ce/FVMPTEFLjqsBv8=
X-Received: by 2002:a50:cd4c:0:b0:54a:f1db:c290 with SMTP id
 d12-20020a50cd4c000000b0054af1dbc290mr4888935edj.9.1701766835720; Tue, 05 Dec
 2023 01:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20231202150807.2571103-1-srasheed@marvell.com>
 <CADEbmW12OWS6et2wp3skicUM=V81x8dS4_aySYP1Ok0kEc2M9Q@mail.gmail.com>
 <CADEbmW3K7QkfniBtmMt=SZtwZWez30F+sM=656wqmZR8=ig1jQ@mail.gmail.com> <PH0PR18MB47342E45E84C86A274F78074C785A@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB47342E45E84C86A274F78074C785A@PH0PR18MB4734.namprd18.prod.outlook.com>
From:   Michal Schmidt <mschmidt@redhat.com>
Date:   Tue, 5 Dec 2023 10:00:24 +0100
Message-ID: <CADEbmW3WjQFQk=g5ESAdMWjoQGHzr3ndL_0AQ8O7-QE2XRVS9w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net v1] octeon_ep: initialise control mbox tasks
 before using APIs
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 7:50=E2=80=AFAM Shinas Rasheed <srasheed@marvell.com=
> wrote:
> > -----Original Message-----
> > > On Sat, Dec 2, 2023 at 4:08=E2=80=AFPM Shinas Rasheed <srasheed@marve=
ll.com>
> > wrote:
> > > > Do INIT_WORK for the various workqueue tasks before the first
> > > > invocation of any control net APIs. Since octep_ctrl_net_get_info
> > > > was called before the control net receive work task was even
> > > > initialised, the function call wasn't returning actual firmware
> > > > info queried from Octeon.
> > >
> > > It might be more accurate to say that octep_ctrl_net_get_info depends
> > > on the processing of OEI events. This happens in intr_poll_task.
> > > That's why intr_poll_task needs to be queued earlier.
>
> Intr_poll_task is queued only when the interface is down and the PF canno=
t catch IRQs as they have been torn down.
> Elsewise, OEI events will trigger the OEI IRQ and consequently its handle=
r.

Right. octep_ctrl_net_get_info is called from the probe function, and
at this point the netdev is not even registered yet. Hence the need
for intr_poll_task.
The reason I started wondering about intr_poll_task is that the commit
message talks about the INIT_WORK, but the patch also moves the
queue_delayed_work call and the reasoning for that move was missing in
the message.
I think the move is correct, but please expand the description.

> Nevertheless, your point is correct in that it
> needs to be queued earlier, but I think subsequently since it calls the c=
ontrol mbox task, that is more relevant and necessary as if it
> is not initialized, it cannot be scheduled even if OEI interrupts have be=
en caught.

OK.

> > > Did octep_send_mbox_req previously always fail with EAGAIN after
> >           ^^^^^^^^^^^^^^^^^^^^^
> > I meant octep_ctrl_net_get_info here.
> >
> > > running into the 500 ms timeout in octep_send_mbox_req?
>
> Yes it did, but as it was silent (note that we're not checking any error =
value), it didn't stop operation. I think I might have to update this patch
> to catch the error values as well (This was a relic from the original cod=
e which spawned an extra thread to setup device and hence couldn't give bac=
k
> an error value. That implementation was discouraged and we setup things a=
t probe itself in the upstreamed code and can check error values)

Yes, please, catch that error value.

> > > Apropos octep_send_mbox_req... I think it has a race. "d" is put on
> > > the ctrl_req_wait_list after sending the request to the hardware. If
> > > the response arrives quickly, "d" might not yet be on the list when
> > > process_mbox_resp looks for it.
> > > Also, what protects ctrl_req_wait_list from concurrent access?
>
> Such a race condition is, I also think, valid, but is not currently occur=
ring as response, after due processing from Octeon application,
> wouldn't arrive that quickly. Regarding concurrent access, there is curre=
ntly no protection for ctrl_req_wait_list. Concurrent access here,
> can only happen if either two requests manage to get hold of the ctrl_req=
_wait_list or a request and a response manages to get hold of the
> ctrl_req_wait_list (the case you stated above).
>
> In the first case, since locks are implemented atop the control mbox itse=
lf, requests would have to in effect wait for their chance to
> queue their wait data "d" to ctrl_req_wait_list, avoiding concurrent acce=
ss.
>
> The second case is valid, but as I stated, wouldn't happen practically. B=
ut I suppose we do have to handle all theoretical cases and perhaps
> locking can be done. I suppose a separate patch for it might be better.

Yes, fixing this should be a separate patch.

Thanks,
Michal

