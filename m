Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1EC759DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjGSSze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 14:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGSSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 14:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4184E5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689792888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=FiLukfExqk/QOX22sEsb5JdF3Lm1RsRvOhr137zzAgkcTxEN/hVrtFiEDfARHCOcjjVMND
        xvl9MxS/orpZZPj4m3qYb63OTGZxjFrSjCElqhxzqi9u1dAVWWKu3+wPi3f4rIm5Um1KSo
        N90OI0L4fa3CzID2ALKZfl/KHiL9Z1g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458--E9X4iP2OzOnl5Us0inJYg-1; Wed, 19 Jul 2023 14:54:46 -0400
X-MC-Unique: -E9X4iP2OzOnl5Us0inJYg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-2f2981b8364so4344047f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689792885; x=1690397685;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F50ZRNO2TGVX8Kl6rozSN2J4zAo6+Tkfm50rtvi7/ZE=;
        b=Od6VeTawFu1jFwke+Puz6+ou48TPX61c+jNebqlLhVBOqZatPS0zq2IQ6LbdGGtdh4
         NC0m1bGY0L963BaL0kqWVQndrKijeLFxcVxRTQ1hXk/4q2000tFOIWvyikRj+k1r3j3T
         1uoZ34DwoGZJE0/E21sx6uv7VguB+yY98BtZQXG2QEpISrlynGyE6VpRbeSrMzTyCRvn
         NSh6gZkDasv3mPYfM+HrJXTLuZ9G6YTWoMWzVItvNKKIFT3yfiUHTExMqFxyWcNQ40yj
         BOtXjn0PVsSzUQ+MRqeWKOWzCkTo24kcYTMerI0ZuqmD1ucLXWIhe2Qhg4hOvH79AMKI
         uIBA==
X-Gm-Message-State: ABy/qLbEbZn8BMlxnNRm7KMF01jS2jKLq5rPOIQLnHCL+EO8hUtw8Zkb
        fOH0+srXCGCrVTP22bE/Ao4KCIp/cGvmxZaPJPjl98MHsuOIatp64i9Ay7ZBtdpPkFYLNFERwMJ
        e+TsxiKz0iBOnIMI6mnKP/jkf
X-Received: by 2002:adf:f710:0:b0:313:ea6b:6322 with SMTP id r16-20020adff710000000b00313ea6b6322mr598558wrp.9.1689792885724;
        Wed, 19 Jul 2023 11:54:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG2R/Xv30hj6XOpfiOSLt/lvChiKNZCGj3tPoo/DAdnjcpeiROEXlA9fxWU3sBuqdLXHC+8DA==
X-Received: by 2002:adf:f710:0:b0:313:ea6b:6322 with SMTP id r16-20020adff710000000b00313ea6b6322mr598550wrp.9.1689792885396;
        Wed, 19 Jul 2023 11:54:45 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n13-20020adff08d000000b0031433443265sm6008647wro.53.2023.07.19.11.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:54:45 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/11] drm/tests: client-modeset: Remove call to
 drm_kunit_helper_free_device()
In-Reply-To: <20230710-kms-kunit-actions-rework-v1-2-722c58d72c72@kernel.org>
References: <20230710-kms-kunit-actions-rework-v1-0-722c58d72c72@kernel.org>
 <20230710-kms-kunit-actions-rework-v1-2-722c58d72c72@kernel.org>
Date:   Wed, 19 Jul 2023 20:54:42 +0200
Message-ID: <87y1jbhgul.fsf@minerva.mail-host-address-is-not-set>
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

> Calling drm_kunit_helper_free_device() to clean up the resources
> allocated by drm_kunit_helper_alloc_device() is now optional and not
> needed in most cases.
>
> Remove it.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

