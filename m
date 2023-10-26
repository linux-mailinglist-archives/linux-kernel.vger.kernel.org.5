Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFC7D7E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbjJZI3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJZI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:29:01 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C5128
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:28:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so6901a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698308937; x=1698913737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTnFJcs/zb1X42gP/1gu9nIsKnDhG2sNpR1zu8AWMg=;
        b=qeeSTzmYBvHp7+6Yv/iDI/D5+btALrqKSbXuIqIMgZkXQJRJfAKCjlg8VeZeNvzt0U
         glvTY+HIo4Cqev/8xvQWwist9wHNaFfnZpLQFLS8Gi+GuCG6vJwN6KQ9w5rfAk4GrSrS
         EgYBLu8nWmo7ddkvZFOttFw8Fe1Uo8KpKckwsBa0JjD+5ZyIYO4Bw7PRirCeFI4vAa35
         RgmfzbwJcD1jJOfy9QpfhALW95Gooi4/jQ90TymWhWxPYoFlWpd2DZssUKVZbCkSV00h
         Y/dlXoSh2/zao+0OtSfN/vxMlK+nk2fIDzVjgQiYRtI5ThealnEDN6kG3roP9oDEqyD+
         lJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698308937; x=1698913737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHTnFJcs/zb1X42gP/1gu9nIsKnDhG2sNpR1zu8AWMg=;
        b=EGp6tuFzFMe790rWM9xM/i0UOA7qp+DFlGrXeg3m9w+abAi3hjkf/S6aB1O+h3Z8Np
         wOe1tcwBB5Xp3dwVlAC5iCaaeH3rqprxoA6MS00t138Gga0NlpU7T8DO3JUOTip6rAoC
         Jq+Ua+JqiLMuMtIbea/CjYuw+XWImPDOWjrKGuqHpmoyoHchSMIWVtNSJORiOpM/id0b
         nlqN+c+nEWvhL/qNKmZeYmv/LptCwqd/atrTsq03pA/GM/rc3I9EKaE1pLvU8P7GB9ti
         /zgQwwxnI9EfRkBoB7bTtvYfUZrv3QBe9A5zcddcL+FFn2d0nQV/EyrdFxOghF8Gy0Bo
         lLqw==
X-Gm-Message-State: AOJu0YxL//8D4VsD8Ww1PjO0+GYVX7c76N4stoKuJX/wXjM1xXw3pc+1
        DDgbCjqccPaCbKlNWeWdQLgHBdXKJUOcqGI3GEUzRA==
X-Google-Smtp-Source: AGHT+IGOwpi2fW9KqiCeMSdiPgD7tYE+oJtILLrdFelOmMw2Ngoce0v2/l6TETbREzJm2ekFULZ+ZGFr1k9YgC2okVI=
X-Received: by 2002:aa7:da95:0:b0:540:e46d:1ee8 with SMTP id
 q21-20020aa7da95000000b00540e46d1ee8mr232051eds.4.1698308937317; Thu, 26 Oct
 2023 01:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231024145119.2366588-1-srasheed@marvell.com>
 <20231024145119.2366588-4-srasheed@marvell.com> <20231024172151.5fd1b29a@kernel.org>
 <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
In-Reply-To: <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 26 Oct 2023 10:28:44 +0200
Message-ID: <CANn89iKAn0-KBr00qrVibeM9Y7OqxDsg-keQQkty9oD1aCVtcA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more
 in transmit
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani <hgani@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Sathesh B Edara <sedara@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 9:58=E2=80=AFAM Shinas Rasheed <srasheed@marvell.co=
m> wrote:
>
> Hi Jakub,
>
> Again, thanks for your review.
>
> > Does this guarantee that a full-sized skb can be accommodated?
> >> I assume by full-sized skb you mean a non-linear skb with MAX_SG_FRAGS=
 elements in frags array.  Yes, this can be accommodated and the hardware u=
ses separate SG list memory to siphon these skb frags instead of obtaining =
them from the same tx hardware queue. What I'm trying to say is, this means=
 that a single tx descriptor will be enough for a full-sized skb as well, a=
s hardware can pick up SG frags from separate memory and doesn't require se=
parate descriptors.
>
> >If so - consider stopping stopping the queue when the condition is not t=
rue.
> >> We do stop the queue if tx queue is full, as in octep_iq_full_check ea=
rlier on.
>
> >The recommended way of implementing 'driver flow control'
> is to stop the queue once next packet may not fit, and then use
> netif_xmit_stopped() when deciding whether we need to flush or we can
> trust xmit_more. see
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__www.kernel.org_doc=
_html_next_networking_driver.html-23transmit-2Dpath-2Dguidelines&d=3DDwICAg=
&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3D1OxLD4y-oxrlgQ1rjXgWtmLz1pnaDjD96sDq-cKUwK4=
&m=3DFyJHTb5Z2u9DTFSYPU38S5kPcP5KvwGWzY-DPcqOl1gdnm7ToZhTFpyvhLMqh1hd&s=3Dd=
BMmwfWKAi0UH3nrz7j9kYnAodDjuN3LZ5tC2aL_Prs&e=3D
>
> >> In the skeleton code above, as I understand each tx desc holds a skb f=
rag and hence there can be possibility of receiving a full-sized skb, stopp=
ing the queue but on receiving another normal skb we should observe our que=
ue to be stopped. This doesn't arise in our case as even if the skb is full=
-sized, it will only use a single tx descriptor so we can be sure if queue =
has been stopped, the write index will only be updated once posted (and rea=
d) tx descriptors are processed in napi context and queues awoken.
>
> Please correct me if I'm wrong anywhere (sorry if so) to further my under=
standing, and again thanks for your time!

Fact that octep_start_xmit() can return NETDEV_TX_BUSY is very suspicious.

I do not think a driver can implement xmit_more and keep
NETDEV_TX_BUSY at the same time.

Please make sure to remove NETDEV_TX_BUSY first, by stopping the queue earl=
ier.
