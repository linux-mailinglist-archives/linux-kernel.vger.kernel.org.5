Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D39F7CF5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjJSKuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjJSKuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:50:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568F121
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:50:19 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca052ec63bso54015835ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1697712618; x=1698317418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+23JhXChJ2upiI1yweoZc95DCKyTZufxmMJiUGUuS4=;
        b=FyMqDZwRb+QEk92GcepdsEvKfOmyKRHRB3D1MaTgocUSqfGef/GfErWJXR7t3zOndR
         zOdICYYevKX7yHX3w0aWoGU3SPcC8tyofNq0f2Dcd72l5XnLgdHdMTRmIMFHxGoqbU47
         gCu6IGzqBG/8y4fXFeo8/f8K8RnyKk/e9orHe16wmFrM2+UKmpiufti/bv73hFbrWRHb
         fx4dKUVkjP+QY5OxBer1h3DDuB1T/Sy/h/iW4LFsBNt4vDS1fklk/B1fJ5+39U18ItZ2
         p4jhVPUUoMz2jp9y6notl3kSdBk/tGhfRQ1a/z4AHTb9ZjIqDrb/gqfnWb+3MroMlSie
         wgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697712618; x=1698317418;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+23JhXChJ2upiI1yweoZc95DCKyTZufxmMJiUGUuS4=;
        b=lsW/s276edHZ0FWSoZk6DGNMV62tM7YSCWZdC/BcTVjpcy/03eu+ed0KWAc/mcCgiY
         hkHCmOk3Y2+3BRfNRZBwuVv05+jG0JIGMFKyFQnDzH28NyexylgWyrzC4pdtaeuZYZhR
         QZ/x7NdNdJCCDCwI5r8zzSfsUzjlY4eX2vtAv6F8cXlrP8IwKHEGHf37CCRIlS671MFY
         F06mbQi0X4t4yMthzwEbxtYFDhsdPQVtcF9/1vfR7fpChx50lvYvUveRgowmmfPlvlcP
         /suEy48d+uKc7lOjNMoT8A5XJ40vrhW9kVHa4cXQ/sos6UVKxE2Jpvx2qOK5ElUgSHkV
         LqrQ==
X-Gm-Message-State: AOJu0YwYkSMRR9rB1IV7eAJDOZ9s+/1LTlxcDk/sJZi0CfjG4FZG2BSD
        8kR2WFsbiCbzhcNAzIh1e4LK5w==
X-Google-Smtp-Source: AGHT+IFCyfxJyRzphA3v3M3Qp58I614V6//BnX9R0uapcsA82NS8ukmHZJFgqxcRKdAYmP2SozoV8A==
X-Received: by 2002:a17:902:d48f:b0:1c9:cf1e:f907 with SMTP id c15-20020a170902d48f00b001c9cf1ef907mr2142794plg.57.1697712618416;
        Thu, 19 Oct 2023 03:50:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:82f4:0:43ac:2324:cc6e:9fa5? (2403-580d-82f4-0-43ac-2324-cc6e-9fa5.ip6.aussiebb.net. [2403:580d:82f4:0:43ac:2324:cc6e:9fa5])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001bc18e579aesm1612043plg.101.2023.10.19.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 03:50:18 -0700 (PDT)
Message-ID: <6b856b0d-4f69-70ac-59a7-237fd21d1a92@tweaklogic.com>
Date:   Thu, 19 Oct 2023 21:20:12 +1030
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: iio: light: Squash APDS9300 and APDS9960
 schemas
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231019080437.94849-1-subhajit.ghosh@tweaklogic.com>
 <20231019-rematch-ethically-9d482ca4607e@spud>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20231019-rematch-ethically-9d482ca4607e@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/23 19:21, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 06:34:37PM +1030, Subhajit Ghosh wrote:
>> Squashing Avago (Broadcom) APDS9300 and APDS9960 schemas into one
>> file and removing the other.
> 
>> Link: https://lore.kernel.org/all/4e785d2e-d310-4592-a75a-13549938dcef@linaro.org/
> 
> "Yes, they look similar. I will combine them all in a single yaml file in
> the next revision. Thank you Krzysztof."
> 
> Yet this is a follow-up patch, not a version 2. The original patches
> seem to not have been applied, so I am not sure why you didn't send a
> v2?
> 
> Cheers,
> Conor.

Sorry, I should have put a longer description and a longer commit message.
That patch series adds a new driver - apds9306 which is separate to this
patch. As per Krzysztof's comments, first operation is to merge the existing
apds9300 and apds9960 schemas. This patch is the first operation.

Second operation will be to add apds9306 support on top of that. I will
explain more on Krzysztof's comments. Thank you for reviewing.

Regards,
Subhajit Ghosh
