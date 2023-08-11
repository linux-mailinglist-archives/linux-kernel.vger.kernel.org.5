Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93977867D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 06:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjHKE0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 00:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjHKE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 00:26:09 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DDF2130;
        Thu, 10 Aug 2023 21:26:03 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0311B86053;
        Fri, 11 Aug 2023 06:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1691727962;
        bh=ySINd7zgYrKScIbj7DoBdQXuf/WKPQV09FEZXu774rA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kg4QZh7hM1+otYZOBZ/Nls6iQX//uxzFtYjO6SFk7J+614uAChgqN0rD0XOI8VTlT
         1+4K/NVEmByhgf2Vx2V7pPK25tEwQJMv239l9Ngga1j2lPeyS/WWdXgMlQ30nWt1fd
         GCKoxnGm2Bk+SiKGRv9KeGWEclkIbxhe4Xo4iaXONX95o5MF0nIVVUd/8YQWQl9Ny4
         nCVkYVmMRx75nRlxKdzErLC6SMaJ9w8SMG9cD7w6190MQlV+PKKmLJsJ7P9pDH3qLT
         TjShVYTlUM37Yr9I682yXwQ03TdL8c02g8N3M4TMLMQFQzqYQujRC1ZCKltct1ea9d
         RUsdnPVVet06A==
Message-ID: <120ca0a9-0e2f-bd87-8266-2a03e2865015@denx.de>
Date:   Fri, 11 Aug 2023 05:47:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: mxsfb: Exclude i.MX8MQ from power-domains
 requirement
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <guido.gunther@puri.sm>
Cc:     David Heidelberg <david@ixit.cz>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liu Ying <victor.liu@nxp.com>, kernel@puri.sm,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730184120.94984-1-david@ixit.cz>
 <ZMonFSqutQRqs61n@qwark.sigxcpu.org>
 <20230810-embroider-seduce-ee4506e7608b@spud>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230810-embroider-seduce-ee4506e7608b@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 21:30, Conor Dooley wrote:
> On Wed, Aug 02, 2023 at 11:51:17AM +0200, Guido Günther wrote:
>> Hi,
>> On Sun, Jul 30, 2023 at 09:41:20PM +0300, David Heidelberg wrote:
>>> i.MX8MQ uses as secondary compatible fsl,imx6sx-lcdif, which triggers
>>> requirement of power-domains, thou it's not required.
>>>
>>> Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")
>>>
>>> Signed-off-by: David Heidelberg <david@ixit.cz>
>>> ---
>>>   .../devicetree/bindings/display/fsl,lcdif.yaml        | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
>>> index fc11ab5fc465..2d868276b0f9 100644
>>> --- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
>>> +++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
>>> @@ -129,8 +129,15 @@ allOf:
>>>                 - fsl,imx8mp-lcdif
>>>                 - fsl,imx93-lcdif
>>>       then:
>>> -      required:
>>> -        - power-domains
>>> +      if:
>>> +        properties:
>>> +          compatible:
>>> +            not:
>>> +              contains:
>>> +                const: fsl,imx8mq-lcdif
>>> +      then:
>>> +        required:
>>> +          - power-domains
>>
>> We currently enable the mipi power domain for the mipi dphy and nwl
>> bridge only but not for LCDIF itself assuming it's not needed (as there's
>> other outputs LCDIF can drive). I *think* this is correct but maybe
>> Marek or Liu can confirm?
> 
> I'm happy to Ack this, but I've been sitting on it waiting to see if
> Marek or Liu popped up..

I don't see anything which would resemble power domains like on 
MX8MM/N/P on the MQ MXSFB, there are such domains for the VPU and DCSS, 
but not MXSFB. So

Reviewed-by: Marek Vasut <marex@denx.de>
