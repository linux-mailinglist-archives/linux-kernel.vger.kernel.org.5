Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B58D7D1E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjJURQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjJURQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:16:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1580A188
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:16:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084f682d31so13818655e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697908588; x=1698513388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkXQx7i5+joI99QFWucS4PtQe0BoKp/UAVRxKkG1Y/A=;
        b=HHAyVisPz2ANh7/joQB0REWNEDV6tCoVxuGc8CiZakevlWWQExdX94XDNKnp9aF0/V
         jd7XWYEYHjpwnQb9Fs5S9CCcZKUS1oyElWlndZJ5tmtxa4BoB0e12ITTk+LpmuerHONH
         XHITa5jzNc0cMIp/gv0pMiEDK9pul1fEtbj6ppaI1gXV1TWf/k8qS4F0HuvNOZtcceuv
         quDrHrWLVpVo4C2tIRt6sjeORmJnkoi3khmJbBeBrP1j7jUDAnS9Xhbfw2akDlHsIAPU
         jHLO5aa/za9XrnNTfMWdnEjtj1mXLMGkd1LBwf8hsnrMZUuY3O5a/1R0setxdyFzqgTl
         j3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697908588; x=1698513388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkXQx7i5+joI99QFWucS4PtQe0BoKp/UAVRxKkG1Y/A=;
        b=DLJlbfA0L0nWU4gBxRaPZh32C2yHOdr52QC67tRtNe3aYX3L3vz4GD3WFI2rZ2bN7Y
         vrp19dhqU30KG/QLvD0tisPwU4gWTKCQE38xOV3koS2tHPs3QNOVu7+aE6+p2GXYTm6c
         wgZxW/o+wQXtSqKufxUaLjuiCZ8vTA6xCsHmVYVCx5Nt8X9QL+BSbIJBl/bQBWHlhRRk
         gjBNbtHvvdSLKNyZKl+geKH9fmV63Ad3HLAzVZkCgmnfHiSpsOclfvNraGrzxI35daO2
         mRwrxZuvUVvc77CXoCgQsolGfVg+boRTVe7fX20nwTTIybiHkbEpIYPfC2W39NPltO/G
         OKzg==
X-Gm-Message-State: AOJu0Yxx3oHAyK1t2dMgYKH8eC+g6lYCBpMPj+3f5QsUf0zA2PS7Ml4U
        deht/Nrq29YXPYAqrfRreAr6fg==
X-Google-Smtp-Source: AGHT+IGPAXCjaKUWsb322iXCxKdJXTs27XmdUwvdY7ChdMh9tNV7eJ5t7QZZ+qFcMEAX0TXTuKcyCQ==
X-Received: by 2002:a05:600c:34d0:b0:408:3f87:cba with SMTP id d16-20020a05600c34d000b004083f870cbamr3579939wmq.39.1697908588409;
        Sat, 21 Oct 2023 10:16:28 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm9597405wmf.5.2023.10.21.10.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:16:28 -0700 (PDT)
Message-ID: <5d537b3a-91ea-4a2b-829c-d5218041291d@linaro.org>
Date:   Sat, 21 Oct 2023 19:16:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree Initial support for Xiaomi Pad 6 tablet, that have sm8250 soc.
Content-Language: en-US
To:     luka177 <lukapanio@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20231021164654.146002-1-lukapanio@gmail.com>
 <20231021164654.146002-2-lukapanio@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231021164654.146002-2-lukapanio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/23 18:46, luka177 wrote:
> Signed-off-by: luka177 <lukapanio@gmail.com>
> ---
I just noticed, you should write some sort of a commit
message and make the title shorter (70 something chars
is a good length)

Konrad
