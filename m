Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8868A7C4D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 10:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjJKI10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 04:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJKI1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 04:27:25 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F3C93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:27:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405524e6769so3942055e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 01:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697012842; x=1697617642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0w+hcGKEi3xrBWLyTiiDJpolO60Wub3ov86WnEvSRg=;
        b=lVF2DFh//U6ummRk/GWNWtxVTxgy8XSXgWVHMSDa+hiNqFO9/kxnOCRJb0cngtMvtV
         oBfYhirmATlw9i0RkYD/ouD+jHg+A2CbcT/gN0tEByM61mg+Clpi2TQw+D6hdu7Pe972
         clB8vAWzJCcHMV/T1Ot0cHlTtsFUOKiHpDmLN7tcfHRXDN8txJOG6r4gzkP87GqfxGiK
         8c2qIznqRS+YwmSMvwsAOioBfx5ol3gdnEvOhgDgNWWzofCEKxzWbnA7EqAnm1umNs7H
         P13Hv2IY877FoEw4GRldfnZGh7hM5mX2tZCGncwf/9fomcsENGyjC1zsCs0WHOhahsTl
         KA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697012842; x=1697617642;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0w+hcGKEi3xrBWLyTiiDJpolO60Wub3ov86WnEvSRg=;
        b=qA22CHJOKmbW38wce8WAs7iYE/lJcstSvF4GKqGyvMtB6BuhxXSui3Zaqcw8ZJI6V5
         pT1TL6KyW0es96t9AzjaXxD4QJQQykDli7QxAXAfQW7f6YrGA/ReXlkcqElb2TRHRisp
         Bo5uGS8BHnfzrzXApolGqW0Utyl8XCI7wVoGzWBHfuUIUipoyU8MKhr8Mc/6QbzQdUkA
         1yMhhqr4M6vsTLC7VV9wOsiqljMaom3Ykx244QBBIsUS8zFjfwiiuSbP9pddkiNKR4Ec
         UWFwJxbMhfInEPnEZ0h09gsQD7/qJIlOYdjqS4FBxgZiQ5e3w/G6CW+qlo8I+y9ElfTQ
         NzJQ==
X-Gm-Message-State: AOJu0Yz4RqUwF8qT012EuDLg17jvVoZZU/oNel6rkwdxIqN8EOm1gX+i
        iN0GfThJErUWri8AvI784v3AJw==
X-Google-Smtp-Source: AGHT+IHysVefmRPMThmSbNHWbJ+BZXdyfYcnlxM0wzFYsPTjEDbT4yn2fgFIfIoKYkP4KTazm9TWQw==
X-Received: by 2002:a05:600c:1c21:b0:407:4701:f9e with SMTP id j33-20020a05600c1c2100b0040747010f9emr8023851wms.17.1697012841838;
        Wed, 11 Oct 2023 01:27:21 -0700 (PDT)
Received: from [192.168.86.24] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 4-20020a05600c228400b003fee53feab5sm16143262wmf.10.2023.10.11.01.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 01:27:21 -0700 (PDT)
Message-ID: <548849a8-9f11-5274-778e-f291267603bb@linaro.org>
Date:   Wed, 11 Oct 2023 09:27:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v12 7/7] nvmem: core: Expose cells through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Marko <robert.marko@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
References: <20231005155907.2701706-1-miquel.raynal@bootlin.com>
 <20231005155907.2701706-8-miquel.raynal@bootlin.com>
 <318fe799-f53e-64ed-b631-d099bb5202f4@linaro.org>
 <20231011091524.0c9ecc55@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231011091524.0c9ecc55@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/10/2023 08:15, Miquel Raynal wrote:
>>> +
>>> +	nvmem_cells_group.bin_attrs = cells_attrs;
>>> +
>>> +	ret = devm_device_add_groups(&nvmem->dev, nvmem_cells_groups);
>>> +	if (ret)
>>> +		goto unlock_mutex;
>> This is going to create groups after the nvmem device is added, isn't this going to be problem with user space notifications?
> Greg said it was not. I hope I understood correctly 😄
> 
> And anyway, cells have never been available to userspace, so there is
> nothing userspace might expect yet?
I agree, but once we add sysfs uapi then this is going to change.

--srini


> 
> Thanks,
> Miquèl
