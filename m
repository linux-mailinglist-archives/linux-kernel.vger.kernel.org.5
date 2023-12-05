Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3B8062CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346546AbjLEXQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:16:01 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0D1B6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 15:16:05 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 97BB732000D7;
        Tue,  5 Dec 2023 18:16:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 05 Dec 2023 18:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1701818163; x=1701904563; bh=aZux9fQ9/v
        SXbtuquj0GaDTgfe1Hi/cCOnfZj836/2k=; b=nY25oe4rUOP7WJpabLB6iCvCHD
        fUfbAuo/L0FDZVLVpugBLGQ8BEPQHxHPqZ1gPCkZCz4Z+KLVe7yiYk8cdJlBCr9H
        HTdSqYzIgNGlHe2mSR6IPZ77TWai9qRaI8IEWic1L5Uf/pEMOSV9hBXAGIhLUMXq
        TsZrJ4OwPnaV+w5DTgHOYkmYt+aAQdE3kbLzZjLV99Tj9+mi31Sc1+qZzdqBC1fi
        NV/IlOWd1g6m55lUKQup81MRG0zFavNkMrCk9IapY2cb6D7KwRAiFOD0TKSFMYVA
        0uriPie7p/9Mh5gNvhux1gnbHd88NLBCEnBUSaWzDr7SDcdHhxIWP59h3LvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701818163; x=1701904563; bh=aZux9fQ9/vSXb
        tuquj0GaDTgfe1Hi/cCOnfZj836/2k=; b=XXkoBqyXqxr43GpHF9wsaxTC127PJ
        VnqYp9IM3kUN9oB1xtlg1sVtUjXkZiVpw/FXl8HP0/XXGOAMh8OyV9bmIzCTe00o
        j5yzwrh+wr+0ZgNO+i35rCazyXxkDJKjUQFxD7bLphSXXTOpGEjoNM3aiCleTgTc
        +IyoabhuvIcqt3ZZs9v4Wmjmw+xIeIJuyOb6mUAhum1pY9F2MwU0cxn1fcGmHoQt
        tGNqUkUphjJDYhcEiAmM0uRBkaZA3GhQHQ/93QNKitLwq8TpqrkCT1CiZCH1m5kF
        lURm3+Xxxu7VCxJC/fs7FjfBPIbT5YJ3GVwX6N/eZBrnSsBPP5ksArBMw==
X-ME-Sender: <xms:M69vZeooQGeYRe_S20Dm1opmmQh6zN5Ma46sjya34UQaZ0kTto85qQ>
    <xme:M69vZcrDwYaVWAZx5HBf9I6bzULQCHZmkE1MFoEmvuoPZ-H5l3Fm9SWtMLf1eHgMQ
    _INCFBxVnukS0ASahU>
X-ME-Received: <xmr:M69vZTMxABhYukqNqLec_8y5YLEf6v7frYQEv4lGj04XPE8Jspzycm00wfm2hge_Yae6j4B88C1B60pIwzMHUWX9FcaroFN5vs4PhRoPqfY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejledgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:M69vZd4wMD6TnMH24H_ZwPPHhZg04mVkAhSpbG7uNgQ9SdR36Eh2ow>
    <xmx:M69vZd4GWJMojCQhU4su7ccIe_oWyoQ8oB-93arf4wpjmYvwSsjh9A>
    <xmx:M69vZdj8NCyQS4PQ9xifQ7uKs5yb1AJak1IcKutqMLOiaLe1RLSr8A>
    <xmx:M69vZXklvzQFgkiPN-jOvM37DFm08TIf48wwM3JyYk22aaN_H5BZzA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Dec 2023 18:16:03 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] staging: rtl8192e: patch series renames (5) different variables
Date:   Tue,  5 Dec 2023 18:16:18 -0500
Message-ID: <20231205231623.23070-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series renames (5) different variables with
checkpatch coding style issue, Avoid CamelCase.

Patch 1/5) renamed variable bRegShortGI20MHz
Patch 2/5) renamed variable bRegShortGI40MHz
Patch 3/5) renamed variable bRegBW40MHz
Patch 4/5) renamed variable bRegSuppCCK
Patch 5/5) renamed variable nAMSDU_MaxSize

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>


*** BLURB HERE ***

Gary Rookard (5):
  staging: rtl8192e: renamed variable bRegShortGI20MHz
  staging: rtl8192e: renamed variable bRegShortGI40MHz
  staging: rtl8192e: renamed variable bRegBW40MHz
  staging: rtl8192e: renamed variable bRegSuppCCK
  staging: rtl8192e: renamed variable nAMSDU_MaxSize

 drivers/staging/rtl8192e/rtl819x_HT.h     | 10 +++----
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 32 +++++++++++------------
 2 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.41.0

