Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D68B761811
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjGYMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYMPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 08:15:12 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E362CA7;
        Tue, 25 Jul 2023 05:15:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DEE3FE0007;
        Tue, 25 Jul 2023 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690287307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LYJd+VsJ21uTdArjcLVwufe3nCHfmG3FrYtCW5qgL2I=;
        b=jv8P6XYcf3zoB+s203JnVbmjZ4Ej5jd0CK//V+0l+APdP6ty/bqdRBx2BxG8dTqnl4BdXp
        abKPFjrTJJMyBkyOn99RDKpRy2CNQSC9R+vDuE0z5nWDfINGPjzN3q7rhxtGTqU01yk50I
        7cQD2QI5vsgVkxplSinxiyDYhI+IkKs+qlAv7KyQPmUGlUfB2sSK6bxE5mPJbDb2p5v08L
        SNMFawUi/+sfM652ablqIn8a2GVAejs+NlOF55mk77kMIkE89Fk9JW+rfyngW1nUmgMszf
        8swAyLlApRp1KAgMCbeiUtHe0MUmKcvixVYwATLAgIxLEgtF5fe/Fi6pz2bGuA==
Date:   Tue, 25 Jul 2023 14:15:04 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Message-ID: <ZL-8yBhWWChKBDHM@aptenodytes>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
 <ZK6zjaJtulRSrn7P@aptenodytes>
 <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KehLbf333yLPyq0X"
Content-Disposition: inline
In-Reply-To: <bbd62e1b-dd0b-e351-110e-040b42d02974@synaptics.com>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KehLbf333yLPyq0X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

Long time, good to see you are still around and interested in these topics =
:)

On Tue 25 Jul 23, 11:33, Hsia-Jun Li wrote:
> On 7/12/23 22:07, Paul Kocialkowski wrote:
> > Hi Nicolas,
> >=20
> > Thanks for the quick reply!
> >=20
> > On Tue 11 Jul 23, 14:18, Nicolas Dufresne wrote:
> > > Le mardi 11 juillet 2023 =C3=A0 19:12 +0200, Paul Kocialkowski a =C3=
=A9crit=C2=A0:
> > > > Hi everyone!
> > > >=20
> > > > After various discussions following Andrzej's talk at EOSS, feedbac=
k from the
> > > > Media Summit (which I could not attend unfortunately) and various d=
irect
> > > > discussions, I have compiled some thoughts and ideas about stateles=
s encoders
> > > > support with various proposals. This is the result of a few years o=
f interest
> > > > in the topic, after working on a PoC for the Hantro H1 using the ha=
ntro driver,
> > > > which turned out to have numerous design issues.
> > > >=20
> > > > I am now working on a H.264 encoder driver for Allwinner platforms =
(currently
> > > > focusing on the V3/V3s), which already provides some usable bitstre=
am and will
> > > > be published soon.
> > > >=20
> > > > This is a very long email where I've tried to split things into dis=
tinct topics
> > > > and explain a few concepts to make sure everyone is on the same pag=
e.
> > > >=20
> > > > # Bitstream Headers
> > > >=20
> > > > Stateless encoders typically do not generate all the bitstream head=
ers and
> > > > sometimes no header at all (e.g. Allwinner encoder does not even pr=
oduce slice
> > > > headers). There's often some hardware block that makes bit-level wr=
iting to the
> > > > destination buffer easier (deals with alignment, etc).
> > > >=20
> > > > The values of the bitstream headers must be in line with how the co=
mpressed
> > > > data bitstream is generated and generally follow the codec specific=
ation.
> > > > Some encoders might allow configuring all the fields found in the h=
eaders,
> > > > others may only allow configuring a few or have specific constraint=
s regarding
> > > > which values are allowed.
> > > >=20
> > > > As a result, we cannot expect that any given encoder is able to pro=
duce frames
> > > > for any set of headers. Reporting related constraints and limitatio=
ns (beyond
> > > > profile/level) seems quite difficult and error-prone.
> > > >=20
> > > > So it seems that keeping header generation in-kernel only (close to=
 where the
> > > > hardware is actually configured) is the safest approach.
> > > This seems to match with what happened with the Hantro VP8 proof of c=
oncept. The
> > > encoder does not produce the frame header, but also, it produces 2 en=
coded
> > > buffers which cannot be made contiguous at the hardware level. This n=
otion of
> > > plane in coded data wasn't something that blended well with the rest =
of the API
> > > and we didn't want to copy in the kernel while the userspace would al=
so be
> > > forced to copy to align the headers. Our conclusion was that it was b=
est to
> > > generate the headers and copy both segment before delivering to users=
pace. I
> > > suspect this type of situation will be quite common.
> > Makes sense! I guess the same will need to be done for Hantro H1 H.264 =
encoding
> > (in my PoC the software-generated headers were crafted in userspace and=
 didn't
> > have to be part of the same buffer as the coded data).
> We just need a method to indicate where the hardware could write its slice
> data or compressed frame.
> While we would decided which frame that the current frame should refer, t=
he
> (some) hardware may discard our decision, which reference picture set wou=
ld
> use less bits. Unless the codec supports a fill up method, it could lead =
to
> a gap between header and frame data.

