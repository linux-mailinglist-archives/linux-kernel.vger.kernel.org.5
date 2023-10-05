Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B07B9E5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjJEOEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjJEOD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:03:28 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFAF6A56
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 23:30:39 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b0383f618so3536356d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 23:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696487438; x=1697092238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SQ+Fg73Fl1pdYOuoSzMniIQZ34aTxWQ4ZYKT+W2gXQ=;
        b=kHQrV4/q7DNUnT3h6BltELplHfMJB3KarFzoDWaSujxX8CkEhm7xNLLCrYLr83iThj
         OyO3CNx/ag/OMoRvpuhwUiU4Nk8gmRpn4GqnFkELv28Y979xm+cWgfq+LOzlEnicyURk
         kEifd2SC3L7vcA4L6Xetj8pacFqWKDE8FLJHr5E+idLcY+Axy1tsuCceP3Pfhy+yepdU
         s9USvYBqJl49Ljf3X8kfnL08aml2ZCBjtWFnIdSeqTNOMPtQNVsj2IMtXQdx7HWPkubK
         rXM3+V7lhQNmpbg3/JfORnBhZXyYPLaowdHxlVxGymCQbG6q1C22goqT3GYRb+plLhuS
         QhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696487438; x=1697092238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SQ+Fg73Fl1pdYOuoSzMniIQZ34aTxWQ4ZYKT+W2gXQ=;
        b=wZrRFTLhn6vlWgl9UQjU1IE20gUw+2pGGpo+r7mm9qz8LRPiRAvaJnV8poM4iSU39Q
         44n0cpKYJoCl4SdZBoGFhaC8Ox9WkhTCVu4tFZa5pYCSUveuncs10nLIhCtEnM+tE2mx
         Wo8kZMlmZXey3xMTUak5vA+ZykBgRMfxpCj3xo7tmCWfyoLKVhk+IodQQ6gdeaJqvOy7
         dTKG0bRmCFpHbjcafOUiu7Qf1sPfiNyL7onmpILmNxy1kbGiIedmhdKXpmNwT11yZgpB
         hWo47ZE15JHtPqOYMeW1rsUcwJPL84yM4xhaNoltCltKZmi0K5NbWrXzAJsQfowNYwdo
         rv8w==
X-Gm-Message-State: AOJu0YxTkhnQATdW1pBCTYhPGDYqdZakGOpxxRxDiZLOxPiOmYovJWwB
        o/pOV6Yt823iLHyrrtNu/MA7K3AgYmsBi9RxJGOH4w==
X-Google-Smtp-Source: AGHT+IF5f1woXxIsewhgr6LbTilldo0UbnPe8GvHXkLgce/BgID0Anv6sRQXpWQI1Bf4MTBoj6iubumSQOISbver5vA=
X-Received: by 2002:a05:6214:4885:b0:65c:fec5:6f0 with SMTP id
 pc5-20020a056214488500b0065cfec506f0mr4748990qvb.45.1696487438665; Wed, 04
 Oct 2023 23:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-7-c8e4f15190c8@arm.com> <20231004091021.GA1091193@rayden>
 <20231004151123.z4w5u3j7a743bmdq@bogus>
In-Reply-To: <20231004151123.z4w5u3j7a743bmdq@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 5 Oct 2023 08:30:27 +0200
Message-ID: <CAHUa44HYJP_F0MqXFTb9rgvMstXmTfU4thAhGxS6aSObZz+tMA@mail.gmail.com>
Subject: Re: [PATCH v3 07/17] firmware: arm_ffa: Implement the
 NOTIFICATION_INFO_GET interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 5:11=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, Oct 04, 2023 at 11:10:21AM +0200, Jens Wiklander wrote:
> > On Fri, Sep 29, 2023 at 04:02:56PM +0100, Sudeep Holla wrote:
> > > The receiver=E2=80=99s scheduler uses the FFA_NOTIFICATION_INFO_GET i=
nterface
> > > to retrieve the list of endpoints that have pending notifications and
> > > must be run. A notification could be signaled by a sender in the secu=
re
> > > world to a VM. The Hypervisor needs to determine which VM and vCPU
> > > (in case a per-vCPU notification is signaled) has a pending notificat=
ion
> > > in this scenario. It must obtain this information through an invocati=
on
> > > of the FFA_NOTIFICATION_INFO_GET.
> > >
> > > Add the implementation of the NOTIFICATION_INFO_GET interface
> > > and prepare to use this to handle the schedule receiver interrupt.
> > > Implementation of handling notifications will be added later.
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/firmware/arm_ffa/driver.c | 70 +++++++++++++++++++++++++++++=
++++++++++
> > >  1 file changed, 70 insertions(+)
> > >
> > > diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm=
_ffa/driver.c
> > > index 02eedb7bc171..dfeeb751bebe 100644
> > > --- a/drivers/firmware/arm_ffa/driver.c
> > > +++ b/drivers/firmware/arm_ffa/driver.c
> > > @@ -602,6 +602,13 @@ static int ffa_notification_bitmap_destroy(void)
> > >     (FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
> > >      FIELD_PREP(RECEIVER_ID_MASK, (r)))
> > >
> > > +#define NOTIFICATION_INFO_GET_MORE_PEND_MASK       BIT(0)
> > > +#define NOTIFICATION_INFO_GET_ID_COUNT             GENMASK(11, 7)
> > > +#define ID_LIST_MASK_64                            GENMASK(51, 12)
> > > +#define ID_LIST_MASK_32                            GENMASK(31, 12)
> > > +#define MAX_IDS_64                         20
> > > +#define MAX_IDS_32                         10
> > > +
> > >  static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
> > >                                     u32 flags, bool is_bind)
> > >  {
> > > @@ -673,6 +680,69 @@ static int ffa_notification_get(u32 flags, struc=
t ffa_notify_bitmaps *notify)
> > >     return 0;
> > >  }
> > >
> > > +static void __do_sched_recv_cb(u16 partition_id, u16 vcpu, bool is_p=
er_vcpu)
> > > +{
> > > +   pr_err("Callback for partition 0x%x failed.\n", partition_id);
> > > +}
> > > +
> > > +static void ffa_notification_info_get(bool is_64b)
> > > +{
> > > +   int idx, list, max_ids, lists_cnt, ids_processed, ids_count[MAX_I=
DS_64];
> > > +   ffa_value_t ret;
> > > +   u64 id_list;
> > > +
> > > +   do {
> > > +           invoke_ffa_fn((ffa_value_t){
> > > +                     .a0 =3D FFA_FN_NATIVE(NOTIFICATION_INFO_GET),
> > > +                     }, &ret);
> > > +
> > > +           if (ret.a0 !=3D FFA_FN_NATIVE(SUCCESS)) {
> >
> > The specification doesn't require a response using 64-bit SMCCC, it is
> > valid to respond using 32-bit SMCCC too.
> >
>
> Do you mean to say the we need to support 64b NOTIFICATION_INFO_GET
> returning 32b FFA_SUCCESS ? If so do we need to assume only 32bits are
> used in the result. As per the specification,
>
> "0xC4000061(FFA_FN64_SUCCESS): This function ID is used only if any resul=
t
>  register encodes a 64-bit parameter."
>
> My question is what that means allowing 32bit FFA_SUCCESS here?

My bad, this is the one place where a 64-bit FFA_SUCCESS is more or
less required. I'll fix my side of things.

Thanks,
Jens
