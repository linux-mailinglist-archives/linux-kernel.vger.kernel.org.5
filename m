Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4BA79F09C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbjIMRrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbjIMRrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:47:01 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28531BD5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-770ef334b4fso6739485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694627216; x=1695232016; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fq2QaUw7hcnVk3oTH8w/se+CPL9qM4hG/JXx5bxYAvg=;
        b=E/aNsKg6EAKW37iWcnq95ArmU+7ilPsUz7063zPv9L0zAigykAXPwBMw9+yM0w/i2/
         097L03lxcIMmljCu9TmQWs+NkxCTCkT0XXKuRV7JlsFcDxLQsFNPhS+xjdFj+igYNSCk
         +MQ32KzgWhlVCF0rebu5Pj4efFvqM5cMzfcTgq1ODJbPbyUhym2OQlKNaA5HxqJiLN+L
         BtK5dsq7ONmVtM9UFUizm09nmN/kOSlLTvPJ1vOyR7s/Ma8Mkn1EKS6VxBo6MGbjlgq0
         94ABTvJeJ85jYwa1L3comrxRjPENRyWOTN4cgjW62ZO9AmoS4w8K+aNfNCLcrmNCIdnx
         Wthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694627216; x=1695232016;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq2QaUw7hcnVk3oTH8w/se+CPL9qM4hG/JXx5bxYAvg=;
        b=N5azwR2PnT5G0laInXcsFZmULVAkSPsPMUQpiHUcZeh+HI84NiqWi+ohA94aSZ2SHB
         i4jryGFGJcRV2f9clCVG87l3QvLCqMQgbo52ow+mqxBhxPcpgjlxUq5Jftpv1BIuDWkQ
         QJSt7gy1JR7bBjmIwDZhz5lMHoJ43ois8mfg+VXnO/EPeAWP+V36Ky3jtphuJd+9TGs4
         OP4zzLVZXs2KAv1StYWS7XOStaaHsGUHqkxOd8mTJ3R0te2Xd0qoWDGVXn42E3X3n5iM
         xXd2d+amSapSL/CtA53eIqHsWlpzHUDIjj4982Rq/YfEAygXEq0rdbXWe8/1yNvN0cdH
         r69g==
X-Gm-Message-State: AOJu0YwI0RU4qGI8nVwr3R+usJkQnClBHlAHJwhsvweYtLhMBzZNZxKm
        EoSDpdKzlEzDZtsmm16J6cEh
X-Google-Smtp-Source: AGHT+IHeiwuCnkQcwVSOljnFxH4QHEUpQ9t0rbghMa6BVpfVfg7IO99ZVo4vgxfBXfzMbwV6BhXv5g==
X-Received: by 2002:a05:620a:3182:b0:76f:1230:3186 with SMTP id bi2-20020a05620a318200b0076f12303186mr7881449qkb.2.1694627215816;
        Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z4-20020a05620a100400b00763b94432ebsm4047231qkj.18.2023.09.13.10.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 10:46:55 -0700 (PDT)
Date:   Wed, 13 Sep 2023 13:46:55 -0400
Message-ID: <5ecaa60d383d75aebf266bf10850a791.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] selinux: simplify avtab slot calculation
References: <20230818151220.166215-3-cgzones@googlemail.com>
In-Reply-To: <20230818151220.166215-3-cgzones@googlemail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 18, 2023 Stephen Smalley <stephen.smalley.work@gmail.com> wrote:
> 
> Instead of dividing by 8 and then performing log2 by hand, use a more
> readable calculation.
> 
> The behavior of rounddown_pow_of_two() for an input of 0 is undefined,
> so handle that case and small values manually to achieve the same
> results.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  security/selinux/ss/avtab.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

Much nicer, thanks.  Merged into selinux/next.

--
paul-moore.com
