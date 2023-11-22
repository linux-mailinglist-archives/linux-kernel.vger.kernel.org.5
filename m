Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69037F517C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjKVUWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjKVUWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:22:42 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD3D42
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:22:38 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50970c2115eso156240e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700684556; x=1701289356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7MrYgOMdKVuK+GDXv9aJD8jhLhCPuIE63O1Ov1GqRc=;
        b=vmMPxghlI18mS/HMiHX2JHnysNomTrXCWD0zL3LTi0eSq2b/lTUElj9ULvI00QbgVJ
         vLm+tWwWATGL6kCqJeAF0vBZ6kITuaPGbr6qlPZIUiFuQJxiIS5iVsUrm3Prp5starms
         I9T2bTWkLWi4ok/RGTZFCk4sLxZdEJJI98Rf/GTF9K+IA6MD84d04PuZyritLLOzm/9k
         JSUJyrrw0wJTDbpKHLwcKAi+NlURaN3YuJXsQqWWJPk7iiCuV5O4vrb/fHCuu9VAlYUu
         F+Hxa1QMOujHRByhH7SGjsn093x/Q7dSHcFsp0nYcsYKDiAw6gVDQr76KiaUIUWqFZum
         RujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700684556; x=1701289356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7MrYgOMdKVuK+GDXv9aJD8jhLhCPuIE63O1Ov1GqRc=;
        b=PCqBmhPFYCrXKKqycJjVWT+KpbDYnUcFIq02Mwj/D43u257HAipzw54rj3cz59fXPP
         ICXeXaVYzHi0sE4X00pwQbE4HZjXyQFIuUqrTINhwHRDBdS1jjz/cFIm0KMci+TM2FIQ
         Hd6poUC4YbWVBj/PqPuDT/HbXbwTdXPojABZ9l+G7Io3gYAXl61xrP9zDeLpGrSrhkpe
         d00ufpHz0073/oQOKUdjy4L+TzwvPppKW97uEWcvMyoR21Xdtwpzk7AZ5pEe+pMKWVIb
         pEAaHWPgBZU0Sany1k34gEWPqYcwHR8y+VFWy+I1bt32sCSWneX+GTd1WOKCAQXbU2LW
         vb9g==
X-Gm-Message-State: AOJu0YxQGPDsnyVUGU98wQC0v1/aeSEwkkAb/CX9Jn3PIQSXA4LG/7MR
        zeftYV6d27aslmg1O62GLUdLyA==
X-Google-Smtp-Source: AGHT+IEhleik4LWRMe/dmf9VTpFWeI3uN5MuNWVtzwF5hLzAKGpAJN5yXMeSzO52dXBTv06mOretFA==
X-Received: by 2002:a05:6512:3c95:b0:50a:a5ab:e393 with SMTP id h21-20020a0565123c9500b0050aa5abe393mr3366084lfv.61.1700684556447;
        Wed, 22 Nov 2023 12:22:36 -0800 (PST)
Received: from [172.30.204.74] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d24-20020a056512369800b005091314185asm1952576lfs.285.2023.11.22.12.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:22:36 -0800 (PST)
Message-ID: <81a8faea-b2d3-437d-8923-954569969bf6@linaro.org>
Date:   Wed, 22 Nov 2023 21:22:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] clk: qcom: ipq5332: add gpll0_out_aux clock
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231121-ipq5332-nsscc-v2-0-a7ff61beab72@quicinc.com>
 <20231121-ipq5332-nsscc-v2-5-a7ff61beab72@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-ipq5332-nsscc-v2-5-a7ff61beab72@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 15:30, Kathiravan Thirumoorthy wrote:
> Add support for gpll0_out_aux clock which acts as the parent for
> certain networking subsystem (NSS) clocks.
> 
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
