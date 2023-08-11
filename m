Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F59779831
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjHKUIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjHKUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:08:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAA230C8;
        Fri, 11 Aug 2023 13:08:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9AF7240002;
        Fri, 11 Aug 2023 20:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691784518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COpPJHLefGZw9elD2mnuYZa8e6AIe2Ao46kpJ5gtyu4=;
        b=AHq32wd1chjGrjv6rUt84Ra87RiczyxyesmGyCGySGgC8Eq4xyHUhvzvGoSa+zz6pteNGA
        Cna8xfWr1pLxr8hZcPnJ2Q0QaU9ksycruUhN3OCJROU5AsGqAZv3wFF1JOFV+vYogPEKGz
        qJ/46nf+l3Yio31pB1IwymTQg06FEycLeyCzPVZq2FWD2hek3+6mqbo56D/ftf5JHFWrfQ
        4mmWPmTwauSdlS5Y0GNy3ULRp9sKHfSzsECkSW1QR2+JIp08JZoCu+DArMctQbDTbxXk+g
        R1ITpxL1uXu2ahBgmjwgrl6ueBqdBptfTvh8E4EgkaOob2W2MgZ17A2GOt/GMw==
Date:   Fri, 11 Aug 2023 22:08:35 +0200
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
Message-ID: <ZNaVQ-zxIuCpGGha@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/E+rVLciVKLYAZk5"
Content-Disposition: inline
In-Reply-To: <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/E+rVLciVKLYAZk5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On Thu 10 Aug 23, 10:34, Nicolas Dufresne wrote:
> Le jeudi 10 ao=C3=BBt 2023 =C3=A0 15:44 +0200, Paul Kocialkowski a =C3=A9=
crit=C2=A0:
> > Hi folks,
> >=20
> > On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
> > > I am now working on a H.264 encoder driver for Allwinner platforms (c=
urrently
> > > focusing on the V3/V3s), which already provides some usable bitstream=
 and will
> > > be published soon.
> >=20
> > So I wanted to shared an update on my side since I've been making progr=
ess on
> > the H.264 encoding work for Allwinner platforms. At this point the code=
 supports
> > IDR, I and P frames, with a single reference. It also supports GOP (bot=
h closed
> > and open with IDR or I frame interval and explicit keyframe request) bu=
t uses
> > QP controls and does not yet provide rate control. I hope to be able to
> > implement rate-control before we can make a first public release of the=
 code.
>=20
> Just a reminder that we will code review the API first, the supporting
> implementation will just be companion. So in this context, the sooner the=
 better
> for an RFC here.

I definitely want to have some proposal that is (even vaguely) agreed upon
before proposing patches for mainline, even at the stage of RFC.

While I already have working results at this point, the API that is used is
very basic and just reuses controls from stateful encoders, with no extra
addition. Various assumptions are made in the kernel and there is no real
reference management, since the previous frame is always expected to be used
as the only reference.

We plan to make a public release at some point in the near future which sho=
ws
these working results, but it will not be a base for our discussion here ye=
t.

> > One of the main topics of concern now is how reference frames should be=
 managed
> > and how it should interact with kernel-side GOP management and rate con=
trol.
>=20
> Maybe we need to have a discussion about kernel side GOP management first=
 ?
> While I think kernel side rate control is un-avoidable, I don't think sta=
teless
> encoder should have kernel side GOP management.

I don't have strong opinions about this. The rationale for my proposal is t=
hat
kernel-side rate control will be quite difficult to operate without knowled=
ge
of the period at which intra/inter frames are produced. Maybe there are kno=
wn
methods to handle this, but I have the impression that most rate control
implementations use the GOP size as a parameter.

More generally I think an expectation behind rate control is to be able to
decide at which time a specific frame type is produced. This is not possibl=
e if
the decision is entirely up to userspace.

> > Leaving GOP management to the kernel-side implies having it decide whic=
h frame
> > should be IDR, I or P (and B for encoders that can support it), while k=
eeping
> > the possibility to request a keyframe (IDR) and configure GOP size. Now=
 it seems
> > to me that this is already a good balance between giving userspace a de=
cent
> > level of control while not having to specify the frame type explicitly =
for each
> > frame or maintain a GOP in userspace.
>=20
> My expectation for stateless encoder is to have to specify the frame type=
 and
