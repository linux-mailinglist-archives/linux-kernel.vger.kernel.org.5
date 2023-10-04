Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FE47B7F96
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbjJDMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242394AbjJDMq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 08:46:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBACB0;
        Wed,  4 Oct 2023 05:46:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F14325C03E4;
        Wed,  4 Oct 2023 08:46:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 04 Oct 2023 08:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696423581; x=1696509981; bh=rM
        1MsvWolpifnaQY/in82qI4cb+h4m8iUBNO072Kq00=; b=3A0PbaTM8ZN9qu55Tn
        nnxDWVMwRtCwkikb4WrOKjar93DbjS0DvKnF/2YP1ImP9y8UU9lEiMVvadTzIe/6
        37PcReJ40S93BUEHdg6KdfBz4lLiQ+WnJkudILfI6rWaAfS3IPbm1MWmUYhARQKg
        Sm1lqNk3m5zxChUJstA8hQJAiYt79K2xybb1oN/0fnRvdzBzKq/vbcEq4VTMwWRq
        QUDv0A+OvTwmaKMgU8W60lWVSzyyvq6jgbcc5qHLjHm/8O1O9UCRgopaCA30sSXk
        +oexWyzkgKw0X9BmRCeATFp1ml6YIX7DZ5Pfabk5r4dny9cEvXOVJbVrPV5SLr+K
        0czA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696423581; x=1696509981; bh=rM1MsvWolpifn
        aQY/in82qI4cb+h4m8iUBNO072Kq00=; b=Tg80WTpQvzaKjAeCH/kyQcOGKGXNX
        ldG5B+cKaIqvW1apukHzCvPrmZvHSB3beOXoevkdPXl6O/ad1bDTV8RiHz/jZk8P
        2RDcoKAyWGTwk3OePF/BVsk/QgoLNufHZE7dmHMLMfP6SMwDYJ9WlIQYRkuhkYpi
        5VGMed3dmeqeRSykpf3iLzaRuh8PkkFkAWbvcx4HvvngnkvQpXOWdFKlIVjdJXJ+
        121pxhdLjKKTn9jj4Cf8Zlc+EeZkSjwetdTKCNHx/egoTZt0nsZ8cu2ht2G4UJto
        GcDH3ioRpXeGLXKeVSHp4V4gpIubuq3IUO99/DY8sSk3q44BXJD2+jwlw==
X-ME-Sender: <xms:nV4dZWzGQPOHEjnAPTaDOy0bW3g7carG2zK8lhs-CL85tBEBJsFzHQ>
    <xme:nV4dZSSgX6DWQefo9r_10DI-7dvJh1HInDd0CJFuToNc_Au8FsXfzYDuO5ozpHCM1
    hjiPwrZ4TApEQ>
X-ME-Received: <xmr:nV4dZYXfJwN5P_jZ9eaz02jqktJEz9U9a6u-FQgVxv_B69dNIGaAAcH40cXj6h4snBNISvp9gODAPJL4jc1ghrRh0mKOwg4WYiQoJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedvgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeegheeuhe
    fgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleevtddtvdenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:nV4dZcgVS9QNEF72iuhMKrWicrmbsZQKJrNIs7647hAkA63g2c4X5g>
    <xmx:nV4dZYC6LZrc1tr55oLdkMofdDGKxDHSjZKR-1sXOEk59Si1i857ZA>
    <xmx:nV4dZdIE7il9r9pnnEsOTy5yvlnlK69RwUiwiLcKxUSrn30l_YqHMA>
    <xmx:nV4dZa2eXFk7ozka_joBKv-_S_pavcVfuI8hRXLih7wFWLfkbQlD2g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 08:46:20 -0400 (EDT)
Date:   Wed, 4 Oct 2023 14:46:17 +0200
From:   Greg KH <greg@kroah.com>
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <2023100445-cymbal-glade-52c8@gregkh>
References: <20231004132247.01c3bfeb@canb.auug.org.au>
 <2023100410-concave-explore-95bf@gregkh>
 <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 12:17:27PM +0530, Rohit Agarwal wrote:
> 
> On 10/4/2023 12:13 PM, Greg KH wrote:
> > On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> > > failed like this:
> > > 
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
> > >    156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
> > >        |                                           ^~~~~~~~~~~~~~~~~~~~
> > >        |                                           QPHY_V2_PCS_SW_RESET
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
> > >    157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
> > >        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >        |                                           QPHY_V3_PCS_START_CONTROL
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
> > >    158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
> > >        |                                           ^~~~~~~~~~~~~~~~~~~~~~~
> > >        |                                           QPHY_V5_PCS_PCS_STATUS1
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
> > >    159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
> > >        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >        |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
> > >    162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> > >        |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >        |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
> > >    163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> > >        |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >        |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
> > >    991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
> > >    992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
> > >    993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
> > >    994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
> > >    997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
> > >    998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
> > >    999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
> > >   1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
> > >   1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
> > >   1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
> > >   1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
> > >   1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
> > >   1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
> > >   1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
> > >   1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> > >        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > >     78 |                 .offset = o,            \
> > >        |                           ^
> > > 
> > > Caused by commit
> > > 
> > >    685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
> > > 
> > > I have used the usb tree from next-20231003 for today.
> > Thanks, I've now reverted this from my tree.
> As mentioned in the cover letter of these changes, the series was dependent
> on the other submitted series [1], [2].

Ah, I missed that, I almost never read cover letters :)

> Can you also pick these series [1], [2] to resolve this build failures.
> [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
> [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/

How about you just send this change with these others, or all of them as
one big series so they can be applied in the proper order?

thanks,

greg k-h
