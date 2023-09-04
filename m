Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB956791AD8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353245AbjIDPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350339AbjIDPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:45:40 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8B2CCC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 08:45:36 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9338e4695so23950861fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 08:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693842335; x=1694447135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0+GlJFHzb1D3XDHeV2FI4PvbcaPkKqun8UbiQUvz0aQ=;
        b=AWKkcQ2tCv94z9lX690R+4n/bjXTUHTYZtGAGckSOHDps/9FPcg2E5/g7KXHfhXSzw
         xlqsluIGHcge/VuN1/eQ/ya0oXH63Wb9Qa2s2DSdFZioEX+srYwgloNO1yCIDIIWm0Z3
         pb/ZFkBv0vRqAYFhRCld1nX9AMBwN4zlWLlPuel1Z0/HTDqSaxNfECc7GEh6UUSZLBSp
         PPlcCQCRaaUjY0dmO2an8XXdJNiZX0nX7/rW3ssUbK00IRTYickynhchd3/275kZ2uyl
         VpDbuSOveXllggZEuiZf5kFP/73+bZDpc+zxxfOtsjQ/t5f59bcKEtNmeZPpwkK+8KRG
         JmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693842335; x=1694447135;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0+GlJFHzb1D3XDHeV2FI4PvbcaPkKqun8UbiQUvz0aQ=;
        b=fWStPeWo0bgv+wWFLIwrjpS11Q20h63FonDzklWs4VhK9bv8kod3Ru0y5D90V+e6LO
         1HpFSWoNFxBj51IBkNPlVA0dJ/wnM9wkVl1cd66wpVFuPS5XwNpbZuglsAAsUETcJ0qI
         LNPjOIl/NM0FFoBsKdkNO6lktE73rYqZNpUqTDO6mso/rMWuMJdGDo7PceMXiIGOGBm1
         nzdDcAqItRX/+14A04EDrcaOFvMVVvztNJfhUYmw9qQc2eEIOrs8/2nlcmd60O7wPjgP
         Q1uQ02EI3Q+uuUsNUGoY6756t3tacztXjGGKziUuW6nWSPcRKf7W8Y/R32azfx9b3Kh2
         asJQ==
X-Gm-Message-State: AOJu0YyowlWzs7dNct4MYg1Bxlq6byIQbfGmqIvpd0Slt0HLocFr6NTi
        A1s3QoJ4LX5ygDL2ofUq3uD3rA==
X-Google-Smtp-Source: AGHT+IGjTokOv/IDyhswVsXI07leRAlQxYi93jO33A/nRd/LVlk/Glx/WNgORnNOdsXYPsYI1hwazw==
X-Received: by 2002:a2e:9c99:0:b0:2b6:eb5a:6504 with SMTP id x25-20020a2e9c99000000b002b6eb5a6504mr8087643lji.18.1693842335157;
        Mon, 04 Sep 2023 08:45:35 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb2d1000000b002ba161bdc9asm2181266ljz.79.2023.09.04.08.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:45:34 -0700 (PDT)
Message-ID: <c078ba24-df68-49f9-b38b-0ccbff493a25@linaro.org>
Date:   Mon, 4 Sep 2023 18:45:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 07/12] soc: qcom: pmic_glink_altmode: report that
 this is a Type-C connector
Content-Language: en-GB
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Janne Grunau <j@jannau.net>, Simon Ser <contact@emersion.fr>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org
References: <20230903214150.2877023-1-dmitry.baryshkov@linaro.org>
 <20230903214150.2877023-8-dmitry.baryshkov@linaro.org>
 <skpvgxdkyciuijkv55uh4ircrrarqhdoiocqc6h5gs4dw6c2rj@zv4fwdri4mwz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <skpvgxdkyciuijkv55uh4ircrrarqhdoiocqc6h5gs4dw6c2rj@zv4fwdri4mwz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 18:43, Bjorn Andersson wrote:
> On Mon, Sep 04, 2023 at 12:41:45AM +0300, Dmitry Baryshkov wrote:
>> Set the bridge's path property to point out that this connector is
>> wrapped into the Type-C port.
>>
>> We can not really identify the exact Type-C port because it is
>> registered separately, by another driver, which is not mandatory and the
>> corresponding device is not even present on some of platforms, like
>> sc8180x or sm8350. Thus we use the shortened version of the PATH, which
>> includes just the 'typec:' part.
> 
> How would a properly resolved path look like?

On RB5 it is 'typec:port0', as the USB-C port is registered as 
/sys/class/typec/port0

> 
> As with the other patch, I'm okay with this going through the USB tree.
> 
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> 
> Regards,
> Bjorn

-- 
With best wishes
Dmitry

