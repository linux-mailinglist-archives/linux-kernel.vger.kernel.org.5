Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8177092D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjHDToQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHDToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:44:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27AC3E7;
        Fri,  4 Aug 2023 12:44:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so528864266b.0;
        Fri, 04 Aug 2023 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691178251; x=1691783051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7d+J7JLjtlPoezgQvcsKrQ7M26pTKCKXnoUr1qqP+rY=;
        b=DiKwQ9bxDEXhhW6WL1b64KlpieL6VSEHdJq1P/G4DTYj0jKDtjx4fEEEWW/zCyFIml
         UBRU2Mv6DCC5y5pT3b70ajDTof7Dg6rM40H5+UJbCrYahIoe1vDp+M12D3lD5QOFjR+X
         b/syJ9v3q8RNaLyFedAMnTdi8M+MDcRVWLwa0/jwWHgcdrlyKcceH0X1yx8QYG5JfCd4
         M1cXNP4jOz4HrmDL/aM3esJ2TkDLTP0gog9W1WJGvysaTB4ftWNnbuRBwZImPsIDImpW
         SK9uag+qh5EjSxJpxGgsO0AX+RgKERIzpkGzKLnVazKduwksQpBBQEQLjjf9jcb7RWAn
         WBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691178251; x=1691783051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7d+J7JLjtlPoezgQvcsKrQ7M26pTKCKXnoUr1qqP+rY=;
        b=N3ZJOWEo9DvT57P1gw80EhfD2EH9yBrKb3xzGvuFCDcdXi+hHUGBonVxaAQE+wyVmS
         nKpccT4AsXmyMRfewytu+xkm0zIZeC1mhej0NO8q3nQKaZXtWDX/UgKu5icpAdKCulpf
         LBUrmreQBy6/QjmzMu+wgHELcBtSKV9dDETdKdfG4DqQZHz6JMeHsn4KD0TVZJ1JMWcJ
         3VJ1IDA9hzrYGpraqQjyI67gYIm0Jjudo4S0/z1lv6/ZXQE6cSQBGNls9OD23hzHB22u
         qmqF4akw5Yv0E6Sictt0NXSCDpd2Z64yCJvheuCOcNhRoIywf6Qch/IYq+zW1Le/PUqt
         AlYw==
X-Gm-Message-State: AOJu0Yw5b/uTQW5lVxtY/ncVPnCzlc5P4+KPGpi21WdQ20qsjyrYX8tD
        MSGmii0R6Z/++i4QycDPreT7ecx//Ag=
X-Google-Smtp-Source: AGHT+IGmVeIt9TUSVexi1m88V64aOZm+P0u2XcqQjoJ7UYCl+41w2rOfcpsRlQvhuS8oXs9cJq4S4A==
X-Received: by 2002:a17:907:3e8f:b0:99c:728:c655 with SMTP id hs15-20020a1709073e8f00b0099c0728c655mr764896ejc.2.1691178251423;
        Fri, 04 Aug 2023 12:44:11 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id bj10-20020a170906b04a00b0099bd6026f45sm1710205ejb.198.2023.08.04.12.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 12:44:10 -0700 (PDT)
Message-ID: <63f0f3b0-0fb2-afad-710f-fccadfb52a42@gmail.com>
Date:   Fri, 4 Aug 2023 21:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230730161906.606163-1-luzmaximilian@gmail.com>
 <20230730161906.606163-4-luzmaximilian@gmail.com>
 <ZM0tO1K4yuBdK6pa@hovoldconsulting.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <ZM0tO1K4yuBdK6pa@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 18:54, Johan Hovold wrote:
> On Sun, Jul 30, 2023 at 06:19:04PM +0200, Maximilian Luz wrote:
>   
>> +config QCOM_QSEECOM_UEFISECAPP
>> +	bool "Qualcomm SEE UEFI Secure App client driver"
>> +	depends on QCOM_SCM
> 
> No need for this one.

Oh right, forgot to remove that.

>> +	depends on QCOM_QSEECOM
>> +	depends on EFI
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Thanks!

Regards
Max
