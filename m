Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2126975DD59
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGVQAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGVP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 11:59:58 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8721D1FDC;
        Sat, 22 Jul 2023 08:59:57 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 6E6FA320014C;
        Sat, 22 Jul 2023 11:59:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Jul 2023 11:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ftml.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1690041595; x=1690127995; bh=XSn0NBNwuY
        2+CuFFTgdqK4m2Fuiyt/hZZPFunq38Eik=; b=NTK7b1IctvITGMtbtjIqdFJsxM
        7ujv3dqQ02HKem42Wj8h33QjWmX0Uqg35FJ43q5YguD+xWmdUJAFxXIG9nuR91iW
        neuGysvCIs8SdYQN3R33NHFLDArTswyQTN/c7zj017Jdv+UZg1tXIU4jThqyNgmp
        QxJ0n21rIg7dw+ruyD5Dxk95jRXAZgQ2AIgvFoKPgwbruS6Il/He6qrF+mrVjm/U
        qFSdojXbFZ8xOA/x4sUBBtC6kXDkcwD6Q4M3T5aTXUez22GcGM4iXlQIJs6QCrO8
        UrNQId7HZVABGSKihxVXN5uldi5TkCUyk5lVvlcSImLGA+C4SNZrnTqiic4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690041595; x=1690127995; bh=XSn0NBNwuY2+C
        uFFTgdqK4m2Fuiyt/hZZPFunq38Eik=; b=sW3KPl/KgW6M2t95HWVm/QoNjDjnW
        4gvD3V3E5iZsxUVcC5WRKCZOhoxmWKiUP9mlUh4xX5R3seORwxlUlTpcRj7fjKNs
        7GTe/HRY5xUMMFscVk42AmJ/TcCZ43ag2MzJvd5BXTi52VEDZaLiIQsf8+zmp8cl
        j4FiY4Gk/dsnHZQoIB68TYUuenmoal0zMNFq2JdXCIObhG4xfokiB35sKqRx08F0
        jI52+3gGxI9aBfpX1IKkG5X8wMoRaccQxgmopIW5njf9U9Z6MsEfBJnX1jGL/ayJ
        jqmaP1kvTc6dAUaoNuqLmmxSM5+pzaHHBjdMrx4qwFLYso14CbEqmhBTw==
X-ME-Sender: <xms:-_y7ZAa1Fyvbd7dm-lmwienpPwJpx44rcZ1u0_yiv7JJR0qsm6_8aw>
    <xme:-_y7ZLaTOQPGS0WGq8NPSUYG1Aj0X5kkixgrVLc8TMcqMmmcE0JlyADXIifAkFQgj
    Z8yts2Nn-VhgvTMPoM>
X-ME-Received: <xmr:-_y7ZK_AYRGLQLpQuDlGk_l6W_rniR4QwIAvxjVnfaPVWC4VYSVpym5tpgRaxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefmohhnshhtrghn
    thhinhcuufhhvghlvghkhhhinhcuoehkrdhshhgvlhgvkhhhihhnsehfthhmlhdrnhgvth
    eqnecuggftrfgrthhtvghrnhepfefgtdelhffffeefgfduveehtdekhedvieejveekheef
    gfduleduteejgfevudevnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrdhshhgvlhgvkhhh
    ihhnsehfthhmlhdrnhgvth
X-ME-Proxy: <xmx:-_y7ZKqw8-Ekridky9ogdM2EUM8B8upFB9O7_D3IhB9ZYBzvdlnJbw>
    <xmx:-_y7ZLq4dqoQAdM-NCQBm21VhZyrZklzIUGNCESBwh7z5WxfBYBn2w>
    <xmx:-_y7ZIRf4lZ654jxxKklbFEyRep5xonKTNHwyGKWR2r3W_4C8DUl8Q>
    <xmx:-_y7ZMmAjgYDcTnYNvAcyWytHkDDXIpyk_VcAKjs74PcMMrZQ6Xqvw>
Feedback-ID: ib7794740:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 22 Jul 2023 11:59:54 -0400 (EDT)
From:   Konstantin Shelekhin <k.shelekhin@ftml.net>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konstantin Shelekhin <k.shelekhin@ftml.net>
Subject: [PATCH] platform/x86: huawei-wmi: Silence ambient light sensor
Date:   Sat, 22 Jul 2023 18:59:20 +0300
Message-ID: <20230722155922.173856-1-k.shelekhin@ftml.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently huawei-wmi causes a lot of spam in dmesg on my
Huawei MateBook X Pro 2022:

  ...
  [36409.328463] input input9: Unknown key pressed, code: 0x02c1
  [36411.335104] input input9: Unknown key pressed, code: 0x02c1
  [36412.338674] input input9: Unknown key pressed, code: 0x02c1
  [36414.848564] input input9: Unknown key pressed, code: 0x02c1
  [36416.858706] input input9: Unknown key pressed, code: 0x02c1
  ...

Fix that by ignoring events generated by ambient light sensor.

This issue was reported on GitHub and resolved with the following merge
request:

  https://github.com/aymanbagabas/Huawei-WMI/pull/70

I've contacted the mainter of this repo and he gave me the "go ahead" to
send this patch to the maling list.

Signed-off-by: Konstantin Shelekhin <k.shelekhin@ftml.net>
---
 drivers/platform/x86/huawei-wmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/huawei-wmi.c b/drivers/platform/x86/huawei-wmi.c
index 70e5c4c0574d..0ef1c46b617b 100644
--- a/drivers/platform/x86/huawei-wmi.c
+++ b/drivers/platform/x86/huawei-wmi.c
@@ -85,6 +85,8 @@ static const struct key_entry huawei_wmi_keymap[] = {
 	{ KE_IGNORE, 0x293, { KEY_KBDILLUMTOGGLE } },
 	{ KE_IGNORE, 0x294, { KEY_KBDILLUMUP } },
 	{ KE_IGNORE, 0x295, { KEY_KBDILLUMUP } },
+	// Ignore Ambient Light Sensoring
+	{ KE_KEY,    0x2c1, { KEY_RESERVED } },
 	{ KE_END,	 0 }
 };
 
-- 
2.41.0

