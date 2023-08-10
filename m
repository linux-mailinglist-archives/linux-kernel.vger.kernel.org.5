Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD65777AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbjHJOeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbjHJOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:34:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9303F26A8;
        Thu, 10 Aug 2023 07:34:43 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EFAC660722E;
        Thu, 10 Aug 2023 15:34:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691678081;
        bh=3Zsxvrvg7GYBZjLROI+ovT01ERM/uePBlKr8/Sy0TZc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=doPaLHnWyLADzg4ZIqi91T9R6lX2NYbPRPBfkzlsjbUyv30zX/KvzUjxDM/FgB8v/
         FzPhlG+Gvj/A2a9ShF4RmYUcBoHWMVd5cFNVi4NCXTiesnFeAvMUMczNYMvD+NBKVs
         Et0+ThUIgCUp3C1mARb8b67d6TvuS9L3ufYxyRJ+n7zegZBQGhHn3V4c/wGLRpTlKx
         MdgW/qtdwQ5Y3v8tqRUr8bP9XZDJySuIqdKoO9HH239JxxJ4pbiQzy3H+6xWtEmvIs
         VHHEW679YWL4fJYbjFsgSmT0+/Dycy8X8H4luuJ+T1Q4PR55MrcbeD1pBd8WmxSoB3
         87HeWfayicC8A==
Message-ID: <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     Jernej =?UTF-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Thu, 10 Aug 2023 10:34:31 -0400
In-Reply-To: <ZNTp1e4gJ2zeYmS-@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 10 ao=C3=BBt 2023 =C3=A0 15:44 +0200, Paul Kocialkowski a =C3=A9cr=
it=C2=A0:
> Hi folks,
>=20
> On Tue 11 Jul 23, 19:12, Paul Kocialkowski wrote:
> > I am now working on a H.264 encoder driver for Allwinner platforms (cur=
rently
> > focusing on the V3/V3s), which already provides some usable bitstream a=
nd will
> > be published soon.
>=20
> So I wanted to shared an update on my side since I've been making progres=
s on
> the H.264 encoding work for Allwinner platforms. At this point the code s=
upports
> IDR, I and P frames, with a single reference. It also supports GOP (both =
closed
> and open with IDR or I frame interval and explicit keyframe request) but =
uses
> QP controls and does not yet provide rate control. I hope to be able to
> implement rate-control before we can make a first public release of the c=
ode.

Just a reminder that we will code review the API first, the supporting
implementation will just be companion. So in this context, the sooner the b=
etter
for an RFC here.

>=20
> One of the main topics of concern now is how reference frames should be m=
anaged
> and how it should interact with kernel-side GOP management and rate contr=
ol.

Maybe we need to have a discussion about kernel side GOP management first ?
While I think kernel side rate control is un-avoidable, I don't think state=
less
encoder should have kernel side GOP management.

>=20
> Leaving GOP management to the kernel-side implies having it decide which =
frame
> should be IDR, I or P (and B for encoders that can support it), while kee=
ping
> the possibility to request a keyframe (IDR) and configure GOP size. Now i=
t seems
> to me that this is already a good balance between giving userspace a dece=
nt
> level of control while not having to specify the frame type explicitly fo=
r each
> frame or maintain a GOP in userspace.

My expectation for stateless encoder is to have to specify the frame type a=
nd
the associate references if the type requires it.

>=20
> Requesting the frame type explicitly seems more fragile as many situation=
s will
> be invalid (e.g. requesting a P frame at the beginning of the stream, etc=
) and
> it generally requires userspace to know a lot about what the codec assump=
tions
> are. Also for B frames the decision would need to be consistent with the =
fact
> that a following frame (in display order) would need to be submitted earl=
ier
> than the current frame and inform the kernel so that the picture order co=
unt
> (display order indication) can be maintained. This is not impossible or o=
ut of
> reach, but it brings a lot of complexity for little advantage.

We have had a lot more consistent results over the last decade with statele=
ss
hardware codecs in contrast to stateful where we endup with wide variation =
in
behaviour. This applies to Chromium, GStreamer and any active users of VA
encoders really. I'm strongly in favour for stateless reference API out of =
the
Linux kernel.

>=20
> Leaving the decision to the kernel side with some hints (whether to force=
 a
> keyframe, whether to allow B frames) seems a lot easier, especially for B=
 frames
