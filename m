Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C09878F2B0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347066AbjHaSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347064AbjHaSdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:33:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E76E7B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:32:52 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso710275fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 11:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693506771; x=1694111571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBmD6+hPqatJJamgU4HI6o0CO+57hmYKqdLd/YQCAyg=;
        b=h/klJj9osrf1NTqIwud0azELUQPqHnVQDONIQujQvn5rET1GyX+tw/x39Y9qwAQMJt
         /B7VUdEg6tFqzoQKeizbFRFwaFVPK94F2jJ32w3ipdUEaeAdq+KxYZDBib5JhfeqflnZ
         JXZXj3MeqvURecy92pbzccYXbvQP4jJeFN1Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693506771; x=1694111571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBmD6+hPqatJJamgU4HI6o0CO+57hmYKqdLd/YQCAyg=;
        b=XgbCsxpsCBtT6vieDLpYkNOqK+H++WUhqOUJ9aezQTpy7eIVaswP6sYMUqg6RIqNSX
         eK4G0lXAEugvLGwBy6p8OkFMlQQ5SiVYyIcclSEiNgLj0qATqp8ipGCMDqhKG2GSxhJq
         DKy8bEQPpYyWdrZbY3eQfXhGKFG4YIm/mJfDpSFIdRZtxWT6ZPUx/dPUoX16/drmv8/E
         +o/tzmGO2/6cAewmdVxCd01H7B2rr3dDf3NFV64Zif8WYXq/Fs/4e3Y5Q6cWfvcpl340
         mTI598a6bbhvn1sc38AbR8KXWkBLt6u1MP9Ippw+nA0JB9bYcvXhxoYt4bLeDXHwScdk
         X7Hg==
X-Gm-Message-State: AOJu0YxuJGphSsfVBbdhFkMPmmGGbII3Wz4IdKK+BouWeBG5OfMKJHUL
        d5zSSZ/1DxAHj3jbzY9+mpyAJQ==
X-Google-Smtp-Source: AGHT+IF5/TlF/lQHblPVjGsswwKKZAwdedPWRSeqhvKS5yw01SH3v4w/rzlvbcG4HljdDHCJ90/d7w==
X-Received: by 2002:a05:6870:1cc:b0:1d0:f5bd:6d9 with SMTP id n12-20020a05687001cc00b001d0f5bd06d9mr281116oad.53.1693506771189;
        Thu, 31 Aug 2023 11:32:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u191-20020a6379c8000000b0056368adf5e2sm1634030pgc.87.2023.08.31.11.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 11:32:50 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:32:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kobject: Replace strlcpy with strscpy
Message-ID: <202308311132.246D40D2@keescook>
References: <20230831140104.207019-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831140104.207019-1-azeemshaikh38@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 02:01:04PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
