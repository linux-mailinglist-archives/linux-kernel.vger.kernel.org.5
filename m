Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B701F7EABAE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjKNIgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbjKNIf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:35:56 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BC1AA;
        Tue, 14 Nov 2023 00:35:53 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7DE443202312;
        Tue, 14 Nov 2023 03:35:51 -0500 (EST)
Received: from imap53 ([10.202.2.103])
  by compute1.internal (MEProxy); Tue, 14 Nov 2023 03:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1699950951; x=1700037351; bh=3PkRuTsXewJgyFnJEAGNp7/muuh2dcfpARP
        RahjPeaw=; b=PdWzvf2SLKlIYYQ9ONE4quixniTTDzYEAxHhStJYEupaNVYz8K1
        /hEiUg5wRmMkTrKpLBYnioLpL4fbklCe/aBwGEkZ2uokAydgP4Yip47+1dQEvYjF
        3OLmFG2EtB7MlMSaT3A4qoKGyjPUG9c/mUpwiL4fFuJ3mnMAl6TLJ/z9BRYc/kC2
        Bnji+oyKpnjyuegrKOfk4B/O0nomt485jv7/M6pNlo7ADWZTHLB4kNOAHfNboZ/8
        w6nN6Ts/q3cuUG/j2GAyQ9fixM0+jkWiuXUQJ6rGIe+ZQyPojRgz/AYE2BthklUD
        POyZjgdvL7pLLHQUc/DPS015cfUiWLHpxWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1699950951; x=1700037351; bh=3PkRuTsXewJgyFnJEAGNp7/muuh2dcfpARP
        RahjPeaw=; b=OlWZvFZiLN7EBGjXSJ4tCyaPDSBu7TVECV4GB9e4FVQ0g536vPB
        WZK8C5gN0PV2CXJACLxmWHq/2m01bjqjrBk0brX0f5n51m8MZkkgQudAsY0ogSCI
        nUU7LYtD2QfeCh5pTVNEMeQuGHpcen8hW9mGZPXuCjFNuMfxm+ur3xVrtfFvuDhU
        Ia3xji1EsX0bSUjVRXO0xhKf1PmQrUd+CBEUkMyrvHgbj76iYCdfLnD2QGj4kd42
        AC1ZfCZC+nNOadcrLKoyH6ittMx3Y6WYL4uCx5K7Uq133rbqxSX04SMrOhIVL1p5
        /K17fz6QMtklA0Uvub5F2FC/kwKHU5vS+sA==
X-ME-Sender: <xms:ZjFTZQVLEbUurlSP89IO4KzUFn_QWZRlJ_cZdwovjW2hM27SEZH83g>
    <xme:ZjFTZUmLVWhRImv5RpBvvq9eXO_c2iiXeWxBGf1i_tzpcO8hpsECa6wma7HswE8HI
    bf1ChJCWi7yepDDCro>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefuddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    lfgrnhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrth
    htvghrnhephfegteevteejheetgfeutddvuefgvdehiedufeelfeettdejgefgveevhfev
    feeinecuffhomhgrihhnpehprghsthgvsghinhdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruhdrnhgvth
X-ME-Proxy: <xmx:ZjFTZUY8PPS9igL6a7iU9arl6Z4PcY_b75XZA56lA4eGXMqJWcEe8g>
    <xmx:ZjFTZfX5N6VTdRhhS6Y8_J1GlMR7F61SHk-MsHCfO_Tuofi1KwpemA>
    <xmx:ZjFTZalPh8NtRi_DlJsePkNLnR1rI4bU5C3PLhXR2yf0qpXAwjOx4A>
    <xmx:ZzFTZTce9bxTHb9L4Nc4KGukQH-1GMgojcojeDrQklAEgKcnMChOKQ>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0E5F83640069; Tue, 14 Nov 2023 03:35:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <9308033b-971f-4cbf-9443-d41a3f09ac61@app.fastmail.com>
In-Reply-To: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
References: <22582194-DE99-45E5-ABEE-C1C7900DA523@live.com>
Date:   Tue, 14 Nov 2023 09:35:27 +0100
From:   "Janne Grunau" <j@jannau.net>
To:     "Aditya Garg" <gargaditya08@live.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Sven Peter" <sven@svenpeter.dev>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Cc:     "Orlando Chamberlain" <orlandoch.dev@gmail.com>,
        "Kerem Karabay" <kekrby@gmail.com>,
        "Aun-Ali Zaidi" <admin@kodeit.net>,
        "Asahi Linux" <asahi@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth is not working on Macs with BCM4377 chip starting
 from kernel 6.5
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

On Mon, Nov 13, 2023, at 21:57, Aditya Garg wrote:
> Starting from kernel 6.5, a regression in the kernel is causing=20
> Bluetooth to not work on T2 Macs with BCM4377 chip.
>
> Journalctl of kernel 6.4.8 which has Bluetooth working is given here:=20
> https://pastebin.com/u9U3kbFJ
>
> Journalctl of kernel 6.5.2, which has Bluetooth broken is given here:=20
> https://pastebin.com/aVHNFMRs
>
> Also, the bug hasn=E2=80=99t been fixed even in 6.6.1, as reported by =
users.

There could be a possible regression in kernel 6.4 and later affecting B=
luetooth low energy on bcm4377 devices specifically.  288c90224eec ("Blu=
etooth: Enable all supported LE PHY by default") broke BLE connections o=
n bcm4378 and bcm4387. I did not find any reports about broken BLE on bc=
m4377 so I marked only bcm4378 and bcm4387 as broken with Coded Phy in 4=
1e9cdea9c4a ("Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_=
CODED")

If  BLE devices like Logitech keyboards/mice are affected (mostly during=
 pairing) it would be worth testing the change below (against v6.7-rc or=
 stable releases):

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm=
4377.c
index a61757835695..bc8398cde3c3 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2453,6 +2453,7 @@ static const struct bcm4377_hw bcm4377_hw_variants=
[] =3D {
                .bar0_window2 =3D 0x1810c000,
                .disable_aspm =3D true,
                .broken_ext_scan =3D true,
+               .broken_le_coded =3D true,
                .send_ptb =3D bcm4377_send_ptb,
        },
=20
This  should affect 6.4.8 as well so might be unrelated to the reported =
issue.

Janne
