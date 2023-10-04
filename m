Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250647B83DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbjJDPmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242939AbjJDPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:42:07 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97969C4;
        Wed,  4 Oct 2023 08:42:03 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53447d0241eso4317502a12.3;
        Wed, 04 Oct 2023 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696434122; x=1697038922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OvjVzPTGCtL4oqLjVzkbN/IxKpJGIvUtgYCPF8tas/Y=;
        b=aCDp8/DjCA1fhiF4Kxe9okno+cYJ3o7ATaG8McEbdBefziLj0n5X+aEZ5aw7FCU+wB
         CY3M2kpuB6jcnv92f2v5qHQqWOYOhs7JlJUMMdeY8x2a++ABbsFCproMVAbzjWtrDXtB
         Ps+wCnmhV+2PhEJvWKwLl47fDaTZSgK3aR8nKCLY5Elp4LtjbhiDLOQN3Ax/LcWLEf4g
         Y9aHLlIKF76wolSMBI+nRKgfXiuhWsOQAjJSCgvL1fikWd1FAFre0whl+ihTN5zDiD9R
         YOFbBdfPK4UVsTHFMBiT67R0KZh/OjSqJF5CtD84BtcThLEx7Z07KECxRrJzm29oUh/N
         2TeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434122; x=1697038922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvjVzPTGCtL4oqLjVzkbN/IxKpJGIvUtgYCPF8tas/Y=;
        b=SALC5b6x2zM9gLPlBcKAZjYgDGGODYo5HUw8pQejtTMbq7pkL/KPS3JyK3I9HD448R
         lp2WPq4suYtfculq1m2XCfG59YttUNzJczOmguYHPxV0hqudEIynZpuDrq6UkjWMRooV
         3J9U44Wmw89Jbffeld0MU3sy2GkDgi+BrEFes4IPXh6NUDv0WY0Tl3B/kVggPosWE2yz
         mUfBnZsns2CxsD2QN0jDYS0SMvV1YkT4dC6wSrJyjFjK9FMK3pvq5AfplyQLVFc591jP
         jTzOtiC+kbbZfJULD8P5cN1+MkWdZXn2OSiKk2J626JJXX7Ca68jHa+GG2eMSILsRWgU
         jIGg==
X-Gm-Message-State: AOJu0YwAYaJn156JpZJHi2l+CCEBjCe/xuhR6t+Y8AC+rlA1Tp2O++Nv
        VdC7B2c5Q4KimMgE1em1Z7c=
X-Google-Smtp-Source: AGHT+IGfJFMYoivdUNueBocO55E3i4Zz7heVKHr5RK9bEhFnP8nhzI0EgR5qAPSBRSDPWCwTb+ikrg==
X-Received: by 2002:a05:6402:350:b0:534:1e2a:d966 with SMTP id r16-20020a056402035000b005341e2ad966mr2549746edw.11.1696434121765;
        Wed, 04 Oct 2023 08:42:01 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id g20-20020aa7d1d4000000b00536159c6c45sm43431edp.15.2023.10.04.08.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 08:42:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 17:41:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jianlin Li <ljianlin99@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the tip tree
Message-ID: <ZR2Hx7ILfxU3q/E+@gmail.com>
References: <20231004133306.3285d8de@canb.auug.org.au>
 <874jj64iol.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jj64iol.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jonathan Corbet <corbet@lwn.net> wrote:

> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> 
> > Hi all,
> >
> > The following commit is also in the jc_docs tree as a different commit
> > (but the same patch):
> >
> >   c53cbc54ccff ("x86/iommu/docs: Update AMD IOMMU specification document URL")
> >
> > This is commit
> >
> >   73c5f76ecbdb ("x86/iommu/docs: Update AMD IOMMU specification document URL")
> >
> > in the jc_docs tree.
> 
> Hmm...I thought I even checked for that.  No worries, I can drop my
> copy.

I'm pretty sure it was me who added the duplicate - sorry about that!

Thanks,

	Ingo
