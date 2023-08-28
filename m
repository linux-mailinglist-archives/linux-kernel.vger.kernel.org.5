Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35278B87E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjH1TiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjH1Thu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:37:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF2FBD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:37:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401187f8071so22736315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 12:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693251466; x=1693856266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06m1OEDqS2WWK0uy+9uCEUWO2nWLWF2qXoN+kTPD3MI=;
        b=h64K48DZTXPSjS/9SQDjG8Iv6CrCeKMeAKKCOyUXqMTlMgg3IbSuLDi+cb2vTxmnQl
         TY09yDhMJyt3I6SM9NnWX2mlzTQjKZroMCnPySQzIGfy4k5xsrE34yLS5AGM1pqGrkxp
         GZEzuHS8IIXYuSwHynmzjJ6DMFm9zrrWjKkV3/lpkqlqnSJroAdhL7t5S8DBoSuL2tJE
         IF6L6v4coxXNYqu/nYcnQqv78pet0cB1mRQtcmO6WnAdANdlURhemmy3BrmWlS/N85w8
         68Vg7lImvz+DGQOYzQGYXRb5FcrXVfxR34gV6PL58NYS9EmJZASlHO+6e8oPqmBFVtV9
         vviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693251466; x=1693856266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06m1OEDqS2WWK0uy+9uCEUWO2nWLWF2qXoN+kTPD3MI=;
        b=crgb5VHx1ikHEt9F/vKaDgqMKLenIscIFKn3Vex9kWqhWad0GEpxsK+IatABpuYA0i
         WXDoNVW88iVMhXn6L2gFUPa5191QDFCiQl5+UnH3MpiEggb522J3CsQuRtX+S0E3+tcb
         E4bxBuEhpslJ0D1hyhOPP6zc015rgePIFjeal2h3qTr/v/xPTI6NpSW69EKKVRcIvWWi
         0JH9vV6uptyr52n8ehlVNcKkBhYBJVn+FuDzcmHuLfe+CAm2IGRNJuTMBRZtz7QkmDve
         VtJ29K3l2M9JdtqnNSN+P4/QQwydd8/ZPUpAhYE+MsFZ2RSmH+UF3Sh7g6SOfp2KWkCf
         dV+w==
X-Gm-Message-State: AOJu0Yw8Avj6aNzCbpGUVHUcztPS9Is6QIbvMPV8UixHfwji56IIKKEt
        MF1CO1FB8LifTEKAm3VpAU4ibg==
X-Google-Smtp-Source: AGHT+IFOjaDHBzjrJFVkZNdcZ1pY7ToCu7MAz62GUl6zWqv7h//4qusu5V4posNlmfkBkemLRwv/AA==
X-Received: by 2002:a05:600c:474c:b0:401:c7ec:b930 with SMTP id w12-20020a05600c474c00b00401c7ecb930mr370180wmo.10.1693251465827;
        Mon, 28 Aug 2023 12:37:45 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 19-20020a05600c235300b003fe4548188bsm14787725wmq.48.2023.08.28.12.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 12:37:45 -0700 (PDT)
Message-ID: <9fb41649-b4fb-d652-3207-7c8ff8b32f24@linaro.org>
Date:   Mon, 28 Aug 2023 20:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 07/15] media: qcom: camss: Capture VFE CSID dependency
 in a helper function
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     rfoss@kernel.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230823104444.1954663-1-bryan.odonoghue@linaro.org>
 <20230823104444.1954663-8-bryan.odonoghue@linaro.org>
 <20230828184716.GM14596@pendragon.ideasonboard.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230828184716.GM14596@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 19:47, Laurent Pinchart wrote:
> Hi Bryan,
> 
> Thank you for the patch.
> 
> On Wed, Aug 23, 2023 at 11:44:36AM +0100, Bryan O'Donoghue wrote:
>>  From sdm845 onwards we need to ensure the VFE is powered on prior to
>> switching on the CSID.
> 
> Based on the discussions with Konrad in the mail thread, I would record
> here the reason for this requirement.
> 
> What happens if you unconditionally power up the VFE prior to switching
> the CSID on ? Will this break something on platforms older than SDM845 ?

vfe->power_count will bump and you will be fine.

---
bod
