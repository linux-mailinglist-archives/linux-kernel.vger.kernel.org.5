Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680077973C9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243964AbjIGP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbjIGP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:28:43 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846A1E47
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:28:18 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31f615afa52so1178603f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694100441; x=1694705241; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvypY1QvOnO1QpwUl4niGa+iAzfXQOe8HmG4CVoVLg4=;
        b=UsI1d1s+0qjn2/n7R9MUFqanyezb1/2koAxQ3WdG2ZfTbA/MsMGrLoCbhq+MQhh3zM
         3yX928hEBnwGWprKF/aLANaNBplkBcnvsUPPYXCLEIG3YEXkvgCndgYmYpVCaTFxqLrS
         jZ81DzfNK2/DJqkx6HJNqYpi9Nbdep9Ydez0RejFn0ZJVg7Ml3yC2XZM+EbQGq5FSUi7
         oV+3kNhwbrg+BTtL37Vieu2Tc86oKJWUq7X73e2g1Y/QiIlSeqszA3Z5GHcQxxICLpKL
         hxXCEdZA5D5zTtLn8qc36SaiJOoPk5faBMb4C2o2QubNZW/kJNr9CuOZ3wzyCv14g/42
         42qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100441; x=1694705241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvypY1QvOnO1QpwUl4niGa+iAzfXQOe8HmG4CVoVLg4=;
        b=H2ktqvGAeIQ3LRGiA+qzrd6s3zEdHpPhW8WIrvqNVjou7xI1eUQ3Ak+dCo5XF0HjGv
         ozN5Pon10mIrSJB46a7I4eKFIvBveLiiVdhC/RonhUhdvDcB+TkvQ/IH0N2PD4czkwRH
         AbEYhznTpYBKZX/jQNOd+h5wy4c6W0o6U5D7B9VWNIn380paCBSTx7cJimlaRsmSUN8R
         OCcab/mzAmcprm6IkG2pgCawhyG0QqcwbGuxVNH9ss0ssMhfgahGfEntascZVVZqQRxk
         MfQgokE/Q98crCd2s2DwJ5LNroIewU3SAB9PYhd2MDtGQXkEHlZzT8ed77XOvnpFGT1r
         ElXw==
X-Gm-Message-State: AOJu0YzOlgei0eCP08ttJYmArEZS5nZ89dLRtxEi4OxoB8RFhP9mS59a
        Rfw1rPq0owonkopJlRsCg+PkuxoeBqUpM6rUbHY=
X-Google-Smtp-Source: AGHT+IGva/E5JZtevG6ujo6b6PECKPAbrIbpmfBsxECwWywCO2LQ9gYoz4P3195aEYeblt4HJCGTvw==
X-Received: by 2002:a05:651c:21b:b0:2b9:e230:25ce with SMTP id y27-20020a05651c021b00b002b9e23025cemr4389569ljn.12.1694079961945;
        Thu, 07 Sep 2023 02:46:01 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.137])
        by smtp.gmail.com with ESMTPSA id f8-20020a1709067f8800b009a1a5a7ebacsm9991110ejr.201.2023.09.07.02.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 02:46:01 -0700 (PDT)
Message-ID: <f9e60fe4-b7aa-4a13-b1b9-f4d3d429eb62@linaro.org>
Date:   Thu, 7 Sep 2023 10:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/41] mtd: spi-nor: atmel: convert flash_info to new
 format
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
References: <20230807-mtd-flash-info-db-rework-v2-0-291a0f39f8d8@kernel.org>
 <20230807-mtd-flash-info-db-rework-v2-17-291a0f39f8d8@kernel.org>
 <aba618e2-ad74-d716-c8d7-e77588b22509@linaro.org>
 <4a25955300a53a36a842f4e8bd3a2e1a@kernel.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4a25955300a53a36a842f4e8bd3a2e1a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/23 09:13, Michael Walle wrote:
>>> +    {
>>> +        .id = SNOR_ID(0x1f, 0x66, 0x01),
>>> +        .name = "at25fs010",
>>
>> nitpick, we shall respect the order of the members declared in
>> flash_info struct.
> 
> As mentioned in my first reply, you're fine with keeping the id
> first? After this series, we can swap the name and id members in
> struct flash_info.
> 
> For all the other members, they should be used consistently. So
> we could also swap the members in flash_info.

I'm ok, sounds good.
> 
>> And I'll let you double check if the conversion is accurate :D.
>>
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> So I'll convert that one in an Acked-by: for all the conversion
> patches?
> 

No, I'll add them afterwards, I'd like to check what I skipped on first
review.
