Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76D805E50
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjLETFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:05:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLETFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:05:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD47B0;
        Tue,  5 Dec 2023 11:05:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d0ccda19eeso6427715ad.1;
        Tue, 05 Dec 2023 11:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803139; x=1702407939; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65x/22kRqVtTqMNpjVRPG/dvndAz+ALREHF0eKUJkbY=;
        b=XMqn6OnjZpijVlsqNjDSl50S5vfY0bJucJDhmIu7TZi9kttbTI7pOlP8OEMNS8aSBb
         02UIWOV3nRyzbDBOZ7/vV3qJGoFvHk9YgiFGEt/UcjExbb3vXGya6+AacYz48h7ekhuE
         K59yr155WVDd6SYmHitk8Tdd18QfwIXMUHtjlXYFtHVBJGa8XJ3afPNjvYPSrPHRH2rY
         xYjHGsqxbjL8isvMkgVa1R6ibDpL7ubjxMKBC7pIOaYmOfPAnoKc2O6QjXpzKg4hulC6
         HK3yhUSvG3F/y87+ri/ebvnAeqTYGtxCtNYkzcqQm3koe2wcg1NSVKtT0+BIAxYcy/As
         gHvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803139; x=1702407939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=65x/22kRqVtTqMNpjVRPG/dvndAz+ALREHF0eKUJkbY=;
        b=vWXV71/mFxBUFTW8UvbyxyN0cRDlEtF77Lb1q6aNPZNV9mR9siIIUTxdjcvMD3ZCBF
         +An1l+xjpRk3xZ7yPNtwDrSq4b9Eb2fRcR2rjVSyV5uA34B4tOeS13AC/vhdKM28iCUL
         MwCmcE79Akaix2m22jdbgNEEPozjIMIag3YJaOLfXzPRH8e+2oL9Lgdm6dij4KoiEYRN
         /MLDPYMdpigGTEkVdcOpncsx2wH4pXHZs8LNn3JTxdeE55QVbb0eKSssjN+8Prf8pr4j
         k4qHFw7tG6mUMrzvVj0/+3qT91XNR4EpndyocymBRK2RSnIry3i8LlkOx1n/NS8AFBpB
         f6cQ==
X-Gm-Message-State: AOJu0YxEyPW4R7QLCxUvfMC2v2TOiTZzYvegUdaBjpa6e+QnOr4X1804
        lsuSatfm6UFs4C0bfq4jNWgUaHUrWnQ=
X-Google-Smtp-Source: AGHT+IHaLTOWiqx9cRcj54bfnoGThr/ez4R1uxKbeBOYs0xMPsoXq+/Ar7OLLnpmcu9Z9SGzt0wrTw==
X-Received: by 2002:a17:90a:fe0b:b0:286:b6ab:5394 with SMTP id ck11-20020a17090afe0b00b00286b6ab5394mr1483552pjb.94.1701803139609;
        Tue, 05 Dec 2023 11:05:39 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id gb2-20020a17090b060200b00286c1a13ed9sm3110511pjb.56.2023.12.05.11.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 11:05:39 -0800 (PST)
Message-ID: <a755a0c6-e963-4172-a4c5-df046e28b5d0@gmail.com>
Date:   Tue, 5 Dec 2023 11:05:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] memory: brcmstb_dpfe: support DPFE API v4
Content-Language: en-US
To:     Markus Mayer <mmayer@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
 <20231205184741.3092376-4-mmayer@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231205184741.3092376-4-mmayer@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 10:47, Markus Mayer wrote:
> Add support for version 4 of the DPFE API. This new version is largely
> identical to version 3. The main difference is that all commands now
> take the MHS version number as the first argument. Any other arguments
> have been pushed down by one (i.e. what used to be arg0 in v3 is arg1 in
> v4).
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

