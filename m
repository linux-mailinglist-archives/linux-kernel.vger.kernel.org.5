Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA57B42B9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjI3R0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbjI3R0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:26:42 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A3CE5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:26:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-5048156976cso7543355e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696094796; x=1696699596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTIc3zh0i/l45HBIix9dYf04hAusch+32uqlKVY6qbU=;
        b=BE4qDhBI17ONQWjWEag1i6EB6kM/zQc5YVrCb6B1AlGdMXmmwagHYBO80Qu/RrLJlZ
         n9vR7XZfAg2RtnA6pQsBl6CTI6Bwg0jZJOSS+3q/Y76nmA86M9b14rCkgQSpEaR+DJRX
         gKnb0LBx2ntq1Gk8sAJ4tqajH/CFyUZJGQyKYbmewzKUqE7fUteVHcbGWnD9E0Ydnjpi
         b6EEJA8r8VMWCYZQYC3se66teed/GwxPi5i1URqSBnjAHb8dcv0fr7UT4x5a5RNFZsnl
         BRs/kv1YuQpNyN0br8mFsPW66O7LNh+/XDbi271zYfYjaQZ1rMFDVV0n9UKPGZm3r0fM
         AHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696094796; x=1696699596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTIc3zh0i/l45HBIix9dYf04hAusch+32uqlKVY6qbU=;
        b=BnsbDilaw37zfG0YC2IGaoNqKU15Exq7kwLZuKEjEF5DkxSEOT0vwjD0+iDY9WWCTR
         w2UBxxxkSnHTGxCrh8GdTJQaupMkcKT+5k5Dx09VhgzxO4DXYlolwYHxXlklHqJK8gyO
         A8p+v0JczHILz1FCkyZJrAw4jweq/ah3qBiJ15UA2+KAtUToWGdrCJtoy6ldgS9akkOT
         fL37VSchU/NAKsioWfpmfIrljJ7WRXMReTO44A0Gw4tUc8dZzPBDZzTKkXEupcZ8PpMI
         qSKkkrsjCr7oFhXFn2wK8Is6a6CIs8cB97IE5SQIr1jzZ2mdOMd7yOydlgAKLtUB37nx
         uFKA==
X-Gm-Message-State: AOJu0YyD1trs6Hex8R1gbS2+sGw4Cc93aQeOI7lp7fojjpjZR/MUle2R
        kT8rVw4aZiABBpDIlfnKPVpRCw==
X-Google-Smtp-Source: AGHT+IF+QJ1JktLXNhzwX2l7EIixDHi+uB7yhFVUgiL1XWhNJTeQllLnlrNI/3y+6WeiEN8VlSdDlQ==
X-Received: by 2002:ac2:4dac:0:b0:503:eac:747 with SMTP id h12-20020ac24dac000000b005030eac0747mr5603752lfe.47.1696094795994;
        Sat, 30 Sep 2023 10:26:35 -0700 (PDT)
Received: from [192.168.246.189] (85-76-98-178-nat.elisa-mobile.fi. [85.76.98.178])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b00500ba43a43asm3994414lfq.86.2023.09.30.10.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 10:26:35 -0700 (PDT)
Message-ID: <1e3af927-52b0-42ab-9643-db4bf3f2d2c4@linaro.org>
Date:   Sat, 30 Sep 2023 20:26:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] arm64: dts: qcom: ipq5332: Add Super-Speed UNIPHY in
 USB node
Content-Language: en-GB
To:     Praveenkumar I <quic_ipkumar@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org,
        nfraprado@collabora.com, u-kumar1@ti.com, peng.fan@nxp.com,
        quic_wcheng@quicinc.com, quic_varada@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_kathirav@quicinc.com, quic_nsekar@quicinc.com,
        quic_srichara@quicinc.com
References: <20230929084209.3033093-1-quic_ipkumar@quicinc.com>
 <20230929084209.3033093-7-quic_ipkumar@quicinc.com>
 <618992fe-4c76-42ef-af47-ee66f74c5bb6@linaro.org>
 <3f89e0b7-189e-4cf7-bec5-b03c903c46b5@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <3f89e0b7-189e-4cf7-bec5-b03c903c46b5@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 16:31, Praveenkumar I wrote:
> 
> 
> On 9/29/2023 6:44 PM, Konrad Dybcio wrote:
>> On 29.09.2023 10:42, Praveenkumar I wrote:
>>> Add UNIPHY node in USB to support Super-speed. As the SS PHY has
>>> pipe clock, removed "qcom,select-utmi-as-pipe-clk" flag.
>>>
>>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>>> ---
>> Patches 6 and 7 should be swapped, otherwise you may get no
>> USB with this commit. Incremental patches must not break
>> functionality, unless it is truly inevitable.
> Understood. Will swap the 6 and 7 patches in the update.

But just swapping the patches will not work, the patch for the board 
file will break compilation. I think you have to squash them.

> 
> -- 
> Thanks,
> Praveenkumar
>>
>> Konrad
> 

-- 
With best wishes
Dmitry

