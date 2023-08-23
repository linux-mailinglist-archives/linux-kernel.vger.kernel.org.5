Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1572B785243
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjHWIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbjHWIGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:06:22 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87D5E61;
        Wed, 23 Aug 2023 01:05:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FB2B40009;
        Wed, 23 Aug 2023 08:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692777945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9GbW9HgISng9XQM4qWdZzSMEIZGQVBQVwp1kExCJ3qU=;
        b=jFJbjZRZXrjU286WJjP4wTtz9xocrlDGYM+3YrLB1G3mKZmBvSgWC55eyzQUE3FccE7Vqu
        Jd+Adg5To4NImYz7R/WrSMXsxCp67JrkrRPyyA55A+uFi7yfBAJyNHwjmecgj1DdzDMkrl
        jJiHErSrIOsIIVkgym7fbjhrijEI5yXp5fU3Gcj8EOQYH5l0tqildMYaz6EuFjMbTFgiNa
        WNE/NqVPWAOqRJyIarbs0ROjxGraT+RAn4PE+iDK80f2R/KQyDFA38Wr/4XMJ8oX0pOSiN
        Sp70dtu4yA36/8MCcL/ZTGVHT0GzADoyFuZXfFIbkKBr46kCQv6xpf933PPm+g==
Date:   Wed, 23 Aug 2023 10:05:42 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZOW91rIXS8fTWZ6I@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
 <ZNaVQ-zxIuCpGGha@aptenodytes>
 <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uayqB142bpoj0pjC"
Content-Disposition: inline
In-Reply-To: <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uayqB142bpoj0pjC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Mon 21 Aug 23, 11:13, Nicolas Dufresne wrote:
> Hello again,
>=20
> I've been away last week.
>=20
> Le vendredi 11 ao=C3=BBt 2023 =C3=A0 22:08 +0200, Paul Kocialkowski a =C3=
=A9crit=C2=A0:
> > Hi Nicolas,
> >=20
> > On Thu 10 Aug 23, 10:34, Nicolas Dufresne wrote:
> > > Le jeudi 10 ao=C3=BBt 2023 =C3=A0 15:44 +0200, Paul Kocialkowski a =
=C3=A9crit=C2=A0:
> > > > Hi folks,
> > > >=20
> > > > On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
> > > > > I am now working on a H.264 encoder driver for Allwinner platform=
s (currently
> > > > > focusing on the V3/V3s), which already provides some usable bitst=
ream and will
> > > > > be published soon.
> > > >=20
> > > > So I wanted to shared an update on my side since I've been making p=
rogress on
> > > > the H.264 encoding work for Allwinner platforms. At this point the =
code supports
> > > > IDR, I and P frames, with a single reference. It also supports GOP =
(both closed
> > > > and open with IDR or I frame interval and explicit keyframe request=
) but uses
> > > > QP controls and does not yet provide rate control. I hope to be abl=
e to
> > > > implement rate-control before we can make a first public release of=
 the code.
> > >=20
> > > Just a reminder that we will code review the API first, the supporting
> > > implementation will just be companion. So in this context, the sooner=
 the better
> > > for an RFC here.
> >=20
> > I definitely want to have some proposal that is (even vaguely) agreed u=
pon
> > before proposing patches for mainline, even at the stage of RFC.
> >=20
> > While I already have working results at this point, the API that is use=
d is
> > very basic and just reuses controls from stateful encoders, with no ext=
ra
> > addition. Various assumptions are made in the kernel and there is no re=
al
> > reference management, since the previous frame is always expected to be=
 used
> > as the only reference.
>=20
> One thing we are looking at these days, and aren't current controllable in
> stateful interface is RTP RPSI (reference picture selection indication). =
This is
> feedback that a remote decoder sends when a reference picture has been de=
coded.
> In short, even if only 1 reference is used, we'd like the reference to ch=
ange
> only when we received the acknowledgement that the new one has been
> reconstructed on the other side.
>=20
> I'm not super keep in having to modify the Linux kernel specially for this
> feature. Specially that similar API offer it at a lower level (VA, D3D12,=
 and
> probably future API).

Yeah I understand this is the kind of feature that the API should not preve=
nt
implementing.

> > We plan to make a public release at some point in the near future which=
 shows
> > these working results, but it will not be a base for our discussion her=
e yet.
> >=20
> > > > One of the main topics of concern now is how reference frames shoul=
d be managed
> > > > and how it should interact with kernel-side GOP management and rate=
 control.
> > >=20
> > > Maybe we need to have a discussion about kernel side GOP management f=
irst ?
> > > While I think kernel side rate control is un-avoidable, I don't think=
 stateless
