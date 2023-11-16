Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423B7EDADB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKPEeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjKPEd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:33:56 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B681B2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41c157bbd30so2656281cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109231; x=1700714031; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=SwYS/wyuZgZb9WJ0PIvbdBV7/u/Z74cHs86kLwpyUjEaxAXQtDq6If6SI7YvAdGeTm
         6CCGvzBiXTzyxPeSUfFgQNUfwXcV8V6Ol45lE8wSbPTJkP5Yh2x+QdBsmHJs9uBoL3oJ
         eGSmR68w0bH5KDsM4hsNba/8NMA/Dl9jaNVn85591Ud0BL+hq9WIzhpnHo13OE4hgLt2
         JmqI4uCRpXAqIc0dTXWhjm/I3Pxv3lu83q7bOIndslt95HTIOsiQ1Xi73YnnBvxqTy2N
         TcmKB0D9Z7rNvSj00Z8ubcL6V54Qfcuv/lxJwqOi5ttkVZ1DdMhAr9Q1PyDEV3fHaCAh
         hhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109231; x=1700714031;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRCIUlxMviG/akojIoiuUtAzlfA4z+ppx5JWcANslrQ=;
        b=lNNhaTyiBrHlTxHCME5U9V9f0cufWZHbrphnUO+3+qIGjBrnObVq7LY10cXFJLz+1u
         5k27UX98coIXDziS7r2YN4urWr+mGHTstDYN8wxYvYATXXL6jHq04YIroV2FZjVMIah2
         wk2Xiy6yI5lKwI9Zx5g4XwBgT9T2T7XEnvoLrSpAD3+BZAXkL38BN4zLfzysSiKriMY6
         cmzEOa6utV7pIarNwKy6eV6AK5NVxanD6UEriyMFkzclmBpJUWKkljIKBeEt6wI0H0wk
         fFFDqV3UqguQpUW6GMCk0J10rFdWgNzYodG/swSqRJZ3bIrua92jZzUA8fXzP5b31pgZ
         DASw==
X-Gm-Message-State: AOJu0YwxAaTETc8wnmN5M5qMxgELgiTuimTgbkv+Q6xrGwP2E3ZWOBOw
        blkPfTNv3fW4TTkSk4YXMEej
X-Google-Smtp-Source: AGHT+IHphFpDzgVFwOfukFTgf3tIsG9A83ycMGfQY4UVTT6EROx8wCbgF2iRta1hsOxzIr0MuKuWvQ==
X-Received: by 2002:a05:622a:1a9c:b0:412:24e6:a485 with SMTP id s28-20020a05622a1a9c00b0041224e6a485mr8399280qtc.2.1700109231366;
        Wed, 15 Nov 2023 20:33:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id e7-20020ac84907000000b004195faf1e2csm4050405qtq.97.2023.11.15.20.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 20:33:50 -0800 (PST)
Date:   Wed, 15 Nov 2023 23:33:50 -0500
Message-ID: <f79bb72356ca062d3f3b6b00c3694d8f.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, mic@digikod.net
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 17/23] security: Introduce inode_post_remove_acl hook
References: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-18-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
> 
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  security/security.c           | 17 +++++++++++++++++
>  4 files changed, 28 insertions(+)

...

> diff --git a/security/security.c b/security/security.c
> index d2dbea54a63a..6eb7c9cff1e5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2413,6 +2413,23 @@ int security_inode_remove_acl(struct mnt_idmap *idmap,
>  	return evm_inode_remove_acl(idmap, dentry, acl_name);
>  }
>  
> +/**
> + * security_inode_post_remove_acl() - Update inode security after rm posix acls
> + * @idmap: idmap of the mount
> + * @dentry: file
> + * @acl_name: acl name
> + *
> + * Update inode security data after successfully removing posix acls on
> + * @dentry in @idmap. The posix acls are identified by @acl_name.
> + */
> +void security_inode_post_remove_acl(struct mnt_idmap *idmap,
> +				    struct dentry *dentry, const char *acl_name)
> +{
> +	if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
> +		return;

See previous comments regaring S_PRIVATE checks.

> +	call_void_hook(inode_post_remove_acl, idmap, dentry, acl_name);
> +}
> +
>  /**
>   * security_inode_post_setxattr() - Update the inode after a setxattr operation
>   * @dentry: file
> -- 
> 2.34.1

--
paul-moore.com
