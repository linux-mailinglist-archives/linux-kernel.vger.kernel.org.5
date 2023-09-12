Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D929179C707
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjILGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:36:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB73E7E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:36:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so56250095e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694500604; x=1695105404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jtkVVweBp51eKnKXmzffldED1uYy4cusM5N8dL4goF8=;
        b=o0uLOO6lbNfCQXX1tFp4gUpDw5dUkVZXBnDVyNBNxezwEgBZ8niSDnUvJp0xHqtDc9
         OGbkSlgDHyMLIFvlAG9rZm1vSemXTaR4UZxgjB/gla5doXenb+vL2yiba2JIKT+/M8kf
         TtA118Ejbi1wAbZwn3G9LBzhqsMnf6uK7veImNc7rZ3rIiDLUc0kjw+gxxgOcb7qThOn
         euk8a/ImH16/DaILusIzG8rqkv1B7PM0QqzvfI2hnDozVx4z1BlIpXi0axLp2ehmeHkU
         3uSwlDMBCbFlCpGV4lJdKR6pgUjd+OQs3sgKnLGSZxSkOaIbdQy9SIxNfTOnJqW5xDIw
         LtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694500604; x=1695105404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jtkVVweBp51eKnKXmzffldED1uYy4cusM5N8dL4goF8=;
        b=UlUcPg4ggNp9v4D2tvUyjS1uMsCWdV/c5DToyeZGJajuizbUuKkiVH7HDbjkRGWdmo
         UB7ola4rRdFTkrKMx+uf9jHmIPNwdFNV4FiuNJng2F+FzDfjII/Ft1mPMlo0VIWnsRAT
         aDAa8Zg7W2m0VtsroIq0LPBQXDQ280tn+GHadM5sKO/g3I7lanv2Kv2yQmpefNxKDmM2
         mc5dgdt+KVmnUXQPMWKSWW9UMmQC7iHHNk2i4PTpJy/uXlY3HNZXmAhMV755nJTOXIYc
         8o6esaI9KbE35LdrDnuXGEmg0g2vRXgIPaZUEbV0XfI4e7tseojJXzT1BhdQph4GdWHV
         HpxA==
X-Gm-Message-State: AOJu0YwXjpMfEU8LXkvpyN+4eDWgeQt8EG4q3qm1KbsIq+t1jSXUKhXk
        ztoCxX3u/px7eidfJnOzMfJfdw==
X-Google-Smtp-Source: AGHT+IEtT6Zxddi30hCs5jyCQ9Ds4mduYP2odCeSemsAPiiAZ9L8uRy0j3HoeOB8+kNYhwVyBlLZRg==
X-Received: by 2002:a7b:cb87:0:b0:401:cc0f:f866 with SMTP id m7-20020a7bcb87000000b00401cc0ff866mr10233979wmi.12.1694500604225;
        Mon, 11 Sep 2023 23:36:44 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a12-20020a5d456c000000b00317afc7949csm11972550wrc.50.2023.09.11.23.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:36:43 -0700 (PDT)
Message-ID: <d8a17496-d2b4-4ed5-8a25-e61fe38bd377@linaro.org>
Date:   Tue, 12 Sep 2023 07:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] arm64: dts: qcom: msm8916-ufi: Drop gps_mem for now
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-3-b7089ec3e3a1@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230911-msm8916-rmem-v1-3-b7089ec3e3a1@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 18:41, Stephan Gerhold wrote:
> gps_mem is needed by the modem firmware for GPS to work. However, it is
> accessed via QMI memshare [1] which is not available upstream yet.
> Until it lands upstream reserving this does not provide any advantage.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20210319172321.22248-1-nikitos.tr@gmail.com/
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>   arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> index c759c0544dd9..69f268db4df9 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
> @@ -22,11 +22,6 @@ mpss_mem: mpss@86800000 {
>   			reg = <0x0 0x86800000 0x0 0x5500000>;
>   			no-map;
>   		};
> -
> -		gps_mem: gps@8bd00000 {
> -			reg = <0x0 0x8bd00000 0x0 0x200000>;
> -			no-map;
> -		};
>   	};
>   
>   	gpio-keys {
> 

Should this have a Fixes tag, should probably be applied to stable.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
