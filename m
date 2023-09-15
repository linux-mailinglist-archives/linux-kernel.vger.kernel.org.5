Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6379D7A1B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjIOJzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjIOJzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:55:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CB23A8D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:54:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so1667803f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771687; x=1695376487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QN2ysECZaxsR5qTnXWSsLCkH62m4vsM33pEzGxXKNLQ=;
        b=Z/OywtsxQe5q/uqSUsgzXcHPXj88pgAfxQrU5CMlxrYJKKWGfd2XMDO20KE3T8wMbb
         MgJqefNHIJTGAdq+qYq+b0DV0b4ExQcaPXp7J0nyOeFaYbOQm4rPe2yhUifKCq/3lgQb
         NILFL6Y8KR1z4Z5P6sVUMNQg/xXJYAKgqdjo1MKU9wZ5eSyrPvqb2Lymi0E8kWUx/LXq
         TF8fpe6Msyip5F6v7qrlOY8uG2z2Xt4824f9qTMOsB+HeVMDCU9QWfIeoCnw13KQzajr
         pTErgJq4EvPEPnxGXlNCdIJFdYiWBUkK6nNIGntIHBm7K8orauv5CtYEjORKr4T9o6U9
         ZOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771687; x=1695376487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QN2ysECZaxsR5qTnXWSsLCkH62m4vsM33pEzGxXKNLQ=;
        b=RRICQkmTc+nVEjUeHEiQEkrVJYPgE1eU0nwCKv4LlzPKgtsCiLnMJkQeRmlMvLYNDx
         qMc12/LNHPg0qMkHOSphU4/9W7vemFtGuVgbrEK1pc5X4B3dKwyAi4yepJMJrnTuhl00
         nYfaFflQIM6qo4DzwaDdonszInNBBrM4i97wvA0/EwLjtAIlxPQ9EeC6fybvtoCKrWLL
         6UhTb/blTAcXFGeDrogf4BR2xFWD+q6YrLCVMIWqFNdIidMuaSek2hNEOtF0O9IfKW7i
         PVOsLw/d/inItsbLw+Woo+n46BlYzvv5ubhuJZJCEAAn7P7sCqV2fLqYfNLfmBQFohtj
         EXPg==
X-Gm-Message-State: AOJu0YzMBtzfUK8Qtjf57HZBH1TPyWngSSFvCzpbDfpQ5v2Bayws2CoB
        gT/Mq63EuinPAI8OsEWLHBA=
X-Google-Smtp-Source: AGHT+IFdRkHr2ftSKb3eS1rAWjcY2pwaOTjJ8665Cc1Y7jsikT+Fz7MV2qN3gbh3TZN7Hg6Xg506TA==
X-Received: by 2002:a5d:6b90:0:b0:31a:d4e1:ea30 with SMTP id n16-20020a5d6b90000000b0031ad4e1ea30mr985411wrx.17.1694771687435;
        Fri, 15 Sep 2023 02:54:47 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d6ac8000000b0031416362e23sm4033905wrw.3.2023.09.15.02.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:54:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 11:54:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yi Sun <yi.sun@intel.com>
Cc:     dave.hansen@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        sohil.mehta@intel.com, ak@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, heng.su@intel.com,
        tony.luck@intel.com, dave.hansen@linux.intel.com,
        yi.sun@intel.intel.com
Subject: Re: [PATCH v6 1/3] x86/fpu: Measure the Latency of XSAVES and XRSTORS
Message-ID: <ZQQp5LbMOHFJITkn@gmail.com>
References: <20230901143414.1664368-1-yi.sun@intel.com>
 <20230901143414.1664368-2-yi.sun@intel.com>
 <ZPMTVNM2oBCdSYjJ@gmail.com>
 <ZPg8pJR55pmEZ4vQ@ysun46-mobl.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPg8pJR55pmEZ4vQ@ysun46-mobl.ccr.corp.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yi Sun <yi.sun@intel.com> wrote:

> > Instead of adding overhead to the regular FPU context saving/restoring 
> > code paths, could you add a helper function that has tracing code 
> > included, but which isn't otherwise used - and leave the regular code 
> > with no tracing overhead?

> Furthermore, according doc static-keys.txt, the condition 
> xrstor_tracing_enabled() would introduce only a minimal overhead when the 
> trace is disabled. I believe it is a negligible impact on the performance 
> when the trace is disabled.

Why introduce *any* extra overhead if it's possible to test the 
functionality separately? The stated goal of the series is only to measure 
FPU context switch performance, which doesn't require extra added overhead 
to the actual context switch path.

[ Or if you want to convince reviewers that the overhead is indeed minimal, 
  please provide before/after generated assembly of the affected code that 
  demonstrates minimal impact. ]

Thanks,

	Ingo
