Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA357D39E6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjJWOnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbjJWOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:43:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EA8171D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40859c466efso15668055e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698072102; x=1698676902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u0+KyYoYHk/UMVzb9ufT5X/yFDuVJYSaudNnGVYxEZs=;
        b=AfJb7lAM+8WJyBCl/fyFuW0sbcbJ7UXFj64zflUpcQEUOVMgWRDmbPGr+H/cnnF7MA
         CprCAFHH39vUgYA0Aq4oJg8h6Bw+Zdqb0BOc2F8Y9qPUWMQqkrWLPpB0rW8ExpSDll5V
         vCRHCm5jEQt8yEZ/1fY+3D/GP2xsAfA8dRVxLKlL8SprT8PK8XDbffN25BaXfyocAh4B
         mBrbGjp4fw5HIa3wVOCcYLGOS8/IbJI8t2gvKbHbewBc/wHou8+lfz3uTYxNTwKlgdnZ
         8QfhHpKrcD0rChbAYC+kY9BJRvg2Yzbh3CCye2sXOhkfsmylpDDt7UAKpiVg6vjp4K6i
         /xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698072102; x=1698676902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0+KyYoYHk/UMVzb9ufT5X/yFDuVJYSaudNnGVYxEZs=;
        b=hncqi48/hX0vMAtNOwV8cRQYUJDosx7t5zakHW4jmi5JyMs4i1PUffVOi21CRqPLGV
         a4NFDU/K8qeNL3FtstqxKPWSZTnpKApA2AJIBx+U4QHEy/cIbKXxH52KEbF2Uwmvf+T/
         6NkK75nwKrWpikK+LnWxi6IEw4WGsxY27s5kfMdTaQLb4gghrRLzSXVJjKCUT6jYOwiP
         uLJArIKXda6yzr+gxWUW2SXHwZDtY9YJNaDVayVPni1q2BBwd/uN784hEP0d3hv8TK1Z
         ufn1R7iAVmSthQ0QO+JeouzDppFKYLAiUYxxKXRkfc85kPYANwdN0wf7KNkcRclmkenW
         ihGA==
X-Gm-Message-State: AOJu0Yyh5WHcUvS+DM7vnlcFKNg3/ai50E6uUAh67cTC5OCtmde+dF+l
        GtgN/FUuUk2CtJWm1MgAROhaDQ==
X-Google-Smtp-Source: AGHT+IGxEIbZFmB4AraQ9pR4q3k4h9U2rvbNCkh34AC3yOH97A4Jl2sj3Io4ZVIo8/QLVKu9SbeaIQ==
X-Received: by 2002:a05:600c:4f81:b0:408:55f8:7de with SMTP id n1-20020a05600c4f8100b0040855f807demr5528052wmq.28.1698072101799;
        Mon, 23 Oct 2023 07:41:41 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c418c00b0040773c69fc0sm14127963wmh.11.2023.10.23.07.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:41:41 -0700 (PDT)
Date:   Mon, 23 Oct 2023 17:41:38 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Jonathan Bergh <bergh.jonathan@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/7] staging: octeon: Fix warnings due to introduction
 of new typedefs
Message-ID: <7e866f48-840a-4b9e-a28d-2016075abb4b@kadam.mountain>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 21, 2023 at 12:12:31PM +0200, Jonathan Bergh wrote:
> This patch series fixes (removes) the introduction of several new typedefs
> for enums and structs in the octeon driver. First the declarations are
> fixed and then implementations are updated to remove references to the 
> old typedefs.
> 
> Changelog:
>  * v1 -> v2: Fix breaking change spread across multiple patches
>  * v2 -> v3: Break changes up into individual patches for each removed
>    typedef
> 
> Jonathan Bergh (7):
>   staging: octeon: Fix introduction of new enum typedef cvmx_spi_mode_t
>     in octeon
>   staging: octeon: Fix up introduction of new typedef
>     cvmx_helper_interface_mode_t  in octeon
>   staging: octeon: Fix introduction of following new typedef
>     cvmx_pow_wait_t in octeon
>   staging: octeon: Fix up introduction of new typedef cvmx_pko_lock_t in
>     octeon
>   staging: octeon: Fix introduction of new typedef cvmx_pko_status_t in
>     octeon
>   staging: octeon: Fix introduction of new typedef
>     cvmx_pip_port_status_t in octeon
>   staging: octeon: Fix introduction of new typedef
>     cvmx_pko_port_status_t in octeon driver
> 
>  drivers/staging/octeon/ethernet.c     |  6 ++--
>  drivers/staging/octeon/octeon-stubs.h | 48 +++++++++++++--------------

Please don't change the stubs without change the arch/ code.

regards,
dan carpenter

