Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764827F9E99
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjK0LaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjK0LaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:30:07 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA1B8;
        Mon, 27 Nov 2023 03:30:12 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 64C3160015;
        Mon, 27 Nov 2023 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1701084611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhGJjrTTtgimxfRNbfSScr4mzO4GO8LCiZ6yeATg9+M=;
        b=npQAcUWNK817PNnMtIdROlqCU68u6J61oYaZWTMkiXUcjId2TZsw9+CYlsWf1Twe1A7QsX
        PPvsguZ8kGHxSACCttFXMA6c2ei3G64kYeMy+O4ks2hYu6y7mO1bjtaBqADr6WclX07srH
        155/YPZ39tOrpqzZESeecLaJ0vM0tOdKlwJmCioV8VOiHnuGB2t0K6hin8yJ4p+UipZkS9
        t5j2c/ATP0vtoe0KQ5MEYPyYsg6f2MBpD8LbOYBm9JGdhTJriRAjtlFHetKxHJBG4Y/nSi
        eGI5gzotSHzqYhUoB84bkoQOt+uUn+iPOWfQusWJrH5LtOwNCxqAp99XSnibiA==
Date:   Mon, 27 Nov 2023 13:30:00 +0200
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
To:     Daniel Golle <daniel@makrotopia.org>
CC:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_RESEND_net-next_2/2=5D_dt-bindings=3A?= =?US-ASCII?Q?_net=3A_dsa=3A_mediatek=2Cmt7530=3A_document_MDIO-bus?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZWPIQW1JA3rsvAzm@makrotopia.org>
References: <6eb1b7b8dbc3a4b14becad15f0707d4f624ee18b.1691246461.git.daniel@makrotopia.org> <9aec0fe0cb676b76132c388bb3ead46f596a6e6e.1691246461.git.daniel@makrotopia.org> <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com> <20230808121707.chona7hakapp6whe@skbuf> <44fde617-1159-4961-84c4-372fe265fbd8@arinc9.com> <20230809220102.t3dqw7iojez5xsq3@skbuf> <3f262579-eec1-4b21-9b18-1d1d612e715b@arinc9.com> <ZWPIQW1JA3rsvAzm@makrotopia.org>
Message-ID: <D03B73C8-0DD4-459E-8BA3-C1A0B16809A3@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 November 2023 00:35:45 EET, Daniel Golle <daniel@makrotopia=2Eorg> wr=
ote:
>On Sat, Aug 12, 2023 at 01:45:29AM +0300, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote=
:
>> On 10=2E08=2E2023 01:01, Vladimir Oltean wrote:
>> > [=2E=2E=2E]
>> > Since commit fe7324b93222 ("net: dsa: OF-ware slave_mii_bus"), DSA as=
 a
>> > framework also supports auto-creating an internal MDIO bus based on t=
he
>> > presence of the "mdio" node name, so I guess it makes sense for the
>> > "mdio" to appear in the generic dsa=2Eyaml if there's nothing else th=
at's
>> > special about it=2E
>>=20
>> I agree with this=2E I've done this which works=2E It's even found a po=
rt
>> node with the ethernet property missing, as it should've=2E
>
>Are you planning to complete/submit your work below?
>I'm asking because being able to reference the PHYs on the internal
>MDIO bus is mandatory on MT7988 which requires calibration data from
>NVMEM for each PHY, so supporting MT7988 depends on the associated
>driver change[1]=2E
>
>[1]: https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/6eb1b7b8dbc=
3a4b14becad15f0707d4f624ee18b=2E1691246461=2Egit=2Edaniel@makrotopia=2Eorg/

This patch triggered conversation on a deeper level regarding the
devicetree bindings aspect of it=2E I will continue discussing that with t=
he
maintainers here and achieve a mutual agreement=2E

To get things going on the driver side, I think it's fine to submit that
as a single patch=2E I'll do that in a week, if nobody else does it first=
=2E

Ar=C4=B1n=C3=A7
