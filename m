Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6317C01D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjJJQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232526AbjJJQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:39:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634B97
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:39:43 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c3ca6ff5a7so46784351fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696955981; x=1697560781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DjMufNeidfBGrH+Q7xLA52AUtP2FfSI1XNMkomfVmdc=;
        b=b3CUzYkuTtXPYymPGRn4QRoAgwtC+ooT2FVMpgL66Le9To6f1FQMMC9BglGulrINXd
         NhB/0d0RWDDE06iAnTgZXcZLGRIfa+S1WW62SaWquDMV0L38znXzs00XBV32Blzjqkqp
         1RU0s44XXfoPgA0zfe2KQYsmgJpPiUPs9T+AQPm20H4RFtPg9qoApsE2+GG5D+d6FTFz
         6S0U3ivUsec7Sh7+K//gfETp9zh2bwCKVTn87w0jhyFyoRNubCkbnjSTmEimTOGy7izY
         f8zA3sPQE5Av8gi9beC9b+gJC9QcSqD3EKLoygQrCjqGzs+wA/HdMSuFLu9foZjUQqdA
         lF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696955981; x=1697560781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DjMufNeidfBGrH+Q7xLA52AUtP2FfSI1XNMkomfVmdc=;
        b=ta00lb+GOZv5kAIWnYSl0LEjMicKUyRnSctk6A0zZy75moB49YZKfiVjyX035bOxmt
         FoxAX5CbhjPHV65A5oVZAhlz9tURbX/OIYTPZRAVe1rib3Ikt7Ufi6G6/h216nI6XYq0
         Y3Ov0Fdi8JsCHExtGfhoLs9aYqVUzBak2FAkaK4EqJiBIafV5OcuEthhXYYo85HEvUQy
         dSyfEWrs2iFUZpo2ZstZkrkwNcHocdq2BuhfYFgKSOcZgD50nE9Nc9Qzfi/vyXCIAm2a
         hNfdaB+GXmCL2aZhXzL2XHD6TyHPj1b98+80jo3rZhY5lRLBSzFIMdq4OGmObaUzBIYF
         mHEA==
X-Gm-Message-State: AOJu0YzDA5mBSId8S68uRln9G1rLk9sASaDXRHEBa7E/xvvcugdV6Mm5
        zjTFD8M6b+HUz6sm3RLqXtMnhw==
X-Google-Smtp-Source: AGHT+IEUTRW8ez8HjWV5wdo+82xvY3bgT8gnLKFaVNc9N7HMxbvQhHocsjFVl+dAb+NRsuNtAwFJKQ==
X-Received: by 2002:a2e:9457:0:b0:2c0:21b6:e82e with SMTP id o23-20020a2e9457000000b002c021b6e82emr15359477ljh.4.1696955981319;
        Tue, 10 Oct 2023 09:39:41 -0700 (PDT)
Received: from [172.30.204.182] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id v6-20020a2e9f46000000b002b9358f5088sm2482543ljk.53.2023.10.10.09.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 09:39:40 -0700 (PDT)
Message-ID: <bcc32adc-8f5d-42fa-866a-e9fcb2d4ad6a@linaro.org>
Date:   Tue, 10 Oct 2023 18:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8{2|3}50: Add TCSR halt register
 space
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
 <1696954157-16327-2-git-send-email-quic_mojha@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1696954157-16327-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/23 18:09, Mukesh Ojha wrote:
> Add TCSR register space and refer it from scm node, so that
> it can be used by SCM driver.
Yes we can see that's your changeset, please explain why you're doing 
this (the reboot mode registers).

> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
Not sure the regex in the subject is valid..

Besides, please split this into an independent change for each SoC.

Konrad
