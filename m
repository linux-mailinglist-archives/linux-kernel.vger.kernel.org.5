Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF278E115
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjH3VAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240702AbjH3VAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:00:22 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418B6CF0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:59:47 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-500a8b2b73eso440725e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693428807; x=1694033607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Azrcvh3Xm9QAv3KS+sbhE3nUaOx631s9JxOEhZkx68I=;
        b=VwHzP/1Cp7K+CBgoIz6oFaBhTIHsLTRrp2hgrzRq1FE2O7lmrR5FNWtjgNFEixM2Ad
         ELW51hCJjlPt5B9xltioVbio29b1JLY9dXa6lqjlwmMfYenyNL+HQCiHn6R+nq2JJ2qF
         lLdPRTfZtBVeUobRdL9F8gYyucUy+//VXCQFs3PBH8tXdqTTRcbeh/4R1ho/0QpFJp0k
         B06EBZXLpqB6v7hTbrvQUsA1MWa+j7sCufJoBXPU9PNfkFDZ1sYSFIucB1JVspOf2yjS
         Jt72IX1S7iHv75I9ZsCywKpjV7AxRAihiVIpVBxWaxwh9h+SfNUho77wWwBqsxL//3hy
         TXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428807; x=1694033607;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Azrcvh3Xm9QAv3KS+sbhE3nUaOx631s9JxOEhZkx68I=;
        b=NLHbyfT2J4rFhoTEue8MEUIov3BWeqyg93f77YKqRUFyz302c0hCasf7aTwkXFQQeg
         RJuXkf7rmfRT3ZUtxOHmbEykeFdM71FV+leL2X13/4ByYlob1mIUnL7bUAhX0BmZVUsm
         ZM0WMMmXZRtGnWPu45wp1IlpJHvffnf1QfRkuf1Ll56Z68PInFqfCUzZUPVxgCzxmy4U
         ot25o5iQLEYycFvxBbAto0dCidCmu4pz3KO99/rGUw+XM/WomXfFCCKbxOPEq1iTXVd0
         hiBcwUZfe6vZKAt+J5Cqe7SRGnKfwDaZJ1guSr2lENSn5wOAyxcCm/FzaLb+glAXELjx
         olKg==
X-Gm-Message-State: AOJu0Yxpr8rBqt5CpqaQDXp/gayiQ4BPHv/5Wtk60/fHn3EF7Hx/AKzK
        NiDxoO6ZEZkLX3UKQsbhdlPU58uOQNJBZe3i
X-Google-Smtp-Source: AGHT+IEHUORUn3WLSciL0S67Vpjv08aQSyPEMwLH9cCFScAo9T0V0zqytkD+TwxL/5lwnVRUg1fjFQ==
X-Received: by 2002:a17:907:2cd4:b0:9a2:232f:6f85 with SMTP id hg20-20020a1709072cd400b009a2232f6f85mr2670691ejc.52.1693428065320;
        Wed, 30 Aug 2023 13:41:05 -0700 (PDT)
Received: from ?IPV6:2a02:908:8b3:1840:e50d:f71d:495d:402d? ([2a02:908:8b3:1840:e50d:f71d:495d:402d])
        by smtp.gmail.com with ESMTPSA id i27-20020a1709063c5b00b009928b4e3b9fsm7558138ejg.114.2023.08.30.13.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 13:41:04 -0700 (PDT)
Message-ID: <b5f84da6-8826-69d3-6617-6d2593a54897@gmail.com>
Date:   Wed, 30 Aug 2023 22:41:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Maxim Schwalm <maxim.schwalm@gmail.com>
Subject: Re: [PATCH v3 00/12] drm/bridge: tc358768: Fixes and timings
 improvements
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Thierry Reding <treding@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
References: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
 <6ecafdd1-e60a-afe6-ea2f-adab168d22fe@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <6ecafdd1-e60a-afe6-ea2f-adab168d22fe@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On 29.08.23 08:27, Tomi Valkeinen wrote:
> Hi Maxim,
> 
> On 22/08/2023 19:19, Tomi Valkeinen wrote:
>> This series contains various fixes and cleanups for TC358768. The target
>> of this work is to get TC358768 working on Toradex's AM62 based board,
>> which has the following display pipeline:
>>
>> AM62 DPI -> TC358768 -> LT8912B -> HDMI connector
>>
>> The main thing the series does is to improve the DSI HSW, HFP and VSDly
>> calculations.
>>
>>   Tomi
> 
> Does this version work for you? Can I add your tested-by?

Yes, this series does work fine on the Asus TF700T, so:

Tested-by: Maxim Schwalm <maxim.schwalm@gmail.com> # Asus TF700T

Aside from the TF700T, I have a different kind of tablet, which also has
a TC358768/TC358778 bridge, but it's not running a mainline kernel yet.
So, unfortunately, I can't tell how this patchset fares on it at this
time.

Best regards,
Maxim
