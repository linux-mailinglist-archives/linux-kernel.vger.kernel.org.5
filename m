Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB813805D8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345644AbjLESEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjLESEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:04:36 -0500
X-Greylist: delayed 35102 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Dec 2023 10:04:40 PST
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D190;
        Tue,  5 Dec 2023 10:04:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701799457; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VmFc1XWvs5u9DH+vdiul0FqKwjuBitqSXZVOQBWY2k7zVyPvg1NFis5yw+pu7hmxjh
    wyBdSnIvT5bWcOXBbunmBinnT+T9BHveySdmlJzKdEEU3OkhU29CuOOm96PD2ZhHg3fc
    4Sui3G7Xqu0ZbPdXkpiRIlM8/A/Qc5RipA9C474RLa2ASZISyDpVCXM7Ewn3BpNy++Bm
    Im7VjKjKu70FtHvnkYLjO4OanaL9ByOwRs1FxlGDldD7bKwxnRI14SHG0QdQBrro/wHA
    2MaPnejDlQI77jit9hQ9EHpkvj76PTeq6jyYt9GFn9uTN9haJowbmrMbYJv0yOkAh4ux
    zdKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701799457;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1UBNn0Iu2hfNvuHQsBRxEquJNd6AQ4+RDCYbbSAQ0nU=;
    b=agnyK1EuXFGdO/wTcLOUuhg6Ytzq9u1Zvl2IeoEdXlDrA6C2jck+3VWJ9z+DvQgDJN
    LJMqWuTrCBDo/W9YR9ay6fB+nophfxjT669jApdlMp4IF5WLgizew3quzAyuvo+uStAk
    70uATWRJt0lCHbfUQsl7SRK994w3IGMXrSrFUDjaMIglqC2D70LS9nth4yFt1jKXF/x3
    GqKWSfgKRzVS7teLHLUX2fhuTAddCBcZ4kkUN6fCICpQoP6pJ2mBfphPW1q3Z++VX7Kl
    B9Xpw8A2dIn0Y9uqkuejz/aJ3UMwLl/3rjnighW18bMLHANtrfKVz6ZOO4j+eJPdioqo
    bPmg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701799457;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1UBNn0Iu2hfNvuHQsBRxEquJNd6AQ4+RDCYbbSAQ0nU=;
    b=L6vpZfzMuHzcxIaLRg6AvzGgDfwVhVH5aV+YftyHIakS72uPspob4CHDIrBafsVwNw
    Xp4y9dZX/c8trthSmjtvXCTv14AioTepn55vjePkKWcouBQH6RexbG4BpGLtjR8XKPuj
    jNMrYVYiWlkhY/uhpk0PT6ngNhhiLqYuMzKKMUUJxWOadq7D1LsM1m/ka9lJ+bjGpPKo
    ZPMlFJbVTi8l1AGGTKJc4tXTWzhQpKovbziBzQhPNz47ApvlLfIRLxGgSgBky6OQLsmd
    dNNy0S0Vmp+rxP/96Wv92ukPSF9w6T74eIqChdoxZ7oIGvLzGZDl76wYRBPhiaAQJUV2
    mcnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701799457;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=1UBNn0Iu2hfNvuHQsBRxEquJNd6AQ4+RDCYbbSAQ0nU=;
    b=TD8ho4B7CGbx6LG30k3gueB1c00HDFe+LdKRbDGI8bd5fwaUoeqx4THPruFYoRie54
    5SO17IPoBXNHVj7mz6Ag==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGeonQ="
Received: from smtpclient.apple
    by smtp.strato.de (RZmta 49.10.0 DYNA|AUTH)
    with ESMTPSA id wfeb35zB5I4F3Mm
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 5 Dec 2023 19:04:15 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH RFC 01/10] dt-bindings: gpu: Add PowerVR Series5 SGX GPUs
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <cb590a13-e0ff-49d9-8583-be613ad50dc5@ti.com>
Date:   Tue, 5 Dec 2023 19:04:05 +0100
Cc:     Frank Binns <frank.binns@imgtec.com>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Adam Ford <aford173@gmail.com>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FE0DBA5E-95A5-4C27-9F69-D1D8BDF56EC3@goldelico.com>
References: <20231204182245.33683-1-afd@ti.com>
 <20231204182245.33683-2-afd@ti.com>
 <CFF198DA-5C42-425E-86F4-759629489ECB@goldelico.com>
 <cb590a13-e0ff-49d9-8583-be613ad50dc5@ti.com>