> the associate references if the type requires it.
>=20
> >=20
> > Requesting the frame type explicitly seems more fragile as many situati=
ons will
> > be invalid (e.g. requesting a P frame at the beginning of the stream, e=
tc) and
> > it generally requires userspace to know a lot about what the codec assu=
mptions
> > are. Also for B frames the decision would need to be consistent with th=
e fact
> > that a following frame (in display order) would need to be submitted ea=
rlier
> > than the current frame and inform the kernel so that the picture order =
count
> > (display order indication) can be maintained. This is not impossible or=
 out of
> > reach, but it brings a lot of complexity for little advantage.
>=20
> We have had a lot more consistent results over the last decade with state=
less
> hardware codecs in contrast to stateful where we endup with wide variatio=
n in
> behaviour. This applies to Chromium, GStreamer and any active users of VA
> encoders really. I'm strongly in favour for stateless reference API out o=
f the
> Linux kernel.

Okay I understand the lower level of control make it possible to get much b=
etter
results than opaque firmware-driven encoders and it would be a shame to not
leverage this possibility with an API that is too restrictive.

However I do think it should be possible to operate the encoder without a l=
ot
of codec-specific supporting code from userspace. This is also why I like h=
aving
kernel-side rate control (among other reasons).

> > Leaving the decision to the kernel side with some hints (whether to for=
ce a
> > keyframe, whether to allow B frames) seems a lot easier, especially for=
 B frames
> > since the kernel could just receive frames in-order and decide to hold =
one
> > so that it can use the next frame submitted as a forward reference for =
this
> > upcoming B frame. This requires flushing support but it's already well =
in place
> > for stateful encoders.
>=20
> No, its a lot harder for users. The placement of keyframe should be bound=
 to
> various image analyses and streaming conditions like scene change detecti=
on,
> network traffic, but also, I strictly don't want to depend on the Linux k=
ernel
> when its time to implement a custom reference tree. In general, stateful =
decoder
> are never up to the game of modern RTP features and other fancy robust
> referencing model.

That is a fair point.

> I overall have to disagree with your proposed approach. I
> believe we have to create a stateless encoder interface and not a complet=
ely
> abstract this hardware over our existing stateful interface. We should ta=
ke
> adventage of the nature of the hardware to make simpler and safer driver.

Understood.

> > The next topic of interest is reference management. It seems pretty cle=
ar that
> > the decision of whether a frame should be a reference or not always nee=
ds to be
> > taken when encoding that frame. In H.264 the nal_ref_idc slice header e=
lement
> > indicates whether a frame is marked as reference or not. IDR frames can
> > additionally be marked as long-term reference (if I understood correctl=
y, the
> > frame will stay in the reference picture list until the next IDR frame).
>=20
> This is incorrect. Any frames can be marked as long term reference, it do=
es not
> matter what type they are. From what I recall, marking of the long term i=
n the
> bitstream is using a explicit IDX, so there is no specific rules on which=
 one
> get evicted. Long term of course are limited as they occupy space in the =
DPB.=20
> Also, Each CODEC have different DPB semantic. For H.264, the DPB can run =
in two
> modes. The first is a simple fifo, in this case, any frame you encode and=
 want
> to keep as reference is pushed into the DPB (which has a fixed size minus=
 the
> long term). If full, the oldest frame is removed. It is not bound to IDR =
or GOP.
> Though, an IDR will implicitly cause the decoder to evict everything (inc=
luding
> long term).
>=20
> The second mode uses the memory management commands. This is a series if
> instruction that the encoder can send to the decoder. The specification i=
s quite
> complex, it is a common source of bugs in decoders and a place were state=
less
> hardware codecs performs more consistently in general. Through the comman=
ds, the
> encoder ensure that the decoder dpb representation stay on sync.

This is also what I understand from repeated reading of the spec and thanks=
 for
the summary write-up!

My assumption was that it would be preferable to operate in the simple fifo
mode since the memory management commands need to be added to the bitstream
headers and require coordination from the kernel. Like you said it seems co=
mplex
and error-prone.

But maybe this mechanism could be used to allow any particular reference fr=
ame
configuration, opening the way for userspace to fully decide what the refer=
ence
buffer lists are? Also it would be good to know if such mechanisms are gene=
rally
present in codecs or if most of them have an implicit reference list that c=
annot
be modified.

