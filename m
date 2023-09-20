Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0A7A8323
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbjITNTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234672AbjITNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:19:36 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2F9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:19:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-502e6d632b6so10750115e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695215968; x=1695820768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOy+tw7JFth8FCqJzlba7saXfyCHBART6wBdyA2SClY=;
        b=USEuVSk3cOj6jhT0t03TmuNpomMFHoF6Q42AwTFDxZjmMulHlY82fcJWgRBJZFM9PP
         l5xH1stUSGaHTMEc+HuOEVTlf4x0UcGK+0ujiS5rVMuzy7t5K1MDtVf3AazbzdBxl8vX
         RadTyBleTtLIT50KDwBrWnJSNGkYaHdRCRpa4b4pD8Ydd23kriGk+viZuhIYrqUiG6Db
         plCK4UOmTd1GqE7ELrDW9DK7I9gQTRFZ1ykej1sejf9PW+K/3Ex5P1a1B/I6DaJ05RK0
         koZgWFDhqtgW/PDaKWa79TN8KCTpZvkHEvYNo6S0hclWUD4QAXT3Spo05KYGd76/EJFK
         5jjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215968; x=1695820768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOy+tw7JFth8FCqJzlba7saXfyCHBART6wBdyA2SClY=;
        b=mk7s+j2tnGC9xQASbLqnkBodlM0zzVH8B6cQHOYyxd/LPv3ZS2x+tJLtTgOM7CCr5z
         OmU33uPZHJtOdW/I98EiU2bogVd5Bmsz0rlCO8c1d717rXIgXStKFSPh5rbyTX1caA3j
         LeGkeiRBCEaNC1xOh9GDFtJh7yC3mYjJVyY5xdlqmJO9fq4grjaGVCv6H4og3rXPphUj
         Iq0/FLXiaXEnYZcDZ30GW96DMKS2ZE8x5FRhFJh1w/52VAU2QPU38uW0vsYZWZdsjj7A
         AzHT58rwn1VQsCKRD5CZAFQFbLdQkcFFNmoNU82TZX8cKT4tgdhsvJg45pYRbR/v42Ug
         upog==
X-Gm-Message-State: AOJu0Yz5DU49OrO/3rnOZ5s9RMYPs3pXMcZkFaAfTRpkyJ5Ff0zbszCv
        dBaVMyHflcq4Q9gp6g3lNVrt9Q==
X-Google-Smtp-Source: AGHT+IHkbmDhplCmcpWceWrsHHknh/hic++9MQZmNTujBFNA0UUiPrM6aqLADYgkoKVyakt4MATTSA==
X-Received: by 2002:ac2:5e79:0:b0:500:92f1:c341 with SMTP id a25-20020ac25e79000000b0050092f1c341mr2288339lfr.54.1695215967771;
        Wed, 20 Sep 2023 06:19:27 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id i8-20020a0564020f0800b005309eb7544fsm7205179eda.45.2023.09.20.06.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:19:27 -0700 (PDT)
Message-ID: <c53958d2-d7bb-c859-b4d1-37e7c61f6107@linaro.org>
Date:   Wed, 20 Sep 2023 15:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Content-Language: en-US
To:     "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Gogada, Bharat Kumar" <bharat.kumar.gogada@amd.com>
References: <20230830090707.278136-4-thippeswamy.havalige@amd.com>
 <20230906172500.GA231799@bhelgaas>
 <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SN7PR12MB720159F33F53B40453111D128BFAA@SN7PR12MB7201.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 15:21, Havalige, Thippeswamy wrote:
> Hi Bjorn/ Lorenzo/Krzysztof,
> 
> Can you please provide any update on this patch series.

Krzysztof? You need to Cc him first... I mean, the other Krzysztof, or
whoever is needed to be Cc-ed.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC (and consider --no-git-fallback argument). It might
happen, that command when run on an older kernel, gives you outdated
entries. Therefore please be sure you base your patches on recent Linux
kernel.

Best regards,
Krzysztof