I think I would need a bit more context to understand this case, especially
what the hardware could decide to discard.

My understanding is that the VP8 encoder needs to write part of the header
separately from the coded data and uses distinct address registers for the =
two.
So the approach is to move the hw-generated headers and coded data before
returning to userspace.

> >=20
> > > > # Codec Features
> > > >=20
> > > > Codecs have many variable features that can be enabled or not and s=
pecific
> > > > configuration fields that can take various values. There is usually=
 some
> > > > top-level indication of profile/level that restricts what can be us=
ed.
> > > >=20
> > > > This is a very similar situation to stateful encoding, where codec-=
specific
> > > > controls are used to report and set profile/level and configure the=
se aspects.
> > > > A particularly nice thing about it is that we can reuse these exist=
ing controls
> > > > and add new ones in the future for features that are not yet covere=
d.
> > > >=20
> > > > This approach feels more flexible than designing new structures wit=
h a selected
> > > > set of parameters (that could match the existing controls) for each=
 codec.
> > > Though, reading more into this emails, we still have a fair amount of=
 controls
> > > to design and add, probably some compound controls too ?
> > Yeah definitely. My point here is merely that we should reuse existing =
control
> > for general codec features, but I don't think we'll get around introduc=
ing new
> > ones for stateless-specific parts.
> >=20
> Things likes profile, level or tiers could be reused. It make no sense to
> expose those vendor special feature.
> Besides, profile, level or tiers are usually stored in the sequence header
> or uncompressed header, hardware doesn't care about that.
>=20
> I think we should go with the vendor registers buffer way that I always
> said. There are many encoding tools that a codec offer, variants of hardw=
are
> may not support or use them all. The context switching between userspace =
and
> kernel would drive you mad for so many controls.

I am strongly against this approach, instead I think we need to keep all
vendor-specific parts in the kernel driver and provide a clean unified user=
space
API.

Also I think V4L2 has way to set multiple controls at once, so the
userspace/kernel context switching is rather minimal and within reasonable
expectations. Of course it will never be as efficient as userspace mapping =
the
hardware registers in virtual memory but there are so many problems with th=
is
approach that it's really not worth it.

> > > > # Reference and Reconstruction Management
> > > >=20
> > > > With stateless encoding, we need to tell the hardware which frames =
need to be
> > > > used as references for encoding the current frame and make sure we =
have the
> > > > these references available as decoded frames in memory.
> > > >=20
> > > > Regardless of references, stateless encoders typically need some me=
mory space to
> > > > write the decoded (known as reconstructed) frame while it's being e=
ncoded.
> > > >=20
> > > > One question here is how many slots for decoded pictures should be =
allocated
> > > > by the driver when starting to stream. There is usually a maximum n=
umber of
> > > > reference frames that can be used at a time, although perhaps there=
 is a use
