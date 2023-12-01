Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764F3800513
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377727AbjLAHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjLAHxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:53:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C3170B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:53:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b397793aaso11568975e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 23:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701417233; x=1702022033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnpedeSocBCRbtfOah0pjGpceoXFEpBt4fqfQaogKNk=;
        b=wDjT5R11U7bBCGCy69qDYkW4efFwLXEbmTLzhGJlgt5SuwxDI6LRoBq9EbQw8Jqb4P
         9LEcUugyt1YPTY89xNrLCabnOx9hoXpjINXcI7X4JISqVRy0WqJO8jqh5iO1o7ilaf5k
         793XGYUnnPE7bLbsjXDXsFJzIExt+YR0+AikqpRJdTE2NO2SAxMd1TTQ5YY5Ndrm3OH2
         NNtGjuLc1rejrKdupsNXlVWUyjQou34WL7Rr+vszLCjSAq0qqJbe4K1I1zIt7LQAbvIC
         FYkS7GcW5BWHmQ+G97Tq8dI/awKzo+HHceEL6qUg/485fq8s8+uVeV1g9/Ar3dALDKsD
         cdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701417233; x=1702022033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnpedeSocBCRbtfOah0pjGpceoXFEpBt4fqfQaogKNk=;
        b=Ld8RtGkURhS0Vo05QfgAedbPRPu5tSZGIQ8nwwuBjiYIaSork2o1BUNumvPov2+B+R
         XyfTyYsiGhH4hplGtZ9l19KHpgmRbCl83CdS4HZxY/F7mNkBaXxEc5h4cJLSjgHiqClZ
         7NCkPNmiN9DqDHq+kzwiADgr2BQFjl9Kabz/1G7045FCPXvNo/MOvrjsmXz96zFO4nBx
         LLgBdpg48XrPa3l69i0ldKbeHqefsObiwhGrOpZmDUWZKKoFjVZkogt1UnitOYL+NL27
         2/qEkoELKRTR1NdLHKmGcBsOSiG+cEYWEmF3I6giLZH6TrSRBp+XuMoPYBtQYFYkWtZ2
         YfnA==
X-Gm-Message-State: AOJu0YwCksW3yP/sjUY6uHC7Sl3x6clpq6Rd8zfFNqYirUgAiBlJ2T1G
        Vx97KAARszA3FThIRHeWxPf3vg==
X-Google-Smtp-Source: AGHT+IH/ROrJyeX4iIdFVBF87rue/OanNTumC8XfVpTFYtF89rY2inQaA0rq5BPHn99Kigq0vO7FSg==
X-Received: by 2002:a1c:7c04:0:b0:40b:5e26:2382 with SMTP id x4-20020a1c7c04000000b0040b5e262382mr379677wmc.51.1701417232693;
        Thu, 30 Nov 2023 23:53:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id je16-20020a05600c1f9000b0040b56f2cce3sm5336261wmb.23.2023.11.30.23.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 23:53:52 -0800 (PST)
Date:   Fri, 1 Dec 2023 10:53:49 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 0/3] scsi: aic7xxx: fix some problem of return value
Message-ID: <d37560ef-d67f-4493-a7bf-1d192ff7351d@suswa.mountain>
References: <20231201025955.1584260-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201025955.1584260-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 10:59:53AM +0800, Su Hui wrote:
> v2:
>  - fix some problems and split v1 patch into this patch set.(Thanks to
>    Dan)
> 
> v1:
>  - https://lore.kernel.org/all/20231130024122.1193324-1-suhui@nfschina.com/
> 

Would have been better with Fixes tags probably.  Otherwise, it looks
good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

