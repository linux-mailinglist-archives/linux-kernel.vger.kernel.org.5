Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A188078E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442817AbjLFTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379411AbjLFTv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:51:28 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29118FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701892290; x=1702151490;
        bh=9bnUt4mQN0sRHuHZE/bBNs8Z6MZSXk16CG08Vf2hXjs=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=oSU146QXFS+PhvtrMroC6/bnYa4wLzuCKzLmcWr3Ckb0yPjIhj+khldB9XV4QqEgR
         NjeUloT2t+poIcLfYkoLEBX/3UWl2lKnkQXfHm62H2OXO/dspJpaFf2ookn25RqwZZ
         U7OtrEhXVIjm4jahmkWiKQTPyteVt0edv3hKukF5i0f+P2GSuWcX82e+f/65Xr/l6H
         vSwtZgvmfGSHJv/yNNlffCpJS3C2EAgPWhSLJHCZila+KY8cQNFCLrFnvvndsvIs+c
         y763KJlfIJi4wadS+kWRNFQskL2E0loDvigStgUAA/b2WUy3heLVwHvH0XziUN0Ee1
         TBNQiZ1725JPg==
Date:   Wed, 06 Dec 2023 19:51:19 +0000
To:     Jakub Kicinski <kuba@kernel.org>
From:   cristian_ci <cristian_ci@protonmail.com>
Cc:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [BUG] wireless: mt7601u: probe failed with error -110
Message-ID: <QGXUDgc-RbYOKRZYX_gp7uyKz_WQ4_6b_R9c4Qyd-3oEd4V_vluPJtyJfVqpvcF5kKQ3Ffr3cVXmxAY3jPYQwKSBrusexYYFIPfHJ1qtFPI=@protonmail.com>
In-Reply-To: <20231126142634.3a100e2c@kernel.org>
References: <Bnwq2et4CBU1_MS8X3rFeejMDmKf2dr_BNq60IzBcGKbjTxHG1CjJ0zB_wZjn8_iLJsi7fCx6_Eh01ozYBqPA-cEZXMZE_X98E0b7yotXCg=@protonmail.com> <20231126142634.3a100e2c@kernel.org>
Feedback-ID: 27475468:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[RESEND I've made a mistake with list of recipients]

Update:

I've built and installed mt7601Usta vendor driver, which is shown into lsmo=
d output.

ra0 interface appears as shown in the following output from iwconfig and if=
config:

ra0       Ralink STA  ESSID:""
          Mode:Auto  Frequency=3D2.412 GHz  Access Point: Not-Associated
          Bit Rate:1 Mb/s
          RTS thr:off   Fragment thr:off
          Link Quality=3D10/100  Signal level:0 dBm  Noise level:0 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:0   Missed beacon:0


ra0       Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisioni:0 txqueuelen:1000
          Byte RX:0 (0.0 B)  Byte TX:0 (0.0 B)

The driver is properly loaded and the device doesn't connect/disconnect con=
tinuously as instead happens in mainline driver:

Bus 001 Device 007: ID 148f:7601 Ralink Technology, Corp.
    |__ Port 3: Dev 7, If 0, Class=3Dvend., Driver=3Drt2870, 480M

Any thoughts?

Waiting for a reply,

Cristian.
