Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532775CEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjGUQ0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbjGUQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:26:03 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8850049D9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:22:57 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76731802203so199695985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1689956527; x=1690561327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=anzVo3hUJH+3skT2M/ifsBnOhDsDvDLiIiPxAeMTDlI=;
        b=UVkVCLfTxdvk+X9SJNoWdJCrc4GrRB+WZ5aBs26E/0CXNIZWTKsoSzYVWaJ2zxdFvr
         B4TPaZxrJR1memEr3mA6PZGU5JKlrBOerZP9QLL7cG43qHxQC4pc7hh8qj7kMr1R60JA
         kCRyfT1BJlm7xhlYgDDDM19sHmPB/vI+UkgoNNQaVNfQASPx9jZVH6/0YT4DLSSxL/cP
         VOyancBt0vq5/dz2wDg7feCYFBsp2gl0uVSltBvxj5AYHZvtoZ9F2tVbVceIg7Yky1Mj
         9EztgHZdtUq/U60BXIjtX0EBy0tMYXnL4RbR3kHJ+QmMG9jntcqRGJi5uT79Q4N8DLmA
         FSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956527; x=1690561327;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=anzVo3hUJH+3skT2M/ifsBnOhDsDvDLiIiPxAeMTDlI=;
        b=IwCLiXhDkLHE5Ykbg++1H43802g2Mt65az50JiucKWA4lCsGbtsrvngKT33WUCQyWv
         jfexjP6woQBdC+/MAz38XjZF8OFYJ1+RAUy00095NxMeyvgS9WzEiKAfVHzcGTpdR8Te
         OzA4nnHu2VC+iWtw43Hj2CYBa5/yt98YafxSA2Dz76QZVaTCeO3Jvyvl4o9dBBgIrNR8
         QL+7PEtT8dcHRJsSVcYK3x+Qa/EWw2947yKaJVqwEK2znEPhHuulppcjKZtukhy3JHSr
         FrMReunfCRR6DYRNdX2moABa1jIPoPJbDrdsMgA2p24RR4ZVUR/haQyJY1GWXH5113rJ
         FTOw==
X-Gm-Message-State: ABy/qLYTyWlj6iA2HZ6CX7W8/Mmh71u7OvF8r9rwYS2rkvWC+TrJToc7
        JUjptGXDWEJQj4VjYrSHvagy7g==
X-Google-Smtp-Source: APBJJlGZiYvgAnJnYzwVz2Q+FjRLwQE0OkdKGdNFx0kh+h8pHjGDnNPXWk/P8IsRz0VuMA6PmAbPhw==
X-Received: by 2002:a05:620a:4141:b0:767:915a:ccf6 with SMTP id k1-20020a05620a414100b00767915accf6mr584247qko.65.1689956526723;
        Fri, 21 Jul 2023 09:22:06 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:580::7a9])
        by smtp.gmail.com with ESMTPSA id r29-20020a05620a03dd00b00767f00a9c67sm1200195qkm.95.2023.07.21.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:22:06 -0700 (PDT)
Message-ID: <801aaaaaa77f28c6fc8f1bcb46b4410f663ec97e.camel@ndufresne.ca>
Subject: Re: [PATCH 1/2] [RESEND] media: v4l2-mem2mem: allow device run
 without buf
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     linux-media@vger.kernel.org, ayaka@soulik.info,
        hans.verkuil@cisco.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hverkuil@xs4all.nl, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Date:   Fri, 21 Jul 2023 12:22:05 -0400
In-Reply-To: <452a4d48-fd73-d539-25f6-ded6bc6212bc@synaptics.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
         <20230704040044.681850-2-randy.li@synaptics.com>
         <20452e233a9a4b39b58139081d818d3b1454105a.camel@ndufresne.ca>
         <20230712093129.pdcbvlxd5zphwr5m@chromium.org>
         <17ca8c5ee31ac8e48bb2ac7f89f6bae84816c893.camel@ndufresne.ca>
         <452a4d48-fd73-d539-25f6-ded6bc6212bc@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 21 juillet 2023 =C3=A0 16:56 +0800, Hsia-Jun Li a =C3=A9crit=C2=
