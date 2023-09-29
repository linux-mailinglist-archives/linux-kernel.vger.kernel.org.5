Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D327B3922
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjI2Rtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjI2Rts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:49:48 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0255019F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:49:47 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690ba63891dso11420560b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696009786; x=1696614586; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tb9SgE+PjQ/TMe+HxjM4ps88fibUn7Lz2P6WDbPV8zI=;
        b=JgY1RtkNk8eGzUbsAJg6KL5+ag3N/GA1zkmDigCkAHflHZl8397AME4JIhFQicRfCB
         MCAVv2qKGMHdZLrrVURpSgpFNPbXJqfvfga7Da81JCRl3Ymfn91wh5b9fC0VTsNipBik
         ETyeaZiJgz3m4DugjKwRhvkE6B5T94b4Xa3pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696009786; x=1696614586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tb9SgE+PjQ/TMe+HxjM4ps88fibUn7Lz2P6WDbPV8zI=;
        b=oTlBWE86tFArzVTRIQlCYqhjJP3NOtBV6TW/FPF8pT1C3Lad86GFtHqBRYRsSR4No1
         AH4rKJP4G+m8pi4euakN7lhYp5E5kXD2+9706Ljt0rPQaN6GWEXvvcDKs32ciifM5ht5
         F7cvn3W3XBxNddQ55Ku+EFOYxVndxSY6YCyAmy3JuZwzyX47KEXSIUTpKULIrafvcZR+
         YGd87F3AM9Zs3nad8ajnt12N/mMOcJIj9SqrMWarnYtuYG65eD5qULpjqcNa0YsMk0su
         edfcDW+WHsfTJOV+NMSEQDIqdcZLQV9O3qFkqlXKeLFSTulIAPeg0N22GcXOvaTd0iUY
         n0PQ==
X-Gm-Message-State: AOJu0YxTLNg/LJMg0tL8CI4a0Hp2RGaNSJiJZdi+GvdVsgIfABo58TKf
        mRiVWnoCFHfSM+xstsOToNWueA==
X-Google-Smtp-Source: AGHT+IGbn+3BNWCjTTuyxQLw8tWyj2VyJzXvlSaWY37xxjHAVT7ka+2tJOFCDs1ZyMD1Uu+LL3BKJg==
X-Received: by 2002:a05:6a00:2e0e:b0:690:d718:8c6d with SMTP id fc14-20020a056a002e0e00b00690d7188c6dmr4660881pfb.15.1696009786482;
        Fri, 29 Sep 2023 10:49:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a17-20020aa780d1000000b00690d4464b94sm4430446pfn.7.2023.09.29.10.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 10:49:45 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:49:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        justinstitt@google.com
Cc:     kernel test robot <lkp@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy'
 specified bound 16 equals destination size
Message-ID: <202309291040.F201590997@keescook>
References: <202309280610.sLGSPkOG-lkp@intel.com>
 <CANiq72=J=bO-Q0=gMDyiRgvbF_Vre39iqbEnaEeDho4Vo2ox6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=J=bO-Q0=gMDyiRgvbF_Vre39iqbEnaEeDho4Vo2ox6A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:36:46AM +0200, Miguel Ojeda wrote:
> On Thu, Sep 28, 2023 at 12:24 AM kernel test robot <lkp@intel.com> wrote:
> >
> >    In function 'write_hints',
> >        inlined from 'dm_cache_write_hints' at drivers/md/dm-cache-metadata.c:1729:6:
> > >> drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy' specified bound 16 equals destination size [-Wstringop-truncation]
> >     1705 |         strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This looks fine given the check above it. In any case, since it
> appears the code wants to terminate the string, this should use
> `strscpy*()`, right?

I agree. I can't tell if _pad is needed though. I think struct
dm_cache_metadata is only used internally? And I see at least the
initial allocation is zeroed:

        cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);

Regardless, for background,

struct has:
        char policy_name[CACHE_POLICY_NAME_SIZE];

code does:
        const char *policy_name = dm_cache_policy_get_name(policy);

        if (!policy_name[0] ||
            (strlen(policy_name) > sizeof(cmd->policy_name) - 1))
                return -EINVAL;

        strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));


Justin, can you add this to your queue (if it's not already there)?

-Kees

-- 
Kees Cook
