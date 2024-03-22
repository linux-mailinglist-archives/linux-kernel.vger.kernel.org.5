Return-Path: <linux-kernel+bounces-111371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC40886B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E69F2841EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A543F9C1;
	Fri, 22 Mar 2024 11:36:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00273EA88
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711107386; cv=none; b=i/NyxCZa0H4EkFoFVAIfvZB5byJmSQ2rWFsV7EUyvKIwT0pTOLaVSLlecmsmsPdlhxAdeZsAc1fkLiifxz/roHWLP7hFZcWji5pl9AxFfAKYx4W5BciTkpYe8b4cLz+KsMsm9dH5Hdx/9zuLUiR1bxMtMLAGS3WA0KOY9NLJACQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711107386; c=relaxed/simple;
	bh=yPrcCze0EHpTuHszj5s6YaVUl58c+kw1BbdxRZvNuNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i8JTkfVhGxFkXpdnu/7r9UsMqrplyKutZ76TsuAf0wY4hSkr52WnHMB9eb054oLGdQBveXNWRtFa7vjvI6x9jHHs+AjNx5EsHC09O97GRtgAQsHe2pbszII5+8WMzAqT82uGKGtio3zLxzdf+9LBGKWdswmOjwRXjW3actvqPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1Kwm52D6z1xsML;
	Fri, 22 Mar 2024 19:34:16 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id BD4F21A016C;
	Fri, 22 Mar 2024 19:36:11 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 22 Mar 2024 19:36:11 +0800
Message-ID: <6e0a0e04-1495-aec0-0ff3-d8df43ee9f16@huawei.com>
Date: Fri, 22 Mar 2024 19:36:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RFC PATCH 1/5] ubifs: Implement POSIX Access Control Lists
 (ACLs)
To: Zhihao Cheng <chengzhihao1@huawei.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-2-lizetao1@huawei.com>
 <61bf91fb-f926-8fdf-0157-20f5ad2ae279@huawei.com>
Content-Language: en-US
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <61bf91fb-f926-8fdf-0157-20f5ad2ae279@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100008.china.huawei.com (7.185.36.48) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

