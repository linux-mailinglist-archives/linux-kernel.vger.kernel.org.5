Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D657B3901
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjI2RcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbjI2Rb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:31:59 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BA19F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:31:58 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so12731556b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696008718; x=1696613518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pjfe+9DAgkAH6WItI1dT6HVJUqUjV4pKi1IHzGz52K4=;
        b=m2WXrXRaQPCdA/scxaXLlQNsCo82xzcYa/Ei+VPSsMzAfDxUSN9whgQWtCCiWbutTF
         MNAwUMRgAuHHxDt7wnkzfJ0GM8dIIYtRsNb0M60MACp8iWH6athpGkhpvmG9/BPbmRfK
         lSfVdiEdkDS8euU5XoAzmHX4gaj8GO6TOIvPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696008718; x=1696613518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pjfe+9DAgkAH6WItI1dT6HVJUqUjV4pKi1IHzGz52K4=;
        b=VZbp4NLprOp3Xcdy6p4Q1hRlcVdC1dgfyUtkr3lORqc/r4DH5nUa/Awnh9zmEqJFnN
         QBUHtp9txv7XuYk9rpnNuKzcEkUbKo7Zv1y9ZwQuLpm11I8YOQ0p8N5QuJNsquqGIyAw
         8mZcrywe923qhCnTEkTx4Wbltj4bSY9HHUmyh63s9RUXr5x1aweMOBHw47+Un91XY77k
         1kMJltJ6XjMH21H5RTHZ/q9aRJopuTrZpvzPnFe9rcxJgL+9dTw1NbgDvRVlVf+retYK
         9cLBJwwpg8w1nE3dcGzPpwRhI9Ej1b22O92TA65w3T6aDVZUcj7uouv0JunSJlpgfvei
         +6aw==
X-Gm-Message-State: AOJu0YxcbVUdbEE7nd8SbEKqnQV14lirmhENVQv0oVRMcvnrhRc0UIjh
        XvAL/ktUFjl0pL8IZhTjQ0ULpA==
X-Google-Smtp-Source: AGHT+IGfzsOOkJOPX9riY6Xxy/JU2BErzwzUVNeNoe1Yb+UlJJejoAy1cqSlz7xFqUqpsuSCjKY80g==
X-Received: by 2002:a05:6a21:601:b0:15d:4a2b:b513 with SMTP id ll1-20020a056a21060100b0015d4a2bb513mr3838810pzb.36.1696008717818;
        Fri, 29 Sep 2023 10:31:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cm22-20020a17090afa1600b0026b6d0a68c5sm1751514pjb.18.2023.09.29.10.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:31:57 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:31:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] kselftest: Add a ksft_perror() helper
Message-ID: <202309291031.1B2A2EE@keescook>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
 <20230928-ktap-exec-v1-1-1013a2db0426@kernel.org>
 <202309281747.594B3352@keescook>
 <ZRaB3SfRaUFsP7XN@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRaB3SfRaUFsP7XN@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 09:50:53AM +0200, Mark Brown wrote:
> On Thu, Sep 28, 2023 at 05:48:22PM -0700, Kees Cook wrote:
> 
> > > nolibc doesn't have a strerror() and adding the table of strings required
> > > doesn't seem like a good fit for what it's trying to do so when we're using
> > > that only print the errno.
> 
> > Oh, interesting... what environment ends up without strerror()?
> 
> Like I say it's for nolibc - it's just some header files (all in the
> kernel source), while it generally aims to be libc compatible it's
> intentionally very small.

Right, I mean, how would one normally encounter this environment? Running
the selftests on m68k userspace or something?

-- 
Kees Cook