> since the kernel could just receive frames in-order and decide to hold on=
e
> so that it can use the next frame submitted as a forward reference for th=
is
> upcoming B frame. This requires flushing support but it's already well in=
 place
> for stateful encoders.

No, its a lot harder for users. The placement of keyframe should be bound t=
o
various image analyses and streaming conditions like scene change detection=
,
network traffic, but also, I strictly don't want to depend on the Linux ker=
nel
when its time to implement a custom reference tree. In general, stateful de=
coder
are never up to the game of modern RTP features and other fancy robust
referencing model. I overall have to disagree with your proposed approach. =
I
believe we have to create a stateless encoder interface and not a completel=
y
abstract this hardware over our existing stateful interface. We should take
adventage of the nature of the hardware to make simpler and safer driver.

>=20
> The next topic of interest is reference management. It seems pretty clear=
 that
> the decision of whether a frame should be a reference or not always needs=
 to be
> taken when encoding that frame. In H.264 the nal_ref_idc slice header ele=
ment
> indicates whether a frame is marked as reference or not. IDR frames can
> additionally be marked as long-term reference (if I understood correctly,=
 the
> frame will stay in the reference picture list until the next IDR frame).

This is incorrect. Any frames can be marked as long term reference, it does=
 not
matter what type they are. From what I recall, marking of the long term in =
the
bitstream is using a explicit IDX, so there is no specific rules on which o=
ne
get evicted. Long term of course are limited as they occupy space in the DP=
B.=20
Also, Each CODEC have different DPB semantic. For H.264, the DPB can run in=
 two
modes. The first is a simple fifo, in this case, any frame you encode and w=
ant
to keep as reference is pushed into the DPB (which has a fixed size minus t=
he
long term). If full, the oldest frame is removed. It is not bound to IDR or=
 GOP.
Though, an IDR will implicitly cause the decoder to evict everything (inclu=
ding
long term).

The second mode uses the memory management commands. This is a series if
instruction that the encoder can send to the decoder. The specification is =
quite
complex, it is a common source of bugs in decoders and a place were statele=
ss
hardware codecs performs more consistently in general. Through the commands=
, the
encoder ensure that the decoder dpb representation stay on sync.

> Frames that are marked as reference are added to the l0/l1 lists implicit=
ly
> that way and are evicted mostly depending on the number of reference slot=
s
> available, or when a new GOP is started.

Be aware that "slots" is a hardware implementation detail. I think it can b=
e
used for any MPEG CODEC, but be careful since slots in AV1 specification ha=
ve a
completely different meaning. Generalization of slots will create confusion=
.

>=20
> With the frame type decided by the kernel, it becomes nearly impossible f=
or
> userspace to keep track of the reference lists. Userspace would at least =
need
> to know when an IDR frame is produced to flush the reference lists. In ad=
dition
> it looks like most hardware doesn't have a way to explicitly discard prev=
ious
> frames that were marked as reference from being used as reference for nex=
t
> frames. All in all this means that we should expect little control over t=
he
> reference frames list.
>=20
> As a result my updated proposal would be to have userspace only indicate =
whether
> a submitted frame should be marked as a reference or not instead of submi=
tting
> an explicit list of previous buffers that should be used as reference, wh=
ich
> would be impossible to honor in many cases.
>=20
> Addition information gathered:
> - It seems likely that the Allwinner Video Engine only supports one refer=
ence
>   frame. There's a register for specifying the rec buffer of a second one=
 but
>   I have never seen the proprietary blob use it. It might be as easy as
>   specifying a non-zero address there but it might also be ignored or req=
uire
>   some undocumented bit to use more than one reference. I haven't made an=
y
>   attempt at using it yet.

There is something in that fact that makes me think of Hantro H1. Hantro H1=
 also
have a second reference, but non one ever use it. We have on our todo to
actually give this a look.

> - Contrary to what I said after Andrzej's talk at EOSS, most Allwinner pl=
atforms
>   do not support VP8 encode (despite Allwinner's proprietary blob having =
an
>   API for it). The only platform that advertises it is the A80 and this m=
ight
>   actually be a VP8-only Hantro H1. It seems that the API they developed =
in the
>   library stuck around even if no other platform can use it.