> > > encoder should have kernel side GOP management.
> >=20
> > I don't have strong opinions about this. The rationale for my proposal =
is that
> > kernel-side rate control will be quite difficult to operate without kno=
wledge
> > of the period at which intra/inter frames are produced. Maybe there are=
 known
> > methods to handle this, but I have the impression that most rate control
> > implementations use the GOP size as a parameter.
> >=20
> > More generally I think an expectation behind rate control is to be able=
 to
> > decide at which time a specific frame type is produced. This is not pos=
sible if
> > the decision is entirely up to userspace.
>=20
> In Television (and Youtube) streaming, the GOP size is just fixed, and yo=
u deal
> with it. In fact, I never seen GOP or picture pattern being modified by t=
he rate
> control.

Sure but my point is rather that rate control has to have some knowledge of=
 what
the GOP size is and what frame type comes next. Not to say that it has to m=
ake
that decision, but I believe it has to be aware of it.

> In general, the high end rate controls will follow an HRD
> specification. The rate controls will require information that represent
> constraints, this is not limited to the rate. In H.264/HEVC, the level and
> profile will play a role. But you could also add the VBV size and probabl=
y more.
> I have never read the HRD specification completely.

That is good to know, especially since I do not have valuable knowledge abo=
ut
high-end rate control.

> In cable streaming notably, the RC job is to monitor the about of bits ov=
er a
> period of time (the window). This window is defined by the streaming hard=
ware
> buffering capabilities. Best at this point is to start reading through HRD
> specifications, and open source rate control implementation (notably x264=
).

Yes I will certainly take a look in those directions when starting the work=
 on
rate control.

> I think overall, we can live with adding hints were needed, and if the gop
> information is appropriate hint, then we can just reuse the existing cont=
rol.

I think it would be necessary for the kernel to have the GOP size hint to do
rate-control, but user-side could still decide on frame types that do not m=
atch
the hint and mess with rate-control. Otherwise, it's not very different from
having the kernel decide on the frame type itself.

I guess I'm still not super convinced that it makes sense to have both
user-selectable frame type/references and kernel-side rate control.

Maybe one option would be to have two operating modes:
- "manual" mode, where user-side decides on the frame type, references and
  per-frame QP, without kernel-side rate control; This would be a purely
  stateless approach;
- "automatic" mode, where user-side decides on the GOP size, rate-control
  approach and kernel-side implements rate control to decide on the frame t=
ype,
  references and QP; This would be purely stateful.

The more I think about it, the more it feels like mixing the two into a uni=
fied
single approach would be messy and unclear. But maybe I'm wrong.

> > > > Leaving GOP management to the kernel-side implies having it decide =
which frame
> > > > should be IDR, I or P (and B for encoders that can support it), whi=
le keeping
> > > > the possibility to request a keyframe (IDR) and configure GOP size.=
 Now it seems
> > > > to me that this is already a good balance between giving userspace =
a decent
> > > > level of control while not having to specify the frame type explici=
tly for each
> > > > frame or maintain a GOP in userspace.
> > >=20
> > > My expectation for stateless encoder is to have to specify the frame =
type and
> > > the associate references if the type requires it.
>=20
> Ack. For us, this is also why we would require requests (unlike statful
> encoder), as we have per frame information to carry, and requests explici=
tly
> attach the information to the frame.
>
> > >=20
> > > >=20
> > > > Requesting the frame type explicitly seems more fragile as many sit=
uations will
> > > > be invalid (e.g. requesting a P frame at the beginning of the strea=
m, etc) and
> > > > it generally requires userspace to know a lot about what the codec =
assumptions
> > > > are. Also for B frames the decision would need to be consistent wit=
h the fact
> > > > that a following frame (in display order) would need to be submitte=
d earlier
> > > > than the current frame and inform the kernel so that the picture or=
der count
> > > > (display order indication) can be maintained. This is not impossibl=
e or out of
> > > > reach, but it brings a lot of complexity for little advantage.
> > >=20
> > > We have had a lot more consistent results over the last decade with s=
tateless
> > > hardware codecs in contrast to stateful where we endup with wide vari=
ation in
> > > behaviour. This applies to Chromium, GStreamer and any active users o=
f VA
> > > encoders really. I'm strongly in favour for stateless reference API o=
ut of the
> > > Linux kernel.
> >=20
> > Okay I understand the lower level of control make it possible to get mu=
ch better
> > results than opaque firmware-driven encoders and it would be a shame to=
 not