On 2024/3/21 10:55, Zhihao Cheng wrote:
> 在 2024/3/20 0:16, Li Zetao 写道:
>> Implement the ACLs feature for ubifs based on vfs Posix ACLs,
>> details as follows:
>>    * Initialize acl for newly created inode.
>>    * Provides get/set interface to access ACLs.
>>
>> ACLs feature relies on xattr implementation which using specific key
>> names "system.posix_acl_default" and "system.posix_acl_access". Now Only
>> the v2 version of POSIX ACLs is supported, and ubifs does not need to
>> customize the storage format, which can simplify the implementation.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   fs/ubifs/acl.c   | 140 +++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/ubifs/ubifs.h |  13 +++++
>>   fs/ubifs/xattr.c |   1 -
>>   3 files changed, 153 insertions(+), 1 deletion(-)
>>   create mode 100644 fs/ubifs/acl.c
>>
>> diff --git a/fs/ubifs/acl.c b/fs/ubifs/acl.c
>> new file mode 100644
>> index 000000000000..253568baf097
>> --- /dev/null
>> +++ b/fs/ubifs/acl.c
>> @@ -0,0 +1,140 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * This file is part of UBIFS.
>> + *
>> + * Copyright (C) 2024 Huawei Tech. Co., Ltd.
>> + *
>> + * Authors: Li Zetao <lizetao1@huawei.com>
>> + */
>> +
>> +/* This file implements POSIX Access Control Lists (ACLs) */
>> +
>> +#include "ubifs.h"
>> +
>> +#include <linux/posix_acl_xattr.h>
>> +
>> +struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, 
>> bool rcu)
>> +{
>> +    char *xattr_value = NULL;
>> +    const char *xattr_name;
>> +    struct posix_acl *acl;
>> +    ssize_t size;
>> +
>> +    if (rcu)
>> +        return ERR_PTR(-ECHILD);
>> +
>> +    xattr_name = posix_acl_xattr_name(type);
>> +    if (unlikely(!strcmp(xattr_name, "")))
>> +        return ERR_PTR(-EINVAL);
> The acl type has been guaranteed valid from vfs caller, there is no need 
> to check converted name by 'strcmp', in theory, we can use it directly 
> just like f2fs does. For this case, I suggest to unfold the 
> posix_acl_xattr_name and convert it to corresponding name just like 
> btrfs does.
Ok, I will modify it in the next version.
>> +
>> +    size = ubifs_xattr_get(inode, xattr_name, NULL, 0);
>> +    if (size > 0) {
>> +        xattr_value = kzalloc(size, GFP_KERNEL);
>> +        if (unlikely(!xattr_value))
>> +            return ERR_PTR(-ENOMEM);
>> +
>> +        size = ubifs_xattr_get(inode, xattr_name, xattr_value, size);
>> +    }
>> +
>> +    if (size > 0)
>> +        acl = posix_acl_from_xattr(&init_user_ns, xattr_value, size);
>> +    else if (size == -ENODATA || size == 0)
>> +        acl = NULL;
>> +    else
>> +        acl = ERR_PTR(size);
>> +
>> +    kfree(xattr_value);
>> +
>> +    return acl;
>> +}
>> +
>> +static int __ubifs_set_acl(struct inode *inode, int type, struct 
>> posix_acl *acl, int flags)
>> +{
>> +    void *xattr_value = NULL;
>> +    const char *xattr_name;
>> +    size_t size = 0;
>> +    int error;
>> +
> 
>> +    xattr_name = posix_acl_xattr_name(type);
>> +    if (unlikely(!strcmp(xattr_name, "")))
>> +        return -EINVAL;
>> +
>> +    if (unlikely(!strcmp(xattr_name, XATTR_NAME_POSIX_ACL_DEFAULT) && 
>> !S_ISDIR(inode->i_mode)))
>> +        return acl ? -EACCES : 0;
>> +
> Similar to previous, replace above 6 lines, refer to __btrfs_set_acl but 
> keep the error code same with __ext4_set_acl.
Ok.
>> +    if (acl) {
>> +        size = posix_acl_xattr_size(acl->a_count);
>> +        xattr_value = kmalloc(size, GFP_KERNEL);
>> +        if (unlikely(!xattr_value))
>> +            return -ENOMEM;
>> +
>> +        error = posix_acl_to_xattr(&init_user_ns, acl, xattr_value, 
>> size);
>> +        if (unlikely(error < 0))
>> +            goto out;
>> +    }
>> +
>> +    error = ubifs_xattr_set(inode, xattr_name, xattr_value, size, 
>> flags, false);
> There are 2 situations here, Updating acl and Removing acl. For the 
> later case, funcion vfs_remove_acl will remove corresponding xattr, the 
> xattr removing function in ubifs is ubifs_xattr_remove.
Thanks. Indeed, ubifs_xattr_set() is is different from other file 
systems, it will not delete xattr when value is NULL.
>> +    if (likely(!error))
> I prefer to remove the 'likely', UBIFS limits the max xattr count for 
> each file(Goto create_xattr), non zero error returned is a common case 
> on a small LEB flash.
Ok.
>> +        set_cached_acl(inode, type, acl);
>> +out:
>> +    kfree(xattr_value);
>> +    return error;
>> +}
>> +
>> +int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, 
>> struct posix_acl *acl, int type)
>> +{
>> +    struct inode *inode = d_inode(dentry);
>> +    umode_t old_mode = inode->i_mode;
>> +    int error;
>> +
>> +    if (type == ACL_TYPE_ACCESS && acl) {
>> +        error = posix_acl_update_mode(idmap, inode, &inode->i_mode, 
>> &acl);
>> +        if (unlikely(error))
>> +            return error;
>> +    }
>> +
>> +    error = __ubifs_set_acl(inode, type, acl, 0);
>> +    if (unlikely(error))
> Mentioned in __ubifs_set_acl, error could be returned, just remove 
> 'unlikely'.
Ok.
>> +        inode->i_mode = old_mode;
>> +
>> +    return error;
>> +
>> +}
>> +
>> +/**
>> + * ubifs_init_acl - initialize the ACLs for a new inode.
>> + * @inode: newly created inode
>> + * @dir: parent directory inode
>> + *
>> + * This function initialize ACLs, including inheriting the
> initialize -> initializes
Ok.
>> + * default ACLs of parent directory or modifying the default
>> + * ACLs according to the mode parameter in open() / creat()
>> + * system calls.
>> + */
>> +int ubifs_init_acl(struct inode *inode, struct inode *dir)
>> +{
>> +    struct posix_acl *default_acl;
>> +    struct posix_acl *acl;
>> +    int error;
>> +
>> +    error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
>> +    if (unlikely(error))
>> +        return error;
>> +
>> +    if (default_acl) {
>> +        error = __ubifs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl, 
>> XATTR_CREATE);
>> +        posix_acl_release(default_acl);
>> +    } else {
>> +        inode->i_default_acl = NULL;
>> +    }
>> +
>> +    if (acl) {
>> +        if (likely(!error))
> Remove 'likely'.
Ok.
>> +            error = __ubifs_set_acl(inode, ACL_TYPE_ACCESS, acl, 
>> XATTR_CREATE);
>> +        posix_acl_release(acl);
>> +    } else {
>> +        inode->i_acl = NULL;
>> +    }
>> +
>> +    return error;
>> +}
>> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
>> index 3916dc4f30ca..b0d3b076290d 100644
>> --- a/fs/ubifs/ubifs.h
>> +++ b/fs/ubifs/ubifs.h
>> @@ -2069,6 +2069,19 @@ static inline int ubifs_init_security(struct 
>> inode *dentry,
>>   }
>>   #endif
>> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL
>> +struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, 
>> bool rcu);
>> +int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, 
>> struct posix_acl *acl, int type);
>> +int ubifs_init_acl(struct inode *inode, struct inode *dir);
>> +
>> +#else /* CONFIG_UBIFS_FS_POSIX_ACL */
>> +#define ubifs_get_inode_acl NULL
>> +#define ubifs_set_acl NULL
>> +static inline int ubifs_init_acl(struct inode *inode, struct inode *dir)
>> +{
>> +    return 0;
>> +}
>> +#endif /* CONFIG_UBIFS_FS_POSIX_ACL */
>>   /* super.c */
>>   struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
>> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
>> index 0847db521984..eb1c1f5d10df 100644
>> --- a/fs/ubifs/xattr.c
>> +++ b/fs/ubifs/xattr.c
>> @@ -40,7 +40,6 @@
>>    * in the VFS inode cache. The xentries are cached in the LNC cache 
>> (see
>>    * tnc.c).
>>    *
>> - * ACL support is not implemented.
>>    */
>>   #include "ubifs.h"
>>
> 

