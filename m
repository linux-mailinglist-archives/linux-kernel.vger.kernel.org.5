Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743DD8060C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbjLEVZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345726AbjLEVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:25:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7939FD41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 13:25:30 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67adc37b797so6975496d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 13:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1701811529; x=1702416329; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JqyDFnCiC9C9iaP1KCSgmfjfaCqCGpifT7WUKn8rGrk=;
        b=b0PBwmWRMGvYvkJoisONmNJ+3T+kkZQqj0m4xMPH8H4VUzuQuonEf/1qKMSlGcFODG
         xJ+T43gtLkRJgKMc86OTz+SAPB3wbKOJ9/Bnygiz1YyRsO1HljWY7NUgPjPS6nKO/0bP
         3UPjHn/vbK2xLjkYQZ4dctCMZCc1gaxE+MMH+xygPjyvPaIipzxqQ3QlLbGsMxlu9ELT
         cNx57Om0Erb6BkOChBEGoOacngBYq9Zv3RzZJR2+cb7YCK1XEzbU2pOM7feYRz4srtJr
         h59hSsZSVVl33yEDvFQi3BIIHFyrzJROvUYLH4T71aQVZlcadBtRPftckPnrtbDCkR7K
         mrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701811529; x=1702416329;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JqyDFnCiC9C9iaP1KCSgmfjfaCqCGpifT7WUKn8rGrk=;
        b=tOb/oYZU7ACrsBq1HX4/4DjMwkn+RanrnmuMfn0VYZAYo0AFPJ1K2mfFiIswLbdMqB
         9wfY/HrDAMLiTiVSOVU9AP6PchKhzGLZVD4YjOO33TZqHV7V+nUPW+HeaI9CEUOFOG/M
         gU3B6X/dtu1xUSDPFPcsZxe6mK5hLGAPoN2+idcymBQgJDClc8QcVggMywYuZdMnfsQz
         r+DyiZp9wEJxJWWv0V33NrLMLbbUStPt/idPGeTui+cYMb2qGU7IDOoN2PtnJt4SAg+p
         J+JiiUm+dyNX123LUtrTONDbRtn9jd5vvMcPeWNinRIV/uioS+Bw9OeAjDqgOi5740ES
         78NQ==
X-Gm-Message-State: AOJu0Yx9vuQrrXnBGGERiXhpvTpsYE/KdLHhschROjI06gPSHWUSHrm5
        JXmIQ9a+FyFzFus+cx237Z+e
X-Google-Smtp-Source: AGHT+IHfsAskPVR7qfeDFP1DBUM6Fip1xoU/6JP7KZknQGN9TMVHFQ/nglQSG33mxgd0O6bDYwfI+Q==
X-Received: by 2002:a0c:fccf:0:b0:679:f5c8:2462 with SMTP id i15-20020a0cfccf000000b00679f5c82462mr1507275qvq.14.1701811529555;
        Tue, 05 Dec 2023 13:25:29 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id c7-20020a0ce147000000b0067ae01ab283sm315639qvl.36.2023.12.05.13.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 13:25:29 -0800 (PST)
Date:   Tue, 05 Dec 2023 16:25:28 -0500
Message-ID: <77e8575a68e862c5c0e64803bf2582b5@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Subject: Re: [PATCH 14/16] commoncap: remove cap_inode_getsecurity()
References: <20231129-idmap-fscap-refactor-v1-14-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-14-da5a26058a5b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2023 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org> wrote:
> 
> Reading of fscaps xattrs is now done via vfs_get_fscaps(), so there is
> no longer any need to do it from security_inode_getsecurity(). Remove
> cap_inode_getsecurity() and its associated helpers which are now unused.
> 
> We don't allow reading capabilities xattrs this way anyomre, so remove
> the handler and associated helpers.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  include/linux/security.h |   5 +-
>  security/commoncap.c     | 132 -----------------------------------------------
>  2 files changed, 1 insertion(+), 136 deletions(-)

Once again, you should get Serge's ACK on the commoncap.c stuff, but
no objections from a LSM perspective.

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

--
paul-moore.com
