Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275A87B04F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjI0NIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjI0NIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:08:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866D192
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:08:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231df054c4so7064465f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695820119; x=1696424919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pb6DmiN9DOuXmTodkw9UpUp8rbwPzi19pk0azXzu3B0=;
        b=PMwa6IFql0wakWK0aXgQU4vdff0vlZvmgsUgB6TkAevWOAoUmn4KatsVRpnkyiYnlH
         XVInmWM+msvnThYtuViNfouJI4PD8OnR3NQVSKlMhRigUlDt2e95luJki4sYEyO2kJHZ
         EqrXmGxiMplITDZ7VOnlgSkuoVbnxeogbYLeJCnqk1te1fiZ19gwOcnRyX0JWAqs7VST
         /9Pbl4bEfBjUy/PZK5NuwkYK/sGefPQw/9bvNDQMR/Ak5Mbs1g0Lkabe8iLRVnSnLWKt
         FgeRdzhEdpGiPVK803j2eL4HjqOEBzuXkMJoegEqiutE+1gSWTpF7rXPPVhHGkYlKYDH
         E47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695820119; x=1696424919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb6DmiN9DOuXmTodkw9UpUp8rbwPzi19pk0azXzu3B0=;
        b=ICtJNplkxObco/+kpk4hBV9MTRACGM5es9WwAKlgBLb2sVA/wsdms+BpJkFzh1vpvG
         0fCtzPGM6ENA6rGCoRr9wyGl2YjZEROM6WLbNeRzTSXpMLGx+EGXW0moGUyrO03oYQrB
         bTmL3EjSoFmQSMQyUhbIlVOaFwl7lHPZpBHAJ0tzTRijwnVN9glifVeGsfnX6Js+U/nE
         VpN5XEos6g4HoHXvJomtERpCwfQ1iqJwAd70kTn3UJkfptCRZWFa3vd//+JenKQYKNfb
         D9p4WoxmGhqwQFZTLGi+ERftEK1ThY62L3eQMJ/dJBBLuSaxz9PRFb4m7wjZbiZBiwOk
         maLg==
X-Gm-Message-State: AOJu0YzGL/LlTsz+yem5sbDTLYNmtB5L0DXoKH4VfIpEdGplnH9tvEnQ
        aWM8bpg/CN7D1y7xYu9OIOI2vg==
X-Google-Smtp-Source: AGHT+IFpwsSlugV5jwUjCr6yrXSWMakD4wYMDoTEu9lILmxH0Gr2BZKmEWFisrj5G/OOXsw2/52Diw==
X-Received: by 2002:adf:e5ce:0:b0:31a:dd55:e69c with SMTP id a14-20020adfe5ce000000b0031add55e69cmr1756496wrn.60.1695820118956;
        Wed, 27 Sep 2023 06:08:38 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm3139370wrn.114.2023.09.27.06.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 06:08:38 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:08:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Gary Rookard <garyrookard@fastmail.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] staging: rtl8192e: renamed a variable
Message-ID: <cb28b28a-64d1-4a38-942a-cac31e0dd48e@kadam.mountain>
References: <20230927112635.27637-1-garyrookard@fastmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927112635.27637-1-garyrookard@fastmail.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 07:26:32AM -0400, Gary Rookard wrote:
> Hi!,
> 
> This patch series renames the same mixed case variable in (3) different
> files of staging/rtl8192e.
> 1) rtllib.h
> 2) rtl819x_HTProc.c
> 3) rtllib_module.c
> 

You need to do this all in one patch, otherwise the kernel can't compile
if we only apply 1 or just 1 and 2.

regards,
dan carpenter
