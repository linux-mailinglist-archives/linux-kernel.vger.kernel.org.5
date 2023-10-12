Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B77C733E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379486AbjJLQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379492AbjJLQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:40:33 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3248DD7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:40:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso888341fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697128829; x=1697733629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YHF9YtAywaLSZ4QgrHB4ZUzNaY0pz+zvYC0Cc3RIf4E=;
        b=kn8v9rLYskyFniAgAxlEDNwY3X6cJbZLOG/2wYHkfdZr/ZQ3vf62IxHoQ1QxTwyYve
         jhZgXzOCflqtBpjs7vuJf+xp/RxTjb6sCuLOBRVhodlLxgzUr5Up/TTUh7oSMNKpVXmG
         5MWZ0eeZBavc6wGBUoatj7HUTtr6kRkJGviJLjXfmr8yWDo9P9sgEi9kejwFTTvvJqCN
         +kX1HgLEfenX48BtB7Q416gSgUMO2sSDaxqOwYSt/jOzFiVI7WHj880Xtv1eelKkihLc
         Rd19x5KaZovxrED6nTu34otvBxCQ4zIyd0Q49iRyXxHqm+vEOMj+QbNh0L8PzNEkHgOV
         OeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128829; x=1697733629;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YHF9YtAywaLSZ4QgrHB4ZUzNaY0pz+zvYC0Cc3RIf4E=;
        b=d3zjFu4Wxkx00AcqZBEUw0qHebfMptsXGKYQ/esYlSEGYHpqwkHYL9BX8iwN44s4aJ
         GA2xCY9uHGlQ/2V/a/UozNHYU7HxjV4j+xhZ8SoyJtzNucTW5euePLn8L1OHneuymfWp
         gOJdFlRjSrdeHeNcgGCaLPiZjMmt5vwO4ajwBxLlIxr1bC8cQ5InLme2w39I3ku1iJau
         QMlUcX2xI4nbYjtr1uLMU3rlV4KEm1R450GreZ3G6xACSPtyTu/yhD8G+4PeeZVopqF9
         UQiDOdv9quz9XhuPGh2QicCDEjmlPfQNVFnE7WRef08mzFaIID7CFfRJ1KskVfxAkDC+
         KjvQ==
X-Gm-Message-State: AOJu0Yxw+ro0TLD0JiinvsfQMXzXep0dNTctapfKv3Tx5BUaArDGuL1E
        ivuM6jM7Wpn+JLp/KjvLpjVhAA==
X-Google-Smtp-Source: AGHT+IEDPobvO18k9l1ohDFOUBrCelHZYp97YD+pzZqpBeLWBLVTSfWhTmZc2My6gDtqY0/Kt/zcHw==
X-Received: by 2002:a2e:a0c8:0:b0:2b9:f13b:613c with SMTP id f8-20020a2ea0c8000000b002b9f13b613cmr21930353ljm.2.1697128829584;
        Thu, 12 Oct 2023 09:40:29 -0700 (PDT)
Received: from [172.30.204.175] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id p9-20020a2e7409000000b002bfe8537f37sm3633373ljc.33.2023.10.12.09.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:40:29 -0700 (PDT)
Message-ID: <7141c2dd-9dcd-4186-ba83-829fe925e464@linaro.org>
Date:   Thu, 12 Oct 2023 18:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 09/10] arm64: dts: qcom: sa8295p: Enable tertiary
 controller and its 4 USB ports
Content-Language: en-US
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-10-quic_kriskura@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231007154806.605-10-quic_kriskura@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/7/23 17:48, Krishna Kurapati wrote:
> Enable tertiary controller for SA8295P (based on SC8280XP).
> Add pinctrl support for usb ports to provide VBUS to connected peripherals.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
