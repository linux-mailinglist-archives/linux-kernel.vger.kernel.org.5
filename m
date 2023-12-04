Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDFD804161
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjLDWMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjLDWMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:12:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB06107
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:12:38 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5c5f0e325a6so1628224a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701727958; x=1702332758; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=kZlZspSLgzRFo2AIXtG6F/y5aA8ezGQOCsKYoHAcJ1v2zCpqJbuMDedfbiBy2Tu9C4
         xBMU8TyxnQa10i2a3GeTUsj8z8gBH5CsQc5+0e0MN03zF+Lw9pyPk9VdbFQ2ukoFbHyD
         BrYOBrSlcnLeWbKJmccJ3x7v8xeQbXe2+w3IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701727958; x=1702332758;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5w+w40k8reyqU3pjVynIeZmpGAhXy9mRn2YDUbDK6o=;
        b=oo7ypMKdCA77NGqlNw658h2BBMOAaSGfbZnoJUivhnrXMvkyLSaZZCwYFTiW0VtNz7
         oNUhZDSNgze5oWcmktmGHUgMwINxwuvfpm+11DcZs70T6Zmz1gNIPdPa5tPQtMLzI/sl
         UQGlAJqcqGiCnJc7RPXsgkWbIsXWO2Sf12IWyDYVuGNF4jP+HOr8yLmI/hY8h2mvsDwc
         ZhXcnzzvp8TURX6UHQsuDX4/dJNWMoPD3Sfz1p8ZvGF1WbPg0c74E0foQAA3k/Dm0lWt
         u+la96ifbR0KiFl0+BdLdom3to+eSyICa5qrS5LbLHtiwPa1IPqvX56EzCw9vx1QUQKj
         BrgA==
X-Gm-Message-State: AOJu0YzwrYXsZFO7A2OYlIPKn0nxeHIPNQDz838rkYcRiRUtLzPX+23Z
        QPyfa1lHwg8Boe/1Yzx7i0E2szmkqCD0ofFm7Po=
X-Google-Smtp-Source: AGHT+IHM5ek9ahZA4zDcV16QXDzsz49v7j1xdOQOO23qiKhgCK2UxX5VuXi5Txfj8ada4KvlaWZx7w==
X-Received: by 2002:a17:902:b210:b0:1d0:6ffd:8346 with SMTP id t16-20020a170902b21000b001d06ffd8346mr1942760plr.81.1701727957671;
        Mon, 04 Dec 2023 14:12:37 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001cfc4d8eddesm8876332plg.180.2023.12.04.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:12:36 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:12:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Granados <j.granados@samsung.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] seccomp: constify ctl_table arguments of
 utility functions
Message-ID: <202312041412.7D0EAC47E@keescook>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231204-const-sysctl-v2-5-7a5060b11447@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:52:18AM +0100, Thomas Weiﬂschuh wrote:
> In a future commit the proc_handlers themselves will change to
> "const struct ctl_table". As a preparation for that adapt the internal
> helpers.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
