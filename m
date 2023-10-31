Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1557DCBF9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJaLjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjJaLjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:39:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F397;
        Tue, 31 Oct 2023 04:39:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507bd644a96so8020792e87.3;
        Tue, 31 Oct 2023 04:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698752377; x=1699357177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JpvaywPQcScYU3CWlECXIqGt+NokSx/RNLM7YM3gDd8=;
        b=jlERvauaOxea/pbESdstcJOIPr1B3jW0TGiU1X+zotnZS0v3k8Ml2s0HG8R9wWG9qj
         HGbrFyiXYqb59XqdtZiX+H+xT9yu2O5DW7rQtDgFbKKehNlNyCjSbwNSVO1AzsLXFr0R
         9C1R4i0gez1rCDclVz6Dn5QWfcK/Tzi737QRMHLamDkuVGB1HdcWCWwkqU31LpFuxKtX
         LfyxD1c0+xOuGQwpKJe5u3aiOvfIqtGC0uXD2TOfA5q6WTjQcBeTQaFD3aShpXLo/Mat
         6xEvGM6JF8i0Pe6yZyklf4WpprZLtzIarLhNqBG7EVJ5lRLYgbOMGuDWExB1w/GquWWF
         qiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752377; x=1699357177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpvaywPQcScYU3CWlECXIqGt+NokSx/RNLM7YM3gDd8=;
        b=kxkwPqxyAw9TpM7bn6PkOh8hUv0QTtFN0N1sxG5UMHyEVQ6Qeqj5HTdMcU1SDjCskl
         4bUaZ7ib4GM2FkF2sxDtbjZ7BTL8VRIGLCVh3JqSKk+aqZLpCtf3XsoOTSoIQqd8VABJ
         eqv4Pa5AcJI5+GvG44W8dAn15+1mxFl88TCGtbp36twDYGga55HU5hKkSMykmTWj/np8
         6tvxDls2R1wExIDViAkVOC5xyj8Z8M4qWuLOpXt/GuVYL+aMJL3TlVi619T4uDBmEWoO
         3LV0EPryZp+bZFoO3YNOMTQFv4abz+mCrpB7pcVC48Rn7j/LHtOJOTTQr34e26CJC9n9
         bG3w==
X-Gm-Message-State: AOJu0Yy+sE4Sgo4czk2qK8TczbH0rcrhljNSAQ5aWR57kYcWB33vtk4V
        VOP4+rSziucF3R81KPIBNf4=
X-Google-Smtp-Source: AGHT+IFoJ4xLZ2QU+Hc/BsrNDWd5uyInpcY7BOXW+0s3SsnRn5FzPJ3pVa1bukPcvChA+DgGxsrG7A==
X-Received: by 2002:a19:ae08:0:b0:507:a58d:24ba with SMTP id f8-20020a19ae08000000b00507a58d24bamr9004591lfc.63.1698752376872;
        Tue, 31 Oct 2023 04:39:36 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id o6-20020a056512050600b00507f0d2b32bsm185652lfb.249.2023.10.31.04.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 04:39:36 -0700 (PDT)
Message-ID: <16443f7b-846c-4133-8d73-22a847a4f4aa@gmail.com>
Date:   Tue, 31 Oct 2023 13:39:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Content-Language: en-US, en-GB
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
 <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 12:38, Andy Shevchenko wrote:
> On Tue, Oct 31, 2023 at 09:11:37AM +0200, Matti Vaittinen wrote:
>> On 10/30/23 12:21, Matti Vaittinen wrote:
>>> On 10/29/23 17:51, Matti Vaittinen wrote:
>>>> On 10/28/23 18:20, Jonathan Cameron wrote:
> 
> ...
> 
>> 	tmp = gts->max_scale;
>>
>> 	rem = do_div(tmp, total_gain);
>> 	if (total_gain > 1 && rem >= total_gain / 2)
>> 		tmp += 1ULL;
> 
> ...which is NIH DIV_ROUND_CLOSEST_ULL()

Thanks for the hint Andy. I do very much prefer using stuff like the 
DIV_ROUND_CLOSEST_ULL().

I will use this - do you have other suggestions for me, especially 
regarding the division u64 / u64?

I would appreciate if you found the time and energy to look at:
https://lore.kernel.org/all/ZUDN9n8iXoNwzifQ@dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi/ 

as well. I feel like I am doing something someone else has already done. 
(Yes, DIV_ROUND_CLOSEST_ULL() can be used there too).

Anyways, Thanks for this!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

