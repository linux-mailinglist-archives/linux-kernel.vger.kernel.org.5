Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845617EF8E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjKQUvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjKQUvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:51:05 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB2D6D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:51:00 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso21144825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700254258; x=1700859058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Cfb9CpRJGax+VMCUnz4cwDEpCdrdsrUj8kZuGAr5ZY=;
        b=cxymiNZKAxhdcmdx5RX7VH/snGLgCNEeorBQnO9tnizwKVQE2SXJljutN7N43zElas
         HyQJ7684IF0aZC5fZMRCqEF/IIahRnIHfzxvebQzjzEWMxKmEYa4Gl85jzE8l73Caezy
         jsexBtZD2Cvu3yzv3u6iJegtwdFLqIHpxFgzHdP1Q+bSHaIi8GfX+XRupMhFkWVIqu+u
         rGpQvhivx4Ek9RxWsVKyM+dF25cllZ5Wv0hCvlcKamiQL4lI7kTRCClg4iY3L588fgCJ
         nDevZc0uio7RAbo0KDVYnj9UFy7dVEgak0M6kPZB/bYZfyAy7Is90k0B9ACAC4FdGdFe
         wSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700254258; x=1700859058;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cfb9CpRJGax+VMCUnz4cwDEpCdrdsrUj8kZuGAr5ZY=;
        b=KqoW3tsYpOmo1g1oT7HaO+oNfoFe2V2gWvlZ3SzSKMLxLYvU8TaDvNJye6KL+aUbc6
         y5idbsUGTaHy76uyqsPF4XSptoRRmU7e2uPgZtyfRXZMMyS2T/nyvwqTYdlbvHjGzM/q
         hwFRWJVXfYJXWr8yEAq+8+I/rsF/fEf19lPOs+NdMg7QP7W4aAheEgMGQC/gYLwQV7nz
         Iwrh76wZJkIlQ4/PZTW0nTcBi5BZtmCr+X7eHhG3w5YE1O++hGUtBCfapmaIb+/WfvFe
         v3hDt2HRXcK1UtSTxZf1LbiIQPr9hFW7KiYJ360feVg55IqXcBUTSkq43pVnpCJQ3heK
         EZ/A==
X-Gm-Message-State: AOJu0YzoXcB5IwlP/WcGUut8vlX8yvvlsNwasOnwXRVWwOYpNsTn1bHt
        f5bwBXQodnm5CaG27d/d0S/koQ==
X-Google-Smtp-Source: AGHT+IFjAiXluizJ9xFU9rHxpbwZ5V6ciMuUpG4zoA9i1A1H/vCkh74tzaHFHMJWi4Ib6mtXQ4tgSw==
X-Received: by 2002:a05:600c:45ca:b0:405:499a:7fc1 with SMTP id s10-20020a05600c45ca00b00405499a7fc1mr203435wmo.40.1700254257945;
        Fri, 17 Nov 2023 12:50:57 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b0040596352951sm8679047wmb.5.2023.11.17.12.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 12:50:57 -0800 (PST)
Message-ID: <ec9d03f7-7158-4309-9a04-b08c69b89f39@linaro.org>
Date:   Fri, 17 Nov 2023 20:50:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] clk: qcom: Add Global Clock controller (GCC)
 driver for X1E80100
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, conor+dt@kernel.org, quic_tdas@quicinc.com,
        quic_rjendra@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org, quic_tsoni@quicinc.com
References: <20231117092737.28362-1-quic_sibis@quicinc.com>
 <20231117092737.28362-3-quic_sibis@quicinc.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231117092737.28362-3-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 09:27, Sibi Sankar wrote:
> * Use shared ops in the x1e80100 gcc driver [Bryan].

This looks better to me now / more consistent with what we have in 
sc8280xp - where we do try to hit suspend and => retention/parking matters.

Could you give a bit more detail on why SDCC* doesn't warrant parking on 
X1E80100 as on SC8280XP though ?

---
bod
