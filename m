Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7532B759E49
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjGSTMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjGSTM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA568199A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689793900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F8XGxi53b0PEdlxoh7O8cl7xJyRMkcuJJYP/JuLoaN8=;
        b=SRxE7/HP8H//Wg/zEmb57Oh398h2MBvK63J5wbgE9mKOdEhkI0bCMqvvYkNVz7SiQdy1+n
        dkkJUo8EJUTKYE6LlVED4aztfbphjsgCrOwnKGc6OwzyeVMpV+h0Y/MJONSKxpD35PvhPF
        53Igcu5Op95vHE9uUHddu6LNj5U9Mkw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-__ui0w8MMKef19n0jhQzTg-1; Wed, 19 Jul 2023 15:11:38 -0400
X-MC-Unique: __ui0w8MMKef19n0jhQzTg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so39101395e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793897; x=1690398697;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F8XGxi53b0PEdlxoh7O8cl7xJyRMkcuJJYP/JuLoaN8=;
        b=Lb8s2SupZs1d+rcn6LAU4q8chrgCZBkSjwJXX3CXO99awdfmc/nkhVh4R/KEBbFvuz
         R/UWCcMi+ZzFZoW53b92eD+zqN4NU3e6ezqDYWpkWQc8sfmHEQCYhnbsPaC7eQl4aBEL
         19Zy2jLQYXIgR4Th1FMIKH3/EJaF/LU0QNW1x9x4v7M+irafjJ5x5flUhdftkJPg2EAN
         YaShbLd2VbjXr/luz3OMVayF8DzXpuMiMWtrzMfijocaZJm7S3FHzfYhwvGefQlOcfqA
         9CFv1AvWNeL5c1NXT/8pe6wqTT+qSYyApSFgdjoFLj/f7M8/XZFJffNtw6Cv1kXm77SZ
         SvYQ==
X-Gm-Message-State: ABy/qLZN623Fno1yCWhkmpwzGEPjaqVuZ0v8sIXJJNka5sw6AIDg6dRV
        JGj8AXz/7jxi2NUsREcrwC+m/LVZpha9xq1EsDICaF2O1onjfxkLbteMXS4DpiXwNz9cCkAHbY8
        BLAcooW6M6s7PcmiB5Ej0Cv1OPA5T10As
X-Received: by 2002:adf:de85:0:b0:313:efed:9162 with SMTP id w5-20020adfde85000000b00313efed9162mr592379wrl.59.1689793897427;
        Wed, 19 Jul 2023 12:11:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGAEpZ3HnNJFf0EXDQ6PiNnXG6pJ7iZ6T6kGVVDyiOZcpi7AONcMjyvvGq2mav4MkZGW/OMOw==
X-Received: by 2002:adf:de85:0:b0:313:efed:9162 with SMTP id w5-20020adfde85000000b00313efed9162mr592365wrl.59.1689793897094;
        Wed, 19 Jul 2023 12:11:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c3-20020adfef43000000b00313f9a0c521sm5973293wrp.107.2023.07.19.12.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 12:11:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 05/11] drm/tests: helpers: Create an helper to allocate
 a locking ctx
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-5-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 21:11:36 +0200
Message-ID: <874jlzk97b.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime Ripard <mripard@kernel.org> writes:

> As we get more and more tests, the locking context initialisation
> creates more and more boilerplate, both at creation and destruction.
>
> Let's create a helper that will allocate, initialise a context, and
> register kunit actions to clean up once the test is done.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

