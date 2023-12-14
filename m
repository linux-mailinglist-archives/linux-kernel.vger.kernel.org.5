Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0E8813169
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjLNN0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjLNNZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:25:58 -0500
X-Greylist: delayed 2169 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 05:26:02 PST
Received: from mx0a-00176a03.pphosted.com (mx0b-00176a03.pphosted.com [67.231.157.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949D124;
        Thu, 14 Dec 2023 05:26:02 -0800 (PST)
Received: from pps.filterd (m0048299.ppops.net [127.0.0.1])
        by m0048299.ppops.net-00176a03. (8.17.1.19/8.17.1.19) with ESMTP id 3BEAqCgB032366;
        Thu, 14 Dec 2023 07:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com; h=date : from :
 to : cc : subject : message-id : references : mime-version : content-type
 : in-reply-to; s=outbound;
 bh=6VCWaveWtQ4TTCEg/huDwclSFR1aouzs3cX1Z5zsynw=;
 b=g6dOpR5liYoky07H88PlbqHiF8ybzHCpIDPlyyjmdW1TKB4RF2Hwewa+TBFMweUESq3Z
 KlzULGxzDGygUeiRZiYqkj7mt+HHtdXLQH4oDPj2Tg4GpzIkC/8NIYTUuxCODCJErZUV
 up8XlzPDrytoQYIKkyD/r7haigTZlEBEYr6WReGFAu3VctI/oVixyY4OZ2bttK0Nf7LV
 3810PYZaUf07TvdKQVw0qNyHJi1yPH1Qug0dyKgNkvXzZMy3Bse4x7SEwLR9opnLi/qA
 0xTXnhjsZJxlmNYU5y8qu+nJBkNbeu7RhN91x7Y0TAgfGjTPThzQorEnlltKYEvS03EP wQ== 
Date:   Thu, 14 Dec 2023 14:49:41 +0200
From:   Ian Ray <ian.ray@gehealthcare.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe Kleine-K??nig <u.kleine-koenig@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        nandor.han@gehealthcare.com
Subject: Re: EXT: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <ZXr55QV4tnCz8GtI@4600ffe2ac4f>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <20231208090754.fn3bddlum3t7kakn@pengutronix.de>
 <2023120821-sandstone-lavender-7487@gregkh>
 <919dd7b3-aa86-4a2f-bcbe-7efa26831975@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <919dd7b3-aa86-4a2f-bcbe-7efa26831975@linaro.org>
X-Proofpoint-ORIG-GUID: cTTSlR9xjeMfDmKT2eWxAJJuMa2zr8om
X-Proofpoint-GUID: cTTSlR9xjeMfDmKT2eWxAJJuMa2zr8om
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_07,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=711 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 01:14:50PM +0100, Krzysztof Kozlowski wrote:
> 
> On 08/12/2023 11:32, Greg Kroah-Hartman wrote:
> > On Fri, Dec 08, 2023 at 10:07:54AM +0100, Uwe Kleine-K??nig wrote:
> >> [Cc += dt maintainers]
> >>
> >> On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:
> > 
> > You are responding to a message from 2021???
> > 
> > I can't remember what I wrote in an email last week, let alone years
> > ago, are you sure any of this is relevant still?
> > 
> 
> Also, adding DT maintainers as Cc, does not magically allow us to
> understand the discussion. Please shortly summarize what do you
> need/expect from us.

This thread is indeed old, but we are remain interested in getting
this resolved.


The topic itself is about the tuning of DMA buffers for the i.MX53
platform.

DMA is required (for the 4M baud UART case), and a specific buffer
configuration is required, too.


Two approaches have been attempted:

"V4" sysfs
https://lore.kernel.org/lkml/20210305115058.92284-1-sebastian.reichel@collabora.com/

"V5" DT
https://lore.kernel.org/lkml/20210430175038.103226-1-sebastian.reichel@collabora.com/
(this thread)


Uwe recently commented to [1], and (hoping to avoid any further
confusion) let's continue in that thread.

[1] https://lore.kernel.org/lkml/20231208090205.ioc76sych3snjiwb@pengutronix.de/


> 
> Best regards,
> Krzysztof
> 
> 
