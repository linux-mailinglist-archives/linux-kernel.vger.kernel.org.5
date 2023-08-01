Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAA876B6DF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjHAOLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjHAOLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:11:02 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7146ADC;
        Tue,  1 Aug 2023 07:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690899045; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=h9gRF356ssKPjg2k5q6nQIoGd0VI8Mk8yi2aWuY7FLl9HZww+2x7VTSPBbCUPxTJw4p2sAGOQlfyCPM523roTmdQs0+UeCKkR1O3GyBbgHjsNi7drEkN2D8eSAe7yjZF4FiIjm54kF+cFM5Eca1Tj1KkN8tVtLjl09cG1KuRhp8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1690899045; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Umue7wpYHFkb33ql48Df3lqSCFV9LrXKhteAa0wF8rE=; 
        b=gFKm5eN48vNDWsP4iCtrtHDAlqCxJV2mVnf0sLOdNysJqEe8WbPW6/wM8mX1YXjo3cKL7QnfS4hTuhDoUYSz/7jxRuCbjTu9BZLqH1VhRfz2YU+edaM4FRDWlwDflLYqAPr0VwrnDn1HD4UyzP/ayJGK6/A9joPDLCs3qob8QjA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690899045;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=Umue7wpYHFkb33ql48Df3lqSCFV9LrXKhteAa0wF8rE=;
        b=AFL1nAv1VOBQUuLEEdgDUUDaia9aJbLmyoEMlf89UMh1sC9JNVw0r0kzcGrgwCH2
        gssWuISUCWtibEIPA3X9u97oApSjeYRh7VI94u+9kzcF/Ihie1PXtdjU/Ht1SgiHIom
        ZvreTeIBTw2j5T6Cdr2kt009zsqMHRRBVAPrjvGLWUEaDO96QHVRTW3oYsBgTVMDsTw
        PYs8zhufx2OcF4Fn+/HXZ9TW3QP2nZ7SkFX4E5rCfQrjhQcBZS9TLJccDth2I7BYk3C
        9TPZFCPZ4OYN+2zMI7U0BdlmGwIitRm+NiNdIGBXow9jlqUMnwnE0cTMJaeA8Gp6Vdu
        OSE0BhN4lg==
Received: from edelgard.fodlan.icenowy.me (120.85.99.175 [120.85.99.175]) by mx.zohomail.com
        with SMTPS id 1690899039071665.3001028089096; Tue, 1 Aug 2023 07:10:39 -0700 (PDT)
Message-ID: <c0ccb3021324883fce5d87e27f5abdcccc96503a.camel@icenowy.me>
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o
 trips subnode
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Date:   Tue, 01 Aug 2023 22:10:34 +0800
In-Reply-To: <20230724042502.GA2403526@google.com>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
         <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
         <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
         <20230724042502.GA2403526@google.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-07-24=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 12:25 +0800=EF=BC=
=8CChen-Yu Tsai=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Jul 23, 2023 at 12:12:49PM +0200, Daniel Lezcano wrote:
> >=20
> > Hi Mark,
> >=20
> > On 22/07/2023 22:11, Mark Brown wrote:
> > > On Sat, Jul 22, 2023 at 08:25:34PM +0800, Icenowy Zheng wrote:
> > > > From: Icenowy Zheng <uwu@icenowy.me>
> > > >=20
> > > > Although the current device tree binding of thermal zones
> > > > require the
> > > > trips subnode, the binding in kernel v5.15 does not require it,
> > > > and many
> > > > device trees shipped with the kernel, for example,
> > > > allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in
> > > > ARM64, still
> > > > comply to the old binding and contain no trips subnode.
> > > >=20
> > > > Allow the code to successfully register thermal zones w/o trips
> > > > subnode
> > > > for DT binding compatibility now.
> > > >=20
> > > > Furtherly, the inconsistency between DTs and bindings should be
> > > > resolved
> > > > by either adding empty trips subnode or dropping the trips
> > > > subnode
> > > > requirement.
> > >=20
> > > This makes sense to me - it allows people to see the reported
> > > temperature even if there's no trips defined which seems more
> > > helpful than refusing to register.
> >=20
> > The binding describes the trip points as required and that since
> > the
> > beginning.
>=20
> Not really. It was made optional in the v5.15 kernel release by
> commit
>=20
> =C2=A0=C2=A0=C2=A0 22fc857538c3 dt-bindings: thermal: Make trips node opt=
ional

I agree, this is why I send this patch (and why I say 'for DT binding
compatibility now' in the commit message). Further discussion could be
performed, but this patch should be applied regardless of the result of
further discussion.

DT binding compatibility is the unbreakable law.

>=20
> > What changed is now the code reflects the required property while
> > before it
> > was permissive, that was an oversight.
> >=20
> > Just a reminder about the thermal framework goals:
> >=20
> > =C2=A0 1. It protects the silicon (thus critical and hot trip points)
> >=20
> > =C2=A0 2. It mitigates the temperature (thus cooling device bound to
> > trip points)
> >=20
> > =C2=A0 3. It notifies the userspace when a trip point is crossed
> >=20
> > So if the thermal zone is described but without any of this goal
> > above, it
> > is pointless.
> >=20
> > If the goal is to report the temperature only, then hwmon should be
> > used
> > instead.
>=20
> What about thermal sensors with multiple channels? Some of the
> channels
> are indeed tied to important hardware blocks like the CPU cores and
> should be tied into the thermal tripping. However other channels
> might
> only be used for temperature read-out and have no such requirement.
>=20
> Should we be mixing thermal and hwmon APIs in the driver?

Well you have no right to decide which sensor should be used for
throttling and which not. So the only way to make the semantic correct
is just rip every sensor driver out of thermal API to hwmon API, and
let thermal framework to use hwmon's.

>=20
> > If the goal is to mitigate by userspace, then the trip point *must*
> > be used
> > to prevent the userspace polling the temperature. With the trip
> > point the
> > sensor will be set to fire an interrupt at the given trip
> > temperature.
> >=20
> > IOW, trip points are not optional
>=20
> for measurement points that are used for thermal throttling /
> mitigation.
>=20
> ChenYu
>=20

