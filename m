Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932B7F9E54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 12:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjK0LP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 06:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjK0LPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 06:15:21 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEFA138;
        Mon, 27 Nov 2023 03:15:27 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ARAOo5T003615;
        Mon, 27 Nov 2023 12:14:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=selector1; bh=8Vbivb9VqhvIy3KkCjS2N
        dwe7AeBFgkC6zhQeVlfu7A=; b=zSxWfPZc1DeG2lKUspz0geU/YXF2Uy06NM25C
        hgu0n+a3RjupMrtlYC5OyZCtwmAkzTubyeXmTu3eaGfFF8FsnbhzdOoUTp6reSob
        poW1EFUGgxy4y1/bW/dWHu56JxagYJtUQjOSvWdqm5zPmLJTuF/+Y3yN64DdRpbl
        BWM3+Sxo6e+ElQIc85PY5Lhr93x/Vec1EyeUKjm3jouGbheFraKCScpSrV0M+ZMu
        U99IMCDAfbmAY8nk2TJ8X7AIAUTKFb0txXo9HZNbyPPrDteNoiJFss3y2jAsfl87
        Sgu82Z55S57+po++JodlZAQz5OGENTxdBB1GotsAFJ+yluYgw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uk951qb3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Nov 2023 12:14:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 90A1710004B;
        Mon, 27 Nov 2023 12:14:55 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A7111217B73;
        Mon, 27 Nov 2023 12:14:55 +0100 (CET)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 27 Nov
 2023 12:14:55 +0100
Date:   Mon, 27 Nov 2023 12:14:46 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/5] Add support for DCMIPP camera interface of
 STMicroelectronics STM32 SoC series
Message-ID: <20231127111446.GA1421638@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Scally <dan.scally@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231122073927.788810-1-alain.volmat@foss.st.com>
 <ZWRwa2ImfkZMI8Xz@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZWRwa2ImfkZMI8Xz@kekkonen.localdomain>
X-Disclaimer: ce message est personnel / this message is private
X-Originating-IP: [10.129.178.213]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_09,2023-11-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Mon, Nov 27, 2023 at 10:33:15AM +0000, Sakari Ailus wrote:
> Hi Alain,
> 
> On Wed, Nov 22, 2023 at 08:39:14AM +0100, Alain Volmat wrote:
> > This patchset introduces support for Digital Camera Memory Interface
> > Pixel Processor (DCMIPP) of STMicroelectronics STM32 SoC series.
> > 
> > This initial support implements a single capture pipe
> > allowing RGB565, YUV, Y, RAW8 and JPEG capture with
> > frame skipping, prescaling and cropping.
> > 
> > DCMIPP is exposed through 3 subdevices:
> > - dcmipp_dump_parallel: parallel interface handling
> > - dcmipp_dump_postproc: frame skipping, prescaling and cropping control
> > - dcmipp_dump_capture: video device capture node
> 
> The DTS changes will presumably be merged via a different tree, right?

Yes, Alexandre will take care of the DTS changes via the linux-stm32 tree.

Regards,
Alain

> 
> -- 
> Sakari Ailus
> 
