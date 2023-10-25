Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD9B7D7805
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjJYWdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJYWdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:33:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A65CAC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:33:44 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-578b4997decso247362a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698273224; x=1698878024; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=opwJbFfeZezmZEuzzSOhTaSQsmNEsDE8+V++KHmxwZU=;
        b=Zw3Pa2e/3+U+nznqtw6EsgqekwKOZLCpgWcrIdIfIW361ngegMlGJERzrO5alHI5dI
         jLq4udAqM9dnFbutIBzFOjmZJnW4iCVSWbf5WZYCZ322B+1l6Nte6LyYoIHENGf+yid3
         Kpat33kudd0NZpR0Iu0Du8TRvk8zZ/F1JMFXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698273224; x=1698878024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opwJbFfeZezmZEuzzSOhTaSQsmNEsDE8+V++KHmxwZU=;
        b=tFx/IUnxdPWGX3RcCX5O5ADBggLVRC28HEPKN1RKbypd2S0EiiiGnpIlbIV8Sqvtah
         pqvBDuZXQWR/dho0MKc3WmYeIvo/CBZ0ohZHMk9fkx3FmnK86ywucfGKFWDQgT9EDsfL
         bV6xr7DeINsX5Dpm5rATIitKWyCK+ExzGNWhtWslpHEMW69Smzp9h1niD76a63yOq/rO
         0P3C0XVM2O38howCU7eQT0KsycA9rtJYNVidEMxUBINxEJaKUWCB5Ki91Srr4pgp1XJ9
         z7P9p+zBKS4OIP19hSOop5gW59qWwFiEF9AhnRG/u1SARLvxNSkxHHmgi4K04etcsKNB
         ew5Q==
X-Gm-Message-State: AOJu0Ywxg9X2G4kY9uqcl5BxXXiU5Z1Tq7YgeQQe8p8QN4qMilXi1F4o
        U7ZuG4n4QZ7Ue8g+8gdNhdPfSw==
X-Google-Smtp-Source: AGHT+IGxTFCX8xvKt6P4f2+i6TbGxj5yvVEoDiE/MOxfbaqndU4RC184AnRD+2msme7KJciUUZryGw==
X-Received: by 2002:a17:90a:1996:b0:27d:2054:9641 with SMTP id 22-20020a17090a199600b0027d20549641mr16534515pji.36.1698273223913;
        Wed, 25 Oct 2023 15:33:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090aab9100b0027fccaa6a29sm372876pjq.15.2023.10.25.15.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 15:33:43 -0700 (PDT)
Date:   Wed, 25 Oct 2023 15:33:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        James Seo <james@equiv.tech>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] scsi: mpt3sas: Use flexible arrays and do a few
 cleanups
Message-ID: <202310251533.1A27F79450@keescook>
References: <20230806170604.16143-1-james@equiv.tech>
 <202310230929.494FD6E14E@keescook>
 <yq1il6vfoiu.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1il6vfoiu.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:05:33PM -0400, Martin K. Petersen wrote:
> 
> Kees,
> 
> > Here's a tested-by: from Boris:
> >
> > https://lore.kernel.org/all/20231023135615.GBZTZ7fwRh48euq3ew@fat_crate.local
> 
> I'm a bit concerned bringing this in just before the merge window.
> Please ping me if I forget to merge once -rc1 is out.

Sounds good; thanks!

-- 
Kees Cook