> > Frames that are marked as reference are added to the l0/l1 lists implic=
itly
> > that way and are evicted mostly depending on the number of reference sl=
ots
> > available, or when a new GOP is started.
>=20
> Be aware that "slots" is a hardware implementation detail. I think it can=
 be
> used for any MPEG CODEC, but be careful since slots in AV1 specification =
have a
> completely different meaning. Generalization of slots will create confusi=
on.
>
> >=20
> > With the frame type decided by the kernel, it becomes nearly impossible=
 for
> > userspace to keep track of the reference lists. Userspace would at leas=
t need
> > to know when an IDR frame is produced to flush the reference lists. In =
addition
> > it looks like most hardware doesn't have a way to explicitly discard pr=
evious
> > frames that were marked as reference from being used as reference for n=
ext
> > frames. All in all this means that we should expect little control over=
 the
> > reference frames list.
> >=20
> > As a result my updated proposal would be to have userspace only indicat=
e whether
> > a submitted frame should be marked as a reference or not instead of sub=
mitting
> > an explicit list of previous buffers that should be used as reference, =
which
> > would be impossible to honor in many cases.
> >=20
> > Addition information gathered:
> > - It seems likely that the Allwinner Video Engine only supports one ref=
erence
> >   frame. There's a register for specifying the rec buffer of a second o=
ne but
> >   I have never seen the proprietary blob use it. It might be as easy as
> >   specifying a non-zero address there but it might also be ignored or r=
equire
> >   some undocumented bit to use more than one reference. I haven't made =
any
> >   attempt at using it yet.
>=20
> There is something in that fact that makes me think of Hantro H1. Hantro =
H1 also
> have a second reference, but non one ever use it. We have on our todo to
> actually give this a look.

Having looked at both register layouts, I would tend to think both designs
are distinct. It's still unclear where Allwinner's video engine comes from:
perhaps they made it in-house, perhaps some obscure Chinese design house ma=
de it
for them or it could be known hardware with a modified register layout.

I would also be interested to know if the H1 can do more than one reference!

> > - Contrary to what I said after Andrzej's talk at EOSS, most Allwinner =
platforms
> >   do not support VP8 encode (despite Allwinner's proprietary blob havin=
g an
> >   API for it). The only platform that advertises it is the A80 and this=
 might
> >   actually be a VP8-only Hantro H1. It seems that the API they develope=
d in the
> >   library stuck around even if no other platform can use it.
>=20
> Thanks for letting us know. Our assumption is that a second hardware desi=
gn is
> unlikely as Google was giving it for free to any hardware makers that wan=
ted it.
>=20
> >=20
> > Sorry for the long email again, I'm trying to be a bit more explanatory=
 than
> > just giving some bare conclusions that I drew on my own.
> >=20
> > What do you think about these ideas?
>=20
> In general, we diverge on the direction we want the interface to be. What=
 you
> seem to describe now is just a normal stateful encoder interface with eve=
rything
> needed to drive the stateless hardware implemented in the Linux kernel. T=
here is
> no parsing or other unsafety in encoders, so I don't have a strict no-go
> argument for that, but for me, it means much more complex drivers and les=
ser
> flexibility. The VA model have been working great for us in the past, giv=
ing us
> the ability to implement new feature, or even slightly of spec features. =
While,
> the Linux kernel might not be the right place for these experimental meth=
ods.

VA seems too low-level for our case here, as it seems to expect full control
over more or less each bitstream parameter that will be produced.

I think we have to find some middle-ground that is not as limiting as state=
ful
encoders but not as low-level as VA.

> Personally, I would rather discuss around your uAPI RFC though, I think a=
 lot of
> other devs here would like to see what you have drafted.

Hehe I wish I had some advanced proposal here but my implementation is quite
simplified compared to what we have to plan for mainline.

Cheers,

Paul

