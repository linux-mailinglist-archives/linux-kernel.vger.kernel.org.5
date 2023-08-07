Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13ED7724E2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjHGNEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjHGNEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:04:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF610FE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:04:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so7399800e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691413448; x=1692018248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8fw0ysUuRGQmdYsHgBJKqqkV1K0A5L6FDJbFcuo1480=;
        b=MJy29QYA/VD6U+CY7J3IJ5cz3bNN7TmAPbf77MJGd3kkYzf9gZadG6tHXfcbfrz3DU
         XNfpy7dt0w1j5asGH8FWu9wn4psO5TC0kAFU9OTmkLrPldK3oXwQVYcCH8QHJbz3v7VW
         kd/N8TSA3sccU7kOxYCq753ePdQCoQGY9Io7duwoBYFwyRwTPWnThIg0Z6PCMZP11DFN
         UcSz3Qw/z6rDlpS7gTGl+TyXFSxMuOBZXouH0lmGm7e3KxLD97KaWgQhb/5+8ro0SnF3
         fpH2vTaqv5KyAquLeJ59UxOFVXoj4MAyecyTJ6o3Vos3bJRmtrbGCyUfLL8NGxAFdOFm
         L7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691413448; x=1692018248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8fw0ysUuRGQmdYsHgBJKqqkV1K0A5L6FDJbFcuo1480=;
        b=WSiH/XUmoeLgWZeAPBBUQp6XBxYNB2NDnbYgbgmuE32Zhzje+H0nutGz2Sld0ebDHr
         ja2jcQWWmqGJNHIEYWOifwXpd4shCoY/G1XXC5z3rJ+oq/IoGw1346jNQkt6IYtxjxvl
         MWp5ON0KZGST8R2p6uXsIHfYHUvlrax+WhAWmQhIbq8DUbHI+e23ZIVUeOHrRTfdbl0d
         9dJGxHp1dnvfud0jgwKuGmARReh+FX/Nh8vWeX6trNZDImAjTCk4rKmrGEIalKkCYjml
         whu8A3iv86Mk1GsaK8T2aaTHQtTPSj/7d1me+nK/j6gTT9l6wUBun82XyVRjLpvxXKVl
         ybbw==
X-Gm-Message-State: AOJu0Yxkl34BDefiBo4GtV3k686z+bGcC32n/T5COAe0UqxM41VWHe+T
        B7zOLOjJpiBiQuYP2wYHG5u2VQ==
X-Google-Smtp-Source: AGHT+IFANa3hBy+WjggbiPeaU4RZbBasyq8DPreopiF5u4h3sdQbfn6LOIasEwL96ek3TlV6MRoBRg==
X-Received: by 2002:a19:f817:0:b0:4fe:590:53ca with SMTP id a23-20020a19f817000000b004fe059053camr5806148lff.4.1691413448165;
        Mon, 07 Aug 2023 06:04:08 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id b17-20020ac25631000000b004fdc6f03c6dsm1477693lff.37.2023.08.07.06.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 06:04:07 -0700 (PDT)
Message-ID: <f710487d-7f35-448d-b2e9-7f008e040607@linaro.org>
Date:   Mon, 7 Aug 2023 15:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] media: platform: venus: Add optional LLCC path
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-4-8c8bbe1983a5@linaro.org>
 <ZNDKtwO3tWNIFIhz@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZNDKtwO3tWNIFIhz@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.08.2023 12:43, Johan Hovold wrote:
> On Fri, Aug 04, 2023 at 10:09:11PM +0200, Konrad Dybcio wrote:
> 
>> @@ -479,12 +488,18 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>>  	if (ret)
>>  		goto err_cpucfg_path;
>>  
>> +	ret = icc_set_bw(core->llcc_path, 0, 0);
>> +	if (ret)
>> +		goto err_llcc_path;
>> +
>>  	ret = icc_set_bw(core->video_path, 0, 0);
>>  	if (ret)
>>  		goto err_video_path;
>>  
>>  	return ret;
>>  
>> +err_llcc_path:
>> +	icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
> 
> This looks wrong; you should not try to restore the video path bw which
> you have not yet updated here.
Oh whoops :D

> 
> Also error labels should be named after what they do, not after where
> you jump from (e.g. to avoid mistakes like the above). Perhaps you can
> clean up the existing labels before adding the new one.
Ack, I wouldn't mind giving this some cleanup.

Konrad
