Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756837A9024
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIUAZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjIUAZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:25:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31AA3;
        Wed, 20 Sep 2023 17:25:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3d6d88231so3209535ad.0;
        Wed, 20 Sep 2023 17:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695255920; x=1695860720; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DczeM/Y/ll/HO5aTU1FZs9q/jGteDrPwoT1dCCvthrk=;
        b=AFibqjw46Xk3SQJfSZaDE4mo59JNIGGfQofnaZbxucbCElsiPUyIAw1cpuGsG9efUn
         vCBBOC81J8/EuFzdzIHkXAFCDzcTJd826q3PCI6j61MYVgDh5A1q6JAkuagoJfvXLqM1
         QZgdJZytZBEdQ0l8FEBEc2DquAZJwx4wp1/E3eASq6Qt8LTuQI5t5bFTDCBkkMJhXPgm
         zJxAj4BTs6Q+6ZMV26h66tXy+YbtkaYH7AeuIdcyTUsYtvDEjEe44q0jZFNWytXari0H
         o/97lAme7GS1/Em6G3w1+fszDF8WEpt7k/chkaRL+4e+oM9JpSfeelP1dtlBzL6ahuRN
         KvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695255920; x=1695860720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DczeM/Y/ll/HO5aTU1FZs9q/jGteDrPwoT1dCCvthrk=;
        b=EcjZcW/QvsF8dByEyLEAuoCPa2QSx/IrRzpzBOhYJ3Diilz4G+/UrepdQ8xo4cG0gH
         JGv4sfsqLAENh07rH2pl7g1TLE5lSABiDDTAHdeS76G+olMkAGVmk9hfCaIBBOYeH7QZ
         4PAfCJ+3g1tRCxF3a5CogtzSN0M6dXDMI2NqqPnKBUzID7O97gwrNDyokMWS88Mb7wyI
         DjUnot0rWjJ2E2NVVAzD62/1QdWQIJeRRvuNfDV200Y3PfWotNbX8ekyBlJ2WogaLP8J
         mMlTN08a/bvr2+iLqx2o81hhT8/3QAcvQ+rmTkWe9Hpxm6JO64/OinPPMZ3ZBaTqeLgt
         CruQ==
X-Gm-Message-State: AOJu0YxauH/VJfMTSMnv3iOz0IairLOdSImjx+PgemwSlz8erprT6GNo
        SDc4P/lVJ/3Z8nCgCfKZJ73TJzdWnJOI+g==
X-Google-Smtp-Source: AGHT+IEborYCvHbvZKLnVJxX+AOOqYd3ehjy+iJcuUM00XR24BNq0vdPJf1tfv2ENzbw8STYhGpymQ==
X-Received: by 2002:a17:902:e74b:b0:1bb:8931:ee94 with SMTP id p11-20020a170902e74b00b001bb8931ee94mr4001271plf.67.1695255920421;
        Wed, 20 Sep 2023 17:25:20 -0700 (PDT)
Received: from localhost ([162.243.44.213])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b9c5e07bc3sm88735plx.238.2023.09.20.17.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 17:25:19 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:24:25 +0800
From:   Jianguo Bao <roidinev@gmail.com>
To:     Manmohan Shukla <manmshuk@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: error: Markdown style nit
Message-ID: <f6azofsmelve5eeppckk5vn6wvjghadt2bduq3lzxcqdk2azos@f73u4yyszooq>
References: <20230906204857.85619-1-manmshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906204857.85619-1-manmshuk@gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:18:57AM +0530, Manmohan Shukla wrote:
> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
> 
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
> ---
>  rust/kernel/error.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 05fcab6abfe6..6233021daa8a 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -133,7 +133,7 @@ pub fn to_errno(self) -> core::ffi::c_int {
>      /// Returns the error encoded as a pointer.
>      #[allow(dead_code)]
>      pub(crate) fn to_ptr<T>(self) -> *mut T {
> -        // SAFETY: self.0 is a valid error due to its invariant.
> +        // SAFETY: `self.0` is a valid error due to its invariant.
>          unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
>      }
>  
> -- 
> 2.34.1

Reviewed-by: Jianguo Bao <roidinev@gmail.com>
