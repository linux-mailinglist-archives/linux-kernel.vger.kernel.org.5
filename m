Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9697EF8EC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346185AbjKQU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjKQU54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:57:56 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8CD5B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:57:52 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-41cc537ed54so13925001cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700254671; x=1700859471; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bzVqwuvaomrtW1rFoY9rJJKDbCx8C1ZbkSBq2JOlS7c=;
        b=UgXRGSUY7JiQlnB7qYapmgY9IHLq6inX1AYTw7HnnKCW5iYGVi/Wo6Np65OwY/6FEv
         p4Kvh1NFMID4VwXGgrZoknbifkXPtrKUXPEuUUNV4s52j+xo4K4+imRQXiuXrScZjX+B
         llvj44l+xccHwV5qWRUpu1OY/biUG6iH/7lXz+wthAPAgX6t+Z7glBgriCVcy+GtBere
         746bdnbnzY4lKkCvPT0TnQlBy11ZAbmDiq6WLc9BJE/bquQE+Pdvjht6QiUb4NsMdmmY
         1fmIgZ356BgwBNMyWbk2VwexqWi2g9ePLbNKjR6XJhkOAMVxDsIybe8fneK15XeJg2YL
         54qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700254671; x=1700859471;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzVqwuvaomrtW1rFoY9rJJKDbCx8C1ZbkSBq2JOlS7c=;
        b=iUh+CpCCYDMYdjsR6zPaDqO8Zj05uXU7im+SLRXiSP2lUVTeFW1oyzmKMYiy9yL8tP
         evRGdN1RG8VXoFHjISEsPDaLA1WUvc7YA5ellKGY/qXr2TcuFLRdLJwAdtU7FfJKIMZ7
         xAsV6SWbHRd8WPXHjm74/qhTuY2oNf2k0fVZ3BMRItZAbXygA5VkJIVhx933hHTbanLB
         67dJvvlXa8x5Hig4vDenx/0GVvn/J8Z3o9DQMnwNb305mfesRD2rxZS1Jal/xhAfJ/69
         8i3EKkxyZaN8oxekzg8Q+XHSX55pSoFeYonMURrEG/xK0VADu0YrgEEokmCggsiyTDWR
         pjsA==
X-Gm-Message-State: AOJu0YzxteoRedY2KR37v4Xfggeb+uoXs+/BMymlDgPqKmIOONAA4Sh6
        Ytvi8oCxJXY0Tg8dJVIJXH44
X-Google-Smtp-Source: AGHT+IETTzY5QAJOhSSX9WgqhpKW3XEYQ+hKIJQj84OHBSoAAzNFaiPFDk/ljl7y5ZXFF2ajrMbeHg==
X-Received: by 2002:ac8:4e8f:0:b0:420:72:3075 with SMTP id 15-20020ac84e8f000000b0042000723075mr1208982qtp.17.1700254671570;
        Fri, 17 Nov 2023 12:57:51 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id p2-20020ac87402000000b004196d75d79csm831843qtq.46.2023.11.17.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:57:51 -0800 (PST)
Date:   Fri, 17 Nov 2023 15:57:50 -0500
Message-ID: <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed blob  for integrity_iint_cache
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
In-Reply-To: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov  7, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Before the security field of kernel objects could be shared among LSMs with
> the LSM stacking feature, IMA and EVM had to rely on an alternative storage
> of inode metadata. The association between inode metadata and inode is
> maintained through an rbtree.
> 
> Because of this alternative storage mechanism, there was no need to use
> disjoint inode metadata, so IMA and EVM today still share them.
> 
> With the reservation mechanism offered by the LSM infrastructure, the
> rbtree is no longer necessary, as each LSM could reserve a space in the
> security blob for each inode. However, since IMA and EVM share the
> inode metadata, they cannot directly reserve the space for them.
> 
> Instead, request from the 'integrity' LSM a space in the security blob for
> the pointer of inode metadata (integrity_iint_cache structure). The other
> reason for keeping the 'integrity' LSM is to preserve the original ordering
> of IMA and EVM functions as when they were hardcoded.
> 
> Prefer reserving space for a pointer to allocating the integrity_iint_cache
> structure directly, as IMA would require it only for a subset of inodes.
> Always allocating it would cause a waste of memory.
> 
> Introduce two primitives for getting and setting the pointer of
> integrity_iint_cache in the security blob, respectively
> integrity_inode_get_iint() and integrity_inode_set_iint(). This would make
> the code more understandable, as they directly replace rbtree operations.
> 
> Locking is not needed, as access to inode metadata is not shared, it is per
> inode.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/iint.c      | 71 +++++-----------------------------
>  security/integrity/integrity.h | 20 +++++++++-
>  2 files changed, 29 insertions(+), 62 deletions(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 882fde2a2607..a5edd3c70784 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -231,6 +175,10 @@ static int __init integrity_lsm_init(void)
>  	return 0;
>  }
>  
> +struct lsm_blob_sizes integrity_blob_sizes __ro_after_init = {
> +	.lbs_inode = sizeof(struct integrity_iint_cache *),
> +};

I'll admit that I'm likely missing an important detail, but is there
a reason why you couldn't stash the integrity_iint_cache struct
directly in the inode's security blob instead of the pointer?  For
example:

  struct lsm_blob_sizes ... = {
    .lbs_inode = sizeof(struct integrity_iint_cache),
  };

  struct integrity_iint_cache *integrity_inode_get(inode)
  {
    if (unlikely(!inode->isecurity))
      return NULL;
    return inode->i_security + integrity_blob_sizes.lbs_inode;
  }

--
paul-moore.com
