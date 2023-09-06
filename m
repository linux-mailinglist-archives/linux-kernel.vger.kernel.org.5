Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B845793517
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 08:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241214AbjIFGE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 02:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIFGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 02:04:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4B6CFF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 23:04:22 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so123987966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693980261; x=1694585061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcgL95jlhuL9v+UQ06Odrz5kXmZyQ+NUuEBVUZMU0fw=;
        b=E5pjsDMKeKCIuy61o0VM8lyyrjz+HWIpuTiiRILWCxfoDkyCvqXrOW1hjDty3QqYjU
         H/yqHrM7SBFf23DNd9SRWzlUhnKwymJnaFpy0nNrh27DkHV3Y1J5qugF/4JZj5vHeilE
         lEJqfUpu8LFapghhPfrke4LCPtdZM+d6w1/Gum1Wf464HYDqRszEDC9vT/IC8Iyk0zWu
         htP5FJ4+WYCpe8Ry74/RUaWGHJCR3KG1EBaJ1hghbtzjmvy8+8O9KsJiXuVHGw/IxziL
         MXYjbxaw0AQhf+nVkVWOawgTJLgdHq/BjrNoQ0zCRzf91lCL9msETUQz4yN8wXuIINJA
         aMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693980261; x=1694585061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcgL95jlhuL9v+UQ06Odrz5kXmZyQ+NUuEBVUZMU0fw=;
        b=HkuzrcqtNAfF2fHfqI8vuzS5V0gsQwmc0cU4Yyko5qV4HfeYu4ySvlnK3uaDRguMng
         thUdrE7pPrZ8RgigQocvIlceAy8uONwYN5WzuyQ30Iehc787sWY4k8RxQcMnqsWf3MJN
         251FMdG0pTW5LpmBY8CvZjZHIxcL+zB7kCyZRTzveKhaLOxfOOjsvvVAeeSjjHxoYdhi
         0f2NVZgQKLkb+qvl1ahd/ppZXxbNtyuS9k/GWfkVwLHCSfVCcIAhQMyQPU5M1B8Kt5c4
         4I/gCAuuJBieh/WkIHCVBODUqg3CCBhvM9+w2q8J0fJhgX+E6w8mNGdsbrYFs6Yfk17i
         hyTQ==
X-Gm-Message-State: AOJu0YxoHfVRtLYBVyuVNPU+wOjNisReflLLZehrr2vgZwqDyGMuyB8Y
        uOjh9uEmHpWiI/ov5VPJPDoYIQ==
X-Google-Smtp-Source: AGHT+IEEmHWRBET5bV2i98awi2oScToFvbEe0MfeN2KyG+2Pmif7nqbTrq/EpyAFFYAcbqWll6W+AQ==
X-Received: by 2002:a17:906:58:b0:9a2:143e:a070 with SMTP id 24-20020a170906005800b009a2143ea070mr1823949ejg.20.1693980260959;
        Tue, 05 Sep 2023 23:04:20 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id ov22-20020a170906fc1600b00992c92af6f4sm8658029ejb.144.2023.09.05.23.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 23:04:20 -0700 (PDT)
Message-ID: <aefff5dd-925a-41e7-ab56-9c3328b672b7@linaro.org>
Date:   Wed, 6 Sep 2023 07:04:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/41] mtd: spi-nor: introduce (temporary) INFO0()
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-12-291a0f39f8d8@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230807-mtd-flash-info-db-rework-v2-12-291a0f39f8d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 08:09, Michael Walle wrote:
> The id will be converted to an own structure. To differentiate between
> flashes with and without IDs, introduce a temporary macro INFO0() and

why do we need to differentiate between them?

> convert all flashes with no ID to use it. After the flash_info
> conversion, that macro will be removed along with all the other INFOx()
> macros.
> 
> Signed-off-by: Michael Walle <mwalle@kernel.org>
