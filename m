Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1200A80AE73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjLHU7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjLHU7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:59:02 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C6A1734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 12:59:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c68da9d639so1956530a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702069148; x=1702673948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4tDY+el5yb1E7vibUCjRLXcZ8qga+f4zfjehHC1F09k=;
        b=nuI8q0Tv3MyVrTJvWoYR48vQspiRLC+1Udu/8M1DFXgVLac+IsnGZnqZwbGPW/S6tN
         7fL2dUHiKyNIjwaEuTvlJlgkLHki3cQmVHH+8EaWBvZIVZf74vIwaqbk8Klq1cBDTAle
         YBUhbGCuSFOpF2gDK64trTzc7BQtONubSjrJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069148; x=1702673948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tDY+el5yb1E7vibUCjRLXcZ8qga+f4zfjehHC1F09k=;
        b=HcD/CNYmXv7KXVZO+kNh6jBFYlnj7jXVVSbZRq++6pwgdoBIkh86o1ce6VcZ6/1QVg
         JMiH30TSkddrgR5VC24ABTNmH7MVVyYSw8DrbjefLYU/WKi4Bw+cd1vFqw0T2/HCRGJJ
         0vxx3qLtk8ns5g1fOHfDXcxqDXBWEtABaPwaLgR2yN3NTo6ShsvcK+8YMbirlMvEn3Ys
         xiCovURhlI/a+0CqzI0Rno1Bn5NwDN9zkYYuXdHZO0Z+gDWNT94zcc4rBEJQPbvTgM0m
         S9TzoxP87yeDlRjhv5dCtmN6uBX0m3fUQAaOlfyAUEBpaUmRPBiYXGR0WpHi2s8EJhdK
         PF+Q==
X-Gm-Message-State: AOJu0Yyh6je4PXg0rkEWgjCquPTQyoNM5h7qqXUvQJ1DchWQmDbVeIYf
        C8APt1GclbKlsEQ9JTHIRkaINh4V7gNr4vzPgy4=
X-Google-Smtp-Source: AGHT+IHC0xhEEwf9AQh+iBNpO2ZO5pX3d5ZBv46D7LnSDAXnR6AD1N3JqwDjUZmr03O1IpKIMJtjAw==
X-Received: by 2002:a05:6a21:18c:b0:190:6bc:adf0 with SMTP id le12-20020a056a21018c00b0019006bcadf0mr726883pzb.50.1702069148008;
        Fri, 08 Dec 2023 12:59:08 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o15-20020a056a0015cf00b006ce9fb084f4sm2011817pfu.101.2023.12.08.12.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 12:59:07 -0800 (PST)
Date:   Fri, 8 Dec 2023 12:59:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bryan Tan <bryantan@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] VMCI: Remove handle_arr_calc_size()
Message-ID: <202312081258.85F7D88E@keescook>
References: <adf0c48a57d911be5509688614d2e00694ff57eb.1702068153.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf0c48a57d911be5509688614d2e00694ff57eb.1702068153.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 09:46:09PM +0100, Christophe JAILLET wrote:
> Use struct_size() instead of handle_arr_calc_size().
> This is much more conventionnal.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks good. And since capacity in u32, there's no need for size_add().

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
