Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074417692CD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjGaKNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjGaKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:13:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A35DE3;
        Mon, 31 Jul 2023 03:13:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RDv9R4xgmz6J7N8;
        Mon, 31 Jul 2023 18:09:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 11:13:06 +0100
Date:   Mon, 31 Jul 2023 11:13:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
Message-ID: <20230731111306.000036da@Huawei.com>
In-Reply-To: <BN6PR03MB339557689BCCF795B18C68319B05A@BN6PR03MB3395.namprd03.prod.outlook.com>
References: <20230727113136.98037-1-antoniu.miclaus@analog.com>
        <7f7d1c90-9969-66bd-fd71-defffe0e05d6@linaro.org>
        <BN6PR03MB3395F9139A225AA97A100B829B01A@BN6PR03MB3395.namprd03.prod.outlook.com>
        <20230729125516.68a29852@jic23-huawei>
        <BN6PR03MB339557689BCCF795B18C68319B05A@BN6PR03MB3395.namprd03.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 07:40:14 +0000
"Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:

> > -----Original Message-----
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Saturday, July 29, 2023 2:55 PM
> > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>;
> > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
> > 
> > [External]
> > 
> > On Thu, 27 Jul 2023 12:02:04 +0000
> > "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com> wrote:
> >   
> > > > -----Original Message-----
> > > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Sent: Thursday, July 27, 2023 2:47 PM
> > > > To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>; jic23@kernel.org;
> > > > robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > > > conor+dt@kernel.org; linux-iio@vger.kernel.org;
> > > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> > > > Subject: Re: [PATCH] dt-bindings: iio: admv1014: make all regs required
> > > >
> > > > [External]
> > > >
> > > > On 27/07/2023 13:31, Antoniu Miclaus wrote:  
> > > > > Since the regulators are required in the driver implementation, make
> > > > > them required also in the bindings.  
> > 
> > This bit is probably not strictly true.  Try no providing them and you will
> > probably find stub regulators created on assumption they are fixed regs
> > that we aren't interested in controlling.
> >   
> > > > >  
> > > >
> > > > The true reason should be whether the hardware requires them.  
> > Because if  
> > > > hardware does not need some, the driver should be fixed.  
> > > The datasheet is not very explicit on this topic, but all the specifications of  
> > the  
> > > part are built around these pins being supplied.
> > > Moreover, the evaluation board or the part comes with all VCC pins  
> > connected  
> > > to fixed supplies.  
> > 
> > Agreed - these should be required in the binding.
> >   
> Hello Jonathan,
> 
> Not sure if I fully understand. Should I drop this patch? 

Patch is good.  The binding should state these are required - it doesn't
mean that the driver will fail to probe on systems that doesn't provide
them.  It does encourage any new DTS files to incorporate them which is
good to have.

Only thing that needs changing is the patch should not justify the
addition of these to the binding because they 'are required in the
driver implementation'.  Just drop that statement and the patch is
fine.



> And also drop the "required" of the regulators in the admv1013 patch?
> https://patchwork.kernel.org/project/linux-iio/patch/20230727110121.93546-1-antoniu.miclaus@analog.com/

As long as the patch doesn't say anything about what the driver does
then it is fine.  Note DT bindings and patch descriptions for them should
never mention the driver.

Jonathan

> 
> Thanks,
> > There was an old disagreement on this in which it they were not marked
> > required in some bindings because the regulator subsystem would assume
> > they
> > were fixed supplies that were just missing in the DT and so provides stub
> > regulators.
> > My understanding at least has changed and now we mark the required even
> > if
> > the driver works fine on some boards without them being supplied.
> > 
> > Note though that this means the whole of trivial-devices.yaml is garbage
> > as very few devices actually work without any power :)
> > 
> > Jonathan
> > 
> > 
> >   
> > > > Best regards,
> > > > Krzysztof  
> > >  
> 