> > > > case to keeping more around and alternative between them for future=
 references.
> > > >=20
> > > > Another question is how the driver should keep track of which frame=
 will be used
> > > > as a reference in the future and which one can be evicted from the =
pool of
> > > > decoded pictures if it's not going to be used anymore.
> > > >=20
> > > > A restrictive approach would be to let the driver alone manage that=
, similarly
> > > > to how stateful encoders behave. However it might provide extra fle=
xibility
> > > > (and memory gain) to allow userspace to configure the maximum numbe=
r of possible
> > > > reference frames. In that case it becomes necessary to indicate if =
a given
> > > > frame will be used as a reference in the future (maybe using a buff=
er flag)
> > > > and to indicate which previous reference frames (probably to be ide=
ntified with
> > > > the matching output buffer's timestamp) should be used for the curr=
ent encode.
> > > > This could be done with a new dedicated control (as a variable-size=
d array of
> > > > timestamps). Note that userspace would have to update it for every =
frame or the
> > > > reference frames will remain the same for future encodes.
> > > >=20
> > > > The driver will then make sure to keep the reconstructed buffer aro=
und, in one
> > > > of the slots. When there's no slot left, the driver will drop the o=
ldest
> > > > reference it has (maybe with a bounce buffer to still allow it to b=
e used as a
> > > > reference for the current encode).
> > > >=20
> > > > With this behavior defined in the uAPI spec, userspace will also be=
 able to
> > > > keep track of which previous frame is no longer allowed as a refere=
nce.
> > > If we want, we could mirror the stateless decoders here. During the d=
ecoding, we
> > > pass a "dpb" or a reference list, which represent all the active refe=
rences.
> > > These do not have to be used by the current frame, but the driver is =
allowed to
> > > use this list to cleanup and free unused memory (or reuse in case it =
has a fixed
> > > slot model, like mtk vcodec).
> > >=20
> > > On top of this, we add a list of references to be used for producing =
the current
> > > frame. Usually, the picture references are indices into the dpb/refer=
ence list
> > > of timestamp. This makes validation easier.  We'll have to define how=
 many
> > > reference can be used I think since unlike decoders, encoders don't h=
ave to
> > > fully implement levels and profiles.
> > So that would be a very explicit description instead of expecting drive=
rs to
> > do the maintainance and userspace to figure out which frame was evicted=
 from
> > the list. So yeah this feels more robust!
> >=20
> > Regarding the number of reference frames, I think we need to specify bo=
th
> > how many references can be used at a time (number of hardware slots) an=
d how
> > many total references can be in the reference list (number of rec buffe=
rs to
> > keep around).
> >=20
> > We could also decide that making the current frame part of the global r=
eference
> > list is a way to indicate that its reconstruction buffer must be kept a=
round,
> > or we could have a separate way to indicate that. I lean towards the fo=
rmer
> > since it would put all reference-related things in one place and avoid =
coming
> > up with a new buffer flag or such.
> >=20
> > Also we would probably still need to do some validation driver-side to =
make
> > sure that userspace doesn't put references in the list that were not ma=
rked
> > as such when encoded (and for which the reconstruction buffer may have =
been
> > recycled already).
> >=20
> DPB is the only thing we need to decide any API here under the vendor
> registers buffer way. We need the driver to translate the buffer reference
> to the address that hardware could use and in its right registers.
>=20
> The major problem is how to export the reconstruction buffer which was
> hidden for many years.
> This could be disccused in the other thread like V4L2 ext buffer api.

Following my previous point, I am also strongly against exposing the
reconstruction buffer to userspace.

> > > > # Frame Types
> > > >=20
> > > > Stateless encoder drivers will typically instruct the hardware to e=
ncode either
> > > > an intra-coded or an inter-coded frame. While a stream composed onl=
y of a single
> > > > intra-coded frame followed by only inter-coded frames is possible, =
it's
> > > > generally not desirable as it is not very robust against data loss =
and makes
> > > > seeking difficult.
> > > Let's avoid this generalization in our document and design. In RTP st=
reaming,
> > > like WebRTP or SIP, it is desirable to use open GOP (with nothing els=
e then P
> > > frames all the time, except the very first one). The FORCE_KEY_FRAME =
is meant to
> > > allow handling RTP PLI (and other similar feedback). Its quite rare an
> > > application would mix close GOP and FORCE_KEY_FRAME, but its allowed =
though.
> > > What I've seen the most, is the FORCE_KEY_FRAME would just start a ne=
w GOP,
> > > following size and period from this new point.
> > Okay fair enough, thanks for the details!
> >=20
> > > > As a result, the frame type is usually decided based on a given GOP=
 size
> > > > (the frequency at which a new intra-coded frame is produced) while =
intra-coded
> > > > frames can be explicitly requested upon request. Stateful encoders =
implement
> > > > these through dedicated controls:
> > > > - V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME
> > > > - V4L2_CID_MPEG_VIDEO_GOP_SIZE
> > > > - V4L2_CID_MPEG_VIDEO_H264_I_PERIOD
> > > >=20
> > > > It seems that reusing them would be possible, which would let the d=
river decide
> > > > of the particular frame type.
> > > >=20
> > > > However it makes the reference frame management a bit trickier sinc=
e reference
> > > > frames might be requested from userspace for a frame that ends up b=
eing
> > > > intra-coded. We can either allow this and silently ignore the info =
or expect
> > > > that userspace keeps track of the GOP index and not send references=
 on the first
> > > > frame.
> > > >=20
> > > > In some codecs, there's also a notion of barrier key-frames (IDR fr=
ames in
> > > > H.264) that strictly forbid using any past reference beyond the fra=
me.
> > > > There seems to be an assumption that the GOP start uses this kind o=
f frame
> > > > (and not any intra-coded frame), while the force key frame control =
does not
> > > > particularly specify it.
> > > >=20
> > > > In that case we should flush the list of references and userspace s=
hould no
> > > > longer provide references to them for future frames. This puts a re=
quirement on
> > > > userspace to keep track of GOP start in order to know when to flush=
 its
