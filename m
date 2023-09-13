Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3979F098
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjIMRrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjIMRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:47:01 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26F1BC3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-450a670565dso68934137.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627214; x=1695232014; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZcFS3iOYkQO2W9mwcWv2JH1y1FxtklhD4Z215kPDlM=;
        b=GFNdi1KOqfLdtuk0R1uPPHQzi+NX4UlLmaO+Ul0vl0+LR0T/KSld967e7+FCf6rl4C
         G4OZiOFmLWNmcVLbrz14ELqZ4JKoqsbbvfBX6PyES8lmmDOZgI5/9zBmJ5chOeVDdrR5
         fHPPoIDnYybgONYGq7oBU0hnz80HplDYUtyOA/J4fCkvT5luh7WUANL4HAREBK1ZWsSU
         TVAsQwmyc8sRXdUn7uxAWAaVm3Y/06AAyojp2ZwzpIn2BaGm+vU3wcobMpEL8fsbH5za
         SDZuiYJVu+8IhXRULzasgJnqj73iB3zWD66v89Qw/dR9JidB8xTPVxOr98avigOPBlvM
         S5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627214; x=1695232014;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZcFS3iOYkQO2W9mwcWv2JH1y1FxtklhD4Z215kPDlM=;
        b=hH0WA/icxUyxtpzQePxVsY/0//MClM24FbJHEF9ff2RsC1VQF5Dc+O1yczCaK8PR9x
         JrIYmJeBOK/FtadxHHlKIKf6AsoWlibDTRHcUoYC4MPLO0F3zExhU1y10Vhylks/AcE4
         ootL5Gig0sTs2w13nNGYPyGCwPytg3a+m2l3mCvJRZ48alfmk2WJ+2LQ1CEBVTDgPON+
         bz5S+AKGtBPhXIh3dvM96F3sdf0A/XD1mSoZILtPrsc4qZFDAtUDPL/xumnYA8XYLzRQ
         pfrUF8nY631xzncOj+x3UUWUbcXH4ZYq9GImsaFccenq14aeLBpFVo7nWjBuIV515Ex1
         dDgw==
X-Gm-Message-State: AOJu0YxQj0Rw5zxj0L5MWer6Wl/+JFDEb3mvT+mU+FB5LygPEeMeey1S
        Cd8GZvPJhcZI846oh+P+hkMo
X-Google-Smtp-Source: AGHT+IEsLy5oMnv35nf0coOHBYWP0U4cJdBDcW5tlQYuaToqfLvM4OCZlHGLBbkzQBzrLXaeY6z4dA==
X-Received: by 2002:a67:fd97:0:b0:44d:5c61:e475 with SMTP id k23-20020a67fd97000000b0044d5c61e475mr2535485vsq.32.1694627214045;
        Wed, 13 Sep 2023 10:46:54 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x18-20020ae9f812000000b00767da10efb6sm4026837qkh.97.2023.09.13.10.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:52 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:51 -0400
Message-ID: <186da545d95255f5ba2368d09fb1a667.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] selinux: print sum of chain lengths^2 for hash tables
References: <20230818151220.166215-6-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-6-cgzones@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Print the sum of chain lengths squared as a metric for hash tables to
> provide more insights, similar to avtabs.
> 
> While on it add a comma in the avtab message to improve readability of
> the output.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c    | 2 +-
>  security/selinux/ss/hashtab.c  | 5 +++++
>  security/selinux/ss/hashtab.h  | 1 +
>  security/selinux/ss/policydb.c | 4 ++--
>  4 files changed, 9 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
