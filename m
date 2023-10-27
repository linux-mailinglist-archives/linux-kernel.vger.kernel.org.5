Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975AF7D9614
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjJ0LND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbjJ0LNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:13:01 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17537129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:12:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507b96095abso2814750e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698405177; x=1699009977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzS3xtRaYXApZ+3kIqeVQrGG8Ns+4rxD5VoBS9jMb0o=;
        b=Nuu8NJfZy0Bq73AysLIZJWEXZEEGWjdEcTajUU5wFcjtnCFX6OXoniPa5eb2jAl2ou
         AAt0yFHN7IWDOiLUVJa3jr5GnFy9REO9Paf9hSJVZODdGSpe7K8GZej+G50mgOnt4nCJ
         NI3FQ94MqV6KyO6HicHdY8yE3wkKIPtKovxCEHeCr07XB+sUWB+sN3SPXfcaFup5ngb8
         eSyxUqDxf5sB2kUjR+1e+ezoP1UYO5STj5NlbalSQ1h5f65zGDNztCoAQfLcN1vhuj7/
         R65ltxabIiSfnMMOfunJ+APEZYdYYk3RFTr0wFcqX7vu2XdiTgn+k0Y9mubNe3QNe2no
         zMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698405177; x=1699009977;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzS3xtRaYXApZ+3kIqeVQrGG8Ns+4rxD5VoBS9jMb0o=;
        b=c0eThHOReoDF/kM7X/bIktcFT7rr30g1Ge+xOxoEO7QISirdNZ9C9ApW3x3I3gAd1p
         bpWVXBkBB8Cpwft2xJjKyASiG4rJYNpC6v/5yEFdlwuYZmleVDBOEcYyqlma1ijckTtq
         4/GG9Idu3lbsrX4eJs1U2M+ZEx+iSWCRI8HVmxGN9Cn0LhtXs9zbSPcI0/Rhrg9WYspV
         qhO09Hala1p9zQSnBZDcZqxeWG1hHRXXFqAKz9HSDg/NL1AI6BYTWagUv2/8nQuvc+ZH
         khpzixse+O8cilOHS0+/FHhflcX4s6FGY+eoHg//qmWMYAGZJrjSJw9vY4WO6ROtSsK7
         4OLg==
X-Gm-Message-State: AOJu0YzTMH3XAdCieP9QHHKibNjno+TU91ynXkAvR6hzsuimZGK5tV0L
        OLUUgJGeoeLvAjYlwmKJezr51w==
X-Google-Smtp-Source: AGHT+IEH3lgoUuBsJBBZA/euKnydpc/GAWK4n64r/DYsrpsTtloPfH9jTmBUZHg9xvVfd8zFxgw6Wg==
X-Received: by 2002:ac2:54a7:0:b0:507:9628:1082 with SMTP id w7-20020ac254a7000000b0050796281082mr1638858lfk.58.1698405177147;
        Fri, 27 Oct 2023 04:12:57 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id dw9-20020a0565122c8900b00502fd9110ffsm238611lfb.294.2023.10.27.04.12.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 04:12:56 -0700 (PDT)
Message-ID: <3168e245-797a-4f30-bb48-8b88993691a6@linaro.org>
Date:   Fri, 27 Oct 2023 13:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: cn913x: add device trees for COM
 Express boards
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>, Elad Nachman <enachman@marvell.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        cyuval@marvell.com
References: <20231026084735.3595944-1-enachman@marvell.com>
 <20231026084735.3595944-2-enachman@marvell.com>
 <2f7ab700-cd87-42f2-870d-950a4c75b17d@lunn.ch>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2f7ab700-cd87-42f2-870d-950a4c75b17d@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2023 19:32, Andrew Lunn wrote:
>> +#include "cn9131-db-comexpress.dtsi"
>> +
>> +/ {
>> +	model = "Marvell Armada AC5X RD COM EXPRESS type 7 carrier board";
>> +	compatible = "marvell,ac5x_rd_carrier", "marvell,cn9131", "marvell,cn9130",

Except wrong naming for compatible, I really do not understand what you
want to add here. If AC5X is the carrier, what is the model name of
entire product? If AC5X is not the carrier, where it the carrier?

>> +		     "marvell,armada-ap807-quad", "marvell,armada-ap807";
> 
> This is really a question to the DT Maintainers. This is a carrier
> board for a standardised Com express type 7 board. In theory, you
> should be able to plug any Com Express module into it, not just
> Marvells. So should the compatible list just have a compatible for the
> carrier itself? Not the module which would normally be mounted in it?

Yes, because there are some common parts of the carrier board.

> 
> Should the carrier have a .dtsi file describing it? And then we have a
> .dts file which combines the module .dtsi and the carrier .dtsi?

Depends, how this is organized depends on possible re-usage etc. Usually
answer is: yes, carrier board should have DTSI.

> 
> Sorry i did not ask this earlier, i was thinking more about SolidRuns
> systems, which tend to have custom SOMs and customs carriers, so you
> can only really mount one particular SOM into one particular
> carrier. But that is not true here.
Best regards,
Krzysztof

