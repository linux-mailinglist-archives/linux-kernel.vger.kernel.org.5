Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340F7B9FAF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjJEO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjJEOZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:25:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DB227B37
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:44:14 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40535597f01so8616965e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696513453; x=1697118253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4H2x/Q98PONLTuvH7BLyvxEUYi0TC7qsCtzYr2cez6g=;
        b=RjFSXDNtSyT9dbIVnlkRGJBroxoLAS8MeaVsdCLB52Hy3xuTZgldMJsTy5YcbimLQy
         G6Bcm+m4RNCjmcQyMQmOaPlP3Ty3g0DssbY40rNydPn+DWsV6y50fKwlL9jg+Paav/DY
         qOaScLdNDl779s//n+PXqx/RLSvBdFjUtf7gT2uFleRwxAqbCmtoC/wEX5eTvqJ6c46V
         2Vkjh3qNAwv/dllZ61AdJpZ8CeCwlHZyfW3pS27rbWTrqFdFpPwZyS67CrIKd3c+FSY3
         aY9G6tBpReU0iVBPzzmY2LHPJRkxi102xjTKhc8GyvPnbyyqxgvpprdNPTFYf3jKWDp6
         9X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696513453; x=1697118253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H2x/Q98PONLTuvH7BLyvxEUYi0TC7qsCtzYr2cez6g=;
        b=YICbCdLvdv6e3FQcC9NOKVzIe+ThLqz6tl30X7EIb8PmUxtszRSugeKZCOE4yvcStc
         O8lKGvAtXIHHcr0wEgRtWLsxsUbB97weW+bK49zUq/ralDic5+8HJbTU0n4gyN6BOWPB
         WegHMN5Inu1Pzke/QN0Rkzv+1HGLNSuFzuH3Hr9zAuPMfQ16e3uSc0wFn18NCNBJsmZ+
         oURjYtMRbaltKUrmbCWXkiTVs4lKvV/AJ+jmU0lTEQOyhErQuIGDMZyt+/MUHkhaEEuA
         Guk16sSxkZpmdFHAT+q96Vwm+O5L0ocnWZ/wdcO3V3JRFoOjJLOKZmlSJAQb8Kd27lgC
         uWig==
X-Gm-Message-State: AOJu0YwdIn9XrxSCareQlJVjpnbs+V4iU9Uxl3OZmn2WS2lWzFcWaZYS
        k7kErnalbzqdMuR8EIBoG7VSCA==
X-Google-Smtp-Source: AGHT+IEkQdWyFKDmYzO0BLwkXEoO2QnS1GnkdjFnl1ZzqizDdpMmrmtiUdCoClpcdWL+YnKS2bR5/w==
X-Received: by 2002:a1c:6a18:0:b0:401:eb0:a974 with SMTP id f24-20020a1c6a18000000b004010eb0a974mr4405896wmc.3.1696513453029;
        Thu, 05 Oct 2023 06:44:13 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m19-20020a7bcb93000000b003fe61c33df5sm3808705wmi.3.2023.10.05.06.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:44:12 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:44:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Su Hui <suhui@nfschina.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
Message-ID: <ceaa146a-2781-4266-ade8-6a25eb39abbf@kadam.mountain>
References: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com>
 <alpine.DEB.2.21.2310041557310.61599@angie.orcam.me.uk>
 <d98f7107-56d7-44a3-8b77-b8766cdc02d9@kadam.mountain>
 <alpine.DEB.2.21.2310051305530.20354@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2310051305530.20354@angie.orcam.me.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a W=1 static checker warning.  We've already reviewed it, and
marked it as old.  There isn't anything else required.

Or are we close to promoting the unused-but-set-variable warning from
W=1 to being on by default?  How many of these warnings are remaining?
It it's like only 20-50 warnings left then maybe we should consider the
other options but that kind of information needs to be in the cover
letter or otherwise we won't know about it.

regards,
dan carpenter