> Nicolas
>=20
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
> > >=20
> > > This is a very long email where I've tried to split things into disti=
nct topics
> > > and explain a few concepts to make sure everyone is on the same page.
> > >=20
> > > # Bitstream Headers
> > >=20
> > > Stateless encoders typically do not generate all the bitstream header=
s and
> > > sometimes no header at all (e.g. Allwinner encoder does not even prod=
uce slice
> > > headers). There's often some hardware block that makes bit-level writ=
ing to the
> > > destination buffer easier (deals with alignment, etc).
> > >=20
> > > The values of the bitstream headers must be in line with how the comp=
ressed
> > > data bitstream is generated and generally follow the codec specificat=
ion.
> > > Some encoders might allow configuring all the fields found in the hea=
ders,
> > > others may only allow configuring a few or have specific constraints =
regarding
> > > which values are allowed.
> > >=20
> > > As a result, we cannot expect that any given encoder is able to produ=
ce frames
> > > for any set of headers. Reporting related constraints and limitations=
 (beyond
> > > profile/level) seems quite difficult and error-prone.
> > >=20
> > > So it seems that keeping header generation in-kernel only (close to w=
here the
> > > hardware is actually configured) is the safest approach.
> > >=20
> > > # Codec Features
> > >=20
> > > Codecs have many variable features that can be enabled or not and spe=
cific
> > > configuration fields that can take various values. There is usually s=
ome
> > > top-level indication of profile/level that restricts what can be used.
> > >=20
> > > This is a very similar situation to stateful encoding, where codec-sp=
ecific
> > > controls are used to report and set profile/level and configure these=
 aspects.
> > > A particularly nice thing about it is that we can reuse these existin=
g controls
> > > and add new ones in the future for features that are not yet covered.
> > >=20
> > > This approach feels more flexible than designing new structures with =
a selected
> > > set of parameters (that could match the existing controls) for each c=
odec.
> > >=20
> > > # Reference and Reconstruction Management
> > >=20
> > > With stateless encoding, we need to tell the hardware which frames ne=
ed to be
> > > used as references for encoding the current frame and make sure we ha=
ve the
> > > these references available as decoded frames in memory.
> > >=20
> > > Regardless of references, stateless encoders typically need some memo=
ry space to
> > > write the decoded (known as reconstructed) frame while it's being enc=
oded.
> > >=20
> > > One question here is how many slots for decoded pictures should be al=
located
> > > by the driver when starting to stream. There is usually a maximum num=
ber of
> > > reference frames that can be used at a time, although perhaps there i=
s a use
> > > case to keeping more around and alternative between them for future r=
eferences.
> > >=20
> > > Another question is how the driver should keep track of which frame w=
ill be used
> > > as a reference in the future and which one can be evicted from the po=
ol of
> > > decoded pictures if it's not going to be used anymore.
> > >=20
> > > A restrictive approach would be to let the driver alone manage that, =
similarly
> > > to how stateful encoders behave. However it might provide extra flexi=
bility
> > > (and memory gain) to allow userspace to configure the maximum number =
of possible
> > > reference frames. In that case it becomes necessary to indicate if a =
given
> > > frame will be used as a reference in the future (maybe using a buffer=
 flag)
> > > and to indicate which previous reference frames (probably to be ident=
ified with
> > > the matching output buffer's timestamp) should be used for the curren=
t encode.
> > > This could be done with a new dedicated control (as a variable-sized =
array of
> > > timestamps). Note that userspace would have to update it for every fr=
ame or the
> > > reference frames will remain the same for future encodes.
> > >=20
> > > The driver will then make sure to keep the reconstructed buffer aroun=
d, in one
> > > of the slots. When there's no slot left, the driver will drop the old=
est
> > > reference it has (maybe with a bounce buffer to still allow it to be =
used as a
> > > reference for the current encode).
> > >=20
> > > With this behavior defined in the uAPI spec, userspace will also be a=
ble to
> > > keep track of which previous frame is no longer allowed as a referenc=
e.
> > >=20
> > > # Frame Types
> > >=20
> > > Stateless encoder drivers will typically instruct the hardware to enc=
ode either
> > > an intra-coded or an inter-coded frame. While a stream composed only =
of a single
> > > intra-coded frame followed by only inter-coded frames is possible, it=
's
> > > generally not desirable as it is not very robust against data loss an=
d makes
> > > seeking difficult.
> > >=20
> > > As a result, the frame type is usually decided based on a given GOP s=
ize
> > > (the frequency at which a new intra-coded frame is produced) while in=
tra-coded
> > > frames can be explicitly requested upon request. Stateful encoders im=
plement
> > > these through dedicated controls:
> > > - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> > > - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> > > - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
> > >=20
> > > It seems that reusing them would be possible, which would let the dri=
ver decide
> > > of the particular frame type.
> > >=20
> > > However it makes the reference frame management a bit trickier since =
reference
> > > frames might be requested from userspace for a frame that ends up bei=
ng
> > > intra-coded. We can either allow this and silently ignore the info or=
 expect
> > > that userspace keeps track of the GOP index and not send references o=
n the first
> > > frame.
> > >=20
> > > In some codecs, there's also a notion of barrier key-frames (IDR fram=
es in
> > > H.264) that strictly forbid using any past reference beyond the frame.
> > > There seems to be an assumption that the GOP start uses this kind of =
frame
> > > (and not any intra-coded frame), while the force key frame control do=
es not
> > > particularly specify it.
> > >=20
> > > In that case we should flush the list of references and userspace sho=
uld no
> > > longer provide references to them for future frames. This puts a requ=
irement on
> > > userspace to keep track of GOP start in order to know when to flush i=
ts
> > > reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set,=
 but this
