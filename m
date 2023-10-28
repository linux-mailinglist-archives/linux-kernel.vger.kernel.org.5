Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195D27DA766
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 15:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjJ1Nw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 09:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjJ1NwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 09:52:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584BE1;
        Sat, 28 Oct 2023 06:52:23 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 7C7B95C01F4;
        Sat, 28 Oct 2023 09:52:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 28 Oct 2023 09:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1698501140; x=
        1698587540; bh=dT4fuzZALl8BXEv8X6op+2/P4xzHSBesehDgo78eAZc=; b=o
        uEiGDSw0mN51/8reQF2vCLw8sWIUEFOmVpFB1hr6X4fVEy+IJvnMldbGjj0y84ah
        piakrKechlSmfxZkgbqXaqf3/LeVfCrnydbtWNqheAgBQeRqXtg0iaY6lC4F/2YF
        Nxt23mXWRftuktIL1sTcXohTipnBU69sb9mxziYgKMc342xP9Z334z4gBGXg4zSx
        qh2VhT8C00B31OaZ9VgSST9rH3ijcMkJrTI4siIzLEHGv6QNhTXMtaz2hv53BX38
        xB8K1nZG9zLs21/3bAnNbTplytX6RWHdy7T0/+GHTPqTPMdKIObFvzeIrXbaQjhn
        PBCNOayDLlDboRmizABfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1698501140; x=1698587540; bh=d
        T4fuzZALl8BXEv8X6op+2/P4xzHSBesehDgo78eAZc=; b=mFUpL7jfQBnjsfJk4
        IKNg+18e2SiJL1pWA3+OeQxeUGvfL5j0/joY/097Pc2p2LLJ6o9tXRBZh3bq+8Cy
        4SRUT1mtf0m6K/BT1jAmK/QEXHI8iDyNcqBb2tO/H/4aDZUfQYU4Uuqb1tv8TTfR
        BF6Jvl61bzY6kornA8iKEfnRFyC4MZrBOUebZuyhS7d9Jrj+QAApVIQmNwsjdUdX
        SukNww+j1KodsPZvMUK9UHAlR/9MOW53v+LKIGzYYSffIlNAYpaLH6bWr6nts2cq
        dHXDSHUkFNl08CZxJPiFU5/+S/6vPwtSc9fwWlR34tgbu4gBvZdSaX+YBOFhW7Mm
        0YrCQ==
X-ME-Sender: <xms:ExI9ZSw96jA_s6fvbDtvcmTzDWWCLDKC_MIOY1btZ-76kCQJBzh7tA>
    <xme:ExI9ZeSvNxt_MZFQ34A36wdyqCWYDPhIK_OsCqLSKKAq7vmRV-ObEK_U3m4LiNhrw
    dLpBK4CE0GXRjrNyic>
X-ME-Received: <xmr:ExI9ZUUUTXQulS40EIUpmwf54Ei5V9w1BUM8C-BLpEQeKrbmtq395eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhufffkfggtgfgvfevofesthejredtredtjeenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpedufffffffhueehvefhgfelveekueegteefgeeiieejheefkeehkeev
    udevieegueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:FBI9ZYgLh49CWFxGnvlO9UV_HoGeePAveisfo4mstU5OB4tVlyWPGg>
    <xmx:FBI9ZUDdfz4smgkDZ1D96qzJvd4_wAnYsEEDzxgRD13RPuwV3SF6BQ>
    <xmx:FBI9ZZJQH3UXYetYfHyMI8krURIMok13fMIwS-5NEETlkOUMlYA19g>
    <xmx:FBI9ZXNS8e-T1ot_7IFU2cIhIaeUHJxLCh_AQLXoYjroulXqocLIMg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Oct 2023 09:52:19 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] MIPS: Adjust SPARSEMEM Kconfigs
Date:   Sat, 28 Oct 2023 14:52:15 +0100
Message-Id: <20231028-mm-v1-0-45377cd158cf@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA8SPWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyML3dxcXQujlGRzQ/NUy1QTSyWgwoKi1LTMCrAh0bG1tQBMx828VAA
 AAA==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adjusted some mm Kconfigs, mainly sparsemem related.

Hope it is not too late for 6.7 :-)

Thanks
- Jiaxun 

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Jiaxun Yang (2):
      MIPS: Enable SPARSEMEM option unconditionally on 64BIT
      MIPS: generic: Set SPARSEMEM by default for 64BIT kernel

 arch/mips/Kconfig             | 14 +++++++++-----
 arch/mips/loongson2ef/Kconfig |  4 ++--
 2 files changed, 11 insertions(+), 7 deletions(-)
---
base-commit: 66f1e1ea3548378ff6387b1ce0b40955d54e86aa
change-id: 20231028-mm-82dc717e9e49

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

