Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8587FDD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjK2Qnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2Qnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:43:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBA98
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:43:48 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a00c200782dso1002763366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701276227; x=1701881027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhyqDd+TZmzHAtUttgWk2RDaNO0MUw32LkqeIlJYnHQ=;
        b=bAfTKZ140mDf+exZw24o0NFOybPvDFWw8bCEfcYAasVO3jOEz65MBtSGbKgai9Y+u/
         i+JpeiEQIDsiG0HCHGQuGhdWzgeaTbcNAY+nW/oP4AkQ1tEQhq3x/yY7dVqeh1kbs80T
         u2dAwZX1Wa0Fxc7V9y+nZ0RTpSwQWLyO1k7SJIrWuiUl4uzPM1L2hio4J1ZrgFqEZbrs
         k+NSVQ1YmITyWT8AKoN+caSXxii9PwvciwmXXD6lK8kH4HVxL5DqigoQLdhU768Ilyc/
         V+203KB9J+24+muBQUW6VnlIHXSrTftlwVlYsWkc4d9FN8LsJ0oPH+8y4JT+C2jMKeZT
         NYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701276227; x=1701881027;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhyqDd+TZmzHAtUttgWk2RDaNO0MUw32LkqeIlJYnHQ=;
        b=oLa8MaB1zpO1yWjRrl5zsRQePWrKykpAxImcg2oF+hqA2pw7kCUlboP4P2z0INwV35
         EugPE6H8SwXlyG3Vffz9wLJHq7uSQ6w6Jz3CwjHjmsY2h1EWVLcef/AmHineVcWL/HDU
         WJeXyjq9zTRmM9tVdq/tnWwNLq8hi614zepWZ9K/ze9FTJPmbWf0RtAqh3TbqsoJRKeu
         wZwjpZz5bonzQjqGPC99gSQTxt7eAEqGGXJ6ljrj6FVkWoqLPysMFg/Cl32l5No9bgmP
         B/BZxARNaMEbIPbyWkyIfJGQZyJheje+rmOQA9pV94G9fFyFo3rZCUcTC9Sp22D2L71y
         l9xA==
X-Gm-Message-State: AOJu0Yx1Ivea+jJsVXPfph1Eote4SuotzWv+ZP0PJ8pvdByBCvPtHW6d
        CEB3dX4qx3rTx+tRsY33mfHxww==
X-Google-Smtp-Source: AGHT+IEP0pjc9mf5L7DI+73M//a6q3e4H0pxj2ine3WXBbq/sfzrTNXMneYwfcfndoJoaJZ95SKbKg==
X-Received: by 2002:a17:907:b011:b0:9bd:bbc1:1c5f with SMTP id fu17-20020a170907b01100b009bdbbc11c5fmr10675401ejc.35.1701276226805;
        Wed, 29 Nov 2023 08:43:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id d14-20020a1709067f0e00b009fcf829d84csm8013100ejr.169.2023.11.29.08.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 08:43:46 -0800 (PST)
Message-ID: <ab0fc6e0-a358-42e7-92e5-77ceea53a546@linaro.org>
Date:   Wed, 29 Nov 2023 17:43:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: qcom: allow multi-link on newer devices
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>
References: <20231128150049.412236-1-krzysztof.kozlowski@linaro.org>
 <e43db38a-206d-4ea5-8813-23e1f918dd65@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e43db38a-206d-4ea5-8813-23e1f918dd65@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 16:35, Pierre-Louis Bossart wrote:
>>  static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
>>  						    struct sdw_msg *msg)
>>  {
>> @@ -1078,6 +1090,7 @@ static const struct sdw_master_port_ops qcom_swrm_port_ops = {
>>  };
>>  
>>  static const struct sdw_master_ops qcom_swrm_ops = {
>> +	.read_prop = qcom_swrm_read_prop,
> 
> nit-pick: read_prop() literally means "read platform properties".
> 
> The functionality implemented in this callback looks more like an
> initialization done in a probe, no?

Yes, but multi_link is being set by sdw_bus_master_add() just before
calling read_prop(). It looks a bit odd, because "bus" comes from the
caller and is probably zero-ed already. Therefore I assumed the code did
it on purpose - ignored multi_link set before sdw_bus_master_add(),

> 
>>  	.xfer_msg = qcom_swrm_xfer_msg,
>>  	.pre_bank_switch = qcom_swrm_pre_bank_switch,
>>  	.post_bank_switch = qcom_swrm_post_bank_switch,
>> @@ -1196,6 +1209,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
>>  
>>  	mutex_lock(&ctrl->port_lock);
>>  	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> 
> just realizing this now, are you sure the 'port_lock' is the proper
> means to protecting the stream->master_list? I don't see this used
> anywhere else in stream.c. I think you need to use bus_lock.

This is from ctrl, internal driver structure:

struct qcom_swrm_ctrl *ctrl


Best regards,
Krzysztof