=A0:
>=20
> On 7/17/23 22:00, Nicolas Dufresne wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > Le mercredi 12 juillet 2023 =C3=A0 09:31 +0000, Tomasz Figa a =C3=A9cri=
t :
> > > On Fri, Jul 07, 2023 at 03:14:23PM -0400, Nicolas Dufresne wrote:
> > > > Hi Randy,
> > > >=20
> > > > Le mardi 04 juillet 2023 =C3=A0 12:00 +0800, Hsia-Jun Li a =C3=A9cr=
it :
> > > > > From: Randy Li <ayaka@soulik.info>
> > > > >=20
> > > > > For the decoder supports Dynamic Resolution Change,
> > > > > we don't need to allocate any CAPTURE or graphics buffer
> > > > > for them at inital CAPTURE setup step.
> > > > >=20
> > > > > We need to make the device run or we can't get those
> > > > > metadata.
> > > > >=20
> > > > > Signed-off-by: Randy Li <ayaka@soulik.info>
> > > > > ---
> > > > >   drivers/media/v4l2-core/v4l2-mem2mem.c | 5 +++--
> > > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/med=
ia/v4l2-core/v4l2-mem2mem.c
> > > > > index 0cc30397fbad..c771aba42015 100644
> > > > > --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> > > > > @@ -301,8 +301,9 @@ static void __v4l2_m2m_try_queue(struct v4l2_=
m2m_dev *m2m_dev,
> > > > >=20
> > > > >    dprintk("Trying to schedule a job for m2m_ctx: %p\n", m2m_ctx)=
;
> > > > >=20
> > > > > - if (!m2m_ctx->out_q_ctx.q.streaming
> > > > > -     || !m2m_ctx->cap_q_ctx.q.streaming) {
> > > > > + if (!(m2m_ctx->out_q_ctx.q.streaming || m2m_ctx->out_q_ctx.buff=
ered)
> > > > > +     || !(m2m_ctx->cap_q_ctx.q.streaming
> > > > > +          || m2m_ctx->cap_q_ctx.buffered)) {
> > > >=20
> > > > I have a two atches with similar goals in my wave5 tree. It will be=
 easier to
> > > > upstream with an actual user, though, I'm probably a month or two a=
way from
> > > > submitting this driver again.
> > > >=20
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.colla=
bora.com_chipsnmedia_kernel_-2D_commit_ac59eafd5076c4deb3bfe1fb85b3b776586e=
f3eb&d=3DDwIFaQ&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7=
biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=3D9eWwqueFnh1yZHTW11j-syNVQvema7iBzN=
QeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=3DEz5AyEYFIAJmC_k00IPO_ImzVdLZjr_veRq1bN4R=
SNg&e=3D
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gitlab.colla=
bora.com_chipsnmedia_kernel_-2D_commit_5de4fbe0abb20b8e8d862b654f93e3efeb1e=
f251&d=3DDwIFaQ&c=3D7dfBJ8cXbWjhc0BhImu8wVIoUFmBzj1s88r8EGyM0UY&r=3DP4xb2_7=
biqBxD4LGGPrSV6j-jf3C3xlR7PXU-mLTeZE&m=3D9eWwqueFnh1yZHTW11j-syNVQvema7iBzN=
QeX1GKUQwXZ9pm6V4HDL_R2tIYKoOw&s=3DtM81gjNe-bTjpjmidZ1sAhiodMh6npcVJNOhMCi1=
mPo&e=3D
> > > >=20
> > >=20
> > > While I'm not going to NAK this series or those 2 patches if you send
> > > them, I'm not really convinced that adding more and more complexity t=
o
> > > the mem2mem helpers is a good idea, especially since all of those see=
m
> > > to be only needed by stateful video decoders.
> > >=20
> > > The mem2mem framework started as a set of helpers to eliminate boiler
> > > plate from simple drivers that always get 1 CAPTURE and 1 OUTPUT buff=
er,
> > > run 1 processing job on them and then return both of the to the users=
pace
> > > and I think it should stay like this.
> >=20
> > Its a bit late to try and bring that argument. It should have been rais=
ed couple
> > of years ago (before I even started helping with these CODEC). Now that=
 all the
> > newly written stately decoders uses this framework, it is logical to ke=
ep
> > reducing the boiler plate for these too. In my opinion, the job_ready()
> > callback, should have been a lot more flexible from the start. And allo=
wing
> > driver to make it more powerful does not really add that much complexit=
y.
> >=20
> > Speaking of complexity, driving the output manually (outside of the job
> > workqueue) during sequence initialization is a way more complex and ris=
ky then
> > this. Finally, sticking with 1:1 pattern means encoder, detilers, image
> > enhancement reducing framerate, etc. would all be unwelcome to use this=
. Which
> > in short, means no one should even use this.
> >=20
> I think those things are m2m, but it would be hard to present in current=
=20
> m2m framework:
> 1. N:1 compositor(It may be implemented as a loop running 2:1 compositor)=
.

Correct, only SRC/DST/BG type of blitters can be supported for compositing,
which is quite limiting. Currently there is no way to make an N:1 M2M, as M=
2M
instances are implemented at the video node layer, and not at the MC layer.=
 This
is a entirely new subject and API design space to tackle (same goes for 1:N=
,
like multi scalers, svc decoders etc.).

> 2. AV1 film gain

For AV1/HEVC film grain, it is handle similar to inline converters and scal=
ers.
The driver secretly allocate the reference frames, and post process into th=
e
user visible buffers. It breaks some assumption made by most protected memo=
ry
setup though, as not all allocation is user driven, meaning the decoder nee=
ds to
know if its secure or not. Secure memory is a also another API design space=
 to
tackle.

> 3. HDR with dynamic meta data to SDR

True, but easy to design around the stateless model. I'm not worried for th=
ese.

>=20
> The video things fix for m2m model could be just a little less complex=
=20
> than ISP or camera pipeline. The only difference is just ISP won't have=
=20
> multiple contexts running at the same time.

I thought that having the kernel schedule ISP reprocessing jobs (which requ=
ires
instances) would be nice. But this can only be solved after we have solved =
the
N:N use cases of m2m (with multiple instances).

> If we could design a model for the video encoder I think we could solve=
=20
> the most of problems.
> A video encoder would have:
> 1. input graphics buffer
> 2. reconstruction graphics buffer
> 3. motion vector cache buffer(optional)
> 4. coded bitstream output
> 5. encoding statistic report
> > >=20
> > > I think we're strongly in need of a stateful video decoder framework =
that
> > > would actually address the exact problems that those have rather than
> > > bending something that wasn't designed with them in mind to work arou=
nd the
> > > differences.
> >=20
> > The bend is already there, of course I'd be happy to help with any new
> > framework. Specially on modern stateless, were there is a need to do be=
tter
> > scheduling.
> I didn't know the schedule problem about stateless codec, are they=20
> supposed to be in the job queue when the buffers that DPB requests are=
=20
> own by the driver and its registers are prepared except the trigger bit?

On RK3588 at least, decoder scheduling is going to be complex. There is an =
even
number of cores, but when you need to decode 8K, you have to pair two cores
(there is a specific set of cores that are to be paired with). We need a de=
cent
scheduling logic to ensure we don't starve 8K decoding session when there i=
s
multiple smaller resolution session on-going.

On MTK, the entropy decoding (LAT) and the reconstruction (CORE) is split. =
MTK
vcodec is using multiple workqueues to move jobs around, which is clearly
expensive. Also, the life time of a job is not exactly easy to manage.

On RPi HEVC (not upstream yet, but being worked on), the entropy decoding a=
nd
reconstruction is done one the same core, but remains 2 concurrent operatio=
n.
Does not impose a complex scheduling issue, but it raised the need for a wa=
y to
fully utilize such HW.

This is just some examples of complexity for which the current framework is=
 not
that helpful (even though, its not impossible either).

>   Just ping me if you have some effort starting, I don't currently
> > have a budget or bandwidth to write new drivers or port existing driver=
s them on
> > a newly written framework.
> >=20
> > Nicolas
> >=20
> >=20
> > [...]
>=20

