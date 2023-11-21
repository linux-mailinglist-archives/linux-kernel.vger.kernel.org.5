Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317A7F26A2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjKUHr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKUHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:47:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17DA11A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:47:49 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40891d38e3fso19967485e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700552868; x=1701157668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1Y57R3L0HcMhbg8KOSSlooP9Ta78IZFzYPPiGoMQM8=;
        b=WoEXrYmTOCuaf6fQP2MS3rLn0xC8In8RcUy376BoNX7OoJhhha/gq397UppnvXY0DW
         8gjGzKsQvoc21JTUEL3triPQ0dt96FVsbYewRHdmR5mi/z+YEPp1aASWh2C0j497BM8T
         N5pDB9ag9sbyLX5Ei7niXFl7zrHjbLUn8mOq6IaY471PdhbxYScWwFLiQmSYK+CmWmiF
         8PCsyhFr0t40mB2q77I3mktwROXOGCiQPnKlSpLtz6eMG8/w46vcw9oOvFwRs7+YeBJn
         Rol/DyzLpwGlArxk7VJ+VzjFZWsziqSUnlPuXaIsVdflpRI9T1nghlDyPBYxtznVUgfL
         P1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700552868; x=1701157668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1Y57R3L0HcMhbg8KOSSlooP9Ta78IZFzYPPiGoMQM8=;
        b=bNRiYsyKvHsvosPbR6cYpd2L2im/f62GiFvvJTTNc4w0Khi4qVr2qKRxkqRzKd/wS1
         Jmd3ReKRTyihn6XE7QRWFeo+FD+UVS6uxcVpF2a0+bDdW5fuehd4qb57mVveYuHI5pDX
         oWl1sHl/2tLhM9vpNGXW3kRbhD3gkSz6IgJ4Em2EbyuRNMfOcaDhQYWSRl4N7bMvJ2+S
         t1cvzFd9RNIb4bXO/B1jKTdXA2/TE5g3r/sO3O0LmKyXiDr9+ujTqNbMpDTdi6Ah7oA7
         rc3pCGoDdSYc53agDur+yy+W/ZqB8mQEuFoitCZ3otqUVVcBijF0VPYIGtdxdraxGe58
         66TA==
X-Gm-Message-State: AOJu0Yw3orGPejE0IIx6j5k9nD5j8/lIA3hEwWKuBJCUmI560EEZy1Ul
        gkjFH1hO+y0PyGkujV2AI0O3BQ==
X-Google-Smtp-Source: AGHT+IH4wwV1/n3G3r43AoKA8JC1M2MY5Nd1HmsDJfGHfBNRI/Jxb2nv4O1DIdpdiedpMdwWvkGfcg==
X-Received: by 2002:a05:600c:4f55:b0:402:f55c:faee with SMTP id m21-20020a05600c4f5500b00402f55cfaeemr7478517wmq.26.1700552868351;
        Mon, 20 Nov 2023 23:47:48 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n21-20020a7bc5d5000000b003fbe4cecc3bsm19975709wmk.16.2023.11.20.23.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 23:47:48 -0800 (PST)
Date:   Tue, 21 Nov 2023 02:47:44 -0500
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     kernel-janitors@vger.kernel.org, mathieu.desnoyers@efficios.com,
        ivan.orlov0322@gmail.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH] selftests/media_tests: fix a resource leak
Message-ID: <71465605-7179-4281-8ec8-80f741e78038@suswa.mountain>
References: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
 <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121025918.2570-1-zhujun2@cmss.chinamobile.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 06:59:18PM -0800, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading
> 
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/media_tests/media_device_open.c | 3 +++
>  tools/testing/selftests/media_tests/media_device_test.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/media_tests/media_device_open.c b/tools/testing/selftests/media_tests/media_device_open.c
> index 93183a37b133..2dfb2a11b148 100644
> --- a/tools/testing/selftests/media_tests/media_device_open.c
> +++ b/tools/testing/selftests/media_tests/media_device_open.c
> @@ -70,6 +70,7 @@ int main(int argc, char **argv)
>  	fd = open(media_device, O_RDWR);
>  	if (fd == -1) {
>  		printf("Media Device open errno %s\n", strerror(errno));
> +		close(fd);

Open failed so there is nothing to close.

>  		exit(-1);

When we exit() then all the resources are automatically reclaimed by the
operating system so we really don't worry about leaks at all in short
running programs.  It's different for an operating system or a web
server which is expected to have a long uptime.  But these programs are
going to run quickly and then exit so resource leaks are not an issue.

regards,
dan carpenter

