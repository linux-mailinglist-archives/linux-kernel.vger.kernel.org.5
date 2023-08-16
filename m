Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E224177D8AA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 04:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjHPC4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241432AbjHPCz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 22:55:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE492212D;
        Tue, 15 Aug 2023 19:55:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6887b3613e4so371190b3a.3;
        Tue, 15 Aug 2023 19:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692154556; x=1692759356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eMBvumhvLAcNW2VdiOT2JRAO7dR7SftnCzpdqfmYU4w=;
        b=nmNA1f8ez305if3CHZZYl9Nt1AyL2s/SkqEiWW4k1RWk6fRSrDi6ZCTocFCEAX84Dw
         g/9MvC4gaDYPbZWsQ+PXcC2OheiFO8r/X0wX1fhKdSYWjaDfEjhIu47Q1Ls1Q722aqzo
         6nn7DS2Wn1NRXb0S7tOXkVc+VtuOUYB9/bBjyE3XwTQW2fXD80RGUXgnVRc+wl65zrBZ
         7x0jbSNFh1SMcoZe/HDFJNIYl1R/zC6HkrsIOD0EfjialjBJI0q9ZiFWaO4ZZEdtIjEH
         8FV+8KRx2p83Nk96BTZ0wbimGQW1VoHTroEAEutB5xpOaM0p6nXhlfESkCLXN5QAYSbJ
         fovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692154556; x=1692759356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMBvumhvLAcNW2VdiOT2JRAO7dR7SftnCzpdqfmYU4w=;
        b=WNA5N0WqQYziM+SWNeoYEiZ4N0S3Wl88M9yNm0K1SELDXQaeul7zC0wjc53KXMSfGS
         NIFxbttSjwBZ9jtrXJhIZF00OyyzATGHDl8+pG6TXE8fZe4pmhRFCS+bdSyP+kaF8ZgM
         2auJY4E9CgRcDUi06PsUwyHEH0YAUhygmZ0DVdqjvXt8gyX2KyjxE2FtRlA6kMOeBhM3
         vZhpUcvYAiOzrj3sJQwlarEgCBqWQ8Pab+hyzGjjBj6C8IfpQMXpsJi+JqZTD3ciOuUa
         b5/0OoTqqlCzvY4sxNR+avDKooPDhiD7vMBo7mYtBZFKxbzD7jQE6hHRbc8FSY4yop6d
         41+g==
X-Gm-Message-State: AOJu0Yw3fB8ZGSUdCPUd4UmOPjhKpbe7Gq2qnSS3ZdWfzkb3nxc7LMRn
        E0Nb+n29x8FR0Ghn41yE2vU=
X-Google-Smtp-Source: AGHT+IGMG0b8hw9E9pVqFs67EQ1NHeGnmgKfBzeTjct+uJV5PfxjDRIerS+hy/XTpLU1uN70LuO/oQ==
X-Received: by 2002:a05:6a20:ce8f:b0:140:3aa:e2ce with SMTP id if15-20020a056a20ce8f00b0014003aae2cemr834476pzb.42.1692154556175;
        Tue, 15 Aug 2023 19:55:56 -0700 (PDT)
Received: from atom0118 ([2405:201:c009:58e9:6a8f:3187:b8c8:1572])
        by smtp.gmail.com with ESMTPSA id n21-20020aa79055000000b006878c00537bsm9994766pfo.120.2023.08.15.19.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 19:55:55 -0700 (PDT)
Date:   Wed, 16 Aug 2023 08:25:50 +0530
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v1] kernel: Add space before parenthesis and around '=',
 "==" and '<'
Message-ID: <20230816025550.GD57274@atom0118>
References: <20230815204553.52261-1-atulpant.linux@gmail.com>
 <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aecb4e94bc65928c674b6a083e7fd489.paul@paul-moore.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 06:09:19PM -0400, Paul Moore wrote:
> On Aug 15, 2023 Atul Kumar Pant <atulpant.linux@gmail.com> wrote:
> > 
> > Fixes following checkpatch.pl issue:
> > ERROR: space required before the open parenthesis '('
> > ERROR: spaces required around that '='
> > ERROR: spaces required around that '<'
> > ERROR: spaces required around that '=='
> > 
> > Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> > ---
> >  kernel/acct.c        |  2 +-
> >  kernel/auditfilter.c | 16 ++++++++--------
> >  kernel/auditsc.c     |  2 +-
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> I changed the subject line to "audit: add space before parenthesis and
> around '=', "==", and '<'" as the "audit:" prefix is more appropriate
> and I'm a believer of the Oxford Comma.  Otherwise it looks fine and I
> just merged it into audit/next, thanks.

	Thank you for your comments. Do I need to change commit message now?

> 
> --
> paul-moore.com
