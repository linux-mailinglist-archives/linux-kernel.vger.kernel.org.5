Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B717DEC87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 06:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjKBFvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 01:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjKBFqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 01:46:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8246D116
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 22:46:37 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cbf47fa563so4452785ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 22:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698903997; x=1699508797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hrOBT+EoEGtPZwvHU7oZh43WyyRFFukfmZ6U4aDKCE0=;
        b=BJN2ET1WU3IiTdq85KDLduA/sqPdxEiHSWEAqoKVDQqA3e3/d1jUakFM0N1ND/rwkv
         p1NWlLSeaKgM1UrryLbN3r6MriNx1qP+00uk5uP31Z5vYqgEhO0MbAq4IYBRgZwsZgRx
         RaaZomOW8uBbsytECIT6x95vtDWAJWqZ+EEbNWjSKOLBXUosgoeHEw+mU44nHmZKPE5K
         w88RuU3uG7dKxyf1p+GrZDOf1kEZeBPFY+t6m359X6WbOWRMpSKouakwg3I8wSZp6xIc
         6rySfz4iDRRPs39Z0wt102pAUCs7z+x3hTPexiMsBcGtz/HUbgiLk4vOfJsw5frnoK1L
         shHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698903997; x=1699508797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrOBT+EoEGtPZwvHU7oZh43WyyRFFukfmZ6U4aDKCE0=;
        b=mR4IxwBqLDD5nJ5tQTbggxPVd8htAQ73sLD0vJqsx9fM+qmU77dbZ1AgRKzt3vtMyP
         nIr7dn0LVaN7FffrQCEL6vUaWX7iY6KcGZrsA4uyV/I0xiDnZvDkw8E7lk3P74r8fTdv
         c8mHax/q9aHw+Eto3Lmrffp+TGMvrFHsmz7zAXjDsm9RauNN+FOFB5jEyS10/1KsYEoF
         ays2KiK8rPCrHEdkFrpDfU8XYRYFbnTVWxVo3tmYj1MH9x2fbn7JonTjwb/OvSRlhkkk
         kNedPWL/2N2VBEawqHfKSWeZMv+xy8nXDYeycRddehGungkHOvSyF1fYlDIeaivhjdAQ
         eXdw==
X-Gm-Message-State: AOJu0Yz0hJbkSGeezo8/9Hf8uSG30wwD4KX9Lezrljie3VID6RDf96aW
        J603BlZi5ujyn8jgaFlVtXKCCg==
X-Google-Smtp-Source: AGHT+IHzWzw/bbF9cpHuPtrCk+7Qj3F7TGyz61Sy9EZrghH/yAKxInxlWmDDujSzqHSGAGr0f2ru4A==
X-Received: by 2002:a17:903:111:b0:1cc:4073:88a1 with SMTP id y17-20020a170903011100b001cc407388a1mr7845028plc.0.1698903996993;
        Wed, 01 Nov 2023 22:46:36 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id e19-20020a170902f1d300b001cc54202429sm2198582plc.288.2023.11.01.22.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 22:46:36 -0700 (PDT)
Date:   Thu, 2 Nov 2023 11:16:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] opp: ti: Use device_get_match_data()
Message-ID: <20231102054634.u3nse5sv5mknyw7z@vireshk-i7>
References: <20231101144501.118972-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101144501.118972-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-11-23, 09:45, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> As this driver only does DT based matching, of_match_device() will never
> return NULL if we've gotten to probe(). Therefore, the NULL check and
> error return for it can be dropped.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Add missing commit msg
> ---
>  drivers/opp/ti-opp-supply.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)

Applied. Thanks.

-- 
viresh
