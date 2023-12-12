Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0121380E804
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjLLJow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLLJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:44:50 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B2DD2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso7753888a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702374295; x=1702979095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=94p+UQZSMr4vzrhrrlgBDh7qA10Ar2gYNehd9t2N1t8=;
        b=XT5Mbyv3Zr8jBCPH77HUVad5JJ2aJClR4nXggTqY94575sE3gWwxauF2ib2G6PJDT6
         heUFan95Sc443e2CjghYszkYjqPBNMHC5a860wvgFOUB3btwn4sb+wMBCeCQxnJzujQ0
         M+NznvZKI4GuzdwgwhIAP+AR+DBj+UAr7/Ejc3ng6S5uMfs4MtJZYNESkjnSJylGjord
         jHM/lWxN5omIJtlYc+kml4DmAgK1wOAfzcc/jDtHjCPneVrSyIw3GSQMj/9btVQOCg+b
         WGUX1qXyMfJ4qkZmwmTLLiikBJwxoZ0AeVzQv8+0AgwdiHDcuMIgDShxfhPDwKXIhOv4
         9wmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374295; x=1702979095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94p+UQZSMr4vzrhrrlgBDh7qA10Ar2gYNehd9t2N1t8=;
        b=J7+9nwwyyx7WGJrVK4EmNWAHNPP5IBrgAa0GmkARQ0MG5esFn0dG9nzeZAZ6XunRc0
         e6WMdrzTpcHS/iyFuQmxVTgSqVb+60peNZrIhKBRTztRwxVeiYkKsguT+Jw6ziFz8uSc
         nRZPvSeBhkGZLWbmvZfEii5yPhQeU7DKTOprv2q7nq7Jv5rtvEjUchZk7ljB+4bPluOW
         EGDjjDvAY+0DJpqSLmGjuotHJBjjr0TBgp21jMjq2VfAApVNusD85PoGM+SuoU7B6brF
         U0DLqBstn+C3E8LPgoJf50HaweZB44XN8sgNhbr+6M3PKgK2bdhNAzxlsz469nC4uHqn
         Qo4Q==
X-Gm-Message-State: AOJu0YyAdYU9m4h3h/FQCKI8uZe1gipyOuT+vYDewq+1tFNEJUDaOEeg
        TukdYg+s2969B79mjy6dlXD8ig==
X-Google-Smtp-Source: AGHT+IFh/ureGGq9zRE3/B5cuAd0U9ijHRArtKFWf6PNYbErUOfGEruQxIQQasSQPm0NyCnkVOWYOg==
X-Received: by 2002:a50:cbc1:0:b0:54c:ac4d:f4b7 with SMTP id l1-20020a50cbc1000000b0054cac4df4b7mr3111551edi.1.1702374295419;
        Tue, 12 Dec 2023 01:44:55 -0800 (PST)
Received: from localhost (h1f2c.n1.ips.mtn.co.ug. [41.210.159.44])
        by smtp.gmail.com with ESMTPSA id o29-20020a509b1d000000b0054ca1d90410sm4773417edi.85.2023.12.12.01.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:55 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:44:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        anjan@momi.ca, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Staging: rtl8192e: Remove variable bFirstSeg
Message-ID: <347fe54e-d8fe-438e-a1ec-37900ca41f51@suswa.mountain>
References: <20231210193705.2131807-1-tdavies@darkphysics.net>
 <20231210193705.2131807-2-tdavies@darkphysics.net>
 <2cdb678d-b784-411e-8913-eb7666e08ccc@suswa.mountain>
 <20793387-da59-4192-bb86-b20aeb127a65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20793387-da59-4192-bb86-b20aeb127a65@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct talks about firmware and it has reserved bits so that's what
confused me.

You know this code better than I do so since you're fine with it, then
I'm fine with it.

regards,
dan carpenter
 
