Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E38C7D05B8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJTAQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbjJTAP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:15:59 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418CC137
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:15:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6ce2cc39d12so190033a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697760956; x=1698365756; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCVrvRoy4SGPWE20sLca2ThSQwQI5qn6X68QgvLEZPo=;
        b=Z8c2oT9ABdXS4JFpoFEZXMc5FLveIg5FD1kmw/RtiibToeWIBu5R53AjQYfm7xMfap
         uDQPfXMeufg3Z7xV1ZfPji8+K3NFQsuMz6tFzL8Nhey0UkkLOd9iMnBVeiTCcEpyu/IX
         AQS2Bo628GnAj+2mDbiL0d8lDG/zDwg41Ca+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697760956; x=1698365756;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCVrvRoy4SGPWE20sLca2ThSQwQI5qn6X68QgvLEZPo=;
        b=dKhPnhdbc8k/WSrQCTJj5JBSzmS5Q4S49HZimD3MC30ZpHdc5rbbevjgvGZYv3PLeW
         sqtEUKe+1+q7T77oI8WB2YScFZWGr9X8FBiyiOTZXYyMVLsV41TqBuoWGIr+KD4WW39G
         3jpEWIv8QX7yMxi7iZaXuCp4ShFz+l0sel665J3cojtfvEBCVcjeukTISNeTUUWraNfE
         4LH071pgCrxy3tXl844CghlfveO7TJtyIVds2cgGbQezz+7mGyJYjWx617J03FZDWU23
         E7/++WT6ePfGsV4WWkILxFXHufKT6B1dyYB1IhJLe/L3VHcELpLS2HeKI3gqpEhOdbQh
         4WyQ==
X-Gm-Message-State: AOJu0YyFhF2hwP9uym4f6kC4cdLP82TNzE2EGG6irdVXiFtNcK+xutPq
        bAAR+7gS8pLYXGs5bkdy0qP/SQ==
X-Google-Smtp-Source: AGHT+IEHLvazYVGD5+oh4u6xlbwXIAQEvzEsnULcGkmSyGkZHb+qUhJKu+91HBvjlkfySxvWpaKNQw==
X-Received: by 2002:a05:6830:2b23:b0:6be:fe1e:c13 with SMTP id l35-20020a0568302b2300b006befe1e0c13mr503343otv.0.1697760956577;
        Thu, 19 Oct 2023 17:15:56 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x11-20020aa78f0b000000b00690fe1c928csm351482pfr.147.2023.10.19.17.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 17:15:55 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:15:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Justin Stitt <justinstitt@google.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: wwan: replace deprecated strncpy with strscpy_pad
Message-ID: <202310191715.5436893DD0@keescook>
References: <20231018-strncpy-drivers-net-wwan-rpmsg_wwan_ctrl-c-v1-1-4e343270373a@google.com>
 <202310182232.A569D262@keescook>
 <ZTExfv2aHPD2B1ze@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTExfv2aHPD2B1ze@gerhold.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:39:10PM +0200, Stephan Gerhold wrote:
> Hm, strscpy_pad() is neither a typical compiler builtin nor an inline
> function, so my naive assumption would be that this could only be
> optimized away with LTO?

Oops, yes, my mistake. I'm too used to the other fortified helpers that
are inlined...

-- 
Kees Cook
