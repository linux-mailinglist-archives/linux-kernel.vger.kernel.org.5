Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC847A7A03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbjITLGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjITKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:19:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD0D110;
        Wed, 20 Sep 2023 03:19:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3A0C433C8;
        Wed, 20 Sep 2023 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695205169;
        bh=OjA7iTECs8f9+839G62xTmbLSGvLzLZmyK1Rhd04rVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/c412THfLmc6qea7o9R/VfTdCcbfi8mZ0ttkYhqouACRznUQ57Hgkrh50E+LknXY
         MsvMbvVdu3CI0iswDjXXT1cE9xD7hw1r7DxwXZHkSCJZ4kkdAMhcTnA8c9iiYaPvFI
         qxp/Dq5zi8dMXWFL9cqQ7Yh8HtihnHVlOT/w5qdkxQyyaOcMIThvdICKC3l/yruyC/
         CvnUUY2ViVFNbMN6npMy68oMuxuFq2CEXdjLOYboGmqqXb8QnduuJitRCizNUqQ9MJ
         1sIT5v+0WLYUzck3AAyVe5MrZ2tHlbHP/3po/cyjALIIIIU4MRASh6jiTa0i16OC6q
         KaiBFXp2gFQHA==
Date:   Wed, 20 Sep 2023 12:19:23 +0200
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Can Guo <quic_cang@quicinc.com>, quic_nguyenb@quicinc.com,
        quic_nitirawa@quicinc.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH 4/6] phy: qualcomm: phy-qcom-qmp-ufs: Move data structs
 and setting tables to header
Message-ID: <20230920101923.GG4732@thinkpad>
References: <1694411968-14413-1-git-send-email-quic_cang@quicinc.com>
 <1694411968-14413-5-git-send-email-quic_cang@quicinc.com>
 <CAA8EJpoWnXeJKPB04kJW6Qo7ifAnt1u2ZSiq+W2HWOez=hi5gA@mail.gmail.com>
 <20230919121524.GD4732@thinkpad>
 <CAA8EJpoqRBxS7HJrFdRAvv677hKJw+d_K+fN_4ABDrj+68r28w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpoqRBxS7HJrFdRAvv677hKJw+d_K+fN_4ABDrj+68r28w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:30:21AM +0300, Dmitry Baryshkov wrote:
> On Tue, 19 Sept 2023 at 15:15, Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Sep 14, 2023 at 03:28:59PM +0300, Dmitry Baryshkov wrote:
> > > On Mon, 11 Sept 2023 at 09:01, Can Guo <quic_cang@quicinc.com> wrote:
> > > >
> > > > To make the code more readable, move the data structs and PHY settting
> > > > tables to a header file, namely the phy-qcom-qmp-ufs.h.
> > > >
> > > > Signed-off-by: Can Guo <quic_cang@quicinc.com>
> > > > ---
> > > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 802 +------------------------------
> > > >  drivers/phy/qualcomm/phy-qcom-qmp-ufs.h | 805 ++++++++++++++++++++++++++++++++
> > > >  2 files changed, 806 insertions(+), 801 deletions(-)
> > > >  create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.h
> > >
> > > Is there any reason to do so? Other than just moving stuff around, it
> > > doesn't give us anything. This header will not be shared with any
> > > other driver. Just moving data tables to the header (ugh, static data
> > > in the header) doesn't make code more readable.
> > >
> >
> > I think the motive here is to move the static tables to one file and have the
> > rest of the code in another. Because, the static tables itself occupy 1.2k LoC
> > now and it is going to grow. So let's keep them in a single file to avoid mixing
> > it with rest of the driver code.
> 
> My 2c is that this is mostly useless. The headers are for sharing, not
> for moving the data out of the .c files. Not to mention that the
> driver code comes after the tables.
> I'd really suggest starting such a move with separating common parts
> of all the QMP drivers.
> 

Makes sense.

Can, please propose a separate series if you want to pursue the effort.
Also, I'd say that instead of moving the tables to a header (which defeats the
purpose of the header), the tables can be moved to a separate .c file. Like,

phy-qcom-qmp-ufs-tables.c
phy-qcom-qmp-ufs.c

Btw, why do we have "phy-qcom" prefix inside drivers/phy/qualcomm/?

- Mani

> >
> > - Mani
> >
> > > If you really would like to clean up the QMP drivers, please consider
> > > splitting _common_ parts. But at this point I highly doubt that it is
> > > possible in a useful way.
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்
