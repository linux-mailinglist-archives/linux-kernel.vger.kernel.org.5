Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D5E77701E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 08:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjHJGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjHJGMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 02:12:55 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2F626BD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:12:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe1d9a8ec6so9155165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 23:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691647964; x=1692252764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gIUNorVMN1a5Kjk18rDX2dlY8vZOfHJwA9074Dh4RkA=;
        b=Iz7K98AK6RA6reuG2y36cdi9LQOAqe70GN7oaLr/RWyqH7xWTUj9vSDSOgAEwOZMvM
         zUT0ncvm+ea/rYaWIsXWEVE+4MMTNmdjCvzKt43O6rJvmNui61Npf7UGBU0hsHm4gknk
         LFZzHM+ySAy0Yc8H85xeGMRxM6ts9DBkx+jJ1prvfnSTK5k/ofp+lvZh661lhbLyPL2i
         IRaetO0DfyPGLK1+Z5PLuSTewHy4I4mx4qAOvmzF7lvuro7ao5HEmv1Sc7kq85vahp5Y
         UboaVnSuemveXgSFrgMqq78hS8vdsI5t6M1rb7BjnlX0qHTfeklWj00DZTmfLNHdHaHs
         BN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691647964; x=1692252764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIUNorVMN1a5Kjk18rDX2dlY8vZOfHJwA9074Dh4RkA=;
        b=Te9bnnur8WgGlS0E5C/RifCOfAxQNlQY4YB+zQiXinXbqWrE2XP1XG0hUOR/fk5abx
         dG6y4T5dwktio35yl4KD9zl++II3Go3UxGHrsK+8/Ok7jWScCkU7a5t7WZXrqXQP0vBW
         2GALSvAHvkmctOC1Mh8dniRIlIjoPfIdI4LZzO2G3CZ+y0eE5oyFgnhOfgtoKbFy5tPq
         6Q2/o0I6e19zapFiZrVRYwM7qj3JJhCUMZlfNFtjTZF9IewMdqfnUJB50HoLaIHVQir6
         VttPp6yr/qzO1X/kQ7qanF8pDpDzay9kDJe9D697sq1gHmBnqY7mQaqLae4i9qWo2v+E
         bpYA==
X-Gm-Message-State: AOJu0YzSJnd4UcbnN3YP2AXSTDJNffRSMLmVsMlKygWFBUPQFJV9b9gK
        H8kKLpP73/KUpjANLE116kgBVg==
X-Google-Smtp-Source: AGHT+IGJhqHGTHepD56LNgHXHfifxm3sVB1HuAJ1GydORfbnVv7dNMtrxIC1AtXlKVZv95v+qm+bSQ==
X-Received: by 2002:a5d:658f:0:b0:313:f38d:555f with SMTP id q15-20020a5d658f000000b00313f38d555fmr631890wru.24.1691647964791;
        Wed, 09 Aug 2023 23:12:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b003176c6e87b1sm954397wrm.81.2023.08.09.23.12.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 23:12:44 -0700 (PDT)
Message-ID: <3f406442-d46e-7f9e-426d-22a96f893103@linaro.org>
Date:   Thu, 10 Aug 2023 08:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Content-Language: en-US
To:     James Ogletree <James.Ogletree@cirrus.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jean Delvare <jdelvare@suse.de>,
        Jeff LaBundy <jeff@labundy.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Eddie James <eajames@linux.ibm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Jerome Neanne <jneanne@baylibre.com>,
        "patches@cirrus.com" <patches@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230808172511.665787-1-james.ogletree@cirrus.com>
 <20230808172511.665787-2-james.ogletree@cirrus.com>
 <065fbe51-928c-4728-efc2-bde87cd48cb3@linaro.org>
 <ADCCD2C5-B79B-4C50-B3CE-007B1FBF5A5E@cirrus.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ADCCD2C5-B79B-4C50-B3CE-007B1FBF5A5E@cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 20:02, James Ogletree wrote:
>>> + if (cs40l50->vibe_workqueue) {
>>> + flush_workqueue(cs40l50->vibe_workqueue);
>>> + destroy_workqueue(cs40l50->vibe_workqueue);
>>> + }
>>> +
>>> + gpiod_set_value_cansleep(cs40l50->reset_gpio, 1);
>>> + regulator_bulk_disable(ARRAY_SIZE(cs40l50_supplies), cs40l50_supplies);
>>> +
>>> + return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(cs40l50_remove);
>>> +
>>> +MODULE_DESCRIPTION("CS40L50 Advanced Haptic Driver");
>>> +MODULE_AUTHOR("James Ogletree, Cirrus Logic Inc. <james.ogletree@cirrus.com>");
>>> +MODULE_LICENSE("GPL");
>>
>> I don't think this is a module.
> 
> It can be compiled as a module with CONFIG_INPUT_CS40L50=m. However, there is a
> typo in the Kconfig entry description: the module will be called “cs40l50” not “cs40l50-core”.
> That will be fixed. 

Really, *this* unit file can be compiled as module? Where is the
module_xxx_driver() then?

Best regards,
Krzysztof