> > > could also indicate a general intra-coded frame that is not a barrier.
> > >=20
> > > So another possibility would be for userspace to explicitly indicate =
which
> > > frame type to use (in a codec-specific way) and act accordingly, leav=
ing any
> > > notion of GOP up to userspace. I feel like this might be the easiest =
approach
> > > while giving an extra degree of control to userspace.
> > >=20
> > > # Rate Control
> > >=20
> > > Another important feature of encoders is the ability to control the a=
mount of
> > > data produced following different rate control strategies. Stateful e=
ncoders
> > > typically do this in-firmware and expose controls for selecting the s=
trategy
> > > and associated targets.
> > >=20
> > > It seems desirable to support both automatic and manual rate-control =
to
> > > userspace.
> > >=20
> > > Automatic control would be implemented kernel-side (with algos possib=
ly shared
> > > across drivers) and reuse existing stateful controls. The advantage is
> > > simplicity (userspace does not need to carry its own rate-control
> > > implementation) and to ensure that there is a built-in mechanism for =
common
> > > strategies available for every driver (no mandatory dependency on a p=
roprietary
> > > userspace stack). There may also be extra statistics or controls avai=
lable to
> > > the driver that allow finer-grain control.
> > >=20
> > > Manual control allows userspace to get creative and requires the abil=
ity to set
> > > the quantization parameter (QP) directly for each frame (controls are=
 already
> > > as many stateful encoders also support it).
> > >=20
> > > # Regions of Interest
> > >=20
> > > Regions of interest (ROIs) allow specifying sub-regions of the frame =
that should
> > > be prioritized for quality. Stateless encoders typically support a li=
mited
> > > number and allow setting specific QP values for these regions.
> > >=20
> > > While the QP value should be used directly in manual rate-control, we=
 probably
> > > want to have some "level of importance" setting for kernel-side rate-=
control,
> > > along with the dimensions/position of each ROI. This could be express=
ed with
> > > a new structure containing all these elements and presented as a vari=
able-sized
> > > array control with as many elements as the hardware can support.
> > >=20
> > > --=20
> > > Paul Kocialkowski, Bootlin
> > > Embedded Linux and kernel engineering
> > > https://bootlin.com
> >=20
> >=20
> >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--/E+rVLciVKLYAZk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmTWlUMACgkQ3cLmz3+f
v9Hj7wf/Ug3TY0qPFYg3abHzmFqNJsrct3CvPwGlzRNHEZaOLTKy44KC4ArqfgL9
i99qu1C8N3h82O33Gjb6aNjyoSzNu8CxcL5dNG5lm/O97Fr2l1kSWU4x6nLG8+tu
YXNCoyZ87/d+TbUhhiJRU1matAQhR5VCqyIkOZnYORIAiyEh7FdM/6DEa48krVnK
Mie1vCuBOfOjfinwh/lA7RNrvDv4+FgCQYjvi64JQTFBwrn0HydIzrrw5nU0UqO2
J5l/gSxzNnlYCgyMZJ6CVD8tfWthHa+aKYxVxlnUnfSGgRedrw1Q+Ylnu3wH/GYA
5z0KTvvRWY5vrTlHjYOB1E9B+rPV2g==
=9xGN
-----END PGP SIGNATURE-----

--/E+rVLciVKLYAZk5--