Thanks for letting us know. Our assumption is that a second hardware design=
 is
unlikely as Google was giving it for free to any hardware makers that wante=
d it.

>=20
> Sorry for the long email again, I'm trying to be a bit more explanatory t=
han
> just giving some bare conclusions that I drew on my own.
>=20
> What do you think about these ideas?

In general, we diverge on the direction we want the interface to be. What y=
ou
seem to describe now is just a normal stateful encoder interface with every=
thing
needed to drive the stateless hardware implemented in the Linux kernel. The=
re is
no parsing or other unsafety in encoders, so I don't have a strict no-go
argument for that, but for me, it means much more complex drivers and lesse=
r
flexibility. The VA model have been working great for us in the past, givin=
g us
the ability to implement new feature, or even slightly of spec features. Wh=
ile,
the Linux kernel might not be the right place for these experimental method=
s.

Personally, I would rather discuss around your uAPI RFC though, I think a l=
ot of
other devs here would like to see what you have drafted.

Nicolas

>=20
> Cheers,
>=20
> Paul
>=20
> >=20
> > This is a very long email where I've tried to split things into distinc=
t topics
> > and explain a few concepts to make sure everyone is on the same page.
> >=20
> > # Bitstream Headers
> >=20
> > Stateless encoders typically do not generate all the bitstream headers =
and
> > sometimes no header at all (e.g. Allwinner encoder does not even produc=
e slice
> > headers). There's often some hardware block that makes bit-level writin=
g to the
> > destination buffer easier (deals with alignment, etc).
> >=20
> > The values of the bitstream headers must be in line with how the compre=
ssed
> > data bitstream is generated and generally follow the codec specificatio=
n.
> > Some encoders might allow configuring all the fields found in the heade=
rs,
> > others may only allow configuring a few or have specific constraints re=
garding
> > which values are allowed.
> >=20
> > As a result, we cannot expect that any given encoder is able to produce=
 frames
> > for any set of headers. Reporting related constraints and limitations (=
beyond
> > profile/level) seems quite difficult and error-prone.
> >=20
> > So it seems that keeping header generation in-kernel only (close to whe=
re the
> > hardware is actually configured) is the safest approach.
> >=20
> > # Codec Features
> >=20
> > Codecs have many variable features that can be enabled or not and speci=
fic
> > configuration fields that can take various values. There is usually som=
e
> > top-level indication of profile/level that restricts what can be used.
> >=20
> > This is a very similar situation to stateful encoding, where codec-spec=
ific
> > controls are used to report and set profile/level and configure these a=
spects.
> > A particularly nice thing about it is that we can reuse these existing =
controls
> > and add new ones in the future for features that are not yet covered.
> >=20
> > This approach feels more flexible than designing new structures with a =
selected
> > set of parameters (that could match the existing controls) for each cod=
ec.
> >=20
> > # Reference and Reconstruction Management
> >=20
> > With stateless encoding, we need to tell the hardware which frames need=
 to be
> > used as references for encoding the current frame and make sure we have=
 the
> > these references available as decoded frames in memory.
> >=20
> > Regardless of references, stateless encoders typically need some memory=
 space to
> > write the decoded (known as reconstructed) frame while it's being encod=
ed.
> >=20
> > One question here is how many slots for decoded pictures should be allo=
cated
> > by the driver when starting to stream. There is usually a maximum numbe=
r of
> > reference frames that can be used at a time, although perhaps there is =
a use
> > case to keeping more around and alternative between them for future ref=
erences.
> >=20
> > Another question is how the driver should keep track of which frame wil=
l be used
> > as a reference in the future and which one can be evicted from the pool=
 of
> > decoded pictures if it's not going to be used anymore.
> >=20
> > A restrictive approach would be to let the driver alone manage that, si=
milarly
> > to how stateful encoders behave. However it might provide extra flexibi=
lity
> > (and memory gain) to allow userspace to configure the maximum number of=
 possible
