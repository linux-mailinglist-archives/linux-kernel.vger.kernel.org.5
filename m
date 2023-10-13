Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2FA7C80E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjJMIxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjJMIxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:53:42 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99CDB7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:53:40 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-4066692ad35so19391245e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697187219; x=1697792019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ei3TFmaOXq0JADSQLlmEKSbGLvw708qlaZ+x/9kH7o=;
        b=NizVOLAPXroEvmC4Z5dos9IDMYeHc0pV9F9J4foWsB5B7YhtN+s5WNXJmJzeoW43rK
         ntND51Ey2bREBeM4L3ZSLHr45JRTcS0uLIm9NLJsScVn0nP6z91d7/v8PxM52+uKeead
         OlERpZR/aNzVk30BPNrbiTQgsQ6ZRWc8ntLCi4zExhn4uHVDOiXI+RtzqMmhRkiLJByt
         YoCUrb3iNSHsSz8fQlLSEd9FF0+TxINJSoPv3an2D0eIpU3e/A6lPUqQeGmcsav3JJ7H
         OVD3g//cpWKXrcl9o/JXWpd4nx5oQJrr6GuHw2V8f5Tz178DQBkaADOgW6020FFWRDMM
         3YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697187219; x=1697792019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ei3TFmaOXq0JADSQLlmEKSbGLvw708qlaZ+x/9kH7o=;
        b=I7uu4gBE8ELi8w2N4WeJbtHgN8l6d/B9FIBhSJUJzjMMEpfJnLyNHQoMmnZFfLN/lD
         UtHL1AuvOnDkLFaBFlvjB6HMe4sNorTADYnhOQ6RRrUBQaQBqmXzgDvmbBt2Z6qJrG7c
         yahaAsRu3cm14bwR45veMJtRRRHmiyZdqQDMcruUSwm9DCjNbw8usT4jfIuDlwZwhoYf
         5WD92hmaC4zIl2fwDH1a0R1jWRoiSecRhKWn7A9wTxMtEA5GnKFxg/A71rYWXh/zuYfz
         aPWOInuH0bgnbfg0F3xlZeiOib6h+Bb4o1arg0c4uHbNIryECfZbKfXCaMlF4kIAYNj2
         BGrg==
X-Gm-Message-State: AOJu0YwkUmJq4ipIZ7iMhkrb0+NCGj3NQlY3O0m+8oyt4+JdGaLpAhAN
        xyUN9/9CThkMJUNSzR2lLK0PHg==
X-Google-Smtp-Source: AGHT+IFRJCBZHGcCmfNxL8440E22YumxfhNrSwE+nFVTUb5Jr2JGzm/PdKtsNhGsIufNU8lCz718lw==
X-Received: by 2002:a1c:4c10:0:b0:402:f8eb:28d8 with SMTP id z16-20020a1c4c10000000b00402f8eb28d8mr22460284wmf.6.1697187219235;
        Fri, 13 Oct 2023 01:53:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe78e000000b0032196c508e3sm20215454wrm.53.2023.10.13.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:53:38 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:53:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: gdm724x: Fix coding style checkpatch warnings
Message-ID: <663c85bb-90c3-4ae1-ab0b-5ab1a8abd2a7@kadam.mountain>
References: <20231013051502.9578-1-soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013051502.9578-1-soumya.negi97@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 10:14:58PM -0700, Soumya Negi wrote:
> @@ -271,8 +272,8 @@ int register_lte_tty_driver(void)
>  	int ret;
>  
>  	for (i = 0; i < TTY_MAX_COUNT; i++) {
> -		tty_driver = tty_alloc_driver(GDM_TTY_MINOR,
> -				TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
> +		tty_driver = tty_alloc_driver(GDM_TTY_MINOR, TTY_DRIVER_REAL_RAW |
> +					      TTY_DRIVER_DYNAMIC_DEV);

Don't do this.  The code was better before. The parameter
"TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV" is one thing and
splitting it up like that makes the code less readable.  And I bet they
had to indent it like that to get under the 80 character limit.

This is an example of checkpatch giving bad advice.

regards,
dan carpenter

