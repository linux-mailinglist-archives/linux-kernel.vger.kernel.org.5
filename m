Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C6978DFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjH3TOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245254AbjH3O5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:57:49 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49DA3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:57:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso50461505e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693407465; x=1694012265; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqemnr3YXLcMa00GXyksLgFMXhdfztrwLhDKDDYSTJ4=;
        b=ouJhoVjAQdLBgsYMKuyS01jYN2b8iyOa1lMIjB5ZUyP6PWOZ35hveqSwjVWZz4bGBM
         7rtVKu71lBjU/Fw7T4FMbo32aaQxunfLLv5l8kLONj8MrImEWU6Xc17QtSkfhOT1ZzOL
         ITbTWviI5jKu6SUNQtKvssbtKf24/PXBWuKcxy93ZGPP0lhAS0wbh8hODEELdGZDfoBH
         h1JqvYwPGktwtwYagQvmzb9zaF17CviUKKS4L6kMnIKU1iZJQYOj2IY3J+Myuc8cdG3m
         TS3FBn9Cy9ramvaxYWlSGXiae74hOXW0jFfNNf4jp5a8tj6wQ9PJQTQIki5/fT53pbxa
         eoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407465; x=1694012265;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqemnr3YXLcMa00GXyksLgFMXhdfztrwLhDKDDYSTJ4=;
        b=To1VP+ci2gXbu4uCRpQYcizoxrxt/pUbXfUTf6U4sWupNzKAPAaY1GSjLjgrdjUlEF
         BpJFs9AErj0jGWHAxB50N8yYvCmbeftuZmDrMVc0mlmA1UTGDD3Rh0JDA0hTg6FfhKYe
         4XtBgcJqBO55ELVP/dXCJmeuNCG6T4McZxOFZq8c3ppkLPLWLVuG7Pl0RHhYsB8i74DV
         ETDla9FXDcUyfl/cKxdEi5j7jdF3OzP/De/INCFhufR+O1STxf7zqe7Vuv2DmBU+bzCi
         ybhOCP5kjavSbxoaI3YlfXDuskKQV/Le80AW7r01fbvutxRMnB+z37apmdAx503Z2hBq
         dhNQ==
X-Gm-Message-State: AOJu0YzeODPSJemk7ggAqfCUJG51EQbahJ9esKOHsQ7lUHzKKy89RQXH
        XRFg/xa1nDb46Y1E1mql9GriuwxAjwI=
X-Google-Smtp-Source: AGHT+IE23ostgywF83txDTyJigsSGn6/8aW/tM+8D98OYPPjUs8RWBsVm8AtMKVWGgh6HA0TyT7+dg==
X-Received: by 2002:a05:600c:289:b0:401:b53e:6c50 with SMTP id 9-20020a05600c028900b00401b53e6c50mr1990260wmk.17.1693407465165;
        Wed, 30 Aug 2023 07:57:45 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8a0:2d00:c546:f57b:b95d:336a? (dynamic-2a01-0c23-b8a0-2d00-c546-f57b-b95d-336a.c23.pool.telefonica.de. [2a01:c23:b8a0:2d00:c546:f57b:b95d:336a])
        by smtp.googlemail.com with ESMTPSA id a14-20020a05600c224e00b003fbe4cecc3bsm2508880wmm.16.2023.08.30.07.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:57:44 -0700 (PDT)
Message-ID: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
Date:   Wed, 30 Aug 2023 16:57:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: WQ_UNBOUND warning since recent workqueue refactoring
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I started to see the following warning on linux-next and presumably
this may be related to the refactoring of the workqueue core code.

[   56.900223] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
[   56.923226] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
[   97.860430] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
[   97.884453] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND

Adding WQ_UNBOUND to these queues didn't change the behavior.
Maybe relevant: I run the affected system headless.