> > > > reference list. It could also check if V4L2_BUF_FLAG_KEYFRAME is se=
t, but this
> > > > could also indicate a general intra-coded frame that is not a barri=
er.
> > > >=20
> > > > So another possibility would be for userspace to explicitly indicat=
e which
> > > > frame type to use (in a codec-specific way) and act accordingly, le=
aving any
> > > > notion of GOP up to userspace. I feel like this might be the easies=
t approach
> > > > while giving an extra degree of control to userspace.
> > > I also lean toward this approach ...
> > >=20
> > > > # Rate Control
> > > >=20
> > > > Another important feature of encoders is the ability to control the=
 amount of
> > > > data produced following different rate control strategies. Stateful=
 encoders
> > > > typically do this in-firmware and expose controls for selecting the=
 strategy
> > > > and associated targets.
> > > >=20
> > > > It seems desirable to support both automatic and manual rate-contro=
l to
> > > > userspace.
> > > >=20
> > > > Automatic control would be implemented kernel-side (with algos poss=
ibly shared
> > > > across drivers) and reuse existing stateful controls. The advantage=
 is
> > > > simplicity (userspace does not need to carry its own rate-control
> > > > implementation) and to ensure that there is a built-in mechanism fo=
r common
> > > > strategies available for every driver (no mandatory dependency on a=
 proprietary
> > > > userspace stack). There may also be extra statistics or controls av=
ailable to
> > > > the driver that allow finer-grain control.
> > > Though not controlling the GOP (or no gop) might require a bit more w=
ork on
> > > driver side. Today, we do have queues of request, queues of buffer et=
c. But it
> > > is still quite difficult to do lookahead these queues. That is only u=
seful if
> > > rate control algorithm can use future frame type (like keyframe) to m=
ake
> > > decisions. That could be me pushing to far here though.
> > Yes I agree the interaction between userspace GOP control and kernel-si=
de
> > rate-contrly might be quite tricky without any indication of what the n=
ext frame
> > types will be.
> >=20
> > Maybe we could only allow explicit frame type configuration when using =
manual
> > rate-control and have kernel-side GOP management when in-kernel rc is u=
sed
> > (and we can allow it with manual rate-control too). I like having this =
option
> > because it allows for simple userspace implementations.
> >=20
> > Note that this could perhaps also be added as an optional feature
> > for stateful encoders since some of them seem to be able to instruct the
> > firmware what frame type to use (in addition to directly controlling QP=
).
> > There's also a good chance that this feature is not available when using
> > a firmware-backed rc algorithm.
> >=20
> > > > Manual control allows userspace to get creative and requires the ab=
ility to set
> > > > the quantization parameter (QP) directly for each frame (controls a=
re already
> > > > as many stateful encoders also support it).
> > > >=20
> > > > # Regions of Interest
> > > >=20
> > > > Regions of interest (ROIs) allow specifying sub-regions of the fram=
e that should
> > > > be prioritized for quality. Stateless encoders typically support a =
limited
> > > > number and allow setting specific QP values for these regions.
> > > >=20
> > > > While the QP value should be used directly in manual rate-control, =
we probably
> > > > want to have some "level of importance" setting for kernel-side rat=
e-control,
> > > > along with the dimensions/position of each ROI. This could be expre=
ssed with
> > > > a new structure containing all these elements and presented as a va=
riable-sized
> > > > array control with as many elements as the hardware can support.
> > > Do you see any difference in ROI for stateful and stateless ? This lo=
oks like a
> > > feature we could combined. Also, ROI exist for cameras too, I'd proba=
bly try and
> > > keep them separate though.
> > I feel like the stateful/stateless behavior should be the same, so that=
 could be
