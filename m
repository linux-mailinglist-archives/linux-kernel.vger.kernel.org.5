Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEED7B29F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjI2As2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2As0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:48:26 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2C194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:48:24 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77574c6cab0so255093085a.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695948504; x=1696553304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iXnFgtnhV35/5nraOkVV+b+6GuFhRtwpj0ASChSU/YM=;
        b=ALTONi2r10C1tLFqLVzhzodgP0OhBfUi3t0DeVZ915RU8AFcZvjfIF1uAU1R0MFG5p
         MmoYx2Jqj6ujfcwgREf6HCobJ3RLt7R3k/AkRyOftwUnYDx0ttYjAnKND8j6H3DM7/VL
         AlyjxQPFl1LUZ/O7S0oRlPUU7tqWrCMoxCqWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948504; x=1696553304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXnFgtnhV35/5nraOkVV+b+6GuFhRtwpj0ASChSU/YM=;
        b=SGhqs9B/Jn8VdlZ+CzjVN2h6FRWqR/Jb+AjevP3OtW4D2pQtbFCTFB0lxeZxoXVtvO
         NLJP7nid6hptXyoURU0FMGYk5q8i+aHaATI4XWGoBvBq9nRrqFhCgoE3ib/KKxUAyHi6
         S4ta6LCzXammCBjkzxqc6VgJlyAV5HlRZXv+/5kOA0I3e8GolMPhxLJZh/h17zZZxHT/
         NwmL/ifq+Wbq6XvUkNGXVyL02sTQNAa3SRZeRujZSYCX0zrj8H/UGgb/gjHMMcW4sdy9
         wNUzlXTGSUCkdQknyS2MFv+VUcwxVwZZ2nZMSMzAaqXcISKY/knoMeG0C9g5Fi5OkFTJ
         264g==
X-Gm-Message-State: AOJu0YxlQDg6q2NVgX0ezFWglv2ksfZmogHHKe2iW6sXZtGELrNlQCgC
        T2FHzQ3vsHkWrgMjYCAnJqHf+g==
X-Google-Smtp-Source: AGHT+IE83wxkVeKmbXMfPZtwhbMZP6G2xuz6158Pb6qsN4X25QL/jHQ9mWomvJzOpwl0T2tBq93Mbw==
X-Received: by 2002:a05:620a:893:b0:773:eeb1:ed1 with SMTP id b19-20020a05620a089300b00773eeb10ed1mr2724234qka.51.1695948503850;
        Thu, 28 Sep 2023 17:48:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7801a000000b0068c10187dc3sm13893826pfi.168.2023.09.28.17.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 17:48:23 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:48:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kselftest: Add a ksft_perror() helper
Message-ID: <202309281747.594B3352@keescook>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:38:11PM +0200, Mark Brown wrote:
> The standard library perror() function provides a convenient way to print
> an error message based on the current errno but this doesn't play nicely
> with KTAP output. Provide a helper which does an equivalent thing in a KTAP
> compatible format.
> 
> nolibc doesn't have a strerror() and adding the table of strings required
> doesn't seem like a good fit for what it's trying to do so when we're using
> that only print the errno.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Oh, interesting... what environment ends up without strerror()?

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
