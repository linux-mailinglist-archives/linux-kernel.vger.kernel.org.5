Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FB67801EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356281AbjHQXtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356306AbjHQXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:49:18 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F263AB8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:48:57 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso304188a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692316135; x=1692920935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PAKQIXLHouMFwx6Fv4crHMiKgTKp66G2ai3jiop1Yj4=;
        b=K0g5aJMXHNQ9tKlmIbKBypxqOqIDvZioTg3HP9CXN5X2fAbt4lnAxJXx9eib9hQ8go
         wRtjxKuDZUWl0ikbLoLQN9j5SlqcKtjV0uLYZGEnlf6C4AJH0dFrWQLQCnFz2J9ASMY0
         0z2mWC9/NCThK3db+6SMpx6dweGYzhQ+E+ALs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692316135; x=1692920935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAKQIXLHouMFwx6Fv4crHMiKgTKp66G2ai3jiop1Yj4=;
        b=C7gIM5notSWIPhBhmOGaaT80lVh5F8sZJ71gmWianVSXU5icqBxL9YPweP8Bc9uCMo
         u46vsG4Box1A/3bJHFsXKsgI+3VJF55EuSo5Bj87YWQ4XUQnGo52QyCtgytAzD6kf/GN
         trQoeQd7u5S2uM/IhgeAiQw+cxMVKNyqMpaZFCa6VASACon1sEaM0rbY9cM/IFYKLdH0
         EKO1eAa5TtRaIamIaRgIvAUI46zC3z1yP3Et3GuQNxJH3PvjbDlvpt4DBeFtrW4V0f4R
         AZ2IagbLOqIPN2o8Uuz/Su0O+OW/4ki0U+cYNYRg1ZayobAOL0LhGQCRXqC/1SoFmv7b
         4L/g==
X-Gm-Message-State: AOJu0Yyb83pTES6HPtsJuvyxDrkZOZaKdMI+LUAL4T4KeIV4w7s3mLsD
        e/UOjTxzunUgcfhPh9j2j2SCBQ==
X-Google-Smtp-Source: AGHT+IEJNI3A1bPCA1MSh55tA3abJoflQ7uW5Ml6Ro/+S+Q1KbYVO82tGeqVZWpAQ/QxN+XJM5WLVw==
X-Received: by 2002:a05:6a20:6a22:b0:135:293b:9b14 with SMTP id p34-20020a056a206a2200b00135293b9b14mr1375833pzk.55.1692316135267;
        Thu, 17 Aug 2023 16:48:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b00686edf28c22sm303933pfd.87.2023.08.17.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 16:48:54 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:48:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] seccomp: fix the kernel-doc comment for the notification
 structure
Message-ID: <202308171648.4D19FBA@keescook>
References: <20230817232618.3022269-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817232618.3022269-1-avagin@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 04:26:18PM -0700, Andrei Vagin wrote:
> Remove an empty line and resort parameters in the comment.
> 
> Fixes: 48a1084a8b74 ("seccomp: add the synchronous mode for seccomp_unotify")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308171742.AncabIG1-lkp@intel.com/
> Signed-off-by: Andrei Vagin <avagin@google.com>

Thanks! I actually just sent this patch earlier, which fixes all of the
warnings being reported for the kerndoc build:

https://lore.kernel.org/lkml/20230817194302.never.378-kees@kernel.org/

-- 
Kees Cook