> > a shared control too. Also we could use a QP delta which would apply to=
 both
> > manual and in-kernel rate-control, but maybe that's too low-level in th=
e latter
> > case (not very obvious when a relevant delta could be when userspace ha=
s no idea
> > of the current frame-wide QP value).
> >=20
> > > This is a very good overview of the hard work ahead of us. Looking fo=
rward on
> > > this journey and your Allwinner driver.
> > Thanks a lot for your input!
> >=20
> > Honestly I was expecting that it would be more difficult than decoding,=
 but it
> > turns out it might not be the case.
> >=20
> Such rate control or quailty report would be complete vendor special.
>
> We just need a method that let driver report those encoding statistic to =
the
> userspace.

Returning the encoded bitstream size is perfectly generic and available to
every encoder. Maybe we could also return some average QP value since that
seems quite common. Other than that the rest should be kept in-kernel so we
can have a generic API.

Also it seems that the Hantro H1 specific mechanism (checkpoint-based) is n=
ot
necessarily a lot better than regular QP-wide settings.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--KehLbf333yLPyq0X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmS/vMcACgkQ3cLmz3+f
v9Fm0wf/QSZXJeacsRzMBPmIAlrvfN6cWSGt1O0NspFmSZ8Z00JemceJiQn7QJlV
T/wQIB5wTLkRVF3o7sHbTdaLVdC4074xDfH9130rhWvmkyEYIrVbNvlMY5Pk8/Xl
wr3NhU35NnzLv4ms4UXntvnUq75FMVtOfKawX88nVjuoh2wEHenns/iQ845EEhU1
EuyPmLTKuP1QstmHhZqTNIexzLJ8lF0H6a9BTuMeHps4/l34BUEFAbX30mPgmgUY
pHpw59IPrfDIDN4IoAvJHDb0+BHJvszG84VkTIn5f+kdTnV+msyrABm/163uQssX
6OUUroY7xGPMfbj++M+sjR4A8G81+Q==
=L6pk
-----END PGP SIGNATURE-----

--KehLbf333yLPyq0X--
