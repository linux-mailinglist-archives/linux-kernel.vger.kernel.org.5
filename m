Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3057D7AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbjJZCWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjJZCWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:22:08 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF24AB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:22:06 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so5838381fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698286924; x=1698891724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8AsAZYQlbRWfphiw+n5aeH2fihFCPhpwTLcqLUi8re8=;
        b=OGlP5TA+SyvvFjMxLog1QJFdRqXC26K/K3hPNFhtZ+2Jm8nk/uyLKdSnfHvy/+qzG8
         uAvh/Ql4Vvr1/0lFa3Ko+KvhexLEO3RqJKgVTvx5AIWXd7F5gx/lhWxtDP96Whw/vn6X
         Y6TM7eJtrUrHzUObbRg8MFYHHyB30oEAJEuA9d/dTjWdxMK89njN6PW7C90546Jqsesk
         7VCnvc6HArA5HSuJd7RpfxaIch2yGYr3xAxcy/2L+DgcFUaPLS+bF1Wv4e6MqTufI/OT
         G6/sehUI5sGatq9/XOhoI9Xi//snKoGbPlGnxQ9YeaG62edZPvUAbhhG9A3murJEignv
         AcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698286924; x=1698891724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AsAZYQlbRWfphiw+n5aeH2fihFCPhpwTLcqLUi8re8=;
        b=sRsqB8FZkeFupQ0Ldh40EPzM+5MBpfMSGzfivdyrau5gxrilz6WTusFOx4GSbGMfsx
         xr6ZTJhCebhSmZQLs/wj8qYX/ESPGSfiBnVw8dM+kqooy1E3CPs4L0SkxFL7C36t6bQy
         oU7HD823vljuBjp7cjvwgpnLNVjxLUX5VLcHDxjT83kqaC4CIbD0k8bzmpn5vloI+wwV
         jrQkPFFN9Pu5HHsmMqJ/M7EvGWlKqxg4WYSLwmbE56gjwtz+1Es9X5+v0iFTPe2Rhv3M
         Xj30ws7R9taw7XiTlmQiiHO57kMRIfUtIzFXE/PRJSdg/MRoAN/Z8gWF3Dp3OXGi1nST
         GOuQ==
X-Gm-Message-State: AOJu0YxzcdBGGzExDU1EKJvR65QMefxpX0U2SEhc6joJan5EQ1VVIXAV
        GR2L7i3D6CAFyzKLBIKymXNCMYTGLhNhOU5OLdZd37Qo2pfkyErfX6ZuUw==
X-Google-Smtp-Source: AGHT+IHA2EJ+f7Fy0hURTD6CKOftYyThyI3Ff7nCrX4zvKOXfet9G8w1O5R3woOxvppl664jK4n9+YTdL6XQwDgQeTQ=
X-Received: by 2002:a19:914e:0:b0:500:daec:2817 with SMTP id
 y14-20020a19914e000000b00500daec2817mr11415274lfj.54.1698286923940; Wed, 25
 Oct 2023 19:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <2023102458-designate-vicinity-4c86@gregkh>
In-Reply-To: <2023102458-designate-vicinity-4c86@gregkh>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Date:   Thu, 26 Oct 2023 10:21:52 +0800
Message-ID: <CABQgh9FYB21pm+-fB1hBYnM5rv70RqTc0NABmxdBt1AxUyNJdA@mail.gmail.com>
Subject: Re: [PATCH] uacce: make uacce_class constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 19:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Now that the driver core allows for struct class to be in read-only
> memory, we should make all 'class' structures declared at build time
> placing them into read-only memory, instead of having to be dynamically
> allocated at runtime.
>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-accelerators@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, Greg

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
