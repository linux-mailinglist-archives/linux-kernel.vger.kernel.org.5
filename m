Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996DF76ACCB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjHAJVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjHAJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:21:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C021BF3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:19:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fe389d6f19so2853321e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690881578; x=1691486378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2wyUVEaj30Bob6ndcrcawnHtobOTSBQWVvuzzmSJ9c=;
        b=AlASal8VcczUs/BQH5HHGg+dferWqRm2tLl9nCXimXrs+pKrirmTugCJ1kSuVPSdNl
         X3AcjCVw5IHNDHjzM8RIS/r5Cc1OC234KeQFgynzDoyhjj3DizoeHCTBXVxevgjYHnfl
         q6Wr7LJdlAuH/fX9u5dPBGPBUy7W36wRAZujNPCh3FSHWyzbF3E6maLEkyu1ZyBbWpyR
         bvJHOdl/EMfYnY7HLfib7WzZAdf9gaSnBgXHTw+9lh6gzm7NL6rgZoMcZFDx61W9hYtM
         BduohPu/SJ4c0appPOni7kCQJexSKGh2l5BGjWg5oNRU17KTS7g9awB0goRaKO9bd1An
         5AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690881578; x=1691486378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2wyUVEaj30Bob6ndcrcawnHtobOTSBQWVvuzzmSJ9c=;
        b=RJ6JyxIXca8GwHxlRx5Kf1Bx3up3uyNPTI4ceJVYReRcRZy4pooZDLHtpyPwUoaczC
         VrT84k/1v6LZaXq650t3sL+M0/W7TcpjoPEnaXxBevbU9Ya1oFAHQijBM3L5n/L5b41a
         N6Wg68XusN9Y7Gnt3aVWsDKqT5B3JAM2qoPKtm+wBVgwYVA4kh+xODFVczTtm9q1Sk1I
         HZ6Uo1/HHOtNHCi0qGyiPkpxVchGgnONODweW/A8WxRAyIUsVbr018O+Sq7z6nctnBtG
         aeULhFjp2oqqSgAo3/ZbNBfhCSfYg69Fwab2UgMfqainpqUoVhOJtF1cvxA2Gi7kTcAG
         inMA==
X-Gm-Message-State: ABy/qLYjaCwqEJ68J/QD/ihKx4Fh5aU3oiso1XnHr7UgUYqiYOq+nAKb
        8aq3fbn4KZg1rTGxNxPsGMj749aEZP5T1FFnFhA=
X-Google-Smtp-Source: APBJJlGVEHUQph95nKoUsHyXP+yToxbZAUuXGfqliCcyoezN+3gruO2jWGxl0EA6qctUyKa+qdjGAQ==
X-Received: by 2002:a5d:6387:0:b0:317:6992:855c with SMTP id p7-20020a5d6387000000b003176992855cmr1839121wru.19.1690880776213;
        Tue, 01 Aug 2023 02:06:16 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y18-20020adff152000000b0031784ac0babsm14292584wro.28.2023.08.01.02.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 02:06:15 -0700 (PDT)
Message-ID: <44a87823-1bde-7bba-4a38-d768d2754dec@linaro.org>
Date:   Tue, 1 Aug 2023 10:06:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/3] ABI: sysfs-nvmem-cells: Expose cells through sysfs
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        John Thomson <lists@johnthomson.fastmail.com.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
 <20230717075147.43326-2-miquel.raynal@bootlin.com>
 <925d1b35-3e70-4b5d-9533-f730a652d242@app.fastmail.com>
 <20230731175152.5c2adbae@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230731175152.5c2adbae@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 31/07/2023 16:51, Miquel Raynal wrote:
> Hi John,
> 
> Srinivas, a question for you below.
> 
> lists@johnthomson.fastmail.com.au wrote on Sun, 23 Jul 2023 19:39:50
> +0000:
> 
>> Hi Miquel,
>>
>> On Mon, 17 Jul 2023, at 07:51, Miquel Raynal wrote:
>>> The binary content of nvmem devices is available to the user so in the
>>> easiest cases, finding the content of a cell is rather easy as it is
>>> just a matter of looking at a known and fixed offset. However, nvmem
>>> layouts have been recently introduced to cope with more advanced
>>> situations, where the offset and size of the cells is not known in
>>> advance or is dynamic. When using layouts, more advanced parsers are
>>> used by the kernel in order to give direct access to the content of each
>>> cell regardless of their position/size in the underlying device, but
>>> these information were not accessible to the user.
>>>
>>> By exposing the nvmem cells to the user through a dedicated cell/ folder
>>> containing one file per cell, we provide a straightforward access to
>>> useful user information without the need for re-writing a userland
>>> parser. Content of nvmem cells is usually: product names, manufacturing
>>> date, MAC addresses, etc,
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> ---
>>>   Documentation/ABI/testing/sysfs-nvmem-cells | 19 +++++++++++++++++++
>>>   1 file changed, 19 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-nvmem-cells
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-nvmem-cells
>>> b/Documentation/ABI/testing/sysfs-nvmem-cells
>>> new file mode 100644
>>> index 000000000000..b2d15a8d36e5
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-nvmem-cells
>>> @@ -0,0 +1,19 @@
>>> +What:		/sys/bus/nvmem/devices/.../cells/<cell-name>
>>> +Date:		May 2023
>>> +KernelVersion:	6.5
>>> +Contact:	Miquel Raynal <miquel.raynal@bootlin.com>
>>> +Description:
>>> +		The "cells" folder contains one file per cell exposed by
>>> +		the nvmem device. The name of the file is the cell name.
>>
>> Could we consider using a file within a folder (name defined by cell propertys) to access the cell bytes?
>> Example (pick the best path and filename):
>> /sys/bus/nvmem/devices/.../cells/<cell-name>/bytes
>>
>> That way, it is much easier to expand this at a later stage,
>> like adding an of_node link at
>> /sys/bus/nvmem/devices/.../cells/<cell-name>/of_node
>> or exposing other nvmem cell properties.
> 
> I have no strong opinion. Srinivas what do you prefer? I'm fine either
> ways. I like the simplicity of the current approach more, but it's true
> that it is more easy to make it grow if we follow John idea.

Sounds sensible to me.


> 
>> This is particularly relevant given the cell-name alone does not always
>> uniquely represent a cell on an nvmem device.
>> https://lore.kernel.org/lkml/ZLaZ7fzUSsa0Igx1@makrotopia.org/
> 
> It seems like this is gonna be fixed by suffixing @<offset> to the
> name, as anyway whatever solution we choose, it is gonna be needed.

we have to be careful here not to break the nvmem_cell_get() users.


--srini


> 
>> https://lore.kernel.org/lkml/e7173ab2-d3b2-4f75-beb8-32593b868774@www.fastmail.com/
>>
>>> +		The length of the file is the size of the cell (when
>>> +		known). The content of the file is the binary content of
>>> +		the cell (may sometimes be ASCII, likely without
>>> +		trailing character).
>>> +		Note: This file is only present if CONFIG_NVMEM_SYSFS
>>> +		is enabled.
>>> +
>>> +		Example::
>>> +
>>> +		  hexdump -C /sys/bus/nvmem/devices/1-00563/cells/product-name
>>> +		  00000000  54 4e 34 38 4d 2d 50 2d  44 4e         |TN48M-P-DN|
>>> +		  0000000a
>>> -- 
>>> 2.34.1
>>
>> Cheers,
>>
> 
> 
> Thanks,
> Miquèl