To:     Andrew Davis <afd@ti.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 05.12.2023 um 18:33 schrieb Andrew Davis <afd@ti.com>:
>=20
> On 12/5/23 2:17 AM, H. Nikolaus Schaller wrote:
>>> +          - enum:
>>> +              - ti,omap3430-gpu # Rev 121
>>> +              - ti,omap3630-gpu # Rev 125
>> Is the "Rev 121" and "Rev 125" a property of the SoC integration =
(clock/reset/power
>> hookup etc.) or of the integrated SGX core?
>=20
> The Rev is a property of the SGX core, not the SoC integration.

Then, it should belong there and not be a comment of the ti,omap*-gpu =
record.
In this way it does not seem to be a proper hardware description.

BTW: there are examples where the revision is part of the compatible =
string, even
if the (Linux) driver makes no use of it:

drivers/net/ethernet/xilinx/xilinx_emaclite.c

> But it seems that
> compatible string is being used to define both (as we see being =
debated in the other
> thread on this series).
>=20
>> In my understanding the Revs are different variants of the SGX core =
(errata
>> fixes, instruction set, pipeline size etc.). And therefore the =
current driver code
>> has to be configured by some macros to handle such cases.
>> So the Rev should IMHO be part of the next line:
>>> +          - const: img,powervr-sgx530
>> +          - enum:
>> +              - img,powervr-sgx530-121
>> +              - img,powervr-sgx530-125
>> We have a similar definition in the openpvrsgx code.
>> Example: compatible =3D "ti,omap3-sgx530-121", "img,sgx530-121", =
"img,sgx530";
>> (I don't mind about the powervr- prefix).
>> This would allow a generic and universal sgx driver (loaded through =
just matching
>> "img,sgx530") to handle the errata and revision specifics at runtime =
based on the
>> compatible entry ("img,sgx530-121") and know about SoC integration =
("ti,omap3-sgx530-121").
>> And user-space can be made to load the right firmware variant based =
on "img,sgx530-121"
>> I don't know if there is some register which allows to discover the =
revision long
>> before the SGX subsystem is initialized and the firmware is up and =
running.
>> What I know is that it is possible to read out the revision after =
starting the firmware
>> but it may just echo the version number of the firmware binary =
provided from user-space.
>=20
> We should be able to read out the revision (register =
EUR_CR_CORE_REVISION), the problem is
> today the driver is built for a given revision at compile time.

Yes, that is something we had planned to get rid of for a long time by =
using different compatible
strings and some variant specific struct like many others drivers are =
doing it.
But it was a to big task so nobody did start with it.

> That is a software issue,
> not something that we need to encode in DT. While the core ID (SGX5xx) =
can be also detected
> (EUR_CR_CORE_ID), the location of that register changes, and so it =
does need encoded in
> DT compatible.

Ok, I didn't know about such registers as there is not much public =
information available.
Fair enough, there are some error reports about in different forums.

On the other hand we then must read out this register in more or less =
early initialization
stages. Even if we know this information to be static and it could be as =
simple as a list
of compatible strings in the driver.

> The string "ti,omap3430-gpu" tells us the revision if we cannot detect =
it (as in the current
> driver), and the SoC integration is generic anyway (just a reg and =
interrupt).

It of course tells, but may need a translation table that needs to be =
maintained in a
different format. Basically the same what the comments show in a =
non-machine readable
format.

I just wonder why the specific version can or should not become simply =
part of the DTS
and needs this indirection.

Basically it is a matter of openness for future (driver) development and =
why it needs
careful decisions.

So in other words: I would prefer to see the comments about versions =
encoded in the device
tree binary to make it machine readable.

BR and thanks,
Nikolaus=
