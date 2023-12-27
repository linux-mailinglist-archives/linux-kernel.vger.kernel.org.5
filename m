Return-Path: <linux-kernel+bounces-11810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C981EBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D92F1C22189
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96543C24;
	Wed, 27 Dec 2023 03:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TIEzljUC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93875290B;
	Wed, 27 Dec 2023 03:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1703649446; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ci+N34DZ/1jEYg/YaTh1Eju9R2R0ILw6v8amLrTBwPkYhKO1dT0NHYL/tn7Ah4jRNW17627qYYYTRcUzIFM/jVDBbLwwgjbv8ivgaLERkeWgZKyiEafZ6aUzirheDdEYESRagsVgigsMKoZJGphbwyJsr2cBl1DJt+4Qqq2bYRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1703649446; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PDs/5RyQrkv8/uvBnzQ1A3NQ3kJYbwWBLDAWvp3dC/g=; 
	b=LrkgA3sU1xiV7M3lI1Up+vd42ynvNWHNhE4s4yVw84ICVq3+issXa1nYZmJPhmzlIj7WdoEc+Ma6VS4s0Q9I3MoZyJusIgny4AKGvjxXV94f8tq8NbjB63shOjJlpTuJsbGNWKjxWHLx6zujZCMApKbeMJ7bBqe014ZdU7f9D1Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1703649446;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=PDs/5RyQrkv8/uvBnzQ1A3NQ3kJYbwWBLDAWvp3dC/g=;
	b=TIEzljUCMSZFCXIRUzbbLkkGvEQThEuyOy5WvEjPHPZ9AIslNARA6SDTyNz+2B4u
	gMdeLyfsZ23226ihMGECXJ0KArV0G85ZeDPWGHHzXsetMCxo/RrkFVPa0NhAh/VoIoy
	2flbuVZQQQxqUslAKC8jxJskifGKJHpBgskwvYaFoppODCw8vfSLQsXmugDm7DZe9TS
	wy6WsmdaIfO8APQ9qV4oKH845/0WmYoK2pCQWJgPxDHC5adABo7/yDvxiaYXb9ZxBkU
	b+zbHU3PO5bXf3iPFi6x0jdzgPu5vC8VNkLmPXAQznA34Qj5pp1QfBocznBR+SAx++y
	eDzVxShNgg==
Received: from edelgard.fodlan.icenowy.me (120.85.97.19 [120.85.97.19]) by mx.zohomail.com
	with SMTPS id 1703649444779355.6452133422597; Tue, 26 Dec 2023 19:57:24 -0800 (PST)
Message-ID: <94bdac9b7347893cfa787b3f8c95215d4b7b4c12.camel@icenowy.me>
Subject: Re: [v3 4/6] drm/vs: Add KMS crtc&plane
From: Icenowy Zheng <uwu@icenowy.me>
To: Keith Zhao <keith.zhao@starfivetech.com>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	 <linux-riscv@lists.infradead.org>
Cc: "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
 "suijingfeng@loongson.cn" <suijingfeng@loongson.cn>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>,  "paul.walmsley@sifive.com"
 <paul.walmsley@sifive.com>, "mripard@kernel.org" <mripard@kernel.org>, 
 Xingyu Wu <xingyu.wu@starfivetech.com>, Jack Zhu
 <jack.zhu@starfivetech.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 William Qiu <william.qiu@starfivetech.com>,  Shengyang Chen
 <shengyang.chen@starfivetech.com>, Changhuang Liang
 <changhuang.liang@starfivetech.com>
Date: Wed, 27 Dec 2023 11:57:17 +0800
In-Reply-To: <580e13ab-a73e-4ce7-999a-8a8685faf2dd@starfivetech.com>
References: <20231204123315.28456-1-keith.zhao@starfivetech.com>
	 <20231204123315.28456-5-keith.zhao@starfivetech.com>
	 <7acd5af8fd4c5bf6ee0614f72cf6cb6751c89dc3.camel@icenowy.me>
	 <580e13ab-a73e-4ce7-999a-8a8685faf2dd@starfivetech.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

