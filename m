Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FB97AA234
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjIUVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjIUVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:13:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB655279;
        Thu, 21 Sep 2023 10:08:21 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8589D660731D;
        Thu, 21 Sep 2023 16:46:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695311211;
        bh=qmLDWY/AuDZBwTiEH6bdhLx9MgWdAsDslzLfx3DOK4A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AAgC+As4Cy0TIyhqMYWvMkMILzrYGP2tdMFpvtrvDNPf0KcxzcZjzMOSK4Rq+GWMQ
         EIpWb+TvGWirRWMOZCnECZJb8onvByXZBGwfeB6ZhIC0oO7BjgjViiHxqwDixdY78Z
         K42MnJB5KJsEJ7fPabAtJvrBf8vDCD1DZ6xRKVOKXgDp7Ecy6k7Slj/HvSyvE2VWMK
         QntErYDk3VwsgkkGUd4sx9fDC1P8XVhFchzQ+LnlHzDVJAEldAUAFC1OeR/4l+Gdi4
         F7SL1J42s1DO+HX9UVMY1uNhlaX6g2/4RjNBE3XNQIveR7GF+dQxCVD4Z0bz0/rViQ
         EvIPcMHnu1ptg==
Message-ID: <c7cd83c49a9226e72c272365653dc8b998b6adcb.camel@collabora.com>
Subject: Re: [PATCH 12/14] media: medkatek: vcodec: set secure mode to
 decoder driver
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jeffrey Kardatzke <jkardatzke@google.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Yunfei Dong =?UTF-8?Q?=28=E8=91=A3=E4=BA=91=E9=A3=9E=29?= 
        <Yunfei.Dong@mediatek.com>,
        "nhebert@chromium.org" <nhebert@chromium.org>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 21 Sep 2023 11:46:40 -0400
In-Reply-To: <CA+ddPcPbox=mknpmDkwfYTfDMca49wU10SNF3mJspYu=5T64FQ@mail.gmail.com>
References: <20230911125936.10648-1-yunfei.dong@mediatek.com>
         <20230911125936.10648-13-yunfei.dong@mediatek.com>
         <1df3e79b84933dda0313d0d9719220dbc06c9022.camel@collabora.com>
         <d4cedcb0-32ed-495d-a8cd-a635d5105824@xs4all.nl>
         <5307203d79c0d90cc742a315bb161fa796b9960f.camel@mediatek.com>
         <bafc37e8-96e8-41c0-b805-c6477f0d7c4a@xs4all.nl>
         <CA+ddPcN6EaFERC60_Z_-ZmWzqyUEwxiDCZwt_U6Y-gpaAu76tA@mail.gmail.com>
         <ff7aa575-c820-4dfa-853f-77438b8b149a@xs4all.nl>
         <b7d661637eacbda3e83d192b1126fc3970c4f50d.camel@collabora.com>
         <c3d14f64-bf04-46b9-ac7b-af7ef9014335@xs4all.nl>
         <CA+ddPcPbox=mknpmDkwfYTfDMca49wU10SNF3mJspYu=5T64FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 20 septembre 2023 =C3=A0 11:20 -0700, Jeffrey Kardatzke a =C3=
=A9crit=C2=A0:
> > >=20
> > > Also, regarding MTK, these are stateless decoders. I think it would b=
e nice to
> > > show use example code that can properly parse the un-encrypted header=
, pass the
> > > data to the decryptor and decode. There is a bit of mechanic in there=
 that lacks
> > > clarification, a reference implementation would clearly help. Finally=
, does this
> > > platform offers some clearkey implementation (or other alternative) s=
o we can do
> > > validation and regression testing? It would be very unfortunate to ad=
d feature
> > > upstream that can only be tested by proprietary CDM software.
> >=20
>=20
> It would be possible to use this with clearkey w/ some additional work
> on our end. If this is then part of the public ChromiumOS build, would
> that be satisfactory? (the TEE would have some binary blob components
> like firmware does though)

From my point of view, this would fully cover my concern. To clarify this
concern, the  decryption into secure memory currently only ever take place =
in
proprietary code that implements the protection (Widewine CDM). With clear =
key,
we can have an open source CDM (made for testing purpose) so that we don't =
have
to have hidden code to test the entire pipeline. So appart from the TEE
firmware, which is just a firmware like all the others, we could have open
source tests in kernelCI and other CI, and we could extend these test to
eventually support other vendors.

Note that currently, with other proposal, one could allocate and fill a nor=
mal
buffer, and "secure" that buffer to test the CODECs and display, but on thi=
s
specific architecture, with the limitation on the number of secure regions,=
 this
feature isn't available.

Alternatives to this end-to-end solution, we could consider a TA (Trusted
Application) that simply copy data from a untrusted chunk of memory into a
trusted chunk of memory. That seems like a cross-platform solution. It woul=
d be
even better if this get standardized in TEEs for course (or at least requir=
ed
with all secure memory implementation). Then copying from untrusted to trus=
ted
could easily become an ioctl generic to all TEE drivers. That to me would b=
e
equally acceptable, and perhaps easier to use.

Nicolas=20