> > reference frames. In that case it becomes necessary to indicate if a gi=
ven
> > frame will be used as a reference in the future (maybe using a buffer f=
lag)
> > and to indicate which previous reference frames (probably to be identif=
ied with
> > the matching output buffer's timestamp) should be used for the current =
encode.
> > This could be done with a new dedicated control (as a variable-sized ar=
ray of
> > timestamps). Note that userspace would have to update it for every fram=
e or the
> > reference frames will remain the same for future encodes.
> >=20
> > The driver will then make sure to keep the reconstructed buffer around,=
 in one
> > of the slots. When there's no slot left, the driver will drop the oldes=
t
> > reference it has (maybe with a bounce buffer to still allow it to be us=
ed as a
> > reference for the current encode).
> >=20
> > With this behavior defined in the uAPI spec, userspace will also be abl=
e to
> > keep track of which previous frame is no longer allowed as a reference.
> >=20
> > # Frame Types
> >=20
> > Stateless encoder drivers will typically instruct the hardware to encod=
e either
> > an intra-coded or an inter-coded frame. While a stream composed only of=
 a single
> > intra-coded frame followed by only inter-coded frames is possible, it's
> > generally not desirable as it is not very robust against data loss and =
makes
> > seeking difficult.
> >=20
> > As a result, the frame type is usually decided based on a given GOP siz=
e
> > (the frequency at which a new intra-coded frame is produced) while intr=
a-coded
> > frames can be explicitly requested upon request. Stateful encoders impl=
ement
> > these through dedicated controls:
> > - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> > - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> > - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
> >=20
> > It seems that reusing them would be possible, which would let the drive=
r decide
> > of the particular frame type.
> >=20
> > However it makes the reference frame management a bit trickier since re=
ference
> > frames might be requested from userspace for a frame that ends up being
> > intra-coded. We can either allow this and silently ignore the info or e=
xpect
> > that userspace keeps track of the GOP index and not send references on =
the first
> > frame.
> >=20
> > In some codecs, there's also a notion of barrier key-frames (IDR frames=
 in
> > H.264) that strictly forbid using any past reference beyond the frame.
> > There seems to be an assumption that the GOP start uses this kind of fr=
ame
> > (and not any intra-coded frame), while the force key frame control does=
 not
> > particularly specify it.
> >=20
> > In that case we should flush the list of references and userspace shoul=
d no
> > longer provide references to them for future frames. This puts a requir=
ement on
> > userspace to keep track of GOP start in order to know when to flush its
> > reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is set, b=
ut this
> > could also indicate a general intra-coded frame that is not a barrier.
> >=20
> > So another possibility would be for userspace to explicitly indicate wh=
ich
> > frame type to use (in a codec-specific way) and act accordingly, leavin=
g any
> > notion of GOP up to userspace. I feel like this might be the easiest ap=
proach
> > while giving an extra degree of control to userspace.
> >=20
> > # Rate Control
> >=20
> > Another important feature of encoders is the ability to control the amo=
unt of
> > data produced following different rate control strategies. Stateful enc=
oders
> > typically do this in-firmware and expose controls for selecting the str=
ategy
> > and associated targets.
> >=20
> > It seems desirable to support both automatic and manual rate-control to
> > userspace.
> >=20
> > Automatic control would be implemented kernel-side (with algos possibly=
 shared
> > across drivers) and reuse existing stateful controls. The advantage is
> > simplicity (userspace does not need to carry its own rate-control
> > implementation) and to ensure that there is a built-in mechanism for co=
mmon
> > strategies available for every driver (no mandatory dependency on a pro=
prietary
> > userspace stack). There may also be extra statistics or controls availa=
ble to
> > the driver that allow finer-grain control.
> >=20
> > Manual control allows userspace to get creative and requires the abilit=
y to set
> > the quantization parameter (QP) directly for each frame (controls are a=
lready
> > as many stateful encoders also support it).
> >=20
> > # Regions of Interest
> >=20
> > Regions of interest (ROIs) allow specifying sub-regions of the frame th=
at should
> > be prioritized for quality. Stateless encoders typically support a limi=
ted
> > number and allow setting specific QP values for these regions.
> >=20
> > While the QP value should be used directly in manual rate-control, we p=
robably
> > want to have some "level of importance" setting for kernel-side rate-co=
ntrol,
> > along with the dimensions/position of each ROI. This could be expressed=
 with
> > a new structure containing all these elements and presented as a variab=
le-sized
> > array control with as many elements as the hardware can support.
> >=20
> > --=20
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
>=20
>=20
>=20

