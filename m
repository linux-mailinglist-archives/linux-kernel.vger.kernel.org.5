Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9878A674
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjH1H1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjH1H1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:27:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C0B116
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:27:14 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf6ea270b2so16339135ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693207633; x=1693812433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7LTe77u2jJWXfijkm7QEemv2cFKI4EhHl0C6kWyEkE=;
        b=cfBHPRr2DHN65PSnddgrSFJq8Ch/dWiFFtJuPl7KttQ4rJi2JstGlRn2jrAdr637Z8
         O5Qa3ODbCihXPAEyMQ7VBbs8D4sLYcjiPhPZehJSt/pRjM8/8/z+LjAsXrUuhCGavQ7X
         2QbIzNINn/i5TUtYaVvflpwrzYjWUWp6gYOnGrQSpjyOcoW7YTJV28z6px9J4ut3qOpO
         wG5tnChWq3FWzRpnwz60JKF8WIQ+buK8AxRrAJYsGd0M3/GqlV5OCKmKiN13dXgtp0aM
         9xaIR54lHEy4jH6Z8kcuoC3S6iTG+uMfYe7X7TVzRBk2/aV4KPc/8nJ5GxPh21rW1hkB
         Xm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207633; x=1693812433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7LTe77u2jJWXfijkm7QEemv2cFKI4EhHl0C6kWyEkE=;
        b=kS+gbDdN0lkAuHYH3iCYS1cm39He+mjFCZ4i7ZZ+gl5VPm/0SodU8e05aj1k6iQiKU
         v/VOcuAgodK8aq2bO3CR3XN4RZVm2ksEZCTeMloPnskQhG0vMalVa4+q/0cIjFE4n+Ss
         KrZJxv+V76mERenZus4fJBemI9vLGpZPVR2Fo1g4saimmr2yoZvyB5EyPIW77sQVfEte
         B7UBHV7J4bn2szIV33G5B+ndWEvTRVnFeFMFbCsnrtCj//1sIeJuGDYIaSgraobEIb+7
         qsoZ7rRJ5OJlT/izXv1vCBzs47ywhpuAaVORN82yGYu/2xg97AQF7yTOFnqyCr2Iu7Zd
         AxGg==
X-Gm-Message-State: AOJu0YyfbvVrWjQ8rbefCFfCtjRsfAdR49IZBZDdIB8LtpNEK7xhHG0/
        N6yQkMpy4BVaSARkNx56SHWeNlhrzZw28cVJoPY=
X-Google-Smtp-Source: AGHT+IES6SWXgDVKXVUXcmuwLa36F/lx5+/3vIjCoxyeHUpzFETJo8NAhiCGlIjnQxynOtJdu1qHbg==
X-Received: by 2002:a17:902:8c87:b0:1bf:1acf:6da9 with SMTP id t7-20020a1709028c8700b001bf1acf6da9mr17161295plo.38.1693207633674;
        Mon, 28 Aug 2023 00:27:13 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id j10-20020a170902690a00b001b9de39905asm6535931plk.59.2023.08.28.00.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 00:27:13 -0700 (PDT)
Date:   Mon, 28 Aug 2023 12:57:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Liao, Chang" <liaochang1@huawei.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: governor: Free dbs_data directly when
 gov->init() fails
Message-ID: <20230828072711.7qvgnreioskgqpkd@vireshk-i7>
References: <20230826012415.1126955-1-liaochang1@huawei.com>
 <20230828065625.ufp66goznd72rcyh@vireshk-i7>
 <0c50a3da-65e2-eb91-95ea-6a2ca825c16d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c50a3da-65e2-eb91-95ea-6a2ca825c16d@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-23, 15:25, Liao, Chang wrote:
> Sure, less copy-and-paste code is better :)
> 
> Do you mind I copy above code in next revision?

Please do.

-- 
viresh
