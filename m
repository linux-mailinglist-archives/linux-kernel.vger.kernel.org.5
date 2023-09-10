Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53B5799D79
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345925AbjIJJWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbjIJJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 05:22:11 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFF919E
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:22:07 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3aa1446066aso2470883b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694337726; x=1694942526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7KmoimTZXBn7xxEa4JoD6DLQsYP/FrWOgfaS5hIz0M=;
        b=FQHsx4WS6KrDjMGAM+iUFk3rdg33j0Izz3gD3zOTLh0za4o5zwMEFFES/7fqmp9I5S
         JbntrPsgKVDyiDFKjJsGu9dBvak9KNTMMTT1hqFvZ1jcydAbYNTueg+vN2EmsbCsbFsy
         gEo/L3lCzlQOkD6JEkhPc10iRl6H1v66Vux6H0HuFopGfiflwSnN3J72fnTIE397CzcQ
         d6mlTTX2moVaqUAEUZBGBL6a9PvBt4FkllbMvCIFZV5ltAkApFLhmVXiI5sC6mTHEXtz
         Y0FoDiRztw41n3I+Dkqe0bfK+qQgkbXja9QbNVtKXVc6JLZLPALSx1yzX+bPXCE1XE7D
         Uk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694337726; x=1694942526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7KmoimTZXBn7xxEa4JoD6DLQsYP/FrWOgfaS5hIz0M=;
        b=U3DLMgu7zDIcj2TNHR5mCo7CqqI8pJTn1iZNTjBsgOhDLLIHujutSyQSfI2+Qlcn8P
         s2J3j/mFhz61drn9ynzrRXAo+ruhAec0ax8W60n/vVFwnKGgC6aJLQ4DPf+OwbPR8gWv
         fLysnmGrpLXN4Nj2g8k039JAS9JnRGQe4UrEtoqf3t7Jqc2ooy6Cm76NbkTtQ3iaTdcb
         wCk79KTDTV6Nny3lyze+31yujRZy8M+2O8EDa/dTp/UdekxVmf0x3529h9dZkD0IteTQ
         rRMexdWpP5HB8lNJssUtBKn8cfj4sPQNIH1cJVhKrn6w1bLfheg8BtctZie8cIMekFjj
         u1tQ==
X-Gm-Message-State: AOJu0YxBaSMx2FSH+Vi1Sj8MKWFEKKWfza5P+aZ9FnD1WKc2mYdcZ3pG
        zu2WulNgBC/Wlx+PkhgHKtJOQw==
X-Google-Smtp-Source: AGHT+IEtF3iC/N+5TNNRC07S/EAfYtFzU+WyK//BgA8OVKmPnpzu4mk4hiYrDRGGJDzoNWuNfC03Ag==
X-Received: by 2002:a05:6808:b3b:b0:3a7:8e05:1699 with SMTP id t27-20020a0568080b3b00b003a78e051699mr8498783oij.37.1694337726511;
        Sun, 10 Sep 2023 02:22:06 -0700 (PDT)
Received: from leoy-huanghe.lan ([98.98.49.29])
        by smtp.gmail.com with ESMTPSA id d5-20020a63a705000000b005633311c70dsm3607356pgf.32.2023.09.10.02.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:22:05 -0700 (PDT)
Date:   Sun, 10 Sep 2023 17:22:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Bump minimum OpenCSD version to ensure a
 bugfix is present
Message-ID: <20230910092201.GA52362@leoy-huanghe.lan>
References: <20230901133716.677499-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901133716.677499-1-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:37:15PM +0100, James Clark wrote:
> Since commit d927ef5004ef ("perf cs-etm: Add exception level consistency
> check"), the exception that was added to Perf will be triggered unless
> the following bugfix from OpenCSD is present:
> 
>  - _Version 1.2.1_:
>   - __Bugfix__:
>     ETM4x / ETE - output of context elements to client can in some
>     circumstances be delayed until after subsequent atoms have been
>     processed leading to incorrect memory decode access via the client
>     callbacks. Fixed to flush context elements immediately they are
>     committed.
> 
> Rather than remove the assert and silently fail, just increase the
> minimum version requirement to avoid hard to debug issues and
> regressions.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Tested-by: Leo Yan <leo.yan@linaro.org>
