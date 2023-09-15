Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7637A2702
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236850AbjIOTOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbjIOTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:14:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2AE7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:14:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fe2470d81so2260234b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694805247; x=1695410047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lby7bcU4IiDJPbswGbt51Rx3r6E0Va+DV7kPCr0AFVc=;
        b=NCO2Fwcj5RefxgPM6ykLYnU28dL9YATr1OObZGZK37U4RvtavfFdWlVDY/IyFUvrRy
         ahUqN7nqWvBU5fEXYt+Ir1mFrB405GwDk6wGLgPPKwrsXDTmwvVHja/i0t5rV0OXBh7u
         uY0MgyjKXVwBgZX0WZRQlWVPs/zKKYISmBOBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694805247; x=1695410047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lby7bcU4IiDJPbswGbt51Rx3r6E0Va+DV7kPCr0AFVc=;
        b=WKy/SHEoxLNkQIYTXqnlcc7gB5WfT70zVoPUlXq4OgtJ0bvOnbc+pFnDR+shvFg/fV
         BqFQzCmOzFn3TKueM7CdDlRdH6tvbODqv/1IH1hcq6bkrwN3i6gYR02WpmZ9+MPmFb+b
         GQV331yJLaq4EFqX4O7r4CJkHwfs/Q1l9lVz/WhR8tXpGUTn+xJW1GG7967STRthzPap
         83ffCnudLi2TSo6cXEeI7kKvIkv13ZSxsesNciv2OCgI5Sl7kb5XIK9LfJyFEftsFtiO
         cSV2OyU02u2V6eHCDf5wV7DKGq9md8ozsfP46hPJ0OJIr9pAb3WaWiuqJpXH2V1sdGbx
         c/IA==
X-Gm-Message-State: AOJu0Yw/BMGPUe+AKRbJ4YW0oKmpRNsx7AnX66Iqs9sXvnxkj+vvGgKg
        3Ug6reJPPmGqS/l76L65dgQR0A==
X-Google-Smtp-Source: AGHT+IHzne5BPrKqqMK9vSWnM8qiv/HC0MwPc6ICuMal3CSjeyFfEn+e32ycO+mQzJEbXbkLVs4WLQ==
X-Received: by 2002:a05:6a20:f384:b0:148:d5d9:aaa9 with SMTP id qr4-20020a056a20f38400b00148d5d9aaa9mr2596138pzb.33.1694805247318;
        Fri, 15 Sep 2023 12:14:07 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s187-20020a6377c4000000b00577f55e4a4esm3121300pgc.20.2023.09.15.12.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:14:06 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:14:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-hardening@vger.kernel.org,
        David.Laight@aculab.com
Subject: Re: [PATCH v3 1/2] uapi: fix __DECLARE_FLEX_ARRAY for C++
Message-ID: <202309151208.C99747375@keescook>
References: <930c3ee5-1282-40f4-93e0-8ff894aabf3a@p183>
 <a0c3a352-89c6-4764-b377-f55a68a1b2cb@p183>
 <202309080848.60319AF@keescook>
 <f1819874-2b91-4983-9ebe-6cd83d5d3bc3@p183>
 <202309080910.44BB7CEF@keescook>
 <e364b36eefa049d8863c1c1001018636@AcuMS.aculab.com>
 <97242381-f1ec-4a4a-9472-1a464f575657@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97242381-f1ec-4a4a-9472-1a464f575657@p183>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:22:24PM +0300, Alexey Dobriyan wrote:
> __DECLARE_FLEX_ARRAY(T, member) macro expands to
> 
> 	struct {
> 		struct {} __empty_member;
> 		T member[];
> 	};
> 
> which is subtly wrong in C++ because sizeof(struct{}) is 1 not 0,
> changing UAPI structures layouts.

Looking at this again just now, what about using a 0-length array
instead of an anonymous struct?

https://godbolt.org/z/rGaxPWjef

Then we don't need an #ifdef at all...

 	struct {
 		int __empty_member[0];
 		T member[];
 	};

-Kees

-- 
Kees Cook
