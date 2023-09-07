Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A5D797676
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjIGQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237822AbjIGQKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:10:08 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA56E89
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:05:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500c6ff99acso2776219e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694102633; x=1694707433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfkJbCdeOUfHZ70y4Xael3OQcTcqcvMqx0FyDVsxA4Y=;
        b=WhoHleXOF22eRK0mPWo8le5nuiFJy5uCej3ElAmt0vCvRWgCTiYvNRkfCt9Go/+4Mq
         BKlz9RnFOXuzzaaZ3lS2eCYNXW+3IQ5kX20sF5ssJiYFNISZGJ32T5QLPlRo/9I2e6a1
         MGOPNyOl1jauPyq1fIdolacF20gPB7xlleJ1eogIPvdO4tYFk/ZxYum18g/YPra+uuUk
         c//2sDhTO1hnbPaIcnxO2RTxxK66rAZMNDgznSVBku6MOgS3BMLfQT/SvqFvMyEht2Th
         Vvxpa1IgfgYf6bPVFHJMjzby/ubUK7AT+QF3uD9+Hb/wwCn78vGXTq5qynraqSwC9HdK
         4jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102633; x=1694707433;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YfkJbCdeOUfHZ70y4Xael3OQcTcqcvMqx0FyDVsxA4Y=;
        b=EgLFrwN6maE+wcD6pgyAebgi4qoby0OxBmYOMvVP3utwi7wftJxUHFhDNMNS5GetCf
         oaIpHMEumVlu5aotYz4ptCHjCNlkMX/K3gCJM8/8qYstjgDc321481z+bc6O9QaBRh/1
         MbeVgDyNL64zXqwLKX5jsITITbbRcZtRPcIPPdts9hUKBvOlwmM8uQ219lx25ljgV3fP
         7m7aOgvP3t+CmaEre4cYArkcdyGxtuhSkLesehvRLAe9WBUUe9m9hh44GE4qy8cWkQBA
         d5g0MMjWiWNLvkQlsTrT/pYoqTpf2FKMoxZ6p5fRVzf9wzcS1YLg+KG/0yBd+ygUDGq2
         F/Dw==
X-Gm-Message-State: AOJu0Yypx5izKMLDKLNtm5iPsYCuiO5Ad/8d3HFm0C/QpJ1wx7pq9o/m
        mgFmruuzeYO0sJHfDsEZfcZl8tmt7fkKrVy+FSI=
X-Google-Smtp-Source: AGHT+IF3/YOkQHh6iMB40RPRVRL0HRRZ4Y+jDkR5ITBBzwgK62VXBvIb91GwhZZs1hsBJmkqPk78aA==
X-Received: by 2002:a05:6402:51cb:b0:525:4696:336d with SMTP id r11-20020a05640251cb00b005254696336dmr2818621edd.8.1694079748067;
        Thu, 07 Sep 2023 02:42:28 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id w26-20020a056402071a00b0051e0be09297sm9465226edx.53.2023.09.07.02.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:42:27 -0700 (PDT)
Message-ID: <747e5633-e3b7-48a9-8a1b-1c1985451314@linaro.org>
Date:   Thu, 7 Sep 2023 10:42:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 39/41] mtd: spi-nor: winbond: sort flash_info entries
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-39-291a0f39f8d8@kernel.org>
 <eec52fd8-663d-7e56-3627-2b33259027b6@linaro.org>
 <c55604322b8b5bb74ce293885599810c@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c55604322b8b5bb74ce293885599810c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 09:14, Michael Walle wrote:
>> I'm fine with the sorting by ID.
>>
>>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Also here, should I convert this to an Acked-by: for all the
> sorting patches?
> 
no, I'll add/drop my tags when applying. Haven't skimmed over the
others, I'll take a second look.
