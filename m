Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3187B9DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 15:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjJEN4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243842AbjJENtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:49:35 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1501F74C
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 02:56:35 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d86a0c97ae6so870202276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696499794; x=1697104594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTyeMJy2xzGHnHNw9zUh80EXdZW9KjN2/53jS/NlHXI=;
        b=oaHnKKFom3F9PcXrKZCd45LnOLUIiyln1vssIKREnPPd76Tfm89fpVzUsnsbLG6LyS
         faswgYxlHLVB9surpBa8KSVrgUV544GJk6qCNMnquEKgPPFZYUXOdwWil/Zz0LYNa5Bi
         7y01AcAb1QVVvAH6saC6IUOe147d1rfOrTbpWPr4lrb+Ie/sC4bBR+rdtRAHDFz9HVp+
         3/YfZ/JM37K7tu6uwqVhjFYI/0kC2eeTTgKQgTtlD/9wH53AtgHNqVOX5XLo59wah+1u
         Hx5XHIwX0cBXKDkhwwA9mInx578Lhu+0rnXKJ30/80J4g8KZUC7Lt2gBnvfpC9zg9sok
         Bl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696499794; x=1697104594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vTyeMJy2xzGHnHNw9zUh80EXdZW9KjN2/53jS/NlHXI=;
        b=D4po1hdyxS9w7ZolX21Il6TcYrEZ7EZMiIeh4W+cIEpnJs3tiRE7d82E3cRB3odS1A
         Fr5CB6wPyRnTopcRSoTGaKwtM2pa8cO4RcwXEy4adfYHFDy7wV53qGaR6h58RKjmXfKG
         J6tJYgaC4XWZ+4oq4jDCXSHPdJvPOUTPhcCvvhaXZAgtuq4Ka0zEvjc5Ke/6o7F6I07W
         K639wk0LUDhPG708+cR/UCqRY1vJCAq/9zt7ynZ3IHfg8Rcv4VI3Qm8r360Bm8ac1C5k
         +tzXxxiiq0mdECec//KcEKdBE/A96IxbHtpcwp/wBznx9wxtIH6AfRF0n3WNBbMlGCky
         W4mQ==
X-Gm-Message-State: AOJu0YwXVXYiKKPksuy7N2kSEjDmVWq1Z2y4XpF9v2Gjt4zPCiufWDvB
        q4uYWM9DHZsEEkH2f6vLuNPNmN4d75Si96O4Ge4aKe8qPgHECu33
X-Google-Smtp-Source: AGHT+IHwh9yQ681T2bUZjRQYUsuUX09y3gTXb3wQGA8eBHWXrM2hwxWgk8/Uwxi6s8ya/5kfYThT5LXTzX03T6yutLE=
X-Received: by 2002:a25:abc9:0:b0:d89:4829:6a63 with SMTP id
 v67-20020a25abc9000000b00d8948296a63mr4847960ybi.65.1696499794203; Thu, 05
 Oct 2023 02:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230929-ffa_v1-1_notif-v3-0-c8e4f15190c8@arm.com>
 <20230929-ffa_v1-1_notif-v3-3-c8e4f15190c8@arm.com> <20231004091154.GB1091193@rayden>
 <DB9PR08MB67968986584B6EAC87B20C439BCBA@DB9PR08MB6796.eurprd08.prod.outlook.com>
 <20231004153234.ktk6egntk7drao47@bogus> <CAHUa44GWA_WQSgOgtQKgawc11vpaD5B4q5rNq8fxnEFJk_NzmA@mail.gmail.com>
 <20231005084946.vn4mbizdisaw4q5d@bogus>
In-Reply-To: <20231005084946.vn4mbizdisaw4q5d@bogus>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 5 Oct 2023 11:56:22 +0200
Message-ID: <CAHUa44ETFTKE17tUMsAiF5vYk2yT9wQT-zE+22ic3jHrHhrrJg@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] firmware: arm_ffa: Implement the notification
 bind and unbind interface
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Olivier Deprez <Olivier.Deprez@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Bonnici <Marc.Bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 10:51=E2=80=AFAM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Thu, Oct 05, 2023 at 08:57:26AM +0200, Jens Wiklander wrote:
> > Hi Sudeep,
> >
> > On Wed, Oct 4, 2023 at 5:32=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.c=
om> wrote:
> > >
> > > On Wed, Oct 04, 2023 at 10:50:26AM +0100, Olivier Deprez wrote:
> > > > Hi Jens,
> > > >
> > > > > dst_id and drv_info->vm_id should be swapped.
> > > >
> > > > I'm curious about this because swapping like this actually makes ha=
fnium
> > > > fail. Need to check from the spec.
> > >
> > > I did check after I had swapped this in v2(because I was convinced Je=
ns) was
> > > correct and you reported the failure. Reading the spec again the othe=
r day,
> > > I got corrected myself and agreed with Olivier and my original
> > > implementation(v1) which matches this patch(v3).
>
> Well, I am not exactly sure what is the root cause for the confusion here=
:
> My poor choice of variable names and their usage with this macro, or the
> macro definition itself(I am not sure)
>
> OR
>
> The wordings in the specification
>
> >
> > I don't get it. The spec says for FFA_NOTIFICATION_BIND:
> > Sender and Receiver endpoint IDs.
> > =E2=80=93 Bit[31:16]: Sender endpoint ID.
> > =E2=80=93 Bit[15:0]: Receiver endpoint ID.
> > This is exactly the same as for instance FFA_MSG_SEND_DIRECT_REQ.
> >
>
> Not really as per my understanding of the specification.
>
> > In ffa_msg_send_direct_req() you assign
> > src_dst_ids =3D PACK_TARGET_INFO(src_id, dst_id);
> >
>
> Correct and if you look at the callsite, it is
>         ffa_msg_send_direct_req(drv_info->vm_id, dev->vm_id,...)
>
> So the driver is the sender and the partition is the receiver. Probably
> this is simpler.
>
> > but here in ffa_notification_bind_common() you assign
> > src_dst_ids =3D PACK_TARGET_INFO(dst_id, drv_info->vm_id);
> >
>
> A receiver(FF-A driver) must bind a non-framework notification to a
> sender(SP) before the latter can signal the notification to the former.
> Only the sender can ring these doorbells. A receiver uses the
> FFA_NOTIFICATION_BIND interface to bind one or more notifications to the
> sender.
>
> So, based on this text(modified to refer sender and receiver in the drive=
r
> context) from the spec, my understanding is the driver is the receiver
> and the SP is the sender of the notification.
>
> Do you think I am missing someting here ? Sorry for agreeing with you
> in v2 and silently changing it back without this actual discussion.
> Olivier raised the issue and then when I went back and looked at the
> spec, I realised why I had it this way from the beginning.

Thanks for the explanation, now I get it. My mistake was that I
thought that sender and receiver meant the sender and receiver of the
actual message being sent like with a direct request, it is using the
same register and the same wording after all. Instead, it means the
sender and receiver of an eventual notification, which of course is
the exact opposite.

Thanks,
Jens
