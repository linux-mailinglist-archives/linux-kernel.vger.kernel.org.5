Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5937B29F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjI2Ask (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjI2Asi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:48:38 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2851A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3af5fcb5e37so1635846b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948515; x=1696553315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tylYhPEWtThqOdjkF6waboL48MfnCro3UFLr0GQ9x28=;
        b=UZWIoDN+hcGjhygGewIEpq4xMg4JXHsxf2/LJgBgM8CKcxjZimzaxqSIuI6MObyg8m
         JFr2/ufJrONw4Uy0PSQ6+sX4cdP/kCY8wp1xGlODI3CXdALlFNTlX0ePltCbh1qo0QpG
         N3ikzEyblLtERDrEjKqBp/SYk1OklRwzMu6kE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948515; x=1696553315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tylYhPEWtThqOdjkF6waboL48MfnCro3UFLr0GQ9x28=;
        b=D0p2DVBNlXNqmJnOQGZccSzgZdE0FlfGvqqRQ/WI5AYi+ZGWQB/m3Iz1w+VxvwtzIW
         PiQldMxG/8P7dHS4yPuMZ9IOLBPH0LmM/t/hbAvvvSET/sV6yRzEESrKn2in5ngmfhmv
         M2/Ki+czGjA3CM7Uupo+F6Rp+lIrcAsq2B2SApvvVagDUdG5yIERC7nqx6wVyxNq5lyv
         u5klBkX1AQ1qjCwcMazs9tnyam8o1YD8TRqvLcCCnzaTpP/XvlT7r/LSs6zy66NOPW1/
         B0sDPxNhk/eV9ck96ZJCe1sW4O14pEkhfZGuoXdZFtKvHEnhJcFb2b0YGW8ZI3B7TkCp
         Upbw==
X-Gm-Message-State: AOJu0YwymWbSaOUPrx4C1U+1nwuO+lNfEB6UdXPog+ePT1piwRjg6sRQ
        oYgOcncbtV5V8OI5pUtrxOL6BA==
X-Google-Smtp-Source: AGHT+IEWHpwzSGA33eSq7rADLwnpRwf9x79Yvho2lnmUCGF45oywwNmstL7fJN9k86IblRlfWA/0BA==
X-Received: by 2002:a05:6808:14d5:b0:3a7:36f9:51aa with SMTP id f21-20020a05680814d500b003a736f951aamr3226322oiw.17.1695948515082;
        Thu, 28 Sep 2023 17:48:35 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q26-20020a62ae1a000000b00689f1ce7dacsm14033655pff.23.2023.09.28.17.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:48:34 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:48:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] selftests/exec: Convert execveat test to generate
 KTAP output
Message-ID: <202309281748.7BAE187A@keescook>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-2-1013a2db0426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-ktap-exec-v1-2-1013a2db0426@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:38:12PM +0200, Mark Brown wrote:
> Currently the execveat test does not produce KTAP output but rather a
> custom format. This means that we only get a pass/fail for the suite, not
> for each individual test that the suite does. Convert to using the standard
> kselftest output functions which result in KTAP output being generated.
> 
> The main trick with this is that, being an exec() related test, the
> program executes itself and returns specific exit codes to verify
> success meaning that we need to only use the top level kselftest
> header/summary functions when invoked directly rather than when run as
> part of a test.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Yay! More KTAP! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
