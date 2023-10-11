Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF17C492C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjJKFZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 01:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjJKFZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:25:19 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:25:18 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-692a885f129so4999332b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 22:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697001918; x=1697606718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2X9IQoOZGMUd+FMDOO6oLZGueNPvW1McZHYWaIOMgqo=;
        b=ruevlGS30ahfo4JPE/T4VeeQbLNEc3tUIcmXWmEI+r/FnyAyobKIhfzR66O0B3e73o
         /Ne1qBFphy2hZIOnGFNk9N0QyDHfyORgJCy2kHGFNDDyjiOPVwnkpuIzOyshpqXhBhQ2
         QHo9ahV0QdWGqAbSf60p8nqd2WFHNebTo3B1BYF23h5V4RZO2TY3nTuxeqhDgrtqSN8T
         C4T6bdj7OYbfm1xYFva+9t5JZinECgNEq3ZHq8FCegzezzDSxgLYupx94LAnlQfsB7Me
         rd/44bBNthKCGkLGxVQCGGmQxy1iY8ITfw2ue6YfL85QEhYw30RvF7PBIwZcimoEERwW
         6MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697001918; x=1697606718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2X9IQoOZGMUd+FMDOO6oLZGueNPvW1McZHYWaIOMgqo=;
        b=UKi9sj9mxiQakX88sizgiITDUd1sy3P7Uv0/w5NPZzBnrXtPF/831wh5uHK19upWsB
         6boYLhxPufkV1vXmmWh+W5/030d2SY2L/OTMRvRgIXrIFQTTTEg3G1tjbSJroOuEAqkv
         2f5Sv2Sbxb3Qra/6xTNj4B4aBZSSBMO7cT4YDuzTeIQrQxr5wYl4Ya4C8GX5EdYwIPAL
         /QboLdFUDdstF1WodyihZmp49Oy9aEAvc0JH48/SQEz1vTuSziM6gg5mnlk/4jr7cqgl
         7d72zEXkNw31jAvPxtXYqL7IykkoRKwh9k5c2D4fx5AiMlrigO/bPLBy+Wt+JckaWhg0
         4iog==
X-Gm-Message-State: AOJu0YzJkJUzdPp/cr+PX/znNbfMECIvaqaNvu10LchKcg9wrrpfwflS
        ZVYPPZw3fmY58TSE710NQeov0Q==
X-Google-Smtp-Source: AGHT+IETB8Eka84sqAUHw9wYrQ3ztLrc9Q9WpG0L8eY+46cGLJIN+R1z8EF4UGAzwTJfFL4jsCIhyQ==
X-Received: by 2002:a05:6a00:1388:b0:68c:a81:4368 with SMTP id t8-20020a056a00138800b0068c0a814368mr21030998pfg.6.1697001917883;
        Tue, 10 Oct 2023 22:25:17 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id g2-20020a62e302000000b0069370f32687sm9427861pfh.174.2023.10.10.22.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 22:25:17 -0700 (PDT)
Date:   Wed, 11 Oct 2023 10:55:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     ilia.lin@kernel.org, vireshk@kernel.org, nm@ti.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/4] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20231011052515.htggd4jlbwyizp26@vireshk-i7>
References: <20230930102218.229613-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930102218.229613-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-09-23, 12:21, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
> Changes in v4:
> * Add support for IPQ8174 (Oak) family

Doesn't apply cleanly over my branch anymore, please resend. Thanks.

-- 
viresh
