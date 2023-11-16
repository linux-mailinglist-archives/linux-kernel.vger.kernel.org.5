Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDB7ED9CF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 03:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344463AbjKPC6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 21:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPC6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 21:58:40 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E8D98
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:58:36 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77891c236fcso17317085a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 18:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700103516; x=1700708316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hs2hnvAued5HrvZ/cBnHlyuuCD0UE1wujBRKwJijC40=;
        b=K3Sx0ycV7qcP0pgSpPX7nGu2KDJWnP8Nmltty7Mao58hRQ6OIexD1h/X+nA7RFHY7W
         bL+Q+pBnVhkVxg0Ul9tzaKTCkvyczRKL0p7Inkq5Ugh8SZ67GjE7kiFQ4ASBr4b3TWxh
         B32nwgHrcbecilFl3CxRv0Zvs8vwOr0CoMFSRRJjbS9r9GROwIOdpO4EHlgqqJney4pz
         2ObnmQ1ngTcwfzjVrfK6hzgg9hKDUPDbLQC5NZIr0ax3hE6pr2weJrQhS8HtImosQcnu
         R2Ji2eWPBN3i4EvRLokiooqYNtqaqPmiYXc2DsMuBovbjWprf0R1EJW2OJ60/dK7FRyd
         8uNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700103516; x=1700708316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs2hnvAued5HrvZ/cBnHlyuuCD0UE1wujBRKwJijC40=;
        b=I1P1dYW48ezPP+93pjCXbS2vIv7W77SXPfYCG1IhRN/O1fnE9BTP2gQHqN9G5Qtu1w
         yNu1Pyyq5jYIgo9ZAIl6r/ADwZd+hBTW2r6BJ32EndgJdFNvH1ajI0bjZi4Je775RDo8
         y7tgvC9HIpdRIW4T252c8KaX2SKI653dV5xUtBDF2JnAOFk8K37LEKFSu1PJ2vkHxDph
         PVViPzkDREZIm9zaR5fkO29nAhhlVES/u5n4SzxanMCN+1Ysi7W4wh2ECI2heuPUCQ3C
         VRIMx59eth7Wq90pOrD/BDA10KpjVwVAOZiGs/c8QNPd6ECifTW7QQ68j0+t6unbVElq
         noZg==
X-Gm-Message-State: AOJu0YwLcKk/IC3a1+HcUwwvmnd1b50/RwtfqF34/MCPSAiaAjIEsSVC
        l3vn+X0UW7VZi307UoBk8Wo=
X-Google-Smtp-Source: AGHT+IEnH9sb1smgYLUwRFJoFBFVmga/mr17nwfNlk09I0AVigPp9XLtgjl671tOXJ6LJMRCh88FiQ==
X-Received: by 2002:a05:620a:4627:b0:779:efb4:73bb with SMTP id br39-20020a05620a462700b00779efb473bbmr8205985qkb.41.1700103515793;
        Wed, 15 Nov 2023 18:58:35 -0800 (PST)
Received: from localhost (mobile-166-170-33-142.mycingular.net. [166.170.33.142])
        by smtp.gmail.com with ESMTPSA id q26-20020ae9e41a000000b0076f12fcb0easm3945742qkc.2.2023.11.15.18.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:58:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 15 Nov 2023 16:58:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     huangzaiyang <huangzaiyang@oppo.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ZaiYang Huang <hzy0719@163.com>
Subject: Re: [PATCH] workqueue: Make a warning when a pending delay work
 being re-init
Message-ID: <ZVWFWh_HL_wzYyd1@mtj.duckdns.org>
References: <20231115113427.1420-1-huangzaiyang@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115113427.1420-1-huangzaiyang@oppo.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 15, 2023 at 07:34:27PM +0800, huangzaiyang wrote:
> @@ -310,6 +326,7 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
> 
>  #define __INIT_DELAYED_WORK(_work, _func, _tflags)                     \
>         do {                                                            \
> +               WARN_ON(delayed_work_pending(_work));                   \
>                 INIT_WORK(&(_work)->work, (_func));                     \
>                 __init_timer(&(_work)->timer,                           \
>                              delayed_work_timer_fn,                     \

As pointed out by others, as we don't know what's in the memory, this
wouldn't really work. This kind of bugs should be caught by
DEBUG_OBJECTS_WORK / DEBUG_OBJECTS_TIMERS, I think. It's not perfect as
those aren't usually turned on but catching this sort of errors does need
tracking some information out of band.

Thanks.

-- 
tejun
