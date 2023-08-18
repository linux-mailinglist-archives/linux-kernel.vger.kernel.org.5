Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDF97815C2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbjHRXU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbjHRXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:20:55 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8D4202
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:20:54 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-56463e0340cso1998711a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692400854; x=1693005654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PyLa/YXCWG8Ioi756bZyfqMYZZrLVzfhVj/H9cxHpY=;
        b=M/a6/H/RyT0D8BSlwnGSke8lsFeU/rFAhJSvmVP4Mi3tp1Cthc49SxGvHn15pLBntt
         buPtT2YNahM7IdodIebowj+D5P3MstG+M6vFFejySIdkPhart5qK6FwMmmGgZaOhagyy
         E8ZTPTJlT6Bw2gfeHQwjFH0Kl8uyv0vCmMTrg7IdZ3hNpOxK0nzErbUS12y8vggb4Lvw
         5gMrdsTSfsDOJkowen/bDkKQUtrUPJ5rMZFIZE+h9p5cLEdqUhH/2AW4v/vF1yDeYAVj
         19f+WdGW/F26P0llX1k+uZfbIeh6M+8RZ6BfdfXhJltbQ1lxCeaborox5jR+TiAvyrL+
         +2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692400854; x=1693005654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PyLa/YXCWG8Ioi756bZyfqMYZZrLVzfhVj/H9cxHpY=;
        b=cJLXsH64kLi8fBMcm+UvOFwlev+Ktqri7BQrmq7Fo2ptg8wssz3TPWqtCLL+ggnFzc
         apmiBFhIwUODxk3Pni0jH4+rigFAdIvln/ch6e8MVKgS1T+utRlqWUHMtk2mg7UWBRh8
         w3/PzUwfxJyuP1vnOxCVfyZtb3T9qUGMNA8b5GrKXiYfFXIroyAzHKbGIcyUT83O44se
         VE9QrzJQd65+l0hn+I3gBP02VFdt+Dw+8TGwddhVswIDcp0w2pULY90YKV6Ab/I6q+ea
         X8ZfJ7HdpqJybEWPJal8sf0ayqxfjTVVnm6qb/23OhN0jB0Aiql0+vLK8qtchn7l6cD/
         gMgw==
X-Gm-Message-State: AOJu0YxmAqnkV04MSgdo1OkRDSnKxPB5GMTPO9CNI2oe3myYYpeRdEZ1
        SUhAkl2NjpXhfAun5rtrRCQomIJDxG0=
X-Google-Smtp-Source: AGHT+IF4qS5R/BE7dJpAeC+QZGrTgckTfcEAGh0xkqcFb8AxU1bSBqKaL2z1ACwImIW/09VJP1acrmE4dFo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:b252:0:b0:563:932d:8cd7 with SMTP id
 t18-20020a63b252000000b00563932d8cd7mr126459pgo.2.1692400853932; Fri, 18 Aug
 2023 16:20:53 -0700 (PDT)
Date:   Fri, 18 Aug 2023 16:20:52 -0700
In-Reply-To: <053b45023744f62bd97cd4f87f048ab514f42b9d.1691446946.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1691446946.git.ackerleytng@google.com> <053b45023744f62bd97cd4f87f048ab514f42b9d.1691446946.git.ackerleytng@google.com>
Message-ID: <ZN/81KNAWofRCaQK@google.com>
Subject: Re: [RFC PATCH 02/11] KVM: guest_mem: Add ioctl KVM_LINK_GUEST_MEMFD
From:   Sean Christopherson <seanjc@google.com>
To:     Ackerley Tng <ackerleytng@google.com>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, shuah@kernel.org,
        andrew.jones@linux.dev, ricarkol@google.com,
        chao.p.peng@linux.intel.com, tabba@google.com, jarkko@kernel.org,
        yu.c.zhang@linux.intel.com, vannapurve@google.com,
        erdemaktas@google.com, mail@maciej.szmigiero.name, vbabka@suse.cz,
        david@redhat.com, qperret@google.com, michael.roth@amd.com,
        wei.w.wang@intel.com, liam.merwick@oracle.com,
        isaku.yamahata@gmail.com, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023, Ackerley Tng wrote:
