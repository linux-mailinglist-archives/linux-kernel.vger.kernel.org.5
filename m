Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567017FD002
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjK2Hiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjK2His (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:38:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B245EE6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:38:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so4235743f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701243533; x=1701848333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7cONzvX3DJ5N2tJbhtl/3F0xHVQGSzTxNADSagct+E=;
        b=jO5WZpOD5NJKp2aVj/9F7Pz7r5lwf4r2/dGCPfXxghoxN1jC9vpHXYRc1Urv0ctdS5
         dWnqLkq8SjMf+gvw4WbCpKTyckvtBrPi/k+2vp9jifb9rgs8T7NbaNt5ssHp5edFjZdU
         Q/v+ugYO1kSif3CoJVsnUyVb8SmssREzSTEuVRzvYkiYkhDUam1c0BTLP2M1WHg3MEyd
         xcPH8r3iK1gy05Bdxix6DJZnDmG+oYkchV2Z4PCgl7P5cFiOkwUp8u+oPtRQvHZIJ5yd
         5WmaR0BiBOGkKU6LHYq8kqM5o2tq8Qn5V1UbmTLEKIoAe02230XT3ipBGoO2zzsYAShz
         vStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243533; x=1701848333;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7cONzvX3DJ5N2tJbhtl/3F0xHVQGSzTxNADSagct+E=;
        b=el9nYT1hYyftp/rhfH0S1R5sBmFi88YUOmk3W3d9EiMf/3LqlX67tcnpPQrxLGyi2w
         ycSsEpdYic9XtSQH+I0qgNU34vup+JEQrZYJLjLNXL1Tz+v7SYe55xJxkV8phd2f+9iu
         PobzbwxEitqrSIMl7I3+LhrOciQ9wCv2KT33DtaYPwf05uSfAC1WkEwTM8MHyf66Q3ga
         WZILpOnM3CLmnEmJlPj+bFsZQI+2CAkySys7MPibl6ohcWoqsRitfYgJIjvlDLBq2ZCk
         Ipu6hIuZuXazNaYYky7FO6OLV9fOixERbjgKo2GYQudxMd6UIcT6VpsriFG+EcfWpgB2
         PBzA==
X-Gm-Message-State: AOJu0Yys9OGrfVCwofnqISKyZoL+d9ZzV9IbiWXUDKfR+rMXwr/FEdaC
        OmnU69Ka1DDltw9K34FxDKfZAA==
X-Google-Smtp-Source: AGHT+IFqgVfitjC6Sy5J82ghxl/laZe5/WVwnFlMaeybrhcaJUuv6lF2MT2VXyu3Pser2LNo37WYQg==
X-Received: by 2002:a5d:6a42:0:b0:332:c50f:45ae with SMTP id t2-20020a5d6a42000000b00332c50f45aemr11339918wrw.44.1701243533133;
        Tue, 28 Nov 2023 23:38:53 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d464c000000b003330aede2besm4262686wrs.93.2023.11.28.23.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 23:38:52 -0800 (PST)
Message-ID: <6e81a443-4e28-48fd-9bec-224d07f1682d@linaro.org>
Date:   Wed, 29 Nov 2023 07:38:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP with
 -EOPNOTSUPP
Content-Language: en-US
To:     AceLan Kao <acelan.kao@canonical.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Kamal Dasu <kamal.dasu@broadcom.com>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mario Kicherer <dev@kicherer.org>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231129064311.272422-1-acelan.kao@canonical.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
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



On 11/29/23 06:43, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> 2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
> mainly being reserved for NFS-related errors. To align with kernel coding
> standards and recommendations, this change is being made.
> 
> 3. By using EOPNOTSUPP, we provide more specific context to the error,
> indicating that a particular operation is not supported. This helps
> differentiate from the more generic ENOTSUPP error, allowing drivers to
> better handle and respond to different error scenarios.
> 
> Risks and Considerations:
> While this change is primarily intended as a code cleanup and error code
> unification, there is a minor risk of breaking user-space applications
> that rely on specific return codes for unsupported operations. However,
> this risk is considered low, as such use-cases are unlikely to be common
> or critical. Nevertheless, developers and users should be aware of this
> change, especially if they have scripts or tools that specifically handle
> SPI error codes.
> 
> This commit does not introduce any functional changes to the SPI subsystem
> or the affected drivers.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> 

I'm fine with the low risk of breaking the MTD related user-space:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
