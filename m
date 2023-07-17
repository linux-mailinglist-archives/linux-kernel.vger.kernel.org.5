Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7E27565A8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjGQOAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGQOAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:00:52 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24536D1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:00:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-768138c59c1so122926985a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689602449; x=1692194449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=86pGFUJupmtwTHTpb8fR3031C4UxpHPWG3ugQ4iErHk=;
        b=wWoDGSviZ+r9PuadCbQ87GlGxcRCX8TOW4isThzs9X8FYihl6u/s5uiBgtsmMbAG1H
         05tswht2rJyqhUvuwrQgLk9OODiOyWtkc9yF/nf5zwiZkg1x/+9fOTabon8iX7J+VBpt
         ahY3wxM5lDTCTqEiFuIs0bwAbEZjw8vudUsTRLrM0LgYsXA9kLONurxX+E/6PsZpmQOP
         T+cKmnLdngK6Tki/roAsbfA8j7vTTRUxuz5jBskGuJXns3q6A4dTf4Jz3U51Znu6cAtK
         Ipo1InNeNzpty3h1iM1nNIHyuY8OPyFt8Lmv1QCs7qr88LN3WyIE8AS4KNNPLNTNgh20
         Aa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602449; x=1692194449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86pGFUJupmtwTHTpb8fR3031C4UxpHPWG3ugQ4iErHk=;
        b=a84I4NmEJt8au6HPBjP9MYxlTiOGfyr05MB7RyyfPu1Gdwk6kqiLDSEykxy5UX8ce9
         I94lPNPDsGCwhJKx9+eGsHb0E+SlTOTI03AHFNTKLbQKBv4Z0S+PYD5VsC6aukIvuzr6
         z/VheXKZSKPmI1hsgbmlFw3mRgqcJOpKCS1+rcfO2O+ZE7mC0DhUjjF6HuivqaWOAP6g
         4id1n95NUBTy2vQ7scN7DUUOdaHeBsSgJGhliQLVwlofAD56gqGrSW0riWjFu2qK2Jtb
         TUNcVgXw1ZUEcfQOMPVnPUrcXaT6p8OvSOOP62iqmXDfEwlNuAHtw7Nko3A4NhK56PhV
         wJ2A==
X-Gm-Message-State: ABy/qLbDP514Umzsvf0cLM4S67/x9BUpU2KW9u/OFIxZsYgliplQNZLM
        k+PHZ//KDedGlk6B+3XpVL+VvtqvSpWhopzFMeU=
X-Google-Smtp-Source: APBJJlFy2BueHga5KIqJLVY4NNcrJRztiGYh+rqKXVsvH85sXWXfghYPwEKfhvq0Rca36ytZr6fXFA==
X-Received: by 2002:a05:6214:12e:b0:62d:f096:be06 with SMTP id w14-20020a056214012e00b0062df096be06mr11982581qvs.22.1689602449229;
        Mon, 17 Jul 2023 07:00:49 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:83d4::7a9])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf30d000000b0063013c621fasm6340095qvl.68.2023.07.17.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 07:00:48 -0700 (PDT)
Message-ID: <17ca8c5ee31ac8e48bb2ac7f89f6bae84816c893.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Hsia-Jun Li <randy.li@synaptics.com>, linux-media@vger.kernel.org,
        ayaka@soulik.info, hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Mon, 17 Jul 2023 10:00:48 -0400
In-Reply-To: <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-2-randy.li@synaptics.com>
         <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
         <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 12 juillet 2023 =C3=A0 09:31 +0000, Tomasz Figa a =C3=A9crit=C2=
=A0:
> On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
> > Hi Randy,
> >=20
> > Le mardi 04 juillet 2023 =C3=A0 12:00 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
> > > From: Randy Li <ayaka@soulik.info>
> > >=20
> > > For the decoder supports Dynamic Resolution Change,
> > > we don't need to allocate any CAPTURE or graphics buffer
> > > for them at inital CAPTURE setup step.
> > >=20
> > > We need to make the device run or we can't get those
> > > metadata.
> > >=20
> > > Signed-off-by: Randy Li <ayaka@soulik.info>
> > > ---
> > >  drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v=
4l2-core/v4l2-mem2mem.c
> > > index 0cc30397fbad..c771aba42015 100644
> > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_m2m_=
dev *m2m_dev,
> > > =20
> > >  	dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx);
> > > =20
> > > -	if (!m2m_ctx->out_q_ctx.q.streaming
> > > -	    || !m2m_ctx->cap_q_ctx.q.streaming) {
> > > +	if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buffered=
)
> > > +	    || !(m2m_ctx->cap_q_ctx.q.streaming
> > > +		 || m2m_ctx->cap_q_ctx.buffered)) {
> >=20
> > I have a two atches with similar goals in my wave5 tree. It will be eas=
ier to
> > upstream with an actual user, though, I'm probably a month or two away =
from
> > submitting this driver again.
> >=20
> > https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/ac59eafd5076c4=
deb3bfe1fb85b3b776586ef3eb
> > https://gitlab.collabora.com/chipsnmedia/kernel/-/commit/5de4fbe0abb20b=
8e8d862b654f93e3efeb1ef251
> >=20
>=20
> While I'm not going to NAK this series or those 2 patches if you send
> them, I'm not really convinced that adding more and more complexity to
> the mem2mem helpers is a good idea, especially since all of those seem
> to be only needed by stateful video decoders.
>=20
> The mem2mem framework started as a set of helpers to eliminate boiler
> plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buffer,
> run 1 processing job on them and then return both of the to the userspace
> and I think it should stay like this.

Its a bit late to try and bring that argument. It should have been raised c=
ouple
of years ago (before I even started helping with these CODEC). Now that all=
 the
newly written stately decoders uses this framework, it is logical to keep
reducing the boiler plate for these too. In my opinion, the job_ready()
callback, should have been a lot more flexible from the start. And allowing
driver to make it more powerful does not really add that much complexity.

Speaking of complexity, driving the output manually (outside of the job
workqueue) during sequence initialization is a way more complex and risky t=
hen
this. Finally, sticking with 1:1 pattern means encoder, detilers, image
enhancement reducing framerate, etc. would all be unwelcome to use this. Wh=
ich
in short, means no one should even use this.

>=20
> I think we're strongly in need of a stateful video decoder framework that
> would actually address the exact problems that those have rather than
> bending something that wasn't designed with them in mind to work around t=
he
> differences.

The bend is already there, of course I'd be happy to help with any new
framework. Specially on modern stateless, were there is a need to do better
scheduling. Just ping me if you have some effort starting, I don't currentl=
y
have a budget or bandwidth to write new drivers or port existing drivers th=
em on
a newly written framework.

Nicolas


[...]
