Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B2E7F983F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjK0EW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0EWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:22:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651C012D
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:22:31 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd099e3d3cso2055989a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701058951; x=1701663751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bq2OIvsQw3yJDsb81W5Mt1xLnrV8cPqvxov47jnGU3E=;
        b=io+j2SWs86aMk6XiysZeovilUIPjZryrsq1a46QqFrJpxKwnJbR7T+YbzDNkAKlB0o
         KpXD+p/y2N0CBjnqhHtvJVecgRxVp+zWUDzD3sDpC9wT3BffrbGOFjgc8Xrl4ZV953NR
         Eso6ud4t9XfJnPT+gzLqif9QdJ8h5tAbgE8KraMuVZGsuFcV1hgedGM6EpV6REoQxyVh
         lLietStSols77gFL/fQ+SEpGW2IoXMRbV4eoDaI11GDgVSaRhjDYcb+3BYHSqQx63UHG
         lo7da2/GdnDCCByrOtaosOcTiWqz6J2MybZph2y2BFGjBW6IW15gyAzXUwURQXZHDsk/
         /CbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701058951; x=1701663751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq2OIvsQw3yJDsb81W5Mt1xLnrV8cPqvxov47jnGU3E=;
        b=G3dB2Ca4rfXQPVQ+nbmQ6ykx6KRT7xbdYFl2quXlRnFhmxL72WRQ7hRuk+AKS0ryBw
         nyfKut5ro7lEpFotFSkgezytOaO/ZKjfmTLWSXt/awQ2Jq9oWKqQNw0XqL3sM/E+G6eb
         MAwFoKT8Wkn+tN20+SpVhBldJSd9Gdw2XgMOA7Pg2ELEz1quuFhCi7BQkdjlPPGD/Z+7
         VT3//SeOjjMMve6MjV73mA5OIMmATVU0wetiiTbGv7gOUzKmZlipqxTOLqpKxXugOnI1
         IBm59f4pFXxHJxxLC9g3FpFh+Nt6QjxN+rTXI8XI6FeDTFnVaE3NaPt46lc+50vccjwV
         QkLQ==
X-Gm-Message-State: AOJu0YwqWNFATpWh8SiFVshMdvQBr44vPjAR2RxyTzCf6LIe1T+CNCRT
        /BcoZd4D0APTzyn4O0N1ieQnHQ==
X-Google-Smtp-Source: AGHT+IGFEXhRAOn5CY2zMCs3iQysk61vGPlq7O2TnXotwEs0JLtBXK4N+r7uWS6tnGuj48E/eqXnTQ==
X-Received: by 2002:a05:6a20:3d1b:b0:18b:556b:6d54 with SMTP id y27-20020a056a203d1b00b0018b556b6d54mr11551163pzi.55.1701058950813;
        Sun, 26 Nov 2023 20:22:30 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id j3-20020a17090a94c300b00285994cf711sm3853499pjw.33.2023.11.26.20.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 20:22:29 -0800 (PST)
Date:   Mon, 27 Nov 2023 09:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 0/3] cpufreq: qcom-nvmem: Fix power domain scaling
Message-ID: <20231127042227.diyl2wlbo72ib6px@vireshk-i7>
References: <20231114-msm8909-cpufreq-v3-0-926097a6e5c1@kernkonzept.com>
 <20231123073901.meb7p4yzueg2lkou@vireshk-i7>
 <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrst+j89nPsrfAmkzGBLAwZ86WWQ_agnd6MHCfR+7FeFw@mail.gmail.com>
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

On 23-11-23, 17:14, Ulf Hansson wrote:
> Assuming you are going to send these as fixes for 6.7-rc[n]?

Yes I will.

-- 
viresh