=E5=9C=A8 2023-12-07=E6=98=9F=E6=9C=9F=E5=9B=9B=E7=9A=84 19:31 +0800=EF=BC=
=8CKeith Zhao=E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
> On 2023/12/7 16:41, Icenowy Zheng wrote:
> > =E5=9C=A8 2023-12-04=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 20:33 +0800=EF=
=BC=8CKeith Zhao=E5=86=99=E9=81=93=EF=BC=9A
> > *snip*
> >=20
> > > +static void update_cursor_plane(struct vs_dc *dc, struct
> > > vs_plane
> > > *plane,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct drm_plane *drm_plane,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct drm_atomic_state
> > > *drm_state)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct drm_plane_state *st=
ate =3D
> > > drm_atomic_get_new_plane_state(drm_state,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0
> > > =C2=A0 drm_plane);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct vs_plane_state *pla=
ne_state =3D
> > > to_vs_plane_state(state);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct drm_framebuffer *dr=
m_fb =3D state->fb;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct dc_hw_cursor cursor=
;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.address =3D plane_s=
tate->dma_addr[0];
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.x =3D state->crtc_x=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.y =3D state->crtc_y=
;
> >=20
> > From my experiments on poking with registers on T-Head TH1520 (also
> > uses DC8200 display controller and a similar driver), the DC8200
> > hardware have a different definition of cursor position X and Y
> > with
> > the CRTC plane state.
> >=20
> > For CRTC plane state, hot_x and hot_y are only provided as
> > reference,
> > and the cursor should be displayed with its (0,0) drawn to (crtc_x,
> > crtc_y) ([XY]_crtc are values specified in CRTC state, the right
> > part
> > of the assignments here), when the cursor is moved to (0,0) but the
> > hot
> > point is not (0,0), it could be negative.
> >=20
> > However, for DC8200 registers definition, cursor XY position could
> > not
> > be negative -- the cursor will disappear then; because in its
> > definition, the cursor XY position should be where the cursor is
> > pointing to, instead of its (0,0). DC8200 will draw (0,0) of the
> > cursor
> > to (x - hot_x, y - hot_y). So to met the expectation of the KMS
> > plane
> > settings, the DC8200 position should be set to (crtc_x + hot_x,
> > crtc_y
> > + hot_y) instead. Thus these two lines of code should be:
> >=20
> > ```
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor.x =3D state->crtc_x +=
 drm_fb->hot_x;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cursor.y =3D state->crtc_y +=
 drm_fb->hot_y;
> > ```

Well I realized that this change is not correct too: when moving the
mouse cursor with the screen rotated, the mouse cursor will disappear
at some screen border.

My current idea is:

As the CRTC hot point is just a reference, we can just ignore it, and
use the HW hot point to implement negative cursor position.

The patch is like the follow:

-    cursor.x =3D state->crtc_x;
-    cursor.y =3D state->crtc_y;
-    cursor.hot_x =3D drm_fb->hot_x;
-    cursor.hot_y =3D drm_fb->hot_y;
+    if (state->crtc_x > 0) {
+        cursor.x =3D state->crtc_x;
+        cursor.hot_x =3D 0;
+    } else {
+        cursor.hot_x =3D -state->crtc_x;
+        cursor.x =3D 0;
+    }
+    if (state->crtc_y > 0) {
+        cursor.y =3D state->crtc_y;
+        cursor.hot_y =3D 0;
+    } else {
+        cursor.hot_y =3D -state->crtc_y;
+        cursor.y =3D 0;
+    }

drm_fb could just be removed in this function then because it's no
longer needed (it's used to get the cursor's hot point, which we
ignored now).

> >=20
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.hot_x =3D drm_fb->h=
ot_x;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.hot_y =3D drm_fb->h=
ot_y;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.display_id =3D to_v=
s_display_id(dc, state->crtc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0update_cursor_size(state, =
&cursor);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cursor.enable =3D true;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dc_hw_update_cursor(&dc->h=
w, cursor.display_id, &cursor);
> > > +}
> > *snip
> hello Icenowy:
> you are deep understanding on dc8200.
> by the way of practice
> I tested this change on the debian desktop, is there a way to compare
> the cursor behavior change?
> Thanks
>=20
>=20
>=20