> > leverage this possibility with an API that is too restrictive.
> >=20
> > However I do think it should be possible to operate the encoder without=
 a lot
> > of codec-specific supporting code from userspace. This is also why I li=
ke having
> > kernel-side rate control (among other reasons).
>=20
> Ack. We need a compromise here.
>=20
>=20
> [...]
>=20
> >=20
> > > > The next topic of interest is reference management. It seems pretty=
 clear that
> > > > the decision of whether a frame should be a reference or not always=
 needs to be
> > > > taken when encoding that frame. In H.264 the nal_ref_idc slice head=
er element
> > > > indicates whether a frame is marked as reference or not. IDR frames=
 can
> > > > additionally be marked as long-term reference (if I understood corr=
ectly, the
> > > > frame will stay in the reference picture list until the next IDR fr=
ame).
> > >=20
> > > This is incorrect. Any frames can be marked as long term reference, i=
t does not
> > > matter what type they are. From what I recall, marking of the long te=
rm in the
> > > bitstream is using a explicit IDX, so there is no specific rules on w=
hich one
> > > get evicted. Long term of course are limited as they occupy space in =
the DPB.=20
> > > Also, Each CODEC have different DPB semantic. For H.264, the DPB can =
run in two
> > > modes. The first is a simple fifo, in this case, any frame you encode=
 and want
> > > to keep as reference is pushed into the DPB (which has a fixed size m=
inus the
> > > long term). If full, the oldest frame is removed. It is not bound to =
IDR or GOP.
> > > Though, an IDR will implicitly cause the decoder to evict everything =
(including
> > > long term).
> > >=20
> > > The second mode uses the memory management commands. This is a series=
 if
> > > instruction that the encoder can send to the decoder. The specificati=
on is quite
> > > complex, it is a common source of bugs in decoders and a place were s=
tateless
> > > hardware codecs performs more consistently in general. Through the co=
mmands, the
> > > encoder ensure that the decoder dpb representation stay on sync.
> >=20
> > This is also what I understand from repeated reading of the spec and th=
anks for
> > the summary write-up!
> >=20
> > My assumption was that it would be preferable to operate in the simple =
fifo
> > mode since the memory management commands need to be added to the bitst=
ream
> > headers and require coordination from the kernel. Like you said it seem=
s complex
> > and error-prone.
> >=20
> > But maybe this mechanism could be used to allow any particular referenc=
e frame
> > configuration, opening the way for userspace to fully decide what the r=
eference
> > buffer lists are? Also it would be good to know if such mechanisms are =
generally
> > present in codecs or if most of them have an implicit reference list th=
at cannot
> > be modified.
>=20
> Of course, the subject is much more relevant when there is encoders with =
more
> then 1 reference. But you are correct, what the commands do, is allow to =
change,
> add or remove any reference from the list (random modification), as long =
as they
> fit in the codec contraints (like the DPB size notably). This is the only=
 way
> one can implement temporal SVC reference pattern, robust reference trees =
or RTP
> RPSI. Note that long term reference also exists, and are less complex the=
n these
> commands.
>=20
> I this raises a big question, and I never checked how this worked with le=
t's say
> VA. Shall we let the driver resolve the changes into commands (VP8 have
> something similar, while VP9 and AV1 are refresh flags, which are just tr=
ivial
> to compute). I believe I'll have to investigate this further.

I kind of assumed it would be up to the kernel to do that translation, but =
maybe
it also makes sense to submit the commands directly from userspace?

It's not very clear to me what's best here.

>=20
> > >=20
> [...]
>=20
> > > > Addition information gathered:
> > > > - It seems likely that the Allwinner Video Engine only supports one=
 reference
> > > >   frame. There's a register for specifying the rec buffer of a seco=
nd one but
> > > >   I have never seen the proprietary blob use it. It might be as eas=
y as
> > > >   specifying a non-zero address there but it might also be ignored =
or require
> > > >   some undocumented bit to use more than one reference. I haven't m=
ade any
> > > >   attempt at using it yet.
> > >=20
> > > There is something in that fact that makes me think of Hantro H1. Han=
tro H1 also
> > > have a second reference, but non one ever use it. We have on our todo=
 to
