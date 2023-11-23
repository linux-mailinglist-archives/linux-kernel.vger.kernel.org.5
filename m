Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0587F5982
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjKWHmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjKWHms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:42:48 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F27F1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:42:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a98517f3so700313e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700725372; x=1701330172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=At+FPC018DKf09p2RSe89eFy4wA5oTJyOpytMU4kgIU=;
        b=o4L739+AmdJB64pyw+JMVRlGSpYRDtjp4sEo1+fokZdYxGG6Ugx4r4h0pk8tYRGRt9
         sOe1tHl4eK7GwGenYZ+0aTUFhSE1c8IHMBLwPJfOHIBqSN1XN+/hKliWgZHf8oaa6424
         iRWI5F7Qzg7eC48YAtuqueSXIBRra7WD3qXQhNiMLo7WJmNHQGn2Cr1WSsXR/oPztWIg
         QK0TJ+kWa6xOShyxtgxmEIZZiXclhlbbf/jDHDNF/r2YHek5BqQM6L/x5T+ucLFN6E0S
         iWx1DFSrOaTumi6bf2rbibi03bKOfXlV77te2SJkSZDsoQa59ZSaQSQz8J0XRPwEoQdB
         torA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700725372; x=1701330172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=At+FPC018DKf09p2RSe89eFy4wA5oTJyOpytMU4kgIU=;
        b=g68Ny+fxfMZbgxCUrmGXW1kLQaQhpVsEfrIklExrQie/gOannuUTLGxQSE7KCmeBtE
         CLQVr9lLSACbUjka1iKck6MWIVxAuvCBYmsNhxLTEcdrIK7/gTk8ttnFbVMf/xB8BDWj
         oX2ymJzQSdKQUUyooGwE58aRqTcyp9xdSBJ7p73p0YLFXCGIULHnotoW6cvgYaQf8pCb
         HIn6ZT4v0yoZctm0kOtWJ2QhX8qOBN3Wv1S6VCXYNPPVFNZr8cOqE2YxmiSS8eZKre3g
         +DXhhNzd0EAxnIUfYBd7cVgzcOCJMsSxmJsJfRlo+eUy4lsy7TlZ8ElQ42ZKsQ2Toh8M
         Z4uQ==
X-Gm-Message-State: AOJu0Yx7Sh1FYc5QPMJ0O14R0CLOKEkUOfXqOAu4tQPGFhkpF5i6dmAU
        aAT8VLhnNbMjXe1tHPwqMpbPPw==
X-Google-Smtp-Source: AGHT+IEmrDJrP/QqVvs9kKyFOG8bQT6cUA0NY7xxSAVNu7mEpFpDXFlPuh7l4xd1U28wFHj3LaJjTA==
X-Received: by 2002:ac2:5f43:0:b0:50a:a82c:a5f2 with SMTP id 3-20020ac25f43000000b0050aa82ca5f2mr2678724lfz.66.1700725372471;
        Wed, 22 Nov 2023 23:42:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0040b360cc65csm1062105wmq.0.2023.11.22.23.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:42:52 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:42:48 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Laura Nao <laura.nao@collabora.com>
Cc:     rafael@kernel.org, lenb@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kselftest@vger.kernel.org, groeck@chromium.org,
        broonie@kernel.org, robh+dt@kernel.org, kernelci@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [RFC PATCH 0/2]  Add a test to verify device probing on ACPI
 platforms
Message-ID: <4f1283d4-1c50-4aba-ba54-b9ea975bf61d@moroto.mountain>
References: <20230925155806.1812249-1-laura.nao@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925155806.1812249-1-laura.nao@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your talk was interesting at Linux Plumbers.

https://www.youtube.com/watch?v=oE73eVSyFXQ [time +2:35]

This is probably a stupid question, but why not just add something to
call_driver_probe() which creates a sysfs directory tree with all the
driver information?

regards,
dan carpenter

