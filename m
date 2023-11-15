Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537F97EC572
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344047AbjKOOit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343949AbjKOOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:38:47 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A73A9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:38:43 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc921a4632so61784135ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 06:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700059123; x=1700663923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MrQuxkzbwU4E8/k5Bt18ic1YvcYfXRCP4owTm7VijZs=;
        b=FBs8lc1kjiHzGTFPxKWU11STESE4s7DKgmaOqyHAbLmao4mkJmh7Kx3o8LrI3+iZaR
         IcCM6uWFJpqk+brTEmo/kD5AoGIalSqOYMKcuhCJPsgwTJnh5OABn+VlYeODJKuckx0i
         zfSpMyyJdVp19WUYCfDBw5asUjjG6LBC2xmNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700059123; x=1700663923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrQuxkzbwU4E8/k5Bt18ic1YvcYfXRCP4owTm7VijZs=;
        b=nL+Y1C57RC6sNs58NgCqBRuz4eJm/E8prWQPTvZ2zyKLWW/qjg96xvvoKNP5gfpejf
         Z2vB2uv/HI+VcjYcg0EMsXetDMzuB0esSlm8A9xe5MgPC583TrEc6HH/bO+I82MSOp/q
         RAZNqc760fGiEp5kpmNDaRIlD93jJXXhih7fhAX2fcSVAeJnHYAR8OuYMW8HcqD5ctv/
         ZrfjbTPd7uiUg0FXKLCMxYXYHxztf/AA44Qq3Lv7+9IZrrV9nGiAjK7KqCis/TE48fbK
         fHT/7lCFxEnVIx4swsOJBav1wnYgcPQOJTiMXHKyROzkpfLJeBKSm9PPZ0WOp09wCtGT
         0kvg==
X-Gm-Message-State: AOJu0Yx+iN2qZY2Zu4RtwC90YuEk0p+/MhNzo3LM8SK8uJxoUv+1SXrh
        LCc6tdu+Ae3p5/TJofm9j9ijyQ==
X-Google-Smtp-Source: AGHT+IHH/cJMF6jF0j5MpKf3mNTEfjoZwddw5DE3EkX9x8IUXTz+RcQT0KKSr1pgZ+pD/2t5OWuqSQ==
X-Received: by 2002:a17:903:32c5:b0:1ca:72f9:253a with SMTP id i5-20020a17090332c500b001ca72f9253amr6085927plr.23.1700059122783;
        Wed, 15 Nov 2023 06:38:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902db1200b001c9c6a78a56sm7416420plx.97.2023.11.15.06.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:38:42 -0800 (PST)
Date:   Wed, 15 Nov 2023 06:38:41 -0800
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
Message-ID: <202311150638.3BB079EB@keescook>
References: <20230806170604.16143-1-james@equiv.tech>
 <202310230929.494FD6E14E@keescook>
 <yq1il6vfoiu.fsf@ca-mkp.ca.oracle.com>
 <202310251533.1A27F79450@keescook>
 <yq1o7fv2kcx.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o7fv2kcx.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 08:54:22AM -0500, Martin K. Petersen wrote:
> >> I'm a bit concerned bringing this in just before the merge window.
> >> Please ping me if I forget to merge once -rc1 is out.
> 
> Applied to 6.8/scsi-staging, thanks!

Great! Thanks for picking this up. :)

-- 
Kees Cook
