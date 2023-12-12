Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8952880F3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjLLQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbjLLQ4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:56:04 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12730E4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:56:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1ED843200AB0;
        Tue, 12 Dec 2023 11:56:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 11:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
        :to; s=fm1; t=1702400164; x=1702486564; bh=xmlHXrpZIRRTY+VHc8MrT
        bfBIUJgXoPYErIdFutUHIs=; b=k4h5di2uhsZYE7qCmkCTspsc2CJAQnQP/Mg6N
        OSgRwKuzQgVOL66LueLqmn+BvhHUQLVvTy2IT1z7bEV1u5VXXKGjxS6G+iWo5K7J
        6YQKk/JJmDRF7bxNSXucIcpgNXHiycoxkK2pe8rp/B95X+HbMPxiBecLkCRR/TE1
        by01OqD2687bAwpAXOSaDUVkRVqcftrA/KmVJtuYpeq5AsiV//gQ7EzBrTVJPJ0a
        zOcFI6JMD038P2zcHkrK/lXdELAGExWxV6USAP5m/1t4lFNKjkiIAtVQIK0Z/ord
        d+5R7Z9uYO4QQ01tTi4e4TSwV/HD4WwutJHmV5b6n2pBt5dbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702400164; x=1702486564; bh=xmlHXrpZIRRTY+VHc8MrTbfBIUJg
        XoPYErIdFutUHIs=; b=d6cAviMxBl7yuYodx0Dr3zY98fxDr4ACIQ49Echi2kjc
        cnFPieldxKdS7ZC4OHVS0gXOGJEa1XsfbGtFvOqxxo1NOzFhnPDqI7XrQIO3IG+P
        r4k4SLyyHoIobDehFxoNH9jFJmOqD/Mnk0sXSwvOr3fjgGQtVI3H76ZZ888vSEdV
        Mi1156tKPcOVvz553zW+L1dDizaCBL/Vdr8XYbVTH70gWOkytQ81cNIhRsrNB289
        Kf2GokPnLcTTy67SaCDqgjcNuJKmdSRQ6jH9mWCnCKMHpB6zOaDTJW6X65QHkUUM
        VL/tPEPuEvyvuKo2QqIpG/AHWRB8BA9XgS/1j/PUDw==
X-ME-Sender: <xms:pJB4ZVOqVI1Jy0ROe9_iVvCWIwndd6DKqZLPhbb3YY389ZTzT5NCJw>
    <xme:pJB4ZX8zjYS9jyKuIyDNgPoB95B2ZwNpFruDqI3ipDA0vBN9nvoQREqr_MOVLl_OF
    B_WIKmiDIegK04Bjhg>
X-ME-Received: <xmr:pJB4ZURf197fCEE3NXvcZXIWXQs9vBh0qig_4T8OOGMfJfvt4wn1d17TFZS6s4xaxsQuuhtkvxMKKWLQbron25V6P5LKmK2JiDioEJP7EjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:pJB4ZRsU3nAiYIRSieBSeC_2m5nGNzjw_uq_YUiQ9x-UZH80NurNSA>
    <xmx:pJB4ZdeVxsOZleFTjgPqGtze38O6xfo59yfMpLybBVkTsGV9tca-iw>
    <xmx:pJB4Zd2SR9v_bUXPj4QlGCm3Myc2R0NrfqW7mAQ5vnSFTzT87zAP-A>
    <xmx:pJB4ZR6XChuD5zBDqwsHBvw_4V_oYzFP0s6VVeU2g1eBbcr7QGJqXg>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Dec 2023 11:56:04 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] [Series 2] rename variable posHTCap and (4) others
Date:   Tue, 12 Dec 2023 11:56:32 -0500
Message-ID: <20231212165637.17618-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series renames (5) different variables with
the checkpatch coding style issue, Avoid CamelCase.

Patch 1/5) rename variable posHTCap
Patch 2/5) rename variable IsEncrypt
Patch 3/5) rename variable bAssoc
Patch 4/5) rename variable pHT
Patch 5/5) rename variable pCapELE

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (5):
  staging: rtl8192e: rename variable posHTCap
  staging: rtl8192e: rename variable IsEncrypt
  staging: rtl8192e: rename variable bAssoc
  staging: rtl8192e: rename variable pHT
  staging: rtl8192e: rename variable pCapELE

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 90 +++++++++++------------
 1 file changed, 45 insertions(+), 45 deletions(-)

-- 
2.41.0

