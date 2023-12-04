Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94618041A2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjLDWUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbjLDWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:20:13 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D7D170F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:20:06 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58e256505f7so1590153eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728405; x=1702333205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+WzlKb2MQSHfnGqBE/e5O7OA37FmS5jYCRCA/LLsH0=;
        b=lf0Tbx4pZSpplXVE+zqYxKYOIwCE2xAIUgcZiK3fCq6WNOA8asMjsl+yN0MHxt2eDn
         rbaiZLPUY41HHiP3/HfHTDEMuBNSsqFAfOwLCszTWL335Aat5ZHiNUr8kTLUlWLeMVgK
         Ko4WxPKFTphxd51BX4j69weJgwWn21SSL2GP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728405; x=1702333205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+WzlKb2MQSHfnGqBE/e5O7OA37FmS5jYCRCA/LLsH0=;
        b=LDZtT9L1fAczOVqXUqcPYBJidB2CQomVbe3y9wwb2xDiuqOWgVcXQaq3IwxPB7klZ0
         SQBsCHYYl7GJHNNBW/ADMV2X+eDyvWvnr8YkJSHQ0/9eQoE2QzwP9Ho1f/TtqfngKChN
         csVtDCMU+gN3fV88y6aGliyKx660DRauXeTnJTnC3ol5N2WqIE3X0AuRm28IhGCXNJRP
         QD6O2G7MYZU1viu8KrZEEhHf1cIQeiy1p/F+wavsxMcICnu1PMRcWiEhtCldhRzp9I1b
         KF7e13KeMtZJzFEfmtojIe1UAhU73dVHibndoSeRFnLnVYU/Da3hP3nIxUWn40Oagdph
         bWmw==
X-Gm-Message-State: AOJu0Yxh7NDz+zRUpZj25jp86T4expOUBhTPNtm7+tYbw8jPJQ6m2wMf
        H1MLFt5+Us3S3sVLqdtjZ2tZYZdKm4ukjuvt0no=
X-Google-Smtp-Source: AGHT+IGC7BzaBQCIfZe1vXo4mx3JRiDIzetuPnC9oVZ29pkisPeQ4hM13pxSUb9WDQN6k46hgaEL7w==
X-Received: by 2002:a05:6358:9106:b0:170:302b:545f with SMTP id q6-20020a056358910600b00170302b545fmr2543842rwq.56.1701728405319;
        Mon, 04 Dec 2023 14:20:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ey5-20020a056a0038c500b006cde75646d3sm4718759pfb.179.2023.12.04.14.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:20:04 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:20:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Song Liu <song@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible
 array
Message-ID: <202312041419.81EF03F7B7@keescook>
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 08:48:06PM +0100, Christophe JAILLET wrote:
> The 'multipaths' field of 'struct mpconf' can be declared as a flexible
> array.
> 
> The advantages are:
>    - 1 less indirection when accessing to the 'multipaths' array
>    - save 1 pointer in the structure
>    - improve memory usage
>    - give the opportunity to use __counted_by() for additional safety
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

This looks like a really nice conversion. I haven't run-tested this, but
it reads correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
