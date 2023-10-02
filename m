Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F247B4D1B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbjJBIHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJBIHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:07:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11E8BC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 01:07:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4054496bde3so144515345e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 01:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696234038; x=1696838838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lAKzSdJ0JsZA3KIMeGO1s7/CEtUUUhbELYzhrqen194=;
        b=cc/HHdJCVO9GWYunefCL5QbZiX1FbhSPwtiY2aIOBbwmZwZWWIccNoIjcrmSNZDCP3
         OC/eWW/whqEcY8+syHqNWuJLE88qrJUEXTrRge9bk1I3mzEtMy1uFprWLEealRT6cEjH
         ZVeM+9P705MekX0Q6frLBobl4oMEK8jGhskjXtyMwwUiwZ8oveAMRvab8jwGaGEgj/zy
         z015OrKAQ6rBaRr3Q9LRlIBQwKNmQ1ks5FkA+6y81J5pTB4rd7QPYgw7xVXAAa1NQoBT
         Nnyk3cQELik5YgwEvGiRZJkhGAN7HLiUt0+MARwgmbnummjbrpEicRbLgnSA58uMASZ7
         VkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696234038; x=1696838838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAKzSdJ0JsZA3KIMeGO1s7/CEtUUUhbELYzhrqen194=;
        b=I8C203RRZXy9Vigdx2pMfpBqJp4Dd85R9z1liMtDjvtyZu84CHO0egvs4xYEXSFZd5
         8J8ClMtR7FqfHYjbkDOU3w5k4MF5m5nnPcAQiPOmUa/qwG4NKRvbX9/oyeczb+vIINnw
         VdpLnRxKAy31JX0THhfb516a7VaCf7vUHqVsQS/0zaSu99drM5b3QIE+/glNfbQeHnsS
         i4QP663nElFCkze0etZuePQnerUaLVmFI1MpC+/XTprXuLLSw41POX3AGPzimCYWleCu
         S23lF8/mYNCkr1CZt4HQ0vTYtuQM4gVriQneKLEoeveXR77r30jLcfGKlCjB2vnpSE/t
         Bd7Q==
X-Gm-Message-State: AOJu0YwnopaVJjhnXLlCpnRauHBE4hMQpVXoY3/qMRTkIEuv1b5qBy36
        bNQbbw0Ms0oLmfTKrGVnNliUOA==
X-Google-Smtp-Source: AGHT+IFtc4bd0fdHHEBrIhYWEABY3pxlatfdm3R8BFokjKerArw/9bPnHh1oWdM1qlF1QWVMCGe7sQ==
X-Received: by 2002:a05:600c:2242:b0:3fb:a0fc:1ba1 with SMTP id a2-20020a05600c224200b003fba0fc1ba1mr9209291wmm.35.1696234038095;
        Mon, 02 Oct 2023 01:07:18 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k3-20020a05600c0b4300b003fe1fe56202sm6685642wmr.33.2023.10.02.01.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 01:07:17 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:07:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/27] staging: iio: resolver: ad2s1210: fix use
 before initialization
Message-ID: <1b366292-6e05-421e-914e-6d3457886238@kadam.mountain>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
 <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929-ad2s1210-mainline-v3-2-fa4364281745@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:23:07PM -0500, David Lechner wrote:
> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> This fixes a use before initialization in ad2s1210_probe(). The
> ad2s1210_setup_gpios() function uses st->sdev but it was being called
> before this field was initialized.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 

Fixes: b19e9ad5e2cb ("staging:iio:resolver:ad2s1210 general driver cleanup.")

This would crash the driver right away, on probe.  It's amazing no one
filed a bug report even though the bug is 12 years old.

regards,
dan carpenter