> KVM_LINK_GUEST_MEMFD will link a gmem fd's underlying inode to a new
> file (and fd).
> 
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> ---
>  include/uapi/linux/kvm.h |  8 +++++
>  virt/kvm/guest_mem.c     | 73 ++++++++++++++++++++++++++++++++++++++++
>  virt/kvm/kvm_main.c      | 10 ++++++
>  virt/kvm/kvm_mm.h        |  7 ++++
>  4 files changed, 98 insertions(+)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index eb900344a054..d0e2a2ce0df2 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -2299,4 +2299,12 @@ struct kvm_create_guest_memfd {
>  	__u64 reserved[6];
>  };
>  
> +#define KVM_LINK_GUEST_MEMFD	_IOWR(KVMIO,  0xd5, struct kvm_link_guest_memfd)
> +
> +struct kvm_link_guest_memfd {
> +	__u64 fd;
> +	__u64 flags;
> +	__u64 reserved[6];
> +};
> +
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
> index 30d0ab8745ee..1b3df273f785 100644
> --- a/virt/kvm/guest_mem.c
> +++ b/virt/kvm/guest_mem.c
> @@ -477,6 +477,79 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
>  	return __kvm_gmem_create(kvm, size, flags, kvm_gmem_mnt);
>  }
>  
> +static inline void __kvm_gmem_do_link(struct inode *inode)
> +{
> +	/* Refer to simple_link() */
> +
> +	inode->i_ctime = current_time(inode);
> +	inc_nlink(inode);
> +
> +	/*
> +	 * ihold() to add additional reference to inode for reference in dentry,
> +	 * created in kvm_gmem_alloc_file() -> alloc_file_pseudo(). This is not
> +	 * necessary when creating a new file because alloc_inode() creates
> +	 * inodes with i_count = 1, which is the refcount for the dentry in the
> +	 * file.
> +	 */
> +	ihold(inode);
> +
> +	/*
> +	 * dget() and d_instantiate() complete the setup of a dentry, but those
> +	 * have already been done in kvm_gmem_alloc_file() ->
> +	 * alloc_file_pseudo()
> +	 */
> +}

Does this have to be done before the fd is exposed to userspace, or can it be
done after?  If it can be done after, I'd prefer to have the allocation helper
also install the fd, and also rename it to something that better conveys that
it's allocating more than just the file, e.g. that it allocates and initialize
kvm_gmem too.

Completely untested, but this is what I'm thinkin/hoping.

static int kvm_gmem_alloc_view(struct kvm *kvm, struct inode *inode,
			       struct vfsmount *mnt)
{
	struct file *file;
	struct kvm_gmem *gmem;

	gmem = kzalloc(sizeof(*gmem), GFP_KERNEL);
	if (!gmem)
		return -ENOMEM;

	fd = get_unused_fd_flags(0);
	if (fd < 0) {
		r = fd;
		goto err_fd;
	}

	file = alloc_file_pseudo(inode, mnt, "kvm-gmem", O_RDWR, &kvm_gmem_fops);
	if (IS_ERR(file)) {
		r = PTR_ERR(file);
		goto err_file;
	}

	file->f_flags |= O_LARGEFILE;
	file->f_mapping = inode->i_mapping;

	kvm_get_kvm(kvm);
	gmem->kvm = kvm;
	xa_init(&gmem->bindings);

	file->private_data = gmem;

	list_add(&gmem->entry, &inode->i_mapping->private_list);

	fd_install(fd, file);

	return 0;
err:
	put_unused_fd(fd);
err_fd:
	kfree(gmem);
	return r;
}

static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags,
			     struct vfsmount *mnt)
{
	const char *anon_name = "[kvm-gmem]";
	const struct qstr qname = QSTR_INIT(anon_name, strlen(anon_name));
	struct inode *inode;
	struct file *file;
	int fd, err;

	inode = alloc_anon_inode(mnt->mnt_sb);
	if (IS_ERR(inode))
		return PTR_ERR(inode);

	err = security_inode_init_security_anon(inode, &qname, NULL);
	if (err)
		goto err;

	inode->i_private = (void *)(unsigned long)flags;
	inode->i_op = &kvm_gmem_iops;
	inode->i_mapping->a_ops = &kvm_gmem_aops;
	inode->i_mode |= S_IFREG;
	inode->i_size = size;
	mapping_set_gfp_mask(inode->i_mapping, GFP_HIGHUSER);
	mapping_set_large_folios(inode->i_mapping);
	mapping_set_unevictable(inode->i_mapping);
	mapping_set_unmovable(inode->i_mapping);

	fd = kvm_gmem_alloc_view(kvm, inode, mnt);
	if (fd < 0) {
		err = fd;
		goto err;
	}
	return fd;
err:
	iput(inode);
	return err;
}
