Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413977D11BC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377579AbjJTOmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjJTOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:42:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10751114
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:42:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9bf60bba6f8so24544266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697812935; x=1698417735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmdGY2DeQ3QuZa3JprEPLs51HOFPWavFfPPi299pTcU=;
        b=jzn/YcD84W7UGVykPJJCytGogzV7j7PTdaZj7c3st7VQz4l6J0SZk0eAm7UGTD9Nxj
         MAPls+OIW5P+OuO9cVIS6NwlqqJD8yh13y2rB+Zm4P+3nRu3k8jLvnc6aUXqnjhj8oBO
         b9PjpR8M/XE7modEaMM7wS0piZwdEYiJVlWvJpGabrCmRLdJflHu1J859o4ZrFUOVJBK
         HmAPlihRyPin1BE1vTQlvXCMm1RYM8Upeu8FTqaD2MwVwys+jvtSg8Tu+3NL+TS/5u/5
         x0OtPm5eaEPCvBkMBn4PmVTiQHNqbRtvs9r72XQfcH1vLcMhiJMO7Xr5W194Tt2rBoli
         Ey6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697812935; x=1698417735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmdGY2DeQ3QuZa3JprEPLs51HOFPWavFfPPi299pTcU=;
        b=dQeEu4HRi1jU3sr0TvXt/j5xlpi0WCMvUAyxlPuStPtMrzHOlts/0QB5lKwmjEiHmx
         SDk3wiYp12KFEN8tV3JGHy/mcTpkzU/tZUEFFDW8ph4OFUyOVsue7fJ3ReuAOq5H124t
         uG7aMyLeC7eVFwAt+Bt6TBJdeWbGn5pPc58vkFC4ym3cKAcZbFRDpJVEo8GX5yM4AR2e
         h7EY7CVETmVuCIRuz9J1vRHcA4HYwYyo6tfTQ+J9VD6zcHGxMbNDItYhHB4vddfsZm58
         Mp7hGOGkrXDZ2WI23MyE/EHG11lGyCmzokmiycDWjEdT8B9i4MCemwxVdgkYXiyd1u/k
         e27Q==
X-Gm-Message-State: AOJu0YydD0Fw331SRVbAGQUhZwglNwPTvOPIxaF1vK9AmAghlnK+3wPq
        eVILveDx2GQjXGD1c+fz19Y=
X-Google-Smtp-Source: AGHT+IEyVQVy7e1t/ZdxaYnMB08TNSPxzdFH8EU166lEqF6lOcNJngpybZTTjW1i3BiyyG/Oz/52RQ==
X-Received: by 2002:a17:906:1d9:b0:9bd:fc27:f3ba with SMTP id 25-20020a17090601d900b009bdfc27f3bamr1288762ejj.0.1697812935362;
        Fri, 20 Oct 2023 07:42:15 -0700 (PDT)
Received: from ariel (dynamic-2a01-0c22-358a-4300-dabb-c1ff-fe05-d863.c22.pool.telefonica.de. [2a01:c22:358a:4300:dabb:c1ff:fe05:d863])
        by smtp.gmail.com with ESMTPSA id e11-20020a170906748b00b00992e265495csm1634897ejl.212.2023.10.20.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 07:42:14 -0700 (PDT)
Sender: Emanuele Rocca <emarocca@gmail.com>
Date:   Fri, 20 Oct 2023 16:45:06 +0200
From:   Emanuele Rocca <ema@debian.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: Runtime overhead of PREEMPT_DYNAMIC
Message-ID: <ZTKScoO9kz_LxNMG@ariel>
References: <ZTJFA_Ac6nWawIHb@ariel>
 <7a818250a8f36476f13b57a172fdb1ab23645edc.camel@gmx.de>
 <ZTKDWnLrSnPs9VUi@ariel>
 <c6259a1824e570ddb7aaf114656aa387e028b76d.camel@gmx.de>
 <15e4768144a74b093ad5a43f6e5c263fd98775fb.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15e4768144a74b093ad5a43f6e5c263fd98775fb.camel@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-20 04:34, Mike Galbraith wrote:
> Hm, I don't recall the overhead as being that bad, but thar she blows.
> 
> i7-4790                                       avg         cmdline
> 6.5.8-voluntary 3685.08 3679.93 3704.98   3689.99  1.000
> 6.5.8-dynamic   3571.62 3568.61 3550.55   3563.59   .965
>                 3052.06 3032.74 3019.93   3034.91   .822  +DEBUG_PREEMPT
>                 3651.37 3599.87 3615.18   3622.14   .981  preempt=none
>                 3459.58 3514.09 3539.88   3504.51   .949  preempt=full

Perfect, that's in line with my measurements (~20% overhead). Debian
kernels have CONFIG_DEBUG_PREEMPT=y, it seems wise to set it to 'n'
instead. Thank you.
