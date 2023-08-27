Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2678A363
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjH0XYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjH0XYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:24:14 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49256B2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 16:24:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B60335C0091;
        Sun, 27 Aug 2023 19:24:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 27 Aug 2023 19:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1693178651; x=1693265051; bh=nZwavsE9RI
        muxtJbpbWX+YP4p3q3jLD//ndKDxPohA0=; b=gJm0T/6PKi/DvR83w/8L02y/8T
        yjCnbaE/Dc1w/44TDNk8BB2UtLjDa727S/hlCuFvqN1XT+A704YpQWw+L4OUnbCT
        OVxskqRHdIEYYAhpSnOYKBVUn4IryNk4eKpoX30haBTptOJmAFfnHZi3Z0gWSDbQ
        gS9DjmWkknl2FRwqcBca0qx3TbWflaQMdKxntDwTOV7HwkFvdxOtCf+OnBjiz8Iw
        cfu47qao90p9wkDP08txzVQx5iHAt3EYD4TvHR3WXSguYR2uAmBD6STokxn8tKPb
        7Ye4VRisvMKFg5+Nthl3DnQmq+TDkoQdF/b8pd7oZY8gGnMiuQCsMe9Yoatw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693178651; x=1693265051; bh=nZwavsE9RImux
        tJbpbWX+YP4p3q3jLD//ndKDxPohA0=; b=TylzzPIMNoJqoIJ4rDYgRYxVOuBet
        VFw/y55A2mTnq5kXxdsIFnzmGvS+28Hd4ufUq8QKynIChbuAH15rksL1sQdDR7PD
        e71yqToLYa+LZcox3KpKRh2zaOulZWkqfFaBWA6JoXZeTwd5Bvcv5sQEZLkeP2Nv
        rDwFdcxEuJv64G32UldV2G9mRZSgcrFQPDFCXXXWw0RBm/cUUXHwAn0LbxlO1QAH
        S3EsrKFXSTvsOA16ltaK4psdC7e2MRU1mytpfaTNZXfMc7IXLLWOFp7SW+z7QaqV
        s40MbXEe4R4dzXVPsEM0Mye4/kmCA9fvvxXwXUUAjq+2fwTSQJOHoi5ow==
X-ME-Sender: <xms:G9vrZLOpG96RKDcslCH_kqyQIL5dvaK_I76wauPWGc6-zaHYGH3q3g>
    <xme:G9vrZF8vOF9rpx-VOgg_0nChPQQFW6izIKjfn8hrRnytnCtahEP-JTfuWy2QEI3ho
    AZ5eECfBjqYPP85BSg>
X-ME-Received: <xmr:G9vrZKTdbwpEbTqtB9myb1MAQQkj8osn4MuSqurxP7z9R9GfYzFRlPNaUOn9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeffedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehljhho
    nhgvshdruggvvheqnecuggftrfgrthhtvghrnheptdehkeeigeeggfelkeeufeefjeduvd
    ejveduvdehtdegveeftdeugeetvdeltdejnecuffhomhgrihhnpehkvghrnhgvlhdrohhr
    ghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehluh
    hkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:G9vrZPsi1sJR-9U-shqYf5ZWOxAY5nQHDKyTCpXg3JnjPtrhlWOyLg>
    <xmx:G9vrZDcrQn4TJNxQqoKIuOYxNzodgD8EW4Lj8BecZIqzIgpzp9qJNQ>
    <xmx:G9vrZL1smj5kGn1i2Qa6aSsfxLoWeKlwo0vM1VCD-menUISW1_m5Kg>
    <xmx:G9vrZErIHIRZ8VoM2Ot34iJBRyfKqD_echkHVduWEFzL3SObEb0nLw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Aug 2023 19:24:09 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     hdegoede@redhat.com
Cc:     corentin.chary@gmail.com, markgross@kernel.org,
        linux-kernel@vger.kernel.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v5 0/1] platform/x86: asus-wmi: add support for ASUS screenpad
Date:   Mon, 28 Aug 2023 11:23:57 +1200
Message-ID: <20230827232358.80512-1-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for the screenpad(-plus) found on a few ASUS laptops that have a main 16:9 or 16:10
screen and a shorter screen below the main but above the keyboard.
The support consists of:
- On off control
- Setting brightness from 0-255

There are some small quirks with this device when considering only the raw WMI methods:
1. The Off method can only switch the device off
2. Changing the brightness turns the device back on
3. To turn the device back on the brightness must be > 1
4. When the device is off the brightness can't be changed (so it is stored by the driver if device
   is off).
5. Booting with a value of 0 brightness (retained by bios) means the bios will set a value
   of > 0, < 15 which is far too dim and was unexpected by testers. The compromise was to set the
   brightness to 60 which is a usable brightness if the module init brightness was under 15.
6. When the device is off it is "unplugged"

All of the above points are addressed within the patch to create a good user experience and keep
within user expectations.

Changelog:
- V5
  - Add minimum brightness to prevent screen from becoming invisible
  - Previous: https://lore.kernel.org/all/20230630041743.911303-1-luke@ljones.dev/
- V4
  - Fix a null dereference that happened if the display was powered off and dev struct uninitialised yet
  - Previous: https://lore.kernel.org/all/20230620030033.55033-1-luke@ljones.dev/
- V3
  - Refactor error handling in all functions
- V2
  - Complete refactor to use as a backlight device

Luke D. Jones (1):
  platform/x86: asus-wmi: add support for ASUS screenpad

 drivers/platform/x86/asus-wmi.c            | 131 +++++++++++++++++++++
 drivers/platform/x86/asus-wmi.h            |   1 +
 include/linux/platform_data/x86/asus-wmi.h |   4 +
 3 files changed, 136 insertions(+)

-- 
2.41.0

