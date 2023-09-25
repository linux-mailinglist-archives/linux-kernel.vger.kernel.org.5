Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9717ADB13
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjIYPNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjIYPNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:13:05 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F6911D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:12:59 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 43EF43200A4E;
        Mon, 25 Sep 2023 11:12:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Sep 2023 11:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1695654777; x=
        1695741177; bh=FO+uTeSEOVyEuRg2lx8QQPcpNGNbsSvCB9PFDrPNfAk=; b=i
        7zJLfXm0uwgUfuVujr57dA+rlw/OHTm+uz2kY17UpdRrWZpX0Jvypr6eyyh6Ewdp
        +WAjoWFQq9bAJZvx+kDEwJMsU3UKy4/EJfBSrxiuvax00h4/NiW5udsFG8bB5qvL
        26ZVz5NCjQYSiLP/OmsDi2aS64j6HuWDPpD07200s9oSkxiiJgmIuQpc02+j6gid
        Bz3bRU3KwtgN37BN+EEbGFkaNZ3Grtejp7ythr9uB/b7FZK9729a4zl9bZ2R8LRp
        h98gPQLC2X55jzsT7RIqBB4qA0i2C+2iBMMb90JOnvriNoUld3vchBXBnC7D6kDn
        Oo5AP9SHKWKY+vpsw1Ygw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1695654777; x=
        1695741177; bh=FO+uTeSEOVyEuRg2lx8QQPcpNGNbsSvCB9PFDrPNfAk=; b=U
        8RWItDB6iA53PbVgXUYS7f+UQjDt4Ql1khFTfjMbW0bnz/b9szQg8ep4+Ta45vYv
        xvkWX7XnIs9K/pDwXh9LOQuY7S82Lg15YP56r9TK9OS/SRzct5MUm5KEXJvWGXzb
        GROCtw9xBIrKhDvVTLzPnkWUa4ICCQBAqVgnqDtWDT2mP+gu0lC54ZCQjsPp25Ps
        ErdQc4AvlcWxw5hCwudD+ciXfQdvNXscaOKARtLUnlsoTzTfhKDi7vzYUOmwYQSE
        ujMG/X5ar5FtrU6lvdHL4KILfl0TTUPBqXsKB5hdagL2wE2OaPyuI1K8ISBn0S4K
        VBarVbwS1jnF2d/fQbl4A==
X-ME-Sender: <xms:eaMRZYkszEAioX5iWJ7-TLkuch3NOVlTm4mMgoCWoS1X_qlKPvJWdQ>
    <xme:eaMRZX0oNCtDZ5SONbscWeUiV27iudTczakFvTlW2JQLx7NZIBfSyzSqi-1d7TuGM
    i-xBd21qHERJ-pm1Sk>
X-ME-Received: <xmr:eaMRZWrjMfI0EpYypgwsPqwn2M_EYj_PtaOnkK7GiawfpCfBg4OcYptNS0ElvufTvbH4F3rPHMR6DfpjpSDf3e6eNSpoF4K_EQH4O22RWyo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgr
    rhgusehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepkeeuvdffueduke
    egieeuffejhefgkeetfeehueelfeduuefgveellefhfefgjedvnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfh
    grshhtmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:eaMRZUl8KsguUX-_Ynr86gSP0Kw7pznDE37kDKbZHGc3vYYtvzW-Dg>
    <xmx:eaMRZW1FUIMiM6PEvSgiyxbaMd5KsX3vZShevgRzJI7bYeZxfgDE-A>
    <xmx:eaMRZbsZ8A7k9krMx31hmiLi2itKIApKylIiMvnXwdphNST1e-Qh7g>
    <xmx:eaMRZUCzA0GxqmCi8S4QCv2S3eP3eC84wfNaw7ckAoaHlKRlQ95kVA>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 11:12:57 -0400 (EDT)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 2/3] rtl8192e: renamed (1) mixed case variable
Date:   Mon, 25 Sep 2023 11:11:56 -0400
Message-ID: <20230925151157.3893-3-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925151157.3893-1-garyrookard@fastmail.org>
References: <20230925151157.3893-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renamed (1) function variable that was written in mixed case
HTUpdateDefaultSetting -> ht_update_default_setting

Linux kernel coding style "cleanup".
No change in runtime logic.

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>
---
 drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_HTProc.c b/drivers/staging/rtl8192e/rtl819x_HTProc.c
index f19feea46158..630acfaf6d55 100644
--- a/drivers/staging/rtl8192e/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_HTProc.c
@@ -67,7 +67,7 @@ static u8 CISCO_BROADCOM[3] = {0x00, 0x17, 0x94};
 
 static u8 LINKSYS_MARVELL_4400N[3] = {0x00, 0x14, 0xa4};
 
-void HTUpdateDefaultSetting(struct rtllib_device *ieee)
+void ht_update_default_setting(struct rtllib_device *ieee)
 {
 	struct rt_hi_throughput *ht_info = ieee->ht_info;
 
-- 
2.41.0