> > > actually give this a look.
> >=20
> > Having looked at both register layouts, I would tend to think both desi=
gns
> > are distinct. It's still unclear where Allwinner's video engine comes f=
rom:
> > perhaps they made it in-house, perhaps some obscure Chinese design hous=
e made it
> > for them or it could be known hardware with a modified register layout.
>=20
> Ack,
> >=20
> > I would also be interested to know if the H1 can do more than one refer=
ence!
>=20
> From what we have in our pretty thin documentation, references are being
> "searched" for fuzzy match and motion. So when you pass 2 references to t=
he
> encoder, then the encoder will search equally in both. I suspect it does =
a lot
> more then that, and saves some information in the auxiliary buffers that =
exist
> per reference, but this isn't documented and I'm not specialized enough r=
eally.
>=20
> From usage perspective, all you have to do is give it access to the refer=
ences
> picture data (reconstructed image and auxiliary data). The result is comp=
ressed
> macroblock data that may refer to these. We don't really know if it is us=
ed, but
> we do assume it is and place it in the reference list. This is of course =
normal
> thing to do, specially when using a reference fifo.
>=20
> In theory, you could implement multiple reference with a HW that only sup=
ports
> 1. A technique could be to compress the image multiple time, and keep the=
 "best"
> one for the current configuration. Though, a proper multi-pass encoder wo=
uld
> avoid the bandwidth overhead of compressing and writing the temporary res=
ult.
>
> >=20
> > > > - Contrary to what I said after Andrzej's talk at EOSS, most Allwin=
ner platforms
> > > >   do not support VP8 encode (despite Allwinner's proprietary blob h=
aving an
> > > >   API for it). The only platform that advertises it is the A80 and =
this might
> > > >   actually be a VP8-only Hantro H1. It seems that the API they deve=
loped in the
> > > >   library stuck around even if no other platform can use it.
> > >=20
> > > Thanks for letting us know. Our assumption is that a second hardware =
design is
> > > unlikely as Google was giving it for free to any hardware makers that=
 wanted it.
> > >=20
> > > >=20
> > > > Sorry for the long email again, I'm trying to be a bit more explana=
tory than
> > > > just giving some bare conclusions that I drew on my own.
> > > >=20
> > > > What do you think about these ideas?
> > >=20
> > > In general, we diverge on the direction we want the interface to be. =
What you
> > > seem to describe now is just a normal stateful encoder interface with=
 everything
> > > needed to drive the stateless hardware implemented in the Linux kerne=
l. There is
> > > no parsing or other unsafety in encoders, so I don't have a strict no=
-go
> > > argument for that, but for me, it means much more complex drivers and=
 lesser
> > > flexibility. The VA model have been working great for us in the past,=
 giving us
> > > the ability to implement new feature, or even slightly of spec featur=
es. While,
> > > the Linux kernel might not be the right place for these experimental =
methods.
> >=20
> > VA seems too low-level for our case here, as it seems to expect full co=
ntrol
> > over more or less each bitstream parameter that will be produced.
> >=20
> > I think we have to find some middle-ground that is not as limiting as s=
tateful
> > encoders but not as low-level as VA.
> >=20
> > > Personally, I would rather discuss around your uAPI RFC though, I thi=
nk a lot of
> > > other devs here would like to see what you have drafted.
> >=20
> > Hehe I wish I had some advanced proposal here but my implementation is =
quite
> > simplified compared to what we have to plan for mainline.
>=20
> No worries, let's do that later then. On our side, we have similar limita=
tion,
> since we have to have something working before we can spend more time in =
turning
> it into something upstream. So we have "something" for VP8, we'll do "som=
ething"
> for H.264, from there we should be able to iterate. But having the opport=
unity
> to iterate over a more capable hardware would clearly help understand the=
 bigger
> picture.

Absolutely, it seems a bit difficult to care for cases we cannot really test
yet. Unfortunately I'm not aware of such hardware being around either.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--uayqB142bpoj0pjC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmTlvdYACgkQ3cLmz3+f
v9G51Af+M2TlVbjEXSo81FxelWgE/0LdoL/xAdC66CMypvEU0STpJND/oHEr3KKg
LhVWqBgFs78OL10jy3hw97zAQif1CnDP8/knTAOtLDBA82dG1VJ+3H5LcD3nsuJs
R5sobknT99Ybgr7wc/dUhGQYz0lDUPy75u4i0enMlLe4A7Ns/Pyu60afe4r9XFMe
z1yV3LPZFHb08mSvrrXShhW+J84F2IQWfAwsmZQUlO+8yMkVukdimxjKAS/wbHiJ
wbCLOyX4GZfv2cpuziPpwzoYy01mE0xOrXY+Gnx7m0dqiJ9i+HSnIE65AwqYL+9F
1ngAVY3LKaHVhDWXeg8ZEaYd7IE0vA==
=24FQ
-----END PGP SIGNATURE-----

--uayqB142bpoj0pjC--
