Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB19804B45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbjLEHkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEHkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:40:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5ECB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 23:40:13 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a18f732dc83so930321866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 23:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701762011; x=1702366811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Iwyea8aUEDEQH5QmcooZYGbCE7CHUUSFaCk91EVoU0=;
        b=lZ7OPt4lv6xavDbloR6WBq5wSK5VT5/1a0tOkvyQ/VQu2Fgg+q/q0eEcZDul5wbskQ
         lXNQoncJ4LjgSw98K2fFLeP3mj4RXcZl/8K07WGmKCesmhZ+F3Enw/65i5SC9Cfe8fnd
         tvoWFVaK0x1g8JZA3eMvIztZvbcJZSiDjIwpmGQ2OFBZfMk5bCRivU1d4ajbY7V02v7W
         fP6Ehz0apeQHJzEZhwY5VSVtTDf7bxO9GN28uuDgRszXB51C3BJcyun5lsFazSHfweIZ
         lZEHLRI8enzOiwBMuctmdMRuuxSq5LEeHVUo2c8UB5yB6WY1aF7a6PxA2kOXo1qljxUK
         Nm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701762011; x=1702366811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Iwyea8aUEDEQH5QmcooZYGbCE7CHUUSFaCk91EVoU0=;
        b=Ozt6po5GRyzqQ8i9YMXy1AubsQt0Xtzr+SMHEpRVqBGzcdjgyM+iry4AHDiqkcAroC
         +Jrgu2wiK2vkFwjkX7hLXV13fCw3eUpYrgrhrr5emOZ9TLftaJN/RY554CNue+5684/4
         wj3MG3dc5UzGQfi83gqlAWLBUfyPCYgvylHKOgnsBqwncPlwuYW9RQ7MNToQPj04LNKp
         zHPzZAYu4MxBb6xq5DzMUfOT3eO2xYnaqWEWzQEktM3KQFZMLZi09i+2aEIt/aYDOrA4
         Oa0TehpqpN5rGSwG4Sm2w8mu3jR76Uy82Q7iV9T+k/f2DNZutDjU6FDp+GrP6Z1I/FGN
         EJuA==
X-Gm-Message-State: AOJu0YzGFJNEPWdfWOC0ge6uw6+H2BrChE9MZarz9Toort2svEjHO63g
        O7URp3hVOAv2As/Q85NWZRlx8w==
X-Google-Smtp-Source: AGHT+IHUF7t5srLXEzU8HP5qZYHTfGV6V8zqdzDEo5EHilI1WeVqYFfNRg9FMdl/gfoCsaVgPu2RRQ==
X-Received: by 2002:a17:906:20d8:b0:a16:1b4a:a6fa with SMTP id c24-20020a17090620d800b00a161b4aa6famr671879ejc.8.1701762011447;
        Mon, 04 Dec 2023 23:40:11 -0800 (PST)
Received: from [192.168.0.174] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id h27-20020a1709062ddb00b00a1c522990ccsm453558eji.85.2023.12.04.23.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 23:40:11 -0800 (PST)
Message-ID: <d1b975e2-ba0f-43b9-af0a-f372fe42e5d5@linaro.org>
Date:   Tue, 5 Dec 2023 09:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] mtd: spi-nor: introduce die erase
Content-Language: en-US
To:     Fabio Estevam <festevam@denx.de>, michael@walle.cc
Cc:     pratyush@kernel.org, linux-mtd@lists.infradead.org,
        takahiro.kuwano@infineon.com, bacem.daassi@infineon.com,
        linux-kernel@vger.kernel.org
References: <20231125123529.55686-1-tudor.ambarus@linaro.org>
 <d7ce98eb-c920-413f-bbe9-059077a9dda7@linaro.org>
 <6156a51f7eadc9594404bb0eacabe1a6@denx.de>
 <f9dc82f3-070a-42cd-a92d-83d031647867@linaro.org>
 <8de7595d8f4839187fdbbe7e139016bc@denx.de>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <8de7595d8f4839187fdbbe7e139016bc@denx.de>
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



On 04.12.2023 22:59, Fabio Estevam wrote:
> 
>> Thanks, will do. Would you please replicate the tests that I did in
>> patch 3/5 for mt25qu01q? You'll have to modify a bit the offsets for the
>> die and cross die tests.
> 
> 
> Here it goes.

Wonderful, thanks!

> 
> Can this series be applied now?

Yes. Michael, any objections?

Thanks,
ta
