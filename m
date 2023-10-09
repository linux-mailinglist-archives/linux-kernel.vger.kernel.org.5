Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723D27BECA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbjJIVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbjJIVQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:16:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297B8192
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 14:15:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso18494431fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696886111; x=1697490911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GF8sVvByPhILrt0ONAgfOaeyuIu1HrfcOafsBj1Kszo=;
        b=jDW6Nw2XwVMmxv3s8Jy+owRjhpcl5rJmP3z0COTeBVfsRHY9GcZUB4KPVeRQSXZH9D
         4MLHVGV1POq1NppcUkViz3eI+FU59J5Ehm57PoONo/2e1ORENe5noa6zeUVgqrQGrrFo
         CNJh5uv3xW+mhwd8G64i0pvvugzbzAzpF/Q+WAs7AIbEwMWkMzCjqo3eDS1M0QacNhjH
         vTyv9oWjeWlhCuBaE+5lfeXcxEsxQTg8fktc902n5xmIA07DOQvQUr2YKbMqy5ZB6ID1
         XAbQoAR69MwFli0bPcNhzFyFhGDcn+hPZHglfYqSirAIoJdNJ6iOLaLwgQy6YNDRk7Xg
         bm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696886111; x=1697490911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GF8sVvByPhILrt0ONAgfOaeyuIu1HrfcOafsBj1Kszo=;
        b=THPrepr4xUBnbF+ySWL8b/9k3Bd1nHvfd++JKL5IUBJhE8rz/kCpNammnfCz/iuuqC
         5m3cYsqdgPQF2+CLL2AEpeCQMYgfL4ehboi69hWhTKdCVUnuJj2c7/8KugE7MRQEQ5oj
         eH0aK+2zzHCYhaxRKBafX3HlNlrH6NGTQn34qqXBD2UtpAe44ssmi5yHFenko4PG3ktt
         huAYjGmhUP2LBf6zH/sFo/nO5Br4N8Kub3tP2V99wAxtv3fhyJmesD10fEAhB/Ti2Br0
         Znijj3qhOrpsU0Bdcx/xIH2UkK9RtjtIN713QMkQhvrEzRxUENpo2WP599Yus0QSs86P
         WILA==
X-Gm-Message-State: AOJu0YzNhB0JpY1eLk3aI09zhffhUgPfq06YGB30FiUNzcgO3UFElKIA
        oA2eFlLv29SI9zuoCnK1nZPSZw==
X-Google-Smtp-Source: AGHT+IHPANy7utWKq+Nt0JGanJ/qxGKrfFVdkzSlLFJqrNsi+LPmEIbl3s9Am1RcS03FjaY5Al1gyQ==
X-Received: by 2002:a05:651c:2049:b0:2c0:12f9:3b7c with SMTP id t9-20020a05651c204900b002c012f93b7cmr10214544ljo.11.1696886111428;
        Mon, 09 Oct 2023 14:15:11 -0700 (PDT)
Received: from [172.30.204.90] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n10-20020a2e86ca000000b002c029a4b681sm2175771ljj.15.2023.10.09.14.15.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 14:15:11 -0700 (PDT)
Message-ID: <c4d418b3-86e7-4768-8d18-bf0c05690ddc@linaro.org>
Date:   Mon, 9 Oct 2023 23:15:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: qcom: sm7125-xiaomi-common: Add UFS nodes
Content-Language: en-US
To:     David Wronek <davidwronek@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Joe Mason <buddyjojo06@outlook.com>
Cc:     cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        hexdump0815@googlemail.com, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20231007140053.1731245-1-davidwronek@gmail.com>
 <20231007140053.1731245-7-davidwronek@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231007140053.1731245-7-davidwronek@gmail.com>
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



On 10/7/23 15:58, David Wronek wrote:
> Enable the UFS found on the SM7125 Xiaomi smartphones.
> 
> Signed-off-by: David Wronek <davidwronek@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
