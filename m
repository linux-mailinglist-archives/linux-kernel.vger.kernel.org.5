Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A06768AEC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGaFFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGaFFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:05:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB79E71
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:05:46 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-268541d2947so2225832a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 22:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690779946; x=1691384746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qMzozlS01EvhKSIYBdj8EYscxDwpJrojnj03ew/Nl0=;
        b=vMLMmIv8UFxEoNtq9lst6r8TdPip2XqlRQvEUJ9YuMmzJFqV+b6HRa4PAkUQhZxqZO
         j7ToKnFaS6g3/+hVXiRXPkUh318Y6LtxrbJe7Dy+Hi9nHKCMPHI2AdnlCx3riwHW8PSG
         FHZO2a58LjQx08bx8UpNulujXQIFJ5XKIBXOjZnymt0MssA00ch6klqlwGB4UiamoAwc
         PUvZkne5Gb+SESf79Wfg1nkXUOSfz7zLsaqmBchMn1aXARh97Y6zLDC14+YwmZDmM2Vy
         OYz5pgoQBxFjnnKPQV94vGJx29No6Tgml8WMDDbBIZC2FNRw5jbXTqkG8JuEnauclqrd
         NpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690779946; x=1691384746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qMzozlS01EvhKSIYBdj8EYscxDwpJrojnj03ew/Nl0=;
        b=ShQd/XmEqmaeDwUw9sPbt7Ktj1Ai4qeuU/KLz5LJUYGNEJFYNBmbTqZbHkZzDMxLwo
         An9Bi66nypazUp3Tq3WrRc1d/HVWtviMxdEy6ULNrpUeFZC2De4Certa8wira+USLIGz
         1G+zJkDIrMnKOjAQ/keq5mLft+4oFQbviAOnJlUIa100jbW2w8QWxpyVzw/VGMyaRhsQ
         7+j/VFhQtOG0chskdSi0GG8pP4FNbrEeWG4n2piAlKqTlNtHUioAohulOC9CoAAoiU+S
         usHGFkVX1dkD01kQ59HswhF1/2QhBa9aVtpESw1+LCaHjC6hLXKlrDSfvtXTKlBZzuFO
         IYWA==
X-Gm-Message-State: ABy/qLZw+dCRUTkTvTxMBLo/9SxF7OLqscgvt3Ei1l9ykbOgTtCIkAU3
        fG26dspWaBdMf3o/azPt9Hbn1Q==
X-Google-Smtp-Source: APBJJlHkHWAlDNYLUb3vJ95nRjSnTPzvUIU0+adOasrwlsSU1tTRCXf9sg7a0lGvv/NSr1nWTOwy3g==
X-Received: by 2002:a17:90a:86c7:b0:268:2b5c:14c with SMTP id y7-20020a17090a86c700b002682b5c014cmr7247025pjv.13.1690779945646;
        Sun, 30 Jul 2023 22:05:45 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a94c200b00263f33eef41sm7076501pjw.37.2023.07.30.22.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 22:05:44 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:35:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: st: spear: split interrupts per cells
Message-ID: <20230731050542.uibx3cwfxzxydhpe@vireshk-i7>
References: <20230730111536.98164-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730111536.98164-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-23, 13:15, Krzysztof Kozlowski wrote:
> Each interrupt should be in its own cell.  This is much more readable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/st/spear1340.dtsi |  8 ++++----
>  arch/arm/boot/dts/st/spear13xx.dtsi | 24 ++++++++++++------------
>  2 files changed, 16 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
