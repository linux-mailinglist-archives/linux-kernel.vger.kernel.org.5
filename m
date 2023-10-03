Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E35F7B70AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbjJCSUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 14:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjJCSUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:20:51 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD583;
        Tue,  3 Oct 2023 11:20:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ACBA35C03B3;
        Tue,  3 Oct 2023 14:20:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Oct 2023 14:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1696357245; x=1696443645; bh=cZ3i6Y2QIq
        3PAJzVDebB72rPaqZEye6CfGXDyYu7v7c=; b=fnsb4hFFsUKYvQkI96u/CyuEjg
        kCt/Vje5c2fVB0X3Z2fWOS9SBF1LBUwHBF9HFYbbfDXZWHLo2Ef7M3mcOiwHb/dE
        MQGjD9bArkRtfQ5AhAJXFIu6IjAYmhrbkLGbJ/sMgxNZNdLQ+2FWWslfHkJdWFCr
        VFkpSTSHjm67vP6zxSDwMkV8abKmMjf+rv1x/9Tz9TH+tIRl5LJuQnfgypOKZ2JL
        v64kNbqJ7c7MwCXjvsOKVsZ2+BK8o6PAbUP4guwfhd/ar1wXDuBRvTw0hUDxTRO/
        3hDfRO6A4gC0jX1XCMDk9a5DzWK10YG/MuFUhzN8NkW1yBQ+QUhS8DL3OqOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1696357245; x=1696443645; bh=cZ3i6Y2QIq3PAJzVDebB72rPaqZEye6CfGX
        DyYu7v7c=; b=RHxrmFqEpV4XAxu9KYZ4PN4yapyMs1X4Jz0m/XEIcSccPthD4mv
        QOri0Zg8ScT2iZ8Y8WX0rO2l3bnVKvzQ5TqXz51j9a/mfjff0oy6POo4kOaFfLne
        pEtkLYuJ1GXwiq/rQx/I8B3GMuiKfGa+vAxiH0b1uWQf5eNgq0JXQE5MhDi3lwSP
        shjJ6hmrrfYaeEkFZf1IIVUOiWdXq2OSSTT4Povz9vqDcbWYg0XZ64za6kKuNZTZ
        qUJVypIWZQZe/df1t9uEWKDaTWF4l2Q61T8Sn20LsjmOqAiFIKB87HWAUUuial/v
        Su11jx/7kiIWgcQ/sFazj/+mdTOqktEE/ww==
X-ME-Sender: <xms:fFscZdNLhjXh74J_7qEfCwAOKGnsWh1qYs8sl3t5DNdK4rTBkEXBYQ>
    <xme:fFscZf_2x5rCIMAv04NjbuCLh5cSPe4JHkoNQvcTihgJpZjwcb_g98oyfPNaAZR4Q
    f4tE8orJVvOjlmbny0>
X-ME-Received: <xmr:fFscZcScgVsw-uaaXz5FCs7N_JNrgZDBfN61EFk1qjqnuG3QSZ23sIRznsEHsmQb29Qv5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeejgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehttddttddttddvnecuhfhrohhmpedfmfhirhhilhhl
    ucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
    eqnecuggftrfgrthhtvghrnhepiefgjeeujeekjeeiveekfeeivdehgfehtdffjeeuveff
    teeiveffvdeuleeuhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:fFscZZtDmyqULPsFWBNNAw8wZx0qvCLi5Blr2zvJiKsk8bnymXsWHg>
    <xmx:fFscZVfPAJwba5dNuGbGf8S6PEShQPDx07JA6cN7QFnPYSPeAJ67WA>
    <xmx:fFscZV0Ouz3xlLiM6CSKfHg6Sw14o4l11dSRnZZ3ohgqJ9kAcaB3JQ>
    <xmx:fVscZUw-of-KVI-6CY-FxjDPvLVvSEhw9ClgJP5AAMzz5e_OvsgzFA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Oct 2023 14:20:44 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C360310A08E; Tue,  3 Oct 2023 21:20:38 +0300 (+03)
Date:   Tue, 3 Oct 2023 21:20:38 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hilda Wu <hildawu@realtek.com>
Cc:     Alex Lu <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Max Chou <max.chou@realtek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Message-ID: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit 044014ce85a1 ("Bluetooth: btrtl: Add Realtek devcoredump support")
broke Realtek-based ASUS USB-BT500, ID 0b05:190e.

Devices failed to connect. hciconfig showed a controller with all-zero BD
address.

I reverted the commit as well as bd003fb338af that depends on the commit.
It made the problem go away.

I know virtually nothing about bluetooth. Let me know what info you need
to debug the issue.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
