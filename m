Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833A87606F8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 06:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjGYECp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 00:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjGYECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 00:02:33 -0400
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BFB19A2;
        Mon, 24 Jul 2023 21:02:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690257731; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GAdbdhh21+/bti32wZEb6XUbq272rdGBsIObkwqeGrqDCVNVj2gdC7ZY3pkd4kFRnpVyl0y1zg/bSNk8gs8YFc/JgedK8sSFbAPCqvAfftN0lNLan+xFa5gRPsUbs6Npe5FxG052jJ4Vtx3QAKvNljs40fNwJ8wcezw81AQ2R1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1690257731; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=mVD+Low9W/wOZB/3otKo1/wjbfLwHXFKVE40rtv4LWg=; 
        b=IolsltNQU1uj0bmFO8QDBbOGsVhR2FOi2G4ByUky5amvevDSjKYN/fpO3U7SDnkHm4gI0ZFUbsEAhZp0WOkn75YmHy/YourEPauMNlFyzdjR0sD+RXIfnq9zfMO84sq+btsCoVnKtNQnfGeJ13RBiQgOvZ4TxVbMxFTRaOn7Ssg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1690257731;
        s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
        h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=mVD+Low9W/wOZB/3otKo1/wjbfLwHXFKVE40rtv4LWg=;
        b=doXbRRNsogjJPD9tJe8wrYfdUmng5UtphNxPNIDLagy3U0Xjq3bf1NmVHvno7vKO
        7bMiMdmFtTJqOz2hyltK8mIa2RYYp4HQUsLmvE7xv78GiyJF4G08NK4JvL6xYrNcVeD
        t269P+JtPLQ4HzH2GHC6yKYDFbdnnr/zI6rycsCcFFzKfZcGtJRQfGsQ1vTccBie5yb
        H6drsbH7n9xaCLV7OYxlAuAfli+GNNltd7Ps0mKd4na0aEExoWklrO0wYh8CBryk8H2
        2f+bX+xMoUq8unownEhBSLGVcmS6MH/Gw8cU5eiAZ3nyaKAcYu+J22oAcUbXqbsAy0L
        /ZWGRmHXJQ==
Received: from [127.0.0.1] (64.225.114.122 [64.225.114.122]) by mx.zohomail.com
        with SMTPS id 1690257728139917.8461836127788; Mon, 24 Jul 2023 21:02:08 -0700 (PDT)
Date:   Tue, 25 Jul 2023 12:01:58 +0800
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Icenowy Zheng <zhengxingda@iscas.ac.cn>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND_RESEND=5D_thermal/of=3A_?= =?US-ASCII?Q?support_thermal_zones_w/o_trips_subnode?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20230724042502.GA2403526@google.com>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn> <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk> <6d1c0915-1485-d9d6-9fff-0413fb16bd3f@linaro.org> <20230724042502.GA2403526@google.com>
Message-ID: <1308F9C6-F629-42BE-A72A-5BED01D1EDFB@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E4=BA=8E 2023=E5=B9=B47=E6=9C=8824=E6=97=A5 GMT+08:00 12:25:02, Chen-Yu T=
sai <wenst@chromium=2Eorg> =E5=86=99=E5=88=B0:
>On Sun, Jul 23, 2023 at 12:12:49PM +0200, Daniel Lezcano wrote:
>>=20
>> Hi Mark,
>>=20
>> On 22/07/2023 22:11, Mark Brown wrote:
>> > On Sat, Jul 22, 2023 at 08:25:34PM +0800, Icenowy Zheng wrote:
>> > > From: Icenowy Zheng <uwu@icenowy=2Eme>
>> > >=20
>> > > Although the current device tree binding of thermal zones require t=
he
>> > > trips subnode, the binding in kernel v5=2E15 does not require it, a=
nd many
>> > > device trees shipped with the kernel, for example,
>> > > allwinner/sun50i-a64=2Edtsi and mediatek/mt8183-kukui=2Edtsi in ARM=
64, still
>> > > comply to the old binding and contain no trips subnode=2E
>> > >=20
>> > > Allow the code to successfully register thermal zones w/o trips sub=
node
>> > > for DT binding compatibility now=2E
>> > >=20
>> > > Furtherly, the inconsistency between DTs and bindings should be res=
olved
>> > > by either adding empty trips subnode or dropping the trips subnode
>> > > requirement=2E
>> >=20
>> > This makes sense to me - it allows people to see the reported
>> > temperature even if there's no trips defined which seems more
>> > helpful than refusing to register=2E
>>=20
>> The binding describes the trip points as required and that since the
>> beginning=2E
>
>Not really=2E It was made optional in the v5=2E15 kernel release by commi=
t
>
>    22fc857538c3 dt-bindings: thermal: Make trips node optional

Yes, thanks for the clarification=2E

My understand of DT binding tells me that this means lacking of the trips =
node
must be handled, before we solve the inconsistency between current
DT binding and shipped DTs=2E

The latter problem could be discussed, but the former problem is a MUST
unless we're breaking the compatibility promise of DT bindings (and shippe=
d DTs)=2E

>
>> What changed is now the code reflects the required property while befor=
e it
>> was permissive, that was an oversight=2E
>>=20
>> Just a reminder about the thermal framework goals:
>>=20
>>   1=2E It protects the silicon (thus critical and hot trip points)
>>=20
>>   2=2E It mitigates the temperature (thus cooling device bound to trip =
points)
>>=20
>>   3=2E It notifies the userspace when a trip point is crossed
>>=20
>> So if the thermal zone is described but without any of this goal above,=
 it
>> is pointless=2E
>>=20
>> If the goal is to report the temperature only, then hwmon should be use=
d
>> instead=2E
>
>What about thermal sensors with multiple channels? Some of the channels
>are indeed tied to important hardware blocks like the CPU cores and
>should be tied into the thermal tripping=2E However other channels might
>only be used for temperature read-out and have no such requirement=2E
>
>Should we be mixing thermal and hwmon APIs in the driver?
>
>> If the goal is to mitigate by userspace, then the trip point *must* be =
used
>> to prevent the userspace polling the temperature=2E With the trip point=
 the
>> sensor will be set to fire an interrupt at the given trip temperature=
=2E
>>=20
>> IOW, trip points are not optional
>
>for measurement points that are used for thermal throttling /
>mitigation=2E
>
>ChenYu
>
