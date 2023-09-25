Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5FE7AD8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjIYNWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIYNWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:22:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E735EA2;
        Mon, 25 Sep 2023 06:22:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvNl16n7cz6D9y0;
        Mon, 25 Sep 2023 21:19:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 14:21:58 +0100
Date:   Mon, 25 Sep 2023 14:21:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andreas Kemnade <andreas@kemnade.info>, <jic23@kernel.org>,
        <lars@metafoo.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bcousson@baylibre.com>, <tony@atomide.com>,
        <jean-baptiste.maneyrol@tdk.com>, <chenhuiz@axis.com>,
        <andy.shevchenko@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Message-ID: <20230925142157.00000914@Huawei.com>
In-Reply-To: <3b81a9a7-69a3-4fd6-875f-7a5170c5c872@linaro.org>
References: <20230924222559.2038721-1-andreas@kemnade.info>
        <20230924222559.2038721-2-andreas@kemnade.info>
        <6db5b758-2ae6-46fb-a699-d73a2b98b4c2@linaro.org>
        <20230925112852.00007d34@Huawei.com>
        <20230925130225.55fe6fd4@aktux>
        <3b81a9a7-69a3-4fd6-875f-7a5170c5c872@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 14:24:32 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/09/2023 13:02, Andreas Kemnade wrote:
> > On Mon, 25 Sep 2023 11:28:52 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> >   
> >> On Mon, 25 Sep 2023 08:54:08 +0200
> >> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> >>  
> >>> On 25/09/2023 00:25, Andreas Kemnade wrote:    
> >>>> Found in ancient platform data struct:
> >>>> level_shifter: 0: VLogic, 1: VDD
> >>>>
> >>>> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> >>>> ---
> >>>>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml         | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> >>>> index 1db6952ddca5e..6aae2272fa15c 100644
> >>>> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> >>>> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> >>>> @@ -48,6 +48,8 @@ properties:
> >>>>  
> >>>>    mount-matrix: true
> >>>>  
> >>>> +  invensense,level-shifter: true      
> >>>
> >>> It does not look like you tested the bindings, at least after quick
> >>> look. Please run `make dt_binding_check` (see
> >>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> >>> Maybe you need to update your dtschema and yamllint.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>>     
> >>
> >> Also this one isn't obvious - give it a description in the binding doc.
> >>
> >> I'm not sure of the arguement for calling it level shift in general.
> >>  
> > I have no more descrption than the old source (see the citation from there)
> > https://invensense.tdk.com/wp-content/uploads/2015/02/MPU-9150-Register-Map.pdf  
> 
> I could not find any reference to level shift in this manual. To which
> page and part do you refer?
> 
> > 
> > does not list it. But that bit is needed to get things to work what also does the
> > vendor kernel do.
> > 
> > What could be a better descrption?  
> 
> I don't know, but something reasonable to you should be put there.

The text you have in the commit log seems better than nothing.
I suspect it's internally wiring VDD to VDDIO. Normally people just
connect both power supplies to same supply if they want to do that,
but maybe there was a chip variant that didn't have enough pins?

If you have the device, can you see it actually matches the packaging
types in the manual?

Jonathan

> 
> Best regards,
> Krzysztof
> 
> 

