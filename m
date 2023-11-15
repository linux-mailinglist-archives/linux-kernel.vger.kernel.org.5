Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D57EC8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjKOQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOQns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:43:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B046C5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:43:45 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507973f3b65so9919356e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700066624; x=1700671424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKwvuedBc9zWWjZXrz7fOSDDi6eG4P0hcIfiBzhjapM=;
        b=tC5cek2YDqCTVA7H4+MDJUh1ywgVPMs3NPLSrIaoxCKKM8XmfIHv/kbMhGLziNjPQn
         86BHDyC9NqzN6sBnV3Bz2Jj+wgbkD6suOxeaq1qETrcK0ZoX+TgsrRk0yJfCrPzBfsWx
         Ek3ZnPqPFhhfKMQ3wF/IE8XRqi1n6rkPQ6mTDtMf7it+5eFp//1ncEOUwpylyBfuv1W/
         XPr4AoeFZNWwP8H3J4BOw4gZ1seDYp+89DBlrpV2oTLb+mqa1GoAN4sZBFyyiJ7fN1F8
         T3w8CkQ44j5xG9xNNpny3DDx4v3+rYx99v2nes+Hq5Gjb8ZZcgGyUZ81Q4txyvUGRM/j
         l+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700066624; x=1700671424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKwvuedBc9zWWjZXrz7fOSDDi6eG4P0hcIfiBzhjapM=;
        b=nDOEAFw7Yz2h0XFlWH14N0sJl7mIomN5Tkf15akOVPD7yebQfVsO7y6kov+J3H6BWT
         l0GRJqBogdeKVe7W7NppeBrTEw9lujAul6hHldxYPEZNii5gfan/UTAle8GeneRPn+c3
         iHbMgoLzwlJeOqEcKOXOY8vjnmKRy2VjHuJsIJevesSUMyjnOchJKu8Lroih+dtFHP6S
         iUEH3O8bvhUN6X3Vv/uuNM9QlejeU8DYrSllw7OVAqsCdbgUee2B62hWIGhFfV0l7u9W
         +LonAmifWIYi0JxoImdns9E518IPaF1/4s5EexgIMnikBXT95nINduNDgHWspW2flZSl
         vjfw==
X-Gm-Message-State: AOJu0Yw0LszH2SvD+RA1TiZlhYhHuKOnGd7OU/jpyyApLLWIJZ7vTViw
        dtUYCwDLQN/W0TFX8RrlHcWwgw==
X-Google-Smtp-Source: AGHT+IEyO+JuxqtD22IlDEHQfvtuGmYUZnlYNdcdmZAwd7aiUoKMqvknqimL7DYcdHAQ0SP/2ilgmQ==
X-Received: by 2002:a05:6512:3f1a:b0:508:266a:e85f with SMTP id y26-20020a0565123f1a00b00508266ae85fmr9820326lfa.1.1700066623747;
        Wed, 15 Nov 2023 08:43:43 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d27-20020a19385b000000b0050a026d3a26sm1705739lfj.227.2023.11.15.08.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:43:43 -0800 (PST)
Message-ID: <e5b0d8c7-82cf-4a3a-9a6e-28e7b468df8d@linaro.org>
Date:   Wed, 15 Nov 2023 17:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] iommu/arm-smmu: re-enable context caching in smmu
 reset operation
Content-Language: en-US
To:     Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
        a39.skl@gmail.com, quic_pkondeti@quicinc.com,
        quic_molvera@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, qipl.kernel.upstream@quicinc.com
References: <20231114135654.30475-1-quic_bibekkum@quicinc.com>
 <20231114135654.30475-4-quic_bibekkum@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231114135654.30475-4-quic_bibekkum@quicinc.com>
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



On 11/14/23 14:56, Bibek Kumar Patro wrote:
> Context caching is re-enabled in the prefetch buffer for Qualcomm SoCs
> through SoC specific reset ops, which is disabled in the default MMU-500
> reset ops, but is expected for context banks using ACTLR register to
> retain the prefetch value during reset and runtime suspend.
> 
> Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> ---
And I assume that goes for all SMMU500 implementations?

Looking at the 8550 ACTRL array from patch 2, CPRE is not enabled
at all times.. Is that because of performance, or some other
technical reason?

Will this regress platforms without ACTRL tables?

Konrad
