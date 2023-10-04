Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA4F7B7817
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241444AbjJDGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbjJDGn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:43:27 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FBA9E;
        Tue,  3 Oct 2023 23:43:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CE4E75C02C5;
        Wed,  4 Oct 2023 02:43:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 04 Oct 2023 02:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696401802; x=1696488202; bh=8e
        8ESopaY26OLtMTWS4z9qPZcE6CW/A/t+Bn4zz5POA=; b=jbjEQCEtKwer+3jEIl
        B5O/PlviLUulscw4gaqepcHrF9+XMRnApoiXm++sKgquPSsRLPUKWbGaP5/7mMFP
        Pvdx5BI+I/6Vuar69sCMA+xZvc2lyz7ijNae/lYsUOmZax/BaZHdtCkV73XIr6zx
        VezdY5cLAUrypX2y/y7epfR7lB/0suOnuItLk11Yk91pdDeDQQ0K+nGRS1INsgxt
        iUm41B8jSa7kULI7Dfqtmj1MutrwkqVrYiAK5c75wNb5S0JI8XK9WUeJoT8L+6vy
        HvnF6agYjEv0nm9N6Ic4FQhdSZv3W9393GxcFfjscemPzdSLzdgx3dGzs7Mj2J0p
        rkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696401802; x=1696488202; bh=8e8ESopaY26OL
        tMTWS4z9qPZcE6CW/A/t+Bn4zz5POA=; b=UstK22NJYaeSSNnmE1m4WTskZw1KG
        i4fQmjOaDvUeuLv7L48YhgODvgABXb6DZHmzIQPfHU7QQ4SeMr5X1M+qF9pZ4P4x
        FzXHOtjnU56lQX1kXeDQlq9VPG6t0AEBcOjMhXafwVfSqQDoPfDlePkOBELtIaQ3
        4BFi1d5egr+slEOu6j9QXvSN8smOTFjmXncfJ7QN6OoxqwtGxZtEbt4toc3PG8gV
        gVdBi6JS4K/FMTokglHY+cLbfXLcvQ1wr4H8ZQ0M/QD3RplOCn3n67c1lpfVZYQM
        olU0q8zU0VrhSVsS7znaKOO9HAB5At/kqlkrQ1f56MqIbNPa/ZCf1NF8w==
X-ME-Sender: <xms:igkdZYQWBrUogvC9S5I2_4F2H9VEoAJRRxnfOx_RyIkbKkHy9b7qDA>
    <xme:igkdZVxKeA117DgBi5kzduG7ezH-_sdVGtEppOE8nYnHzaJDiDX7nJp8gO-wlyMzT
    ZjAqfNoOjKRfg>
X-ME-Received: <xmr:igkdZV2pNhvCSzFFQLRLtkKmx1rZjS-IaDDbRU2eqUTyNsMQc9EXN716Qm4yaOKZhMv88EO0p_I2srG8T-K3reMdbc6Y-dJwIdGawQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedugddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:igkdZcAWD7_EbYPml04IlZnpJchwwlgQzNZldd_idYxL_HQpc5PPSg>
    <xmx:igkdZRj0IJ3FZnz8QlFjbiEvrJ8lJc9dcbIMePznQgEAukLtWPpBYw>
    <xmx:igkdZYoaXNlwoSGY25dLs3XmjyOeufdvVuYYEnRKVJTFMwx0ebcGNg>
    <xmx:igkdZcUk9mFT8ArOp2Wd2KZAEPfgRyWul24ILPiEt8y2cK1gJtQQZQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 02:43:21 -0400 (EDT)
Date:   Wed, 4 Oct 2023 08:43:20 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <2023100410-concave-explore-95bf@gregkh>
References: <20231004132247.01c3bfeb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004132247.01c3bfeb@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
>   156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
>       |                                           ^~~~~~~~~~~~~~~~~~~~
>       |                                           QPHY_V2_PCS_SW_RESET
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
>   157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                           QPHY_V3_PCS_START_CONTROL
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
>   158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~
>       |                                           QPHY_V5_PCS_PCS_STATUS1
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
>   159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
>   162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
>       |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
>   163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
>       |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
>   991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
>   992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
>   993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
>   994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
>   997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
>   998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
>   999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
>  1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
>  1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
>  1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
>  1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
>  1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
>  1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
>  1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
>  1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
>    78 |                 .offset = o,            \
>       |                           ^
> 
> Caused by commit
> 
>   685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
> 
> I have used the usb tree from next-20231003 for today.

Thanks, I've now reverted this from my tree.

greg k-h
