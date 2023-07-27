Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C02C765669
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjG0Otc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjG0OtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:49:12 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06974273E;
        Thu, 27 Jul 2023 07:48:48 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36REmQbG040853;
        Thu, 27 Jul 2023 09:48:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690469306;
        bh=r4o2/e1WicuU52RoywMHaSVJpBndS3GS7f3AJTcYJ3o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RxIkk8xPku9NOF3cHWZkH8z1oJtm7CsTELi5sgwJt+VtPBPOUdNkir5bsEvkh2tRs
         iBvEOl6LQ7a3OqjO1m/zV4A7lBZcBhn2V3sF3BoPfYmGKHV0x9157GIyHwhmU8xr+K
         rUN8xPtHy/0oSSQMFdIqsybCoXz+cE85M0V9pPQc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36REmQil027583
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 09:48:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 09:48:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 09:48:26 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36REmJeP029821;
        Thu, 27 Jul 2023 09:48:20 -0500
Message-ID: <c9629a19-c400-5553-754b-ee17b19e0970@ti.com>
Date:   Thu, 27 Jul 2023 20:18:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] media: imagination: Add E5010 JPEG Encoder driver
Content-Language: en-US
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <laurent.pinchart@ideasonboard.com>,
        <eugen.hristev@collabora.com>, <ezequiel@vanguardiasur.com.ar>,
        <u.kleine-koenig@pengutronix.de>, <sakari.ailus@linux.intel.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>
References: <20230727112546.2201995-1-devarsht@ti.com>
 <20230727112546.2201995-3-devarsht@ti.com>
 <ef4825d6-1016-cbf2-0cd3-94b0fc4165f4@linaro.org>
 <51e4ece5250c3345dae4956fbb4d4dbb5ffdde38.camel@ndufresne.ca>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <51e4ece5250c3345dae4956fbb4d4dbb5ffdde38.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Nicholas,

Thanks for the quick review.

On 27/07/23 19:49, Nicolas Dufresne wrote:
> Hi Krzysztof,
> 
> Le jeudi 27 juillet 2023 à 14:13 +0200, Krzysztof Kozlowski a écrit :
>> On 27/07/2023 13:25, Devarsh Thakkar wrote:
>> ...
>>
>>> +
>>> +static int e5010_release(struct file *file)
>>> +{
>>> +	struct e5010_dev *dev = video_drvdata(file);
>>> +	struct e5010_context *ctx = file->private_data;
>>> +
>>> +	dprintk(dev, 1, "Releasing instance: 0x%p, m2m_ctx: 0x%p\n", ctx, ctx->fh.m2m_ctx);
>>
>> Why do you print pointers? Looks like code is buggy and you still keep
>> debugging it.
> 
> Its relatively common practice in linux-media to leave a certain level of traces
> to help future debugging if a bug is seen. These uses v4l2 debug helper, and are
> only going to print if users enable them through the associated sysfs
> configuration. I do hope though there isn't any issue with IRQ triggering after
> the instance is released, that would be buggy for sure, but I don't think this
> is the case considering the level of documented testing that have been done.
> 
> I'd be happy to see what others have to say on the subject, as its been a
> recurrent subject of confrontation lately. With pretty agressive messages
> associated with that.
> 
> regards,
> Nicolas
> 
> p.s. does not invalidate the question, since for this driver, there is only ever
> going to be one m2m_ctx, so the question "Why do you print pointers?" is
> entirely valid I believe.
> 

There is a possible scenario with multiple applications accessing the device
node simultaneously (and so multiple m2m_ctx are possible as seen in below
logs) and these prints were helpful to debug/analyze these scenarios.

[181955.443632] e5010 fd20000.e5010: e5010_open: Created instance:
0x00000000bea83b70, m2m_ctx: 0x00000000d068a951
[181955.449587] e5010 fd20000.e5010: e5010_open: Created instance:
0x0000000046749df9, m2m_ctx: 0x000000000ff56aa6
[181955.450407] e5010 fd20000.e5010: e5010_open: Created instance:
0x00000000e33791b5, m2m_ctx: 0x00000000217634a8
[181955.457067] e5010 fd20000.e5010: e5010_open: Created instance:
0x00000000d77f83fe, m2m_ctx: 0x000000000c8ec99e


Infact, actually I had added these prints while debugging an issue with this
type of multistream scenario, where I was launching like 20 instances of JPEG
encoding and some of the instances were hanging, these prints were helpful to
fix that scenario and I later still kept these prints as they may help in
future in case any issue is encountered while adding a new feature or in
further testing.

I have also already put the logs for this multi-stream scenario in gist shared
in commit message, below is the exact line :

https://gist.github.com/devarsht/ea31179199393c2026ae457219bb6321#file-e5010_jpeg_upstream_manualtests-txt-L89


Regards
Devarsh
> . . .
