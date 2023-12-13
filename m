Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58442811B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjLMRyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjLMRyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:54:19 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4406E114
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:54:24 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ADB595C03F5;
        Wed, 13 Dec 2023 12:54:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Dec 2023 12:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
        :to; s=fm1; t=1702490063; x=1702576463; bh=lgNsfpk34mFbXVIDjDidF
        csTSEmQbTaM6DfLye9ZgBA=; b=iNZ+8/woDZaynb9h7X0yDIiwtksLnUSXi/AYx
        k8L8KHx9G/sHrUzNtTF3XFuOgg+Mtocs+w9bdFmP0Mdp+W1JeTsyUk4mHXo47aLt
        iCzUhoOgyer6yuQQT4AZxESn7QHttILeoRnnZ5aD6RcEZ20eRmGDJylqEVnn3a8g
        ykWUYWE71YjdsXBtZj75PJUewdcKTfchEI5aticppYY4/fukC/kdf9Pj/91lVPbi
        Xhh60T0COIe+lDjJDRPgKyOMheZt3ybicN9Pa4Ybm5AYswbbQGhShv/FY8tQrnBP
        Wekoostk31CvKtfmF2O18ozw7IHOpBZ26tXeWsMeZDFtNYwAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702490063; x=1702576463; bh=lgNsfpk34mFbXVIDjDidFcsTSEmQ
        bTaM6DfLye9ZgBA=; b=gs9W0bxBa55spq4tDgg5jXLrI6513K0xVjlSseQRwkpe
        S9Ep+2T/SfrhL0llnJjpT4kA6iDBdbIMuVj1k71LGjABPtO2LY1JqgI0EOUcQnAd
        Y9oXc2U+rE9tu1qsAM7fffzLtIP0QObBtQceoUaf5KC3uDQsNbPL0QomrLjDUGTZ
        wT6Wau4S11t+T8fVNBGz+WKVLOBCjuVa8QyV/N3lJy9ypinI3zTFAGLdMtbFBZhX
        tmnGIWvI2ROBP6QjG1Ka83Rhtxz3l6miQZM2H5iiG3qGHWI4YgeXO72zYl0LS1zP
        xJNZyyypYUt9sSkqW2Thft2h9svHJzut/q/5EH4fGQ==
X-ME-Sender: <xms:z-95ZZbxl_XVtEzIGBm-N__-_GNTbUAeXigWC5V7-fkXEqbRCHEWgA>
    <xme:z-95ZQa9_CZUI0hTAMkXZ4h0jVFFK8CtPuw_17qLdDYswVVvfPD4AI4A2TJyClsNY
    EvbmF_B7IUlyskqFN4>
X-ME-Received: <xmr:z-95Zb83WBhaURpsr-9povyy3aU9ZhxPknDWIOdjBlAlBnJtBNCKvrB4LVi5vJxTlM-sYhjwW1tz-j-mrZPtnH1Rl7tR_KOjckr1kSeg-7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeljedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefirghrhicutfhoohhkrghrugcuoehgrghrhihrohhokhgrrhgu
    sehfrghsthhmrghilhdrohhrgheqnecuggftrfgrthhtvghrnhepleegffffgfehhfejge
    ejheeivdfgleefheeuueetkedtffeihfevlefhgeevvdevnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgrrhihrhhoohhkrghrugesfhgrsh
    htmhgrihhlrdhorhhg
X-ME-Proxy: <xmx:z-95ZXrCnOqARFNO0whAq4KqrhHNN0XP8PJaoBP1NEDRUlI8obYuUA>
    <xmx:z-95ZUouNAyLWj_YlgN8Z3OQjhaTTVL54-i-9mNF9guu9tiu6Yyrag>
    <xmx:z-95ZdTN7GzcYyPqSgEPUsXHBORrUdPsyqZGYYYBwtvs6vTVjJmazQ>
    <xmx:z-95ZfWZqW_8InBb1S_NyBDg2ML2OTCOaNlnncYlS6XDcOpg239hew>
Feedback-ID: ifd194980:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Dec 2023 12:54:23 -0500 (EST)
From:   Gary Rookard <garyrookard@fastmail.org>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Gary Rookard <garyrookard@fastmail.org>
Subject: [PATCH 0/5] [Series 3] rename variable HTGetHighestMCSRate and (4) other
Date:   Wed, 13 Dec 2023 12:54:54 -0500
Message-ID: <20231213175459.5425-1-garyrookard@fastmail.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series renames (5) different variables with
the checkpatch coding style issue Avoid CamelCase.

Patch 1/5) rename variable HTGetHighestMCSRate
Patch 2/5) rename variable HTFilterMCSRate
Patch 3/5) rename variable HTSetConnectBwMode
Patch 4/5) rename variable HTOnAssocRsp
Patch 5/5) rename variable HTInitializeHTInfo

Signed-off-by: Gary Rookard <garyrookard@fastmail.org>

Gary Rookard (5):
  staging: rtl8192e: rename variable HTGetHighestMCSRate
  staging: rtl8192e: rename variable HTFilterMCSRate
  staging: rtl8192e: rename variable HTSetConnectBwMode
  staging: rtl8192e: rename variable HTOnAssocRsp
  staging: rtl8192e: rename variable HTInitializeHTInfo

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 18 +++++++++---------
 drivers/staging/rtl8192e/rtllib.h         |  8 ++++----
 drivers/staging/rtl8192e/rtllib_module.c  |  2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c |  4 ++--
 drivers/staging/rtl8192e/rtllib_wx.c      |  2 +-
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.41.0

