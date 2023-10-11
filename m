Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A7B7C46DA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 02:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344496AbjJKAtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 20:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344281AbjJKAtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 20:49:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AE8F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:49:44 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-692779f583fso4446446b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696985384; x=1697590184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRRRoTo2wnsSX5xq5u8T59QWy7S3kko/dv8df4DFlb0=;
        b=T9TC41alCgWEAl+Sv9w6QlzSI2YKErlX9EH5dDQypuuk5xJNA1iee+6SiQ5zXNY5rI
         10t4K1Je26ycLIRMVPvDDnw8seA16x7xZ6p7dSeZxPQWzKnT9WzSMwsNQgtJbciQKwSP
         JwqEnwFFU48eb4siOPmSLUYu7Ch63ToZGC238=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696985384; x=1697590184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRRRoTo2wnsSX5xq5u8T59QWy7S3kko/dv8df4DFlb0=;
        b=OR8PDBtE4B5a/bf135970aCrxQli+GtzU4+qhiGkLxKT/1Mh1Lsp3CfQlQXtxJKKHe
         uotEsulK6iGbl313qv7/MepAJ4u2WAJUYrkmMh+dV5RqMTSfat6M1G6X5SSINXSZmxbr
         p+SVgWtFwE2ezYq9bEpLhFppFO/8bN/2PMvhNZUI8BqvmeufcsqpU4VQJ4ESjUAXZdYQ
         aH6yiQ5prQ0tVla91cUuMDgjzKV26Ine2pQ7JY67IoqVaPLsKUzoiOoaysWG6jQjx+w/
         m/+hVsAK6OB7yHF9wOgsi2Hn9xru/UDpNVzYLcfBvTP/yhhg0cp6ScNwJRtxUvngXAMq
         NxJg==
X-Gm-Message-State: AOJu0Yzx1QOEkfOe/3Xtzt0qzR6ZgUSvk3l8kNtFOWPgb0Xvie4Eb7gi
        SOnk26625b80ajonSAPla4mUsQ==
X-Google-Smtp-Source: AGHT+IH2fFpFd4eP3vIi8kSEraLfKgo8XfCxhm6jKaFV+PkGlZw8qgOPt1QHhoorPyZIqBO+YaMYUg==
X-Received: by 2002:a05:6a00:2da5:b0:68e:2d2d:56c1 with SMTP id fb37-20020a056a002da500b0068e2d2d56c1mr19330340pfb.9.1696985384264;
        Tue, 10 Oct 2023 17:49:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z24-20020a637e18000000b0057411f9a516sm10914474pgc.7.2023.10.10.17.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 17:49:43 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:49:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Seo <james@equiv.tech>,
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
Message-ID: <202310101748.5E39C3A@keescook>
References: <20230806170604.16143-1-james@equiv.tech>
 <yq1edjr25ed.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1edjr25ed.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 11:00:57PM -0400, Martin K. Petersen wrote:
> 
> > Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") has
> > resulted in the only arrays that UBSAN_BOUNDS considers unbounded
> > being trailing arrays declared with [] as the last member of a struct.
> > Unbounded trailing arrays declared with [1] are common in mpt3sas,
> > which is causing spurious warnings to appear in some situations, e.g.
> > when more than one physical disk is connected:
> 
> Broadcom: Please review/test. Thanks!

Another thread ping. Is anyone at broadcom around? I'd really like to
see this series (or some form of it) land to avoid all these runtime
warnings...

-- 
Kees Cook
