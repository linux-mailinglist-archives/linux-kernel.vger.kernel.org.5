Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFF783FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjHVLo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjHVLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:44:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF106CFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:44:03 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31771bb4869so3990198f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692704579; x=1693309379;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCBvk371BaC/CqcWFFFnQudenCUg5vZ6gW5WDAr8SpY=;
        b=qth3flHy66Gh7ZPcmou+9AmxUpILUcY6sWjAxURN05CHVUg53E8b5O948O2d380qnL
         Q2bTDm8hQunbR7Xgp72iY/o5G+jcZFMLvW9E4QbfOrWtcojpMKJVcJ0jDKSDrZexa4VG
         R6NyxXmijp6dB88fMiANkOPZJwZUQqZ7L9VogGqySLJp9UotAL/b4Re9VdOHwhUSfeCR
         ODsrhHR4A8QVf+R6KNZQhp22JJp8qQCscQ1qQMbJt7rLTYWEab9agLBq8T3/wlCF+0l2
         eQp8kVbwKdDjf0F36q/cyusaRD6bv1zEC4S6bYyqK6r09HpgZMVVUaREAXeFErhqQ1Lr
         I51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704579; x=1693309379;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JCBvk371BaC/CqcWFFFnQudenCUg5vZ6gW5WDAr8SpY=;
        b=Mx58obbaBSpVd80ISWPHaiff9GZWOFLpwXCh8fe8hF6l0cl83BhiamtNOa4Pcj9v8g
         j4hSIr218KyG4M65rkF9CgRhnADEPpkMrgccpCrJrPdCecrm01K3Ea/ivXryU803iLrM
         /BMwbdeQ5hHeDwKDJw74lOllIy1SvdEnXfKJrgnFxKdbOViZHPSDMVOqZ/DmpCd2dOdx
         kKBVON4e3eQ7vziidUKqRLy8RjI3+4u3hdlSX3k6OnTCOrwix7yw6t/v2qB6H6rdO+ww
         +akynv3i8QurAaH9Nsvvnhs41OM5o5mxRVnvOnk+5IOGqgkW8paw/vUKVUULwr89MWbi
         ZG3A==
X-Gm-Message-State: AOJu0YyUd51ciRHEAjTm3C2XNSt8pIRYyapdJXLwaHNLnTqoZ2Hi1B75
        FdtnVrFCFESXCOAsByhDzNIDeAGiaAC/WuD1XGk=
X-Google-Smtp-Source: AGHT+IHWkX8XSEGFwdN8ZkJ9MnJoo409O/jNsb4AfA9thIhwfIruwQp3gob+M0sfv/CUuajOeBc7JA==
X-Received: by 2002:ac2:55a7:0:b0:500:8fcd:c3b5 with SMTP id y7-20020ac255a7000000b005008fcdc3b5mr714192lfg.12.1692704013395;
        Tue, 22 Aug 2023 04:33:33 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id t11-20020ac24c0b000000b004ffa28ef3a4sm1202792lfq.100.2023.08.22.04.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 04:33:32 -0700 (PDT)
Message-ID: <510d00e2-65f5-40c5-bd6a-5b5e34fa9e8c@linaro.org>
Date:   Tue, 22 Aug 2023 14:33:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/4] arm64: defconfig: Enable M31 USB phy driver
Content-Language: en-GB
To:     Varadarajan Narayanan <quic_varada@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, arnd@arndb.de, geert+renesas@glider.be,
        nfraprado@collabora.com, rafal@milecki.pl, peng.fan@nxp.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org
References: <cover.1692699472.git.quic_varada@quicinc.com>
 <84162d7d21d6bf45c4cf670000dae3f03b05ad93.1692699472.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <84162d7d21d6bf45c4cf670000dae3f03b05ad93.1692699472.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2023 13:29, Varadarajan Narayanan wrote:
> Enable M31 USB phy driver present in IPQ5332.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2:
> 	Add full stop to commit log.
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

