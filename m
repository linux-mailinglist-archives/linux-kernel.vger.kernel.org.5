Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266578890E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 15:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbjHYNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 09:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245298AbjHYNw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 09:52:59 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB05B1BD2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:52:57 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5732a32674aso644626eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692971577; x=1693576377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hypiZrNUAlpFpds6qforN3FHopPaWtqa1VnQGLSWLoM=;
        b=jWibQtNGlxQKd+CM2JR3hPEcfbc3/Uqw5jr/+nsaSm2YidCYfOpwm9Crz/ZcG7hPKz
         KUXjCCzhK0OMBbeY7lX9SylSHgjOLagl6MBvGvTfAOVd7NzjUJux9n0Lg6nBCNTBCki6
         29gYWrDtMjinKBTJ3HEp4DWmQBJw+NkHbTY3pE4pAVkJIX9k5Zrh+KMSVq/55AXrYa+9
         qqivS4UJF/T/iTWxYzu0VxBb2pL3x7/JRTZhPObOjhXRHAgR/9Y8Roi+W3Ng3k+qD1Hf
         ylHggW5r7LgFe2OQGBMLsLSr71YhsKnzvhHVKmET7tJ0I2H8UBGiG8rr5WDidnMPSB71
         Ne2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692971577; x=1693576377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hypiZrNUAlpFpds6qforN3FHopPaWtqa1VnQGLSWLoM=;
        b=l7jDCclfcEDPNYwuKTeVulOiT8vN+aEGuuTBcQR+z+6Bfh2loVA+JcPZQn6qXIVa62
         6Mwf6f02FORmY4ROhbkUMcPTtrHye/JK6GAgBCCIHo8VauJLc64EDkxmxKiMnDIDA7+F
         vXKZ5ogMHRtykkDlSDyhN3M8RwCp0B+IDxPH+UjjStpUACrsHHeYgb/4T7LWAMobXXaY
         aDcbUtsFdZyH84tbZGttj7bOq1Zk4ozOh/QQTrYsJQeIUBtze3Lv4+YvxpFnH+OGFgGG
         6GAERNoVSNozDwtepSDkJG/EFxgaxXFTKYiWPuixRVu2b0LijTHkCU83U7oDvKMpb5yq
         9Pdw==
X-Gm-Message-State: AOJu0Yys+sXciN9YxRNy+N1AOWHH0WLFf6dGlbA2M4w+8xH3DI3QdpQ/
        pTmLMajuzwpqNP8LvjnFdC03/5TNbqM4t6lKG6Y=
X-Google-Smtp-Source: AGHT+IE6kTpf/gf9HoBQB+U/Q6hDTLaZ1E8OoH4eSzztM0CCEntRDyeSI5r7KkHkcgGZBbnGkIfyLw==
X-Received: by 2002:a05:6871:206:b0:1be:dbd9:dd2b with SMTP id t6-20020a056871020600b001bedbd9dd2bmr3482658oad.54.1692971577180;
        Fri, 25 Aug 2023 06:52:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id e17-20020a62ee11000000b0068bdb0be6bdsm1574051pfi.191.2023.08.25.06.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:52:56 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qZXF9-0024Mu-3M;
        Fri, 25 Aug 2023 10:52:55 -0300
Date:   Fri, 25 Aug 2023 10:52:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Penttila <mpenttil@redhat.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/mm: remove references to hmm_mirror ops and clean
 typos
Message-ID: <ZOiyNxU1BGxMq8NF@ziepe.ca>
References: <20230825133546.249683-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230825133546.249683-1-marpagan@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 03:35:46PM +0200, Marco Pagani wrote:
> Clean typos and remove the reference to the sync_cpu_device_pagetables()
> callback since all hmm_mirror ops have been removed.
> 
> Fixes: a22dd506400d ("mm/hmm: remove hmm_mirror and related")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
> ---
>  Documentation/mm/hmm.rst | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
