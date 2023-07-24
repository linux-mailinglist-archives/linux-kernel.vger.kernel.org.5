Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D542760178
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjGXVpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGXVpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:45:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34CEE4F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b8ad907ba4so24665955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1690235129; x=1690839929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BL+qyCoyo+/FJmxYMvT7Q+EYVA+uxQICVRbaCHaHDjs=;
        b=DIHnVpSEwqHHJlzY6W9W4NKUk5XErF3q7aFfo3LVjbbdatZgl/wAoDVnstbjon4uIe
         2GuyeWvFugaMgG2rSx4cMe1TTZkeK/cTue+Ze8zEmfUbhZVXNRGMaXboZU61TpTDRkXf
         XFYCUa4te9rMhtXUVLVcCsM3fiyzctK4mNfRQj1SaJlJl1RATSiTcbNih/JPLeBnuu5D
         6AsdNm/IEEGRbEKHOV+npEAa6zqwwyvVKnP3Kj3YsSsafZR5ZTI08Ff43V1vzwb/Ou75
         wEMT9uTA+iz/8cWLApA3PwP2p0tnaX9VyQjsak6hUJ9+7q58aW19fxZjmau/Fnpxj1SV
         ZCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235129; x=1690839929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL+qyCoyo+/FJmxYMvT7Q+EYVA+uxQICVRbaCHaHDjs=;
        b=SF64IZXxPYVwgUsx/lOnbSI5yshjuB1vKDOM+1yjPA26CdqQlg8TE0expFPsnVpqaB
         rQ8smvah6d2/gShQ26k6Z2Kn8zRXGGdmNsGB72x+Igbcd2NX2jwXBkNd+YOuMLSbi+T4
         ExTNUHUn0Ml4TpEBTeiN1P+XsJFy7ijnx4yHZhmb+tKDyXUiWGx5gRWgWbVXN62F4noT
         lYFv4EBR9bEjd5AWCToXIRJ4URHSZPXuaVF1v5f6X8EmAsVjPn6MT38/uUX+YftBvMpt
         9bT5Neda6585IqU4n/Hhho7DcRoAjRBKB+4YbZlcmAIWm8UOf2XYuGWhGv/xViEsx7UA
         3LIw==
X-Gm-Message-State: ABy/qLY2ey4LvnbF/m/L+XlEfkpyFLL948tFJ38HQDLqbULd4jmETH1x
        kBwl6YSZavv3ULuqycDMc03Saw==
X-Google-Smtp-Source: APBJJlFVYzbLkqR812PkG7EThpJBwIewq1AsZm8jSGhh6K6T+XZ7HOnrvtv6QkZaNw91N+189A/okg==
X-Received: by 2002:a17:902:e805:b0:1b8:4e69:c8f7 with SMTP id u5-20020a170902e80500b001b84e69c8f7mr9822845plg.23.1690235129133;
        Mon, 24 Jul 2023 14:45:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-119-116.pa.vic.optusnet.com.au. [49.186.119.116])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902740900b001bb9f104330sm3196450pll.240.2023.07.24.14.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 14:45:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qO3Mr-00A6cJ-2H;
        Tue, 25 Jul 2023 07:45:25 +1000
Date:   Tue, 25 Jul 2023 07:45:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Daniel Dao <dqminh@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZL7w9dEH8BSXRzyu@dread.disaster.area>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wXwBR6S3StBwJJmo8Fu6KdPW5Q382N7FwnmfckBJo4e6ZD_A@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:23:31PM +0100, Daniel Dao wrote:
> Hi again,
> 
> We had another example of xarray corruption involving xfs and zsmalloc. We are
> running zram as swap. We have 2 tasks deadlock waiting for page to be released

Do your problems on 6.1 go away if you stop using zram as swap?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
