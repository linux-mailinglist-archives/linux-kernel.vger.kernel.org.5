Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71E27904EE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237596AbjIBERn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIBERm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:17:42 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5121704;
        Fri,  1 Sep 2023 21:17:40 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-794c7d95ba5so93646739f.0;
        Fri, 01 Sep 2023 21:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628259; x=1694233059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw3WQ4EC4hkue+S466kVN/YtcO9/qE8SLLorSsW+qHo=;
        b=CFuWjUevvHIp5kkzM0AKgPYV4+nu8j9Pv9lLcZT3sG4MNUsb1dTSrO3CdX7qJ8aRKW
         P4a2UfljfP5vbkwZptewuJwXET0jTlrwYDfbxJHMj5NFSHDQTwx1JVQxe0qBhclekiG+
         FXHOqqPu0zhO1FhK6fOqy9/KC3yuo5UZdeSA57tG7BxK4FJ62+7esP9trMmjbagzU91w
         zZgVaRE5cWQKoyD46cnnqFT+A0waVQQHH+EYk2k2rwJ8gH/IwDz/nDM8bRskngRDcBAm
         Jj1eYzv9S3Jg53r8kNBVNbW3v8pJF2nkmwXw1xtDPXTmQfpw85d9fzpd3TA3IRQZYov4
         rMPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628259; x=1694233059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mw3WQ4EC4hkue+S466kVN/YtcO9/qE8SLLorSsW+qHo=;
        b=b44LXptX7a5baKqvX1uSd+DDO7IE61wKROE5lWIuK80t5yQ3Yi43MDsCmtTmmgtLES
         NkPqmGV+xLcStDwAUSCjH23N4pTySKwa6ZemVmnnXmz/pW27nKi2Hua26LsPQxkhWOsu
         E7Zfv0cU5czYUG6Oz8nqDS6a05e0nd7caFXtndRXjON51nhYQlCsPtN6Y8xpkBqo8wky
         RzG98z+56xWHK6j1Bu5sQX0AYyko3n6dv2skg3EybK5macXDZI9G9KhBOutw/C2O36NH
         w0ltPG52gMGBFovf43MqOx/YfRIMYTBPY8Uo+tQ6nQJFALP7eCjILileZIVzUQAfVyJy
         x7hw==
X-Gm-Message-State: AOJu0YyiIyQJwzylBA/eS1Uqol+E+AmP3n4FVWBMTfT/fSrgstdSc2iS
        3sn2RMMNta8QLUl+lYRzwS0=
X-Google-Smtp-Source: AGHT+IHcOuWKNbo8LOHiD5iaCC0XwW0kguiWD8wPHfoyYoYGjbfwo+8xNebv+8juZU3rkX9b2sfCEg==
X-Received: by 2002:a6b:da16:0:b0:783:4bc6:636e with SMTP id x22-20020a6bda16000000b007834bc6636emr4432916iob.21.1693628259544;
        Fri, 01 Sep 2023 21:17:39 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6-20020a02a486000000b0042b2d43ee3fsm1532196jam.82.2023.09.01.21.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:17:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:17:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
Message-ID: <f5105d70-2801-4f49-a62b-bfac59bad9b7@roeck-us.net>
References: <20230831110828.874071888@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:09:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
