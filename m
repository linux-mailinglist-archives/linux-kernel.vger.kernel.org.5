Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A671676F7C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjHDCUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjHDCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:20:24 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255B73A90
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:20:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63d4b5890a0so10197166d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1691115622; x=1691720422;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DL7QqO7gdzDeLZ4Lt5CqIM0zO9j+hCqUuNJLaJnYEts=;
        b=YO6AR1bylUT5ii8VCBNh9R0U4hbO7k4kTFszkplDtOGaEUPqA9/wpEt9bK3SlDEw9Q
         DhzcmaWXYWqNuMlAD22xpOR7fEkvyspILNenTSW1NHgMSAKDMWSWnK9nbyEDJntCR/hL
         GFKR7kSjx38aS3Ulw7ODbw9f1GgujM5RNMh8qiPCWhn9NxSfDXmhtoEMxtcBtHL1mkZz
         aQMk+Vpd+n9bPQhaoH/kUe0HyDRtgYcXzgVEQyfdAY6d2qKTO/XwVj2oyBOijJrKrHOK
         D8dkUjOz/iJtRKNL5LGnp7Ur4e1Xv+F4eyA6uqG8ATpZnBOfRxty2kExP7Lf240FKb6M
         mPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691115622; x=1691720422;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DL7QqO7gdzDeLZ4Lt5CqIM0zO9j+hCqUuNJLaJnYEts=;
        b=O1/F5U510hFSZGYGKykWOzJYv5dgmOiP1JxS+odRjwAYoqWQqtIftYC/KYTCQnrXsa
         4mzojltt8ALvgxCgXd0+eoer0/hTxNqFK2GG3BbtvB4gRvt0YlrZsNDxq/JoEZrQwuPU
         5giOohOYWYYoESqDxBIH1rhhL6in+x54uran1jBJ2w0B+GlK75CvOvtBN2uIsLDiVcwz
         lKdh7e6fjjzRXlohWq1U0y5Pu/DgSKAqr/PzZLg5htL7iOBxRip8ILqZHZZ/u/UnMdLH
         HQFqdf3H08a28q7Lnl4Jb+2lr46BS4czqIr6gB003iSsxQAwDcF6H+1bH2wQ/3D1sdGM
         Cvag==
X-Gm-Message-State: AOJu0Ywlr3DfdXQvy3ip483uB8e1Kv63/Zg9O7/HqS95kaGXVevW2S6t
        Zgs6QkWUN3Oy4aaKU+dRaHFD
X-Google-Smtp-Source: AGHT+IHgyO6fkDjwMzmm5bVGuOPfS6kqod4OR8dR2047XqNcjl4XCrQSIlI7QK2pPaj94P9T+xRxQQ==
X-Received: by 2002:a0c:f40e:0:b0:626:1163:b446 with SMTP id h14-20020a0cf40e000000b006261163b446mr426720qvl.4.1691115621940;
        Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id q7-20020a05620a038700b00767db6f47bbsm331331qkm.73.2023.08.03.19.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 19:20:21 -0700 (PDT)
Date:   Thu, 03 Aug 2023 22:20:21 -0400
Message-ID: <80ff0d20d4d796ecf57bb5f08d3aaf7d.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] selinux: avoid implicit conversions in services  code
References: <20230728155501.39632-5-cgzones@googlemail.com>
In-Reply-To: <20230728155501.39632-5-cgzones@googlemail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 28, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 as the output parameter type in security_get_classes() and
> security_get_permissions(), based on the type of the symtab nprim
> member.
> 
> Declare the read-only class string parameter of
> security_get_permissions() const.
> 
> Avoid several implicit conversions by using the identical type for the
> destination.
> 
> Use the type identical to the source for local variables.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
> v2: avoid declarations in init-clauses of for loops
> ---
>  security/selinux/include/security.h |  4 ++--
>  security/selinux/selinuxfs.c        |  7 ++++---
>  security/selinux/ss/services.c      | 23 ++++++++++++-----------
>  3 files changed, 18 insertions(+), 16 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
