Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD37EBE55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343505AbjKOICZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Nov 2023 03:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:02:22 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED979DF;
        Wed, 15 Nov 2023 00:02:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SVZwC08m1z9ycNc;
        Wed, 15 Nov 2023 15:45:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwCHN2HyelRliayxAA--.29367S2;
        Wed, 15 Nov 2023 09:02:00 +0100 (CET)
Message-ID: <379f6a45a3102e8cd1ed992c1895ac9f69ae0595.camel@huaweicloud.com>
Subject: Re: [PATCH v2 5/5] ramfs: Initialize security of in-memory inodes
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     casey@schaufler-ca.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed, 15 Nov 2023 09:01:52 +0100
In-Reply-To: <20230724151341.538889-6-roberto.sassu@huaweicloud.com>
References: <20230724151341.538889-1-roberto.sassu@huaweicloud.com>
         <20230724151341.538889-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwCHN2HyelRliayxAA--.29367S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr1fCrW5tr43uF4UuF1UAwb_yoW5ArykpF
        WIqas8Gwn5tF9rWr1fKF4Uu3WSqayrKr4DJws3Zw17AFn7Gw1Utr4Skr13CF1rGr48Gw4F
        qw4j9ry5Ww1DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJw
        CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
        xhVjvjDU0xZFpf9x07UQzVbUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBF1jj5J4hwABsZ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-24 at 17:13 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Add a call security_inode_init_security() after ramfs_get_inode(), to let
> LSMs initialize the inode security field. Skip ramfs_fill_super(), as the
> initialization is done through the sb_set_mnt_opts hook.
> 
> Calling security_inode_init_security() call inside ramfs_get_inode() is
> not possible since, for CONFIG_SHMEM=n, tmpfs also calls the former after
> the latter.
> 
> Pass NULL as initxattrs() callback to security_inode_init_security(), since
> the purpose of the call is only to initialize the in-memory inodes.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

+ Andrew

Hi Andrew

I'm proposing an extension to initialize the inode security field at
inode creation time for filesystems that don't support xattrs (ramfs in
this case).

The LSM infrastructure already supports setting the inode security
field, but only at run-time, with the inode_setsecurity hook.

I developed this to do some testing on the Smack LSM, and I thought it
could be useful anyway.

Casey would need your acked-by, to carry this patch in his repository.
I'm not completely sure if you are the maintainer, but in the past you
accepted a patch for ramfs.

If you have time and you could have a look, that would be great!

Thanks

Roberto

> ---
>  fs/ramfs/inode.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index fef477c7810..ac90ebd9dbd 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
> @@ -102,6 +102,14 @@ ramfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>  	int error = -ENOSPC;
>  
>  	if (inode) {
> +		error = security_inode_init_security(inode, dir,
> +						     &dentry->d_name, NULL,
> +						     NULL);
> +		if (error) {
> +			iput(inode);
> +			return error;
> +		}
> +
>  		d_instantiate(dentry, inode);
>  		dget(dentry);	/* Extra count - pin the dentry in core */
>  		error = 0;
> @@ -134,6 +142,15 @@ static int ramfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	inode = ramfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
>  	if (inode) {
>  		int l = strlen(symname)+1;
> +
> +		error = security_inode_init_security(inode, dir,
> +						     &dentry->d_name, NULL,
> +						     NULL);
> +		if (error) {
> +			iput(inode);
> +			return error;
> +		}
> +
>  		error = page_symlink(inode, symname, l);
>  		if (!error) {
>  			d_instantiate(dentry, inode);
> @@ -149,10 +166,20 @@ static int ramfs_tmpfile(struct mnt_idmap *idmap,
>  			 struct inode *dir, struct file *file, umode_t mode)
>  {
>  	struct inode *inode;
> +	int error;
>  
>  	inode = ramfs_get_inode(dir->i_sb, dir, mode, 0);
>  	if (!inode)
>  		return -ENOSPC;
> +
> +	error = security_inode_init_security(inode, dir,
> +					     &file_dentry(file)->d_name, NULL,
> +					     NULL);
> +	if (error) {
> +		iput(inode);
> +		return error;
> +	}
> +
>  	d_tmpfile(file, inode);
>  	return finish_open_simple(file, 0);
>  }

