Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3321C779FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjHLLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 07:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjHLLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 07:46:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E286F10D
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:46:37 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe4762173bso4553000e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 04:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691840796; x=1692445596;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a+JGjneC4SRUqtftpqJOx/UsXT5c6LOS8fWfDoVSEc8=;
        b=fbdLpezOr8MA2r5ZjKo7SVwa6Djije9nmePF60bF5kcHJuRMa6gifRjWhT0sVDQVGx
         Kxjzv439JapkUrPqZzqdjrLpxo7PyQ1Kyb56T1hB3sawqECtXGFK4w8AjQ6BoZB/t4RW
         9aPkjviXGWwrPmYX9dT7WO3mx8FttYtnQ4miNY6JyKQQLrQZh9hvo7fcLscIqyb30OQe
         i4K5jq5awb9JuTUgF39Rq4QYtmbi43Nv9Y2/qkYxuLAnsq8GK2bIqJZ84T1OtyNhfi+F
         kHQ/bfUF+O5dpamgfv7vszUXmpurCYGzKEPn93hd1HRp2FUPO62WgN/J1khza9UF5IRR
         0mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691840796; x=1692445596;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+JGjneC4SRUqtftpqJOx/UsXT5c6LOS8fWfDoVSEc8=;
        b=k0KGFyWscjAt7du6+w37c52+IAqGl6qaapR851YItLDNgpRni7gjv6Vesaax5sr2gd
         UN2bxwUpzM9sIukg9i1G8heab8smoJxIRhBYRxHsooJrxlxBD1Fjk+Nr5SaNFe6Onq/s
         I1kRdcjgdh0IL5zQXWcCY9yV+ggaDjdVTq8j97dBbLQJ2OC4CGoRftk6eIHVnP5JtedQ
         oiT6A5HQqg+0IeK23+PR0lqYFzUgiWr35t24hOXIMN06K1XiAIcK/1aFM/b4nYpxh3NH
         InjsAFE6a3QJuFxqMmNNd+gI4oGkVQ/FP0TJpggoVc55r0OiYElIaBpqtPmLKEGVGpZ5
         lFxg==
X-Gm-Message-State: AOJu0YyPFJLT/wEAxyaiTonv+un+687ZziXjhwRF507fd2h4OBJUx9nG
        lD32RSmUgiOcxSnYskvvo8N3iA==
X-Google-Smtp-Source: AGHT+IGkoFOmVvMzr146QLzZz2N6QVOZN15DXr4roVYFSqmXFFsfZNXotCiP7Vgsx5gle7sTPSljvg==
X-Received: by 2002:ac2:5399:0:b0:4f8:bfb4:e4c4 with SMTP id g25-20020ac25399000000b004f8bfb4e4c4mr3039008lfh.19.1691840795877;
        Sat, 12 Aug 2023 04:46:35 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id p24-20020a19f018000000b004fdc5557a70sm1098079lfc.141.2023.08.12.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Aug 2023 04:46:35 -0700 (PDT)
Message-ID: <b93bd745-fd93-4317-a16b-1aa05a34d60d@linaro.org>
Date:   Sat, 12 Aug 2023 13:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] arm64: dts: qcom: msm8998: Remove AGGRE2 clock from
 SLPI
Content-Language: en-US
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-rpm_clk_cleanup-v1-0-cf6cd5c621d5@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v1-9-cf6cd5c621d5@linaro.org>
 <43afe706-5765-a8e7-2bbe-d9b21ec7a06e@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <43afe706-5765-a8e7-2bbe-d9b21ec7a06e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.07.2023 17:50, Jeffrey Hugo wrote:
> On 7/21/2023 9:36 AM, Konrad Dybcio wrote:
>> The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
>> within the interconnect driver. Attaching it to SLPI was a total hack.
>> Get rid of it.
> 
> Nit - why do we care what driver manages the clock?  DT describes hardware...
> 
> The entire SLPI block hangs off the AGGRE2 bus, so that bus needs to be on for the SLPI.  I agree that AGGRE2 is really an interconnect device and SLPI should be a consumer of that, but we don't have 8998 interconnects defined yet.  Seems like this hack is still needed.
As we concluded in private, this has no effect as the clk-smd-rpm driver
leaves that clock dangling at FMAX anyway

Konrad
