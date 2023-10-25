Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDE37D6EFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjJYOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjJYOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:32:28 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 07:32:26 PDT
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF16132
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:32:26 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:32:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698244344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9yGXZx56wLrs8zZugE5T99ylar+sw5kaIHcBk8ebDs=;
        b=ayJEVYsKgQ2CMX2xDldH60OW+42hcVYvNKzt4hM8njPcv9pnKikJkWQaWdQmXULjYqQovx
        r94PExUjXSLnrG3hqFtcXqsKAoVhAOsZOGaoUU/MYyPmrXYZuWTQc+WmMpVxA4Nfiu+K2K
        wc9vLce5trfBa3Q0S3/0sqc6DnGSNMQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: add ti,ina238
Message-ID: <ml5cknb6xwtyfkp744pqutpdm2q547bg4zihsld27kkq2tzmbe@lkoesz4ww2di>
References: <20231025-ina237-v1-0-a0196119720c@linux.dev>
 <20231025-ina237-v1-2-a0196119720c@linux.dev>
 <20231025-hut-omnivore-f4b44a7b928d@spud>
 <qoxgyho5twbm4jopfveaf5ee3z4tkyb2z5f2vsyrpglffegmxf@v2z5ckcaa5jc>
 <20231025-eatery-backup-ad85c043cb01@spud>
 <8cd5c34e-f733-445d-bc1e-d4dea1bcb47d@linaro.org>
 <2syaha4sapfpegvdsvef76egcqfebkuapxok6uripdbrgbk2vn@2xq5oi33zz2j>
 <d68f1109-9e99-4a94-98d8-676be4af920f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68f1109-9e99-4a94-98d8-676be4af920f@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 04:27:18PM +0200, Krzysztof Kozlowski wrote:
> On 25/10/2023 16:23, Richard Leitner wrote:
> > On Wed, Oct 25, 2023 at 04:18:31PM +0200, Krzysztof Kozlowski wrote:
> >> On 25/10/2023 16:11, Conor Dooley wrote:
> >>> On Wed, Oct 25, 2023 at 04:07:31PM +0200, Richard Leitner wrote:
> >>>> On Wed, Oct 25, 2023 at 03:00:01PM +0100, Conor Dooley wrote:
> >>>>> On Wed, Oct 25, 2023 at 10:34:12AM +0000, Richard Leitner wrote:
> >>>>>> The ina238 driver is available since 2021 but lacks a dt-bindings file.
> >>>>>> Therefore add the missing file now.
> >>>>>
> >>>>> Seemingly it is documented in Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
> >>>>
> >>>> Thanks for the feedback. True. So is it fine if it's left there or
> >>>> should it be removed from ti,ina2xxx.yml as this is a separate driver
> >>>> with different properties?
> >>>
> >>> Merging them would seem like the most straightforward thing to do, no?
> >>
> >> Sorry folks, I don't quite get what do you want to merge or move and
> >> why. Drivers are not related to bindings. The point is the compatible is
> >> already documented, so is anything wrong with existing documentation?
> > 
> > ina238 is a separate driver which doesn't evaluate the same properties as
> > the ina2xx driver. So I thought it would be reasonable to split those
> > bindings and therefore reflect the drivers capabilities.
> 
> I do not see different properties in the bindings, so what do you mean
> that it evaluates something else?
> 
> Anyway, whatever driver does is rarely good argument for change in
> bindings, because we focus here on the hardware, not on one, chosen OS
> implementation.

Understood.

> 
> > 
> > If it's fine if there are additional properties in the dt-bindings which
> 
> Where are they? Or rather which additional properties?

For example the "shunt-resistor" property described in ina2xx.yaml is
not evaluated in ina238.c.

> 
> > are not evaluated by the driver then it's of course fine with me to just
> > add the ina327 compatible in ina2xx.yaml.
> 
> Depends. What driver does, might not matter in some cases. What matters
> is if these properties are applicable to this hardware.

Thanks for that explanation. That makes things clearer to me.

The properties described in the ina2xx.yaml are applicable to the ina237
and ina238 hardware, but are not implemented in the ina238.c driver.

So I will just add the ina237 compatible to the ina2xx.yaml and drop the
ina238.yaml from that series. Would that be fine from your side?

regards;rl

> 
> Best regards,
> Krzysztof
> 
