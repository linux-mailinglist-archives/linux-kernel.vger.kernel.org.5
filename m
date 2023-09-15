Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2193C7A1478
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 05:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjIODhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 23:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjIODht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 23:37:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5E22713
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69042d398b1so389115b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694749065; x=1695353865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KrkAHIjQDGiDP5wEakotxifTSwpH8QMLY2bspVz+a84=;
        b=VacDg1G4fPqQLceZaZVGmHlkMY1eJ5CbVieHp0oF4+iurLvzRyAMmqqlA+nWn6jARx
         DvPLfzS3QYOwJ7s4NPpRK+cAFxjM6UTM2fx+wNU8ukTPXAwMBQ36RMeQakzkWxIhFX4y
         Si0/1B3QuM7M1KkL2lUNt5k02JlJc/1ObmYHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694749065; x=1695353865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrkAHIjQDGiDP5wEakotxifTSwpH8QMLY2bspVz+a84=;
        b=Z7xg3W9Nukg3QOK+iJQF3L1H899BYjRvgzCn0wlSbcYEaUlkcBKj/0M9nANOua7lLt
         piqPPyTk+A/cdBUS+lOXaXdoZM86y+FII07tCyka9aYN8DTF0DqYAL6oK3l4r3CwBz6A
         H74zboS83RT0/chOOkqZndBmDoLb6Q/0t9Pjsqvq5ijr2IXOdUOlV/wdX+aNDNCNDS5D
         THJQkFsCtRYB8/EkhpGDp4SvCCVcQ3eH3lvJqEHLNnCqjBdnsntHa15kSFJRG9f7b0EQ
         bj+tl1Oj69yW2BA2A9KwjeT5HL6e4GZiBVWxkjmIK2j2u79oR/BUIDcHkA+ktbGiJ45m
         kVMA==
X-Gm-Message-State: AOJu0YzigTE60Eey1n+vMFdYjuRVzokUv5roRFhaF6TVrWs52s3tnQps
        netKNflq6vfz1GsPQTGD6FMPcg==
X-Google-Smtp-Source: AGHT+IFKL9tpOx2ny4+YwCrHk5FiqrcmS6CBKI/hcxifOw5XLZvj2VUumvEZKpC3o2Q57QcevfaOvg==
X-Received: by 2002:a05:6a00:189a:b0:68a:6d1a:b812 with SMTP id x26-20020a056a00189a00b0068a6d1ab812mr674679pfh.9.1694749065065;
        Thu, 14 Sep 2023 20:37:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f10-20020aa782ca000000b0068fe7e07190sm2011222pfn.3.2023.09.14.20.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 20:37:44 -0700 (PDT)
Date:   Thu, 14 Sep 2023 20:37:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] cpuidle: dt: refactor deprecated strncpy
Message-ID: <202309142037.5D689164B@keescook>
References: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-strncpy-drivers-cpuidle-dt_idle_states-c-v1-1-d16a0dbe5658@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 12:23:19AM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
> 
> We should prefer more robust and less ambiguous string interfaces.
> 
> A suitable replacement is `strscpy` [2] due to the fact that it guarantees
> NUL-termination on the destination buffer. With this, we can also drop
> the now unnecessary `CPUIDLE_(NAME|DESC)_LEN - 1` pieces.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>

A very regular strncpy/strscpy conversion. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
