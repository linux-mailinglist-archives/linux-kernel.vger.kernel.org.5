Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215DF7F5CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344815AbjKWKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjKWKuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:50:13 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9F01BD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:50:19 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507cee17b00so896370e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700736618; x=1701341418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWkmW4NrpVSDSfoG84SGLgZ1/3hG8w7uFZangWvkPCQ=;
        b=yBd1Ynw7VhE6BoscfnqgPUcsyWcSS1MGggztCRSHN4BDt9mtzyE/oJOr9JW8AGGDHb
         26wV1xUDxi5Nkk7Q4fkIVXx0P7FIhiHymPpnXLIQvWQSGi9Pu7R9hpw7Cv+Jz+XCQfDJ
         eIGk8mjFAJ3FTmA1uGOkz/G0xC4gjfTeh0Nz304M/YchTU866VC8n1n4kxpKIFXU1j1z
         Ct+Y1Uc9cUvBkb8vzubL5n03DJJoIrySStIs0wh2lt5gLYl/yZkKfknCUacTSUXBsZCt
         cboxKgmKR1LlOHqIjuOmX2KsIrfHtdx8b+HO94uGopq8ajsAg0JbceCpQcwlTsCX25YK
         eKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700736618; x=1701341418;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWkmW4NrpVSDSfoG84SGLgZ1/3hG8w7uFZangWvkPCQ=;
        b=A1Ly4+xm/bKuxGW/FkgPgsUQ9smnN3700ZRGABDZTZeMwW5wXbmWIMr0oXhlVpQx8q
         RpA0G4uPM5QxzIpKajPaemXOSJSYIeSUwCh3QdWT2u36nWb6h1DiK7E6/4V/84ikPC22
         ypT6JLc+rlXnB2XaH0wbachSmMOGHefYHVaWX9dDOtR10ccE8GwAfgxUhQgpRpkqRE17
         /3JR+dYzVYLfD9DcQKI+zEYwswZQnupb/Kgd0ZmOoS+ALKuqcHCCU5G71tHqRKAMmmwr
         aLMxwjNOl58XSJ7hGSIy6wFktTqs112xjSiC+wLghz4n2OvQ1jD3TOTDP8ixkTsi3Cr9
         f6qg==
X-Gm-Message-State: AOJu0YzT0kPc7UpdVC/KtDbkZoHd8LhlUF/HEjTRRVlTqR9YTs0U3H1V
        4H1rAa6SSEmfwNPBNosOHRB+hQ==
X-Google-Smtp-Source: AGHT+IHs5fP4IJLm3ak/VIWnkrN0Owt9/emtxBJyhldyhhI3EgXhn0P5nCSx7knmRJy61a6y/XgPFA==
X-Received: by 2002:a19:3814:0:b0:509:8e81:1aa4 with SMTP id f20-20020a193814000000b005098e811aa4mr2882944lfa.39.1700736617662;
        Thu, 23 Nov 2023 02:50:17 -0800 (PST)
Received: from [192.168.86.103] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j27-20020a170906255b00b009e5db336137sm619208ejb.196.2023.11.23.02.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:50:17 -0800 (PST)
Message-ID: <9c5b1503-4dba-4ac1-8fef-9b28fb8bd4b5@linaro.org>
Date:   Thu, 23 Nov 2023 10:50:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] soundwire: introduce controller ID
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/10/2023 17:09, Pierre-Louis Bossart wrote:
> This patchset is an alternate proposal to the solution suggested in
> [1], which breaks Intel machine drivers.
> 
> The only difference is to use a known controller ID instead of an IDA,
> which wouldn't work with the hard-coded device name.
> 
> This patchset was tested on Intel and AMD platforms, testing on
> Qualcomm platforms is required - hence the RFC status.
> 
> [1] https://lore.kernel.org/alsa-devel/20231004130243.493617-1-krzysztof.kozlowski@linaro.org/

Tested on X13s.

Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
> 
> Krzysztof Kozlowski (1):
>    soundwire: fix initializing sysfs for same devices on different buses
> 
> Pierre-Louis Bossart (1):
>    soundwire: bus: introduce controller_id
> 
>   drivers/soundwire/amd_manager.c     |  8 ++++++++
>   drivers/soundwire/bus.c             |  4 ++++
>   drivers/soundwire/debugfs.c         |  2 +-
>   drivers/soundwire/intel_auxdevice.c |  3 +++
>   drivers/soundwire/master.c          |  2 +-
>   drivers/soundwire/qcom.c            |  3 +++
>   drivers/soundwire/slave.c           | 12 ++++++------
>   include/linux/soundwire/sdw.h       |  4 +++-
>   sound/soc/intel/boards/sof_sdw.c    |  4 ++--
>   9 files changed, 31 insertions(+), 11 deletions(-)
> 
