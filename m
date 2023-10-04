Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9546D7B807A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 15:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242586AbjJDNPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 09:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbjJDNPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 09:15:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46628A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 06:15:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b27bc8b65eso360042866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696425329; x=1697030129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wM2BQu3GXs7kSU47P46x4m5YPszlj9YFexa8DKIyaQQ=;
        b=igC9Y7oVeJXCee0jvnujfeB/wRubO0Yp8zbs6DxiGxPXo2zXpFaMstWVi3BEHE6PmJ
         R/sdfzRzYbDs2M376rFbW8e+TgkvYbXYtP7zQU620PLTaHFGJKPSV9dJ3DMjhA1jAZ61
         UundCNpBrqs+vEhrnirI6pAEX36Xv8eASiWPoYO+ryH4XulItSuiuRTpfvDRPXUu9u0t
         Q1egl6vwphKSP4MtS0Wg/UqpDY6C8d7+2krfxO5TszMMTDEiogk45+nWI5hne1JXp+Uo
         PUHKmOfotlbpEnBeqxgORIeOsc4VJihd3tbon8VAdruYmBsorgOTgscNwQn0BOSXvlTK
         mWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696425329; x=1697030129;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wM2BQu3GXs7kSU47P46x4m5YPszlj9YFexa8DKIyaQQ=;
        b=ht3kBo5aw9wEtl/zK0LwfhHPayrg9EbiAmISNX4O9Ky9y5MyN1m7YagCsujl6UAQt+
         rb1IRzX0hGigardi8K/xp9Rc4S8foaG8cuNSKcMPdtKzgF4c8i3hJZm15bYIzfWIL2Ov
         1r2FN4mv42tc1ZbA52wFuxUIHhIVWVCKN6wcayPKnJalTmv8bFIWagXNC1wB3jO9KJ1D
         F2Xao8GrZoypVg+QB2V+hosyyhOc9LzaGRhJ3gyEIpd7n6SE3z9JAzDGUyl4NhSqKxOr
         BSdj5fBkcfTCR7xeD0odiQHdCiG8maRjsHYdzeeo37wJF0iwCV3e64m8L9SAuWNdsfRO
         WSbQ==
X-Gm-Message-State: AOJu0YwRcBx9kg4MG9mlY4EUqKsW+Ko/QRu2nJJF60W8/ZbEBS8pVvdk
        3p4VE0vtKWzwZOy0c/Fj/XOLcQ==
X-Google-Smtp-Source: AGHT+IE2JrmL+OuDmloItoA+vG37SFu+A5RBeGMcXmvS5vGg+fihw/PEgCfQjs4lMSSpfQWZ6MOcVQ==
X-Received: by 2002:a17:906:9a:b0:9b2:b149:b818 with SMTP id 26-20020a170906009a00b009b2b149b818mr2096123ejc.70.1696425329455;
        Wed, 04 Oct 2023 06:15:29 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id h14-20020a17090634ce00b0099b6becb107sm2808888ejb.95.2023.10.04.06.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 06:15:28 -0700 (PDT)
Message-ID: <b98594aa-faa3-4623-8f8b-35e89af51137@linaro.org>
Date:   Wed, 4 Oct 2023 15:15:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soundwire: fix initializing sysfs for same devices on
 different buses
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20231004130243.493617-1-krzysztof.kozlowski@linaro.org>
 <2023100426-purebred-cabbie-ae19@gregkh>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2023100426-purebred-cabbie-ae19@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/2023 15:11, Greg Kroah-Hartman wrote:
>>  	if (id->unique_id == SDW_IGNORED_UNIQUE_ID) {
>> -		/* name shall be sdw:link:mfg:part:class */
>> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x",
>> -			     bus->link_id, id->mfg_id, id->part_id,
>> +		/* name shall be sdw:bus:link:mfg:part:class */
>> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x",
>> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,
>>  			     id->class_id);
>>  	} else {
>> -		/* name shall be sdw:link:mfg:part:class:unique */
>> -		dev_set_name(&slave->dev, "sdw:%01x:%04x:%04x:%02x:%01x",
>> -			     bus->link_id, id->mfg_id, id->part_id,
>> +		/* name shall be sdw:bus:link:mfg:part:class:unique */
>> +		dev_set_name(&slave->dev, "sdw:%01x:%01x:%04x:%04x:%02x:%01x",
>> +			     bus->id, bus->link_id, id->mfg_id, id->part_id,
> 
> Shouldn't some documenation also be changed somewhere that describes the
> device id?


+Cc Srini,

The only reference I found is
Documentation/ABI/testing/sysfs-bus-soundwire-slave [1] and it did not
specify the format of each device name entry.

Vinod, Srini, Pierre-Louis,
Any hints from your side if we have it documented anywhere else?


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-bus-soundwire-slave?h=v6.6-rc4

Best regards,
Krzysztof
