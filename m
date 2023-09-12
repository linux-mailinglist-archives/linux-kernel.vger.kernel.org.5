Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F5179D8BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbjILSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjILSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:35:41 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D810D3;
        Tue, 12 Sep 2023 11:35:37 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c39a4f14bcso30243165ad.3;
        Tue, 12 Sep 2023 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694543737; x=1695148537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h24xyAGax89KQjODi2859PpmigCup6QNPCrrNOaC24s=;
        b=iBpJv59NT75SD1U5w1CHQlJiUeEq0rG0d+xfwTlfiwLGMCiY9nXdb48a44ACRu+57N
         escLvnj6o38USaRsXVDcZlwXOZlccO/XvDJRHI4E0MzgUuhqbfZqsm2qFZWLFHicnL/g
         Yj0KkqTMRAQ1C837K3oAEDxL7zDydp2KFwnbx4Mzs5ioRQyl2S/tU4/82lhAp7hfcqa3
         wocAThCKv60fYzkHAt0B2kMT1H7vpHYsJix+JAoCXPTk2M12vDJWnBxrt61qPB4+GLh6
         H3a02ZBrqctBNtGlmW1dO0LtA46e5eMN60WX/FRKmfzUB/b/OEM0J61dkKcxOHLKdgIR
         EuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694543737; x=1695148537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h24xyAGax89KQjODi2859PpmigCup6QNPCrrNOaC24s=;
        b=fRp25A23UcPwQqx3j0pLHRUg3RQdFGWZi5mAxY1tN4XG2S6XcOGfJ7zHv4RMu69VJ5
         Dwp7FyTL4BHmIjwMcRYi8hviP/xXuS1zRHTrU1aFCWNRfkb9rqDr8vLyPboSsdnhLxVQ
         wYzktMdeyZTegf7GrYOC/hT1LjXTa9a0rAMqFr7CqhI5d3ifGXz2ZU5SDLP2W78jbEMG
         JI4gT++NqFzFMPpUGwvc7BGj64OK6QBwXvlE8pzt/Q9Emycd1wANsyRpCA14TTJ/47ar
         xvc2I42YWRThrBj3TAZ+Ej44FDbZZ4Ag6YkkmkeHgHUbpeoopIjWa/r+zKfHWM22qWaK
         bBNw==
X-Gm-Message-State: AOJu0Yx66goAQnWt3tbmep1JiZ+BIcEORidmNL+ap6N7tX78Mf5MqgUX
        pNjhu/ix9GhDBx0B/rVSzTk=
X-Google-Smtp-Source: AGHT+IEyYs0usI7E4zusi8ydwn2ENx3zFpSB+mZ19YzOMCzGIT9R1Qf3BiU1x7tWSu2xU8AmNas1wg==
X-Received: by 2002:a17:90b:fc4:b0:268:15f5:9191 with SMTP id gd4-20020a17090b0fc400b0026815f59191mr105037pjb.36.1694543736980;
        Tue, 12 Sep 2023 11:35:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u11-20020a17090ae00b00b00264044cca0fsm1402310pjy.1.2023.09.12.11.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 11:35:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 12 Sep 2023 11:35:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
Message-ID: <ca95eee2-b776-497a-8c64-c98d016d05d5@roeck-us.net>
References: <20230911134633.619970489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:40:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 529 pass: 529 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
