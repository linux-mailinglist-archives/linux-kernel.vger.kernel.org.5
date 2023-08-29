Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E523A78C3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjH2MMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjH2MMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D2CC2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:12:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c1f6f3884so538074666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693311126; x=1693915926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YU0TgtgqGRI7aogtHMMS82d8XPhgiPSDYvCWsBaYb8E=;
        b=u3NzReOWIrSVsVGcLj95PYv0wHugzS4cWhzd8tYE4C/6YpR0d/qZ6I9X/ZMJuIF5DT
         ObluULl4DZgK4rtRz5aEI20mGbFdJIiRHSpBSR+ysbexBofNWUlBK/6mwLCLrPv7aZbv
         LboH49Jhy2vppmobZpnyqgZVM4dFm5Pk6oQGgohOOnC8SQXjWOB3+N82mCpPYV15ZkBA
         TCmAR2nzsYSf1pQCr1TQHlexbXiFLaBxcF/M6XGdqDkUEOemi5xRojjHx1d9uu7Khldg
         V2lEVn5h+AY8tr7X7QfSTDTX0l0NqmQvQDSqkl4huUeTWS8mkpQrLEFBbiQybJLslXxq
         zS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311126; x=1693915926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU0TgtgqGRI7aogtHMMS82d8XPhgiPSDYvCWsBaYb8E=;
        b=F6t2AH49CKJGnOXSMffRDHQmrwziHrYFkYmfOWKHCSgSERgyaAUdr8t69oH38EgfLi
         zolM8YesU14O2ZMw6kAGZUiL1Fu+6EvXxHpa37ABwj3TiUD/S4DI9VPRhlJ4B4Utv29/
         VA9qyjqik0jBccklIZBjfLpEPTrMqnev+BwShF0j5vcsYg+cno/frNM/sM+6AqZbNk2c
         v1I9f8jtTOiY8pz/Y48WAB7e9GP5PGCIeAsu9Hqe/caWoMRFe0rbe6O91woG6Sqc/Da1
         umAC3GUNRds/tA4oAZsL1Qn8cgmFM/PLagYn3ALyioTUKvFPl7nEQBix2+pXp7AO3AOh
         YT1A==
X-Gm-Message-State: AOJu0YxMPg69Uy19j1wkHhS5cU/F/h/a30lQ06DYsPPQTBzysEEq6+PC
        iyoWAc2CdvzjH/6emI3sfFz26Q==
X-Google-Smtp-Source: AGHT+IFkCQd5YP7WCScx+v1S4J7nWV+UZatclsJdqHef20eQO7yaVhTAjQHNUtJQDli0x7k1jIeUWw==
X-Received: by 2002:a17:906:ae81:b0:99d:f47b:854c with SMTP id md1-20020a170906ae8100b0099df47b854cmr19320610ejb.72.1693311126069;
        Tue, 29 Aug 2023 05:12:06 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b009929ab17be0sm5871834eju.162.2023.08.29.05.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 05:12:05 -0700 (PDT)
Message-ID: <fb2abd03-7393-0d41-8b8e-8fe8dade0923@linaro.org>
Date:   Tue, 29 Aug 2023 14:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v10 0/4] PCI: qcom: ep: Add basic interconnect support
Content-Language: en-US
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com
References: <1689751218-24492-1-git-send-email-quic_krichai@quicinc.com>
 <20230728025648.GC4433@thinkpad>
 <b7f5d32f-6f1a-d584-4cdd-4c5faf08a72e@quicinc.com>
 <73700e92-2308-3fe0-51b1-c2373be2893e@linaro.org>
 <a0fc7f8b-dfb1-f5f8-40f2-43a4f13944ae@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a0fc7f8b-dfb1-f5f8-40f2-43a4f13944ae@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/2023 14:10, Krishna Chaitanya Chundru wrote:
>>>> Krzysztof, can this series be merged for 6.6? Bjorn A will pick the dts patches.
>>>>
>>>> - Mani
>>> A Gentle ping
>>>
>> Whom do you ping and why me? If you choose not to use
>> scripts/get_maintainers.pl, it's your right, but then you might get
>> maintainers wrong and no surprise patches got not accepted...
>>
>> Plus, it's merge window, so why pinging now?
>>
>> Best regards,
>> Krzysztof
> 
> Krzyszto,
> 
> The series is already reviewed and there are some patches which is 
> reviewed by you also.
> 
> I am using this command to send patches it looks like this script is 
> fetching based upon the source file where there was change due to that 
> only I was seeing the problem of all patches are not going to all the 
> maintainers.
> 
>   --cc-cmd=scripts/get_maintainer.pl ./patch-series
> 
> I was trying to install b4 and make sure to send all patches to all the 
> maintainers next time on wards.

This looks good.

> 
> we pinged it now so that as this is already reviewed and no comments on 
> this series so that this can picked up.

And what is has anything to do with me? You got everything needed from
me, don't you?

Anyway, do not ping during merge window.


Best regards,
Krzysztof

