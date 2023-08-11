Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0C7785E7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 05:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHKDRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 23:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjHKDQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 23:16:44 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564735A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:16:42 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-564b326185bso1014845a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 20:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691723802; x=1692328602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY1/rEhUnoYXpP/tRcdn6YBquvQgrE2/QRUNZMHDCT4=;
        b=i9i8wIyv7NPOeHwd1/B2KpsncgodXTe9GKckpVvfs/MXl/wA2dlLcnj2SVTj0J8gij
         Q9qwsEmApInnCzDfeKx0TUfQN67JkmAOoc3QYY/aF0FVz6nFs0fFM2kpgmdBwN+nmLpQ
         7WJUpr7MOS6fohXPdDgHyIfd5wiefhUwPim3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691723802; x=1692328602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY1/rEhUnoYXpP/tRcdn6YBquvQgrE2/QRUNZMHDCT4=;
        b=W0BN6M7bUn0d30x1uWs8MFHHwaBF8bhZeI1bhkEuNaAWYTylZYLsJEyxFVsdpiqrLM
         pxRmQ6d3d9yliHb8NXQR+R9KrWu8uZaw9m2yFhxqtojFVDMymyzCrzzngefqpXIg8tFp
         aTDsGW2PP/lBGhEalcjb8485NBk6fv6GB/mND6x+SBwJtAy4e3iSrMFt6eHDDW4oCTJB
         e2/Sz0leFD5Pwg1huM8iUnxQ5l11c+jUaHv9Gdn4XWXTY4y7rXnCU7lhRqWO1heTyMy9
         qWtCx06I0WzbFBYHfBN9rtbOX4/kQQYYbvgj22uiDUxEnaE5WGCYyVM9V7Wk1P8dOF0u
         BbeQ==
X-Gm-Message-State: AOJu0Yy0Vwq38lNezMWyW6y74OJl+f8bDmyWaz9tSthNxmgPcgLmuTm5
        geQ1NjTKQP9b8I++dqlCBmaxGafVX0xKdhFYKSk=
X-Google-Smtp-Source: AGHT+IHBZ7GgHM1r3fTzdfJt4xBgonjSOPiRQUrZ/NuMkBy4wvsLfv1dqbsurX81MHoCYQ0TL5XU1A==
X-Received: by 2002:a05:6a21:47c7:b0:12f:bb22:ad3b with SMTP id as7-20020a056a2147c700b0012fbb22ad3bmr743565pzc.62.1691723801806;
        Thu, 10 Aug 2023 20:16:41 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902e84300b001bc59cd718asm2547529plg.278.2023.08.10.20.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 20:16:40 -0700 (PDT)
Date:   Thu, 10 Aug 2023 20:16:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: pstore/ram: printk: NULL characters in pstore ramoops area
Message-ID: <202308102013.380EDA684B@keescook>
References: <f28990eb-03bc-2259-54d0-9f2254abfe62@linux.microsoft.com>
 <202308040053.7F38C6D@keescook>
 <0220f601-14f8-1dda-f057-73a608fbe62b@linux.microsoft.com>
 <202308101649.337F4D8@keescook>
 <0dace822-ce13-906e-46bd-e1cb9274cafe@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dace822-ce13-906e-46bd-e1cb9274cafe@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 05:48:17PM -0700, Vijay Balakrishna wrote:
> On 8/10/23 16:50, Kees Cook wrote:
> > Can you share the .config you're building with? And what are you using
> > to trigger an Oops? I will see if I can reproduce this...
> 
> 
> Config: https://paste.ubuntu.com/p/Vrcsf8Ry9g/
> 
> Just ran plain "sudo reboot" and inspected /var/lib/systemd/pstore/dmesg-ramoops-0 after reboot.

Ah-ha! I have reproduced by reconfiguring my system to use your exact
memory sizes. And I get the unexpected "dmesg-ramoops-0" file too! I
will continue digging...

-- 
Kees Cook
