Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C771E7AD715
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjIYLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:36:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A799DA;
        Mon, 25 Sep 2023 04:36:21 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P7KiBJ028486;
        Mon, 25 Sep 2023 13:35:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=oRS8xvFuvY4BhyLVdy5d8
        WmQlc7juDCbRmjvfrvtiyw=; b=HkfDEYLntwqrd6ilSUlHqWDaNzhqIIffLLvA8
        MDdGrpQvnOk1d9y4ztNaUKlPW1xzi8t8qtQsaOur2mgnHKZprUW317qtq8dpu/yq
        +qMUAl50RkeEcvezydUNpl7o3a+Un5RKzZTl+eyXD6W8ehUIGos+TZXO5xsQC68h
        HkkU/Gi/J9JUd/loSHEtTuyOjn1SypKGbNLRfnLK0vaSr+/yQUrJgo78rQugDa8q
        ItAwPl3ZVvRpMCN1yyuRet+oVcOUyEPAamp7JrA6NX8xtT/xQYi9P16p3mhDYZ76
        1Xf9Q8ujLWkESow+zkO4a3lPBN3mT/+sXoPm9ViY95M8H9rdw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9n547smq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 13:35:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C5AD310005C;
        Mon, 25 Sep 2023 13:35:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DF2DB2291BA;
        Mon, 25 Sep 2023 13:35:47 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 13:35:47 +0200
Date:   Mon, 25 Sep 2023 13:35:42 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] ARM: dts: stm32: add dcmipp support to stm32mp135
Message-ID: <20230925113542.GA646870@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230901155732.252436-1-alain.volmat@foss.st.com>
 <20230901155732.252436-5-alain.volmat@foss.st.com>
 <20230905090258.GC31594@pendragon.ideasonboard.com>
 <20230922160227.GA608616@gnbcxd0016.gnb.st.com>
 <20230922160818.GJ19112@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230922160818.GJ19112@pendragon.ideasonboard.com>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_08,2023-09-25_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,


On Fri, Sep 22, 2023 at 07:08:18PM +0300, Laurent Pinchart wrote:
> On Fri, Sep 22, 2023 at 06:02:27PM +0200, Alain Volmat wrote:
> > On Tue, Sep 05, 2023 at 12:02:58PM +0300, Laurent Pinchart wrote:
> > > On Fri, Sep 01, 2023 at 05:57:23PM +0200, Alain Volmat wrote:
> > > > From: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > > 
> > > > Add dcmipp support to STM32MP135.
> > > > 
> > > > Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
> > > > Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> > > > ---
> > > >  arch/arm/boot/dts/st/stm32mp135.dtsi | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/st/stm32mp135.dtsi b/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > index abf2acd37b4e..beee9ec7ed0d 100644
> > > > --- a/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > +++ b/arch/arm/boot/dts/st/stm32mp135.dtsi
> > > > @@ -8,5 +8,13 @@
> > > >  
> > > >  / {
> > > >  	soc {
> > > > +		dcmipp: dcmipp@5a000000 {
> > > > +			compatible = "st,stm32mp13-dcmipp";
> > > > +			reg = <0x5a000000 0x400>;
> > > > +			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> > > > +			resets = <&rcc DCMIPP_R>;
> > > > +			clocks = <&rcc DCMIPP_K>;
> > > > +			status = "disabled";
> > > 
> > > This needs a port, as it's marked as required in the bindings. You can
> > > leave the endpoint out.
> > 
> > I first agreed with your comment but, having done the check (make
> > CHECK_DTBS=y  ...) this doesn't seem to be required because the dcmipp
> > node is kept disabled within our dtsi.
> 
> Interesting.
> 
> > (it is later on only enabled in dts file which as well have the port
> > property).
> > Indeed, to check this I changed it to okay and DTC_CHK complained about
> > missing port property.
> > 
> > Hence, I'd think that port doesn't have to be added in this dtsi file.
> > Would you agree with that ?
> 
> I still think the port belongs here, as it's an intrinsic property of
> the dcmipp, not a property of the board. Does it cause any issue to add
> a port in the .dtsi ?

I agree that the port refers more to the SoC (hence dtsi) rather than
the board (hence dts), however I am wondering if this is really
something usually done.  I had a look at other dtsi with node related
to similar kind of devices and it seems to me that there is no such case
of a dtsi with a port having nothing in it.  Did I missed something ?


> 
> > > With this fixed,
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > > +		};
> > > >  	};
> > > >  };
> 
> -- 
> Regards,
> 
> Laurent Pinchart
