Return-Path: <linux-kernel+bounces-109706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871A881C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F276CB21B50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275F24D10A;
	Thu, 21 Mar 2024 06:49:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81974D9EF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711003752; cv=none; b=I2yNcE0tfe5opoi60Fzs1Mg67bIAn4n4dI5Im3Ge6zGjKXCT5NL2Gq0dTmrHoy3CttE0vXGSy2RsPAJkkQE6RJBlkPWsgjwSoQ024TrxzgjLAMZ7tPigiXKYVjAUkS32y76NMGAL8+sLQ++zP6enpzGxg4w6Gs2XslIWjZNGvsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711003752; c=relaxed/simple;
	bh=gC9fiWVkRdQtTz7S4SM6sTWzeEQ6v/EMb/TX4NV3sp0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sKHHxBT1vxYL/kVW9RxGMZnooNSPOD8oQN6SJrRhH332dSQsRb5NA9ToyctEnVFoVJzs8lbFtfGEGQzD8QC5xmYN4CJb+hagPESNIiHu2/tdJ9Oz/3QM6X5Xm+XnScHV4JRogFBvyKUcfwD64kuY9FcIbtXT7KzwGLt06Kw5CBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V0bbY5bvpz1QB33;
	Thu, 21 Mar 2024 14:46:49 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DAA3D140414;
	Thu, 21 Mar 2024 14:49:06 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 14:49:06 +0800
Subject: Re: [RFC PATCH 4/5] ubifs: Introduce ACLs mount options
To: Li Zetao <lizetao1@huawei.com>, <richard@nod.at>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
 <20240319161646.2153867-5-lizetao1@huawei.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <c3d5f06e-bdc4-4312-19a1-17a7a64e8795@huawei.com>
Date: Thu, 21 Mar 2024 14:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240319161646.2153867-5-lizetao1@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

ÔÚ 2024/3/20 0:16, Li Zetao Ð´µÀ:
> Implement the ability to enable or disable the ACLs feature through
> mount options. "-o acl" option means enable and "-o noacl" means disable
> and it is enable by default.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   fs/ubifs/super.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   fs/ubifs/ubifs.h |  2 ++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 7f4031a15f4d..ed03bf11e51d 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -457,6 +457,13 @@ static int ubifs_show_options(struct seq_file *s, struct dentry *root)
>   	seq_printf(s, ",assert=%s", ubifs_assert_action_name(c));
>   	seq_printf(s, ",ubi=%d,vol=%d", c->vi.ubi_num, c->vi.vol_id);
>   
> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL

This config is introduced in pacth 5, we cannot use it in patch 4.
> +	if (c->mount_opts.acl == 2)
> +		seq_puts(s, ",acl");
> +	else if (c->mount_opts.acl == 1)
> +		seq_puts(s, ",noacl");
> +#endif
> +
>   	return 0;
>   }
>   
> @@ -967,6 +974,8 @@ static int check_volume_empty(struct ubifs_info *c)
>    * Opt_assert: set ubifs_assert() action
>    * Opt_auth_key: The key name used for authentication
>    * Opt_auth_hash_name: The hash type used for authentication
> + * Opt_acl: enable posix acl
> + * Opt_noacl: disable posix acl
>    * Opt_err: just end of array marker
>    */
>   enum {
> @@ -981,6 +990,8 @@ enum {
>   	Opt_auth_key,
>   	Opt_auth_hash_name,
>   	Opt_ignore,
> +	Opt_acl,
> +	Opt_noacl,
It would be better to update Documentation/filesystems/ubifs.rst to 
describe new mount options
>   	Opt_err,
>   };
>   
> @@ -997,6 +1008,8 @@ static const match_table_t tokens = {
>   	{Opt_ignore, "ubi=%s"},
>   	{Opt_ignore, "vol=%s"},
>   	{Opt_assert, "assert=%s"},
> +	{Opt_acl, "acl"},
> +	{Opt_noacl, "noacl"},
>   	{Opt_err, NULL},
>   };
>   
> @@ -1137,6 +1150,23 @@ static int ubifs_parse_options(struct ubifs_info *c, char *options,
>   			break;
>   		case Opt_ignore:
>   			break;
> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL
> +		case Opt_acl:
> +			c->mount_opts.acl = 2;
> +			c->vfs_sb->s_flags |= SB_POSIXACL;
> +			break;
> +		case Opt_noacl:
> +			c->mount_opts.acl = 1;
> +			c->vfs_sb->s_flags &= ~SB_POSIXACL;
> +			break;
> +#else
> +		case Opt_acl:
> +			ubifs_err(c, "acl options not supported");
> +			return -EINVAL;
> +		case Opt_noacl:
> +			ubifs_err(c, "noacl options not supported");
> +			return -EINVAL;
> +#endif
>   		default:
>   		{
>   			unsigned long flag;
> @@ -2011,12 +2041,17 @@ static int ubifs_remount_fs(struct super_block *sb, int *flags, char *data)
>   	sync_filesystem(sb);
>   	dbg_gen("old flags %#lx, new flags %#x", sb->s_flags, *flags);
>   
> +	c->mount_opts.acl = 0;
>   	err = ubifs_parse_options(c, data, 1);

1. mount -onoacl /dev/ubi0_0 /mnt # After that, mount will show 'noacl' 
option
2. mount -oremount,xxx /dev/ubi0_0 /mnt
If 'xxx' has nothing to do with acl, c->mount_opts.acl is set as '0'. 
Then superblock flag is assigned with 'SB_POSIXACL' and mount will not 
display 'nocal'. Will it make user confused?
>   	if (err) {
>   		ubifs_err(c, "invalid or unknown remount parameter");
>   		return err;
>   	}
>   
> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL
> +	if (!c->mount_opts.acl)
> +		c->vfs_sb->s_flags |= SB_POSIXACL;
> +#endif
>   	if (c->ro_mount && !(*flags & SB_RDONLY)) {
>   		if (c->ro_error) {
>   			ubifs_msg(c, "cannot re-mount R/W due to prior errors");
> @@ -2197,6 +2232,11 @@ static int ubifs_fill_super(struct super_block *sb, void *data, int silent)
>   	if (err)
>   		goto out_close;
>   
> +#ifdef CONFIG_UBIFS_FS_POSIX_ACL
> +	if (!c->mount_opts.acl)
> +		c->vfs_sb->s_flags |= SB_POSIXACL;
> +#endif
> +
>   	/*
>   	 * UBIFS provides 'backing_dev_info' in order to disable read-ahead. For
>   	 * UBIFS, I/O is not deferred, it is done immediately in read_folio,
> diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
> index b0d3b076290d..4a6078cbb2f5 100644
> --- a/fs/ubifs/ubifs.h
> +++ b/fs/ubifs/ubifs.h
> @@ -956,6 +956,7 @@ struct ubifs_orphan {
>    *                  specified in @compr_type)
>    * @compr_type: compressor type to override the superblock compressor with
>    *              (%UBIFS_COMPR_NONE, etc)
> + * @acl: enable/disable posix acl (%0 default, %1 disable, %2 enable)
>    */
>   struct ubifs_mount_opts {
>   	unsigned int unmount_mode:2;
> @@ -963,6 +964,7 @@ struct ubifs_mount_opts {
>   	unsigned int chk_data_crc:2;
>   	unsigned int override_compr:1;
>   	unsigned int compr_type:2;
> +	unsigned int acl:2;
>   };
>   
>   /**
> 


