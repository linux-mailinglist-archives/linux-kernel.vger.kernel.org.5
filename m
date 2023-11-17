Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C87EEA9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKQBQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:16:30 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A161A8;
        Thu, 16 Nov 2023 17:16:20 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id A190F5C0120;
        Thu, 16 Nov 2023 20:16:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 Nov 2023 20:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1700183777; x=1700270177; bh=argAW/l5NV
        CwSSKLt8lTVPDhHTjwmM5Ir7e3W5JDo04=; b=GrsbGzEAgT5nR3pCk/pWwpLW1y
        hFG+ioTZfTPgWpISlI8ZhXvrJ59/SLK0nyGkaoaW5C1GdnGcqSHhozkrlfKhfEPZ
        dsaVbVo2LLYLBk4z+klgw0LuWo5zYQ9fN+8lvOxjfFl/ACLIdh8XYiP3UKemJI/8
        ea63iAAmkW9tO14csBr8VziaoPWXWeKg/t12U2KCn+yGafIQG4FaNeApOn8zwjKL
        c8/DHHfKtmDcMBkqHpKoYpq8Etqw1dx3Ve6U5tdmhn10OlZBtxVxOWHDWjKZcD5N
        sOZ4VZHAu1W75O9Mhm14wnoWq1Akje7r8CkPNkbaSoolB93WBe8W1uaUhOXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700183777; x=1700270177; bh=argAW/l5NVCwS
        SKLt8lTVPDhHTjwmM5Ir7e3W5JDo04=; b=chjU55KXXMe+tP6cnVAjAwNIAgXdH
        ELY9t1lNShJvSzO2YyyM7mCO9fcIGeMFoPZIM4P5G9yfTZP9sHUxSE+/wCQvCdKL
        T+V26SMiSGqtiMJFN59XdLchEgnZAt/1cOqpwXzk+Ui9pmO8rZjacTYI5wilCG6n
        w3lbtSJjOIL0K+VJKuanVgjYuSTkoHV2znG7Iqfqfb1yhoZbyaYZVRorX0/6K2Ak
        DCEiqGHL+J5IS326sSmTuqFTJpzkAAXmHeRHDncfY9p7VpWxB1I7KmIoHSfTwET+
        siaZ0fI/I5gX3TKQUgLpQRfpUy/D7hvKJFKLgvlThuo25ca3I1I4DZSfQ==
X-ME-Sender: <xms:4b5WZSzZ97bnyziWHWUPPeMfG5ldG6SSy9baZxMnw-CJVTummvAI6A>
    <xme:4b5WZeQbKzkIaUK4oYanWIR6E1gOQzZjdXCXRuwMJTkhWts-nVP8mpUnqAcsKMT2H
    36ZTKtKrdA1KZJLet0>
X-ME-Received: <xmr:4b5WZUUQ-ndvkkw434tYVDeif86qWhxPa5DXwcJVJ58icsFNFKqb2z-23o2T>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfdujedthfduudekffefkeeiffdttd
    dvhfegudduueffuefhfefggeefteevvdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:4b5WZYhXltolGnfuAHo6oRc0g5Y-Q99RGFV_TCLLMawv8nfml_tiKg>
    <xmx:4b5WZUA5SwLaO32q1PVQNFkABsk77ntSX6j1lSNFC-UY0_29bjCKTg>
    <xmx:4b5WZZJ8XVdn-C7Qw5-EJBO3_qzmXLPR_UsqI4086rPsdGThh-5WWQ>
    <xmx:4b5WZXMuTMcTRk7Mfsevr3I9hjb62vTR37IdE7uWQKbXoSak8VA6xw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Nov 2023 20:16:14 -0500 (EST)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, benato.denis96@gmail.com
Subject: [PATCH 0/2] hid-asus: reset the backlight brightness level on resume
Date:   Fri, 17 Nov 2023 14:15:54 +1300
Message-ID: <20231117011556.13067-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Benato <benato.denis96@gmail.com>

I have noticed that in my Asus device RC71L the keyboard backlight is LEDs brightness of two RGB rings around two joysticks of this handheld device.

The firmware on this device (and other devices from the same manufacturer) restores a default brightness level (that is full brightness for my device and off for some others) after resuming from sleep; that means sysfs will report a wrong brightness level and requires human intervention to restore the desired brightness.

I have fixed aforementioned problems with this patch I am submitting.

This patch (composed of two distinct patches) compiles without warnings on both gcc and clang and also improves a function signature and constant-correctness of the kernel driver.

Denis Benato (2):
  hid-asus: add const to read-only outgoing usb buffer
  hid-asus: reset the backlight brightness level on resume

 drivers/hid/hid-asus.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

-- 
2.42.1

