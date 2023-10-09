Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F2C7BD79C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbjJIJt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345863AbjJIJt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:49:56 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3986594
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:49:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-59f6e6b206fso54212767b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696844993; x=1697449793; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kymbAWSyvMAtIb8qklsi6fMsf9KEKKnmNUtLzHg8eG8=;
        b=Lid94hYHG5vtM/UcxPWvAan+uiUu8LJV85BXm5oPTeKzIjLQHroN12qEHpheQNEv7h
         uWE8ypxCxIPItgwPELOCLVp3rabmGhxgoGnRXXlaplKUz3awBh1JuvdvD7uLkBlGcVB9
         LT0J2+14VBOmQZKpGlU4ghVmkWq201RYfDxcYzqGkgp+xj9gjZI46LgALkWtzI1m4Leu
         Y4mDMsBmz5Jd5BguClcSlw1S393RbDck3T7aLDX2peH3ujI2+dLXsa7A/4PSWWWq6yaO
         bIHsB1IT74Dp9US9WbK41De9ee1p1IZsSlOvUWKuClyLqij9cRHd5lbTuCuPEDvv8wST
         RxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844993; x=1697449793;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kymbAWSyvMAtIb8qklsi6fMsf9KEKKnmNUtLzHg8eG8=;
        b=KDGYFO39uY5Of79hJAwL0p0WaF4S2M/Sk6S6YFbGC9/rEYItpIhrpt7mcpe3Sxa2V6
         WoMNTIhOJ7rFF8Vc/QxH2Lq40qorx1/bh9mf89wSNRKv/XAkT2dktzrVh8Tx1Ist/QXe
         NZjjzY6sZjsG96A41JmsH+EN8z9xaxQFTDjKgtnrsgNe/IcjkuAYjHrxC2HIWn+KNhv1
         OJcbd9i8KAYrsZawTEt6sFKZvPTSjKwZ8IWW3vxYn3V0pLucj2fzUiH5ea23Z909NY+t
         MPADvK5IPYK/DoNc4L+qcLrJSRzKhjbAAEoH4WuTmcKOEVF7TCOfVJm9ebBAWBlNZB9N
         CkCw==
X-Gm-Message-State: AOJu0Yzxl3NYb7R8uYlg84vBuEUYytbW36J0NoNZHBVgV4BeSa3k4H0Y
        W97AJgen2JPROP2GvrE39HMwaJ8XZ6z5FWdh1nLJeGjl2ec3KYkMuwqAmA==
X-Google-Smtp-Source: AGHT+IH781PTWCAeDnSYtnRbA3lGlgKHk/sZeTMY8tsHB73a4uUnu87zfKIJu7H8YJyroWXPjFJFie4tfWDiWzMxp9k=
X-Received: by 2002:a0d:f985:0:b0:59f:21c1:30b6 with SMTP id
 j127-20020a0df985000000b0059f21c130b6mr17202838ywf.51.1696844993354; Mon, 09
 Oct 2023 02:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231004132247.01c3bfeb@canb.auug.org.au> <2023100410-concave-explore-95bf@gregkh>
 <e26b26ff-9e88-4455-9172-1afb520583e7@quicinc.com> <2023100445-cymbal-glade-52c8@gregkh>
 <044a2146-f859-44b3-bcf7-66b68d3e7787@quicinc.com> <2023100912-tiara-pout-ba98@gregkh>
