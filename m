Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221F175E9D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 04:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjGXCgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 22:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGXCgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 22:36:00 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABD9A8;
        Sun, 23 Jul 2023 19:35:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690166140; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZrfJnBT5PPj8AQcHREThWNPJLe65zplYQtOkkmEtTNffVeDPqW52EA6Sb44jEJpshU+yjIfLsMnR9z/7QlZG3i55dJ3XcEIZRSWLxcvqLTNLG/WeZpTFnGVUjpaG7YBAP03j379c9czDO2knHTYz7dqEeL/InyW1+sQOSmQh/Wk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1690166140; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=fCs+8rOY6OqljSgwbEboZzCQYQ5WTAbKJVJQ1Ycsj3g=; 
        b=Fc0n3Ol7lSuXWKrTLesgul+1sbSRWV2RYE45B4hOY0RvNPTCzsBqqXEx7+2xRtx43BG0ZQEBL9ihk/H60KYOEnNdch75Fs2VFtzUaDKTPJghps7Qz4zPNt9SiymNXD1oXiIFKWx7q9RFp/DMle9ONj8Numa8+yPgUwAiaVtQoPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690166140;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=fCs+8rOY6OqljSgwbEboZzCQYQ5WTAbKJVJQ1Ycsj3g=;
        b=AGDvFk+s2HWapb+S9c4ETXFzmDEud1aAcG8ABgHS2tBYFOVqKkE94P27azoRUycu
        CgjiC9IMEl/9dP0SXsSIvN5wlvPP+QfMq5/EvnMVCAWWlSpATElCzSJ6EeNEMuKuVpB
        VdBgvD0mol9cimeF2rav1nUyOmuIyfXEudsKK7oGCHQYB6up1E1DzNBMskAOE/cw26Y
        p2IQIeZC3yXsZQO1mZc9F94N41mzgIFpvUy15vZt4EvCKCOp3qZbYg5HUfc/N2fTH+w
        kHIhS9NseQ7apcbkgCpAu2OHiiZkgnRb0Vfy8+PTgitUgLBYkiSvbktrDfTXPregYMn
        R8fIiLF/OQ==
Received: from edelgard.fodlan.icenowy.me (120.85.97.227 [120.85.97.227]) by mx.zohomail.com
        with SMTPS id 1690166138874966.9395361401032; Sun, 23 Jul 2023 19:35:38 -0700 (PDT)
Message-ID: <4633cc276c12081ca6059a537f549d4ec0f61d7d.camel@icenowy.me>
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o
 trips subnode
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Date:   Mon, 24 Jul 2023 10:35:34 +0800
In-Reply-To: <ZL1BtOZp/2Sw5sFL@finisterre.sirena.org.uk>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
         <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
         <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org>
         <ZL1BtOZp/2Sw5sFL@finisterre.sirena.org.uk>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-07-23=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 16:05 +0100=EF=BC=
=8CMark Brown=E5=86=99=E9=81=93=EF=BC=9A
> On Sun, Jul 23, 2023 at 12:12:49PM +0200, Daniel Lezcano wrote:
> > On 22/07/2023 22:11, Mark Brown wrote:
>=20
> > > This makes sense to me - it allows people to see the reported
> > > temperature even if there's no trips defined which seems more
> > > helpful than refusing to register.
>=20
> ...
>=20
> > If the goal is to report the temperature only, then hwmon should be
> > used
> > instead.
>=20
> Sure, that doesn't seem to be the case in the impacted systems though
> -
> AFAICT the issue with these is that it's a generic SoC DT that's not
> fully fleshed out, either because more data is needed for the silicon
> or
> because the numbers need to be system specific for some reason.

Well maybe we should move all thermal sensors to hwmon framework, then
let thermal framework pull the readout from hwmon; but two frameworks
have the same functionality of reading temperature is the current
situation, we shouldn't break things.

>=20
> > If the goal is to mitigate by userspace, then the trip point *must*
> > be used
> > to prevent the userspace polling the temperature. With the trip
> > point the
> > sensor will be set to fire an interrupt at the given trip
> > temperature.
>=20
> I'm not clear a trip point prevent userspace polling if it feels so
> moved?=C2=A0 Is it just that it makes it more likely that someone will
> implement something that polls?
>=20
> > IOW, trip points are not optional

If it's declared optional in DT binding in a released kernel version,
then it's optional, at least it should be optional in practice to
support this legacy DT binding, and even there are DT files shipped
with the kernel that utilizes the optionalness. Showing a warning is
okay, but bailing out is not an option, according to my understand of
current DT maintaince model.

>=20
> I can see printing a loud warning given that the system is not fully
> configured (there's a warning already, I did nearly comment on this
> patch downgrading it all the way to a debug log), perhaps even
> suppressing the registraton of the userspace interface, but returning
> a
> failure to the registering driver feels like it's escalating the
> problem
> and complicating the driver code.=C2=A0 Suppressing the registration to
> userspace seemed like it was adding more complexity in the core but
> it
> would avoid any potential confusion for userspace.
>=20
> For me the main issue is the impact on devices that support multiple
> thermal zones, in order to avoid having working zones stay registered
> their drivers will all have to handle the possibility of some of the
> zones failing to register due to missing configuration which is going
> to

Well I think in the case of Allwinner SoCs, the thermal sensor is a
multi-channel one, so it's possible that some channels (e.g. the CPU
sensor) are used for thermal throttling and other channels (e.g. the
GPU one, considering Mali-400 is quite weak, and usually no DVFS
equipped) are only used for monitoring.

We should allow this kind of configuration in kernel. Moving everything
to hwmon is an option, but it's a too gaint change.

> add complexity both at both registration and runtime and be easy to
> miss.
> If the core just accepts the zones then whatever complexity there is
> gets factored out into the core.

