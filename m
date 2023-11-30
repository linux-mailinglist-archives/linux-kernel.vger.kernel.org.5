Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AB57FED19
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjK3Kmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3Kmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:42:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32310D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:42:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-332ddd8e0bdso1189312f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701340963; x=1701945763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aU/rktlkm6RWOcfoD7EiPA2vcO/vrNvaDSdJjsM6zYg=;
        b=lK3Wmc34FwjXs7/qeu5lSYt7LIyTo4hTKzt3T9fCAa9A5MWD5Ujgbn1oaucIqMQNqN
         3iS2OoqtK6QqoE8tzNHmgh113Bfp02w1ALvsctPfJCpCu0wprONW8YWXbn2rvHselSw9
         Vz8NPsJnPWhas4qkncPUPsDITRFOi8nhcgeLIlnI0MejTx+YUmKEUC334FBwUWc5i4U3
         cVamP6FFAtFuGrUCeEI9erAO/Qes/PZjm3DB2R2HDwE/xKIa5WhvzIq/9JuuFoUizQjH
         zbgdksDzRGXim4lwfjPgm0viWtg9Zgv+lCKrd/kVjQzwiwVqkljgDWvCp3GPBHOGHCrk
         oNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701340963; x=1701945763;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aU/rktlkm6RWOcfoD7EiPA2vcO/vrNvaDSdJjsM6zYg=;
        b=oi5dM0YFiReBICvsSGiD1s1LIFTMBvat3xtDWY4/XKj7/dh/T6FrPr5T+doGstgpII
         HJRU0+IgzLKlCwGp7GwuVVLbl3o6GqPCD+r+Bt6dGmSrFPUlEkZj/GIcSOuVWSS2glzy
         7DsMtX+nyG5Z6SQOhPHmOmL6iIqqiFE06Fh4g9FpRAfJ/1PPGjbBbg8MHqTwjKT+125o
         cygiapM+hvGyBCMDnawxirHtcQFBXMF4QnN22YvUw6YGNGmvEMlXSx8ju1j03qFhsY77
         LzpnQKbf9ZVyiTynNllHxCjGxZ0sSxgiRH/O6perJcRN8EOLMyvd3Txb49ejK92R9yhg
         m0ww==
X-Gm-Message-State: AOJu0Yxuf9Z5elKR9JgV6DlzTdOHPzhUxHGupMBhoq/8QYDrjyHfDGaR
        25ZxzwfOPTR1L0S6g2RMTrf7Qy0+T+ZZCYL/4jg=
X-Google-Smtp-Source: AGHT+IH3uS/zkBftytejy0izJqy3XbZIIkpcp0FaQHJQseDClLrO0au/imISZpjSMEfjzELnXXSvzQ==
X-Received: by 2002:adf:e602:0:b0:333:b9d:ccaf with SMTP id p2-20020adfe602000000b003330b9dccafmr7521340wrm.11.1701340963649;
        Thu, 30 Nov 2023 02:42:43 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600002a700b00332eb16d215sm1201711wry.23.2023.11.30.02.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:42:43 -0800 (PST)
Message-ID: <f9dc82f3-070a-42cd-a92d-83d031647867@linaro.org>
Date:   Thu, 30 Nov 2023 10:42:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
Content-Language: en-US
To:     Fabio Estevam <festevam@denx.de>
Cc:     pratyush@kernel.org, michael@walle.cc,
        linux-mtd@lists.infradead.org, takahiro.kuwano@infineon.com,
        bacem.daassi@infineon.com, linux-kernel@vger.kernel.org
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
 <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
 <6156a51f7eadc9594404bb0eacabe1a6@denx.de>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <6156a51f7eadc9594404bb0eacabe1a6@denx.de>
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



On 11/25/23 17:29, Fabio Estevam wrote:
> Hi Tudor,

Hi!

> 
> On 25/11/2023 09:37, Tudor Ambarus wrote:
>> I made a typo on Fabio's email address. Now added correctly.
> 
> It looks like the Subject of patch 3/5 is not complete:
> 
> [PATCH v3 3/5] mtd: spi-nor: micron-st: "
> 
> Feel free to add to this series:
> 
> Tested-by: Fabio Estevam <festevam@denx.de>


Thanks, will do. Would you please replicate the tests that I did in
patch 3/5 for mt25qu01q? You'll have to modify a bit the offsets for the
die and cross die tests.

Cheers,
ta
