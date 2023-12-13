Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DFF811AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbjLMR2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjLMR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:28:06 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B26C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1702488482; x=1703093282; i=rwahler@gmx.net;
        bh=d8KQqfVmNpqWzmP5VnNOFNpU+M9tn4X1y6fryn9Vjiw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=IwIHIFwgVYir7md9oVy91JZFVLo2g6mJXBIxVCGJJQqpUDH2jmwxRiJty4FE/hgp
         Tq5cWERjuuXFqjkGx/OU7uwUJ6JKbGNU39xzCusaHAFTCxj/1IyWs1w5xYTH3YaJy
         UhzS1MZZ0bOYGztbtF5oX75lqHCkXFYR3loTNfTQK21P9MOYMGpWLNu7x2RAFmoeb
         URYUKXvBYvQ2p2NO4l+BRANJmWnhbJLHlV2BWe6lOhayG/h1WhhYFQuImZIIVRxjW
         BOyALFFIvQp1dSO6zsbvl1P/snkbdr4YJ9A+7Suq7/AGOmd3o4Wjl2atEuwLl97nD
         GlSOMvWUwuygIjFdkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from wayne.aktex ([176.199.153.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1r7hjo3cJ3-0080Wj; Wed, 13
 Dec 2023 18:28:01 +0100
Received: from fox-mulder.aktex (fox-mulder.aktex [192.168.2.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
        (No client certificate requested)
        by wayne.aktex (Postfix) with ESMTPSA id 4A338280114;
        Wed, 13 Dec 2023 18:28:01 +0100 (CET)
From:   rwahler@gmx.net
To:     kvalo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
Date:   Wed, 13 Dec 2023 18:27:57 +0100
Message-Id: <20231213172757.46199-1-rwahler@gmx.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <874jgmnud8.fsf@kernel.org>
References: <874jgmnud8.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1sKoj4D88Apt75Md6Y/oIFcr35UhkNziQQxguQ1LYh0D0/a/xDR
 9MZEQSamqeE6h9g/fuhY+7y66/bczml+Ddh6DxoumqBXHEp/QUrZDGp32+LXKR+joJowlHa
 kSb2bceCnmjjPk5121FygdeQHspO2HdLTn/gecjOqslVrNPa9oK2zDq86hr93RDpe19p3cG
 l4PS79GGFRDo0Ae9jNFfw==
UI-OutboundReport: notjunk:1;M01:P0:ClFv8jH0ZJA=;fgi/BpeeFvre8HQgSwR1Zb+MFVQ
 F28f0N0KoJdgD+w+viBQMcl0P69MUj6v8itop5lQxSRuGWy9i6QB2BONVES2yrF/EGNVfJIM+
 I2ygT3xAfE90YHbR3lRLCh5vzBLoECcYAVYcKw99LbU6sz+3IzqYAB4RcvAkQALMHHg92ljn1
 JY283Bd4XSpbXpmEp5eMY6wSY8u4sNzM7rAoFJkCk0mEE8cIJY0u53skUWe44YhyyDfyLutP1
 Sf3DOuoCUnSi+KToMuCpIPlCGXtUZ/9690iEBCXssfw26a8vaXt4SxJO7i6oLN5CTt9yWyjtG
 MygBxkK7SwuPfTo0xjpwQbO6wSqQEYyz6vGUeTbzr9il7AtE0mmdrG0iSFMIk93DMB2ROLy3w
 9WRdCUlSV9nCJXO1gFY09DOtIom6glNg4xy/rdC6fFmM3sY/X4EtkKimI6lR0Ibhv4hFJbf1x
 bHzZe7t1vrfKDXXEjWXrO78aRXX7Aojvdk/5nA+lmJlNbALQAc0OMHuGu6HYLJPz10LepM3FJ
 6urfwkBFbarvdGC4XMm09G9vKPB+yg+tSLkRFxaucXDCPDkwJU13jc+pMcPkK+RWDq3xoilQP
 zC5MW5PUEKMqEF7fBLf9++iSOa0lwLz5wq8nwCiZSK1uZLHrbqjHu3iPwD0SWItccXkE6QtVz
 Ol6epUkJcbV9EgqgIz0ENu3AEk8dZUfMg7BB2qz1LwojpcnqzoWdm6zh1ThCHRpUHC0sZS91Y
 GP4utPaqvxTDea7xzi17clxGOuvVbS/ljIgtY4/GjxLU/GiuInt3DHdOgEJSW7WwN/lDDD5i7
 RgVyBZ+XstwWflmwWv3t6rO5TGe/Li7wO8bjYUuolVFw0YjuC76QojOhKueqBnLke4HIbRA9f
 m8YDnusfgrjBgMFd7EDor/DrvnF0EyeDsd6x0aL1VqwXm101YPTcK0425RXz6x1mp7G4JUrz/
 QU0CYiqafr8CxFDfwb1PL/NMX/0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sultan Alsawaf <sultan@kerneltoast.com>

Sultan Alsawaf <sultan@kerneltoast.com> writes:

> 3. For insignificant/low-bandwidth traffic like ICMP to the AP, high lat=
ency is
>    expected since the amount of traffic doesn't warrant kicking the chip=
set out
>    of powersave. So although it's not pretty to look at, bad ping times =
to the
>    AP aren't representative of the full user experience.

Without the proposed patch ping times are often > 3000ms with a packet los=
s of ~20%. And it's not only ICMP packets because i.e. ssh to the laptop i=
s also not working. It is unusable slow and very often the connection brea=
ks completely.

Kalle Valo <kvalo@kernel.org> writes:

> Mario Limonciello <mario.limonciello@amd.com> writes:
>
> > Several users have reported awful latency when powersaving is enabled
> > with certain access point combinations.
>
> What APs are these exactly? In the past 802.11 Power Save Mode was
> challenging due to badly behaving APs. But nowadays with so many mobile
> devices in the market I would assume that APs work a lot better. It
> would be best to investigate the issues in detail and try to fix them in
> mt76, assuming the bugs are in mt76 driver or firmware.

I'm using a FritzBox 6591 Cable Router with latest Firmware for Wlan and u=
se a Framework13 Laptop with built in MT7921 module. I can reliably reprod=
uce the problem with high round trip times and packet loss for inbound con=
nections.

If i can help with some tests to find the problem i'm happy to support you=
.