In-Reply-To: <2023100912-tiara-pout-ba98@gregkh>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 9 Oct 2023 12:49:42 +0300
Message-ID: <CAA8EJpo-cvf3vkvBe+5nF1FpDMXzWJZkaL6n0BAjPvg7xHQ_+w@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the usb tree
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2023 at 12:48, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 09, 2023 at 02:48:27PM +0530, Rohit Agarwal wrote:
> >
> > On 10/4/2023 6:16 PM, Greg KH wrote:
> > > On Wed, Oct 04, 2023 at 12:17:27PM +0530, Rohit Agarwal wrote:
> > > > On 10/4/2023 12:13 PM, Greg KH wrote:
> > > > > On Wed, Oct 04, 2023 at 01:22:47PM +1100, Stephen Rothwell wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > After merging the usb tree, today's linux-next build (x86_64 allmodconfig)
> > > > > > failed like this:
> > > > > >
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:156:43: error: 'QPHY_V6_PCS_SW_RESET' undeclared here (not in a function); did you mean 'QPHY_V2_PCS_SW_RESET'?
> > > > > >     156 |         [QPHY_SW_RESET]                 = QPHY_V6_PCS_SW_RESET,
> > > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                           QPHY_V2_PCS_SW_RESET
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:157:43: error: 'QPHY_V6_PCS_START_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_START_CONTROL'?
> > > > > >     157 |         [QPHY_START_CTRL]               = QPHY_V6_PCS_START_CONTROL,
> > > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                           QPHY_V3_PCS_START_CONTROL
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:158:43: error: 'QPHY_V6_PCS_PCS_STATUS1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_PCS_STATUS1'?
> > > > > >     158 |         [QPHY_PCS_STATUS]               = QPHY_V6_PCS_PCS_STATUS1,
> > > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                           QPHY_V5_PCS_PCS_STATUS1
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:159:43: error: 'QPHY_V6_PCS_POWER_DOWN_CONTROL' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_POWER_DOWN_CONTROL'?
> > > > > >     159 |         [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V6_PCS_POWER_DOWN_CONTROL,
> > > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                           QPHY_V3_PCS_POWER_DOWN_CONTROL
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:162:43: error: 'QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL'?
> > > > > >     162 |         [QPHY_PCS_AUTONOMOUS_MODE_CTRL] = QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> > > > > >         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                           QPHY_V5_PCS_USB3_AUTONOMOUS_MODE_CTRL
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:163:44: error: 'QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR'?
> > > > > >     163 |         [QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR] = QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> > > > > >         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >         |                                            QPHY_V5_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:991:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG1'?
> > > > > >     991 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG1, 0xc4),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:992:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_LOCK_DETECT_CONFIG2'?
> > > > > >     992 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG2, 0x89),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:993:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG3' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG3'?
> > > > > >     993 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG3, 0x20),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:994:26: error: 'QPHY_V6_PCS_LOCK_DETECT_CONFIG6' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_LOCK_DETECT_CONFIG6'?
> > > > > >     994 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_LOCK_DETECT_CONFIG6, 0x13),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:997:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L'?
> > > > > >     997 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_L, 0xe7),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:998:26: error: 'QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H' undeclared here (not in a function); did you mean 'QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H'?
> > > > > >     998 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_RCVR_DTCT_DLY_P1U2_H, 0x03),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:999:26: error: 'QPHY_V6_PCS_CDR_RESET_TIME' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_CDR_RESET_TIME'?
> > > > > >     999 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_CDR_RESET_TIME, 0x0a),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1000:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG1'?
> > > > > >    1000 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG1, 0x88),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1001:26: error: 'QPHY_V6_PCS_ALIGN_DETECT_CONFIG2' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_ALIGN_DETECT_CONFIG2'?
> > > > > >    1001 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_ALIGN_DETECT_CONFIG2, 0x13),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1003:26: error: 'QPHY_V6_PCS_EQ_CONFIG1' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG1'?
> > > > > >    1003 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG1, 0x4b),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1004:26: error: 'QPHY_V6_PCS_EQ_CONFIG5' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_EQ_CONFIG5'?
> > > > > >    1004 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_EQ_CONFIG5, 0x10),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1008:26: error: 'QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL'?
> > > > > >    1008 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1009:26: error: 'QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2'?
> > > > > >    1009 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1010:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L' undeclared here (not in a function); did you mean 'QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L'?
> > > > > >    1010 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_L, 0x40),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:1011:26: error: 'QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H' undeclared here (not in a function); did you mean 'QPHY_V5_PCS_USB3_RCVR_DTCT_DLY_U3_H'?
> > > > > >    1011 |         QMP_PHY_INIT_CFG(QPHY_V6_PCS_USB3_RCVR_DTCT_DLY_U3_H, 0x00),
> > > > > >         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > > drivers/phy/qualcomm/phy-qcom-qmp-usb.c:78:27: note: in definition of macro 'QMP_PHY_INIT_CFG'
> > > > > >      78 |                 .offset = o,            \
> > > > > >         |                           ^
> > > > > >
> > > > > > Caused by commit
> > > > > >
> > > > > >     685dbd1b2306 ("phy: qcom-qmp-usb: Add Qualcomm SDX75 USB3 PHY support")
> > > > > >
> > > > > > I have used the usb tree from next-20231003 for today.
> > > > > Thanks, I've now reverted this from my tree.
> > > > As mentioned in the cover letter of these changes, the series was dependent
> > > > on the other submitted series [1], [2].
> > > Ah, I missed that, I almost never read cover letters :)
> > >
> > > > Can you also pick these series [1], [2] to resolve this build failures.
> > > > [1] https://lore.kernel.org/all/20230911203842.778411-1-dmitry.baryshkov@linaro.org/
> > > > [2] https://lore.kernel.org/linux-phy/20230824211952.1397699-1-dmitry.baryshkov@linaro.org/
> > > How about you just send this change with these others, or all of them as
> > > one big series so they can be applied in the proper order?
> > Adding Dmitry as well.
> >
> > I see some of the dependent patches are already applied and the patches from
> > [2] are not.
> > Since all the rest dependent changes are already applied,
> > you can pick series[2] and then this series that should also be fine.
> > Please let me know if this is fine?
>
> What is "this" series?  I don't have any of these in my inbox at all
> anymore, sorry.  Please resend the pending patches that need to be
> applied to my usb tree and I will be glad to do so.

Actually, I wonder why the PHY patches were merged through the USB
tree, maybe that is the issue here.

-- 
With best wishes
Dmitry
