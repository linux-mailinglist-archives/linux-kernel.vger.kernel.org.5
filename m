Return-Path: <linux-kernel+bounces-156091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA678AFDCF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 03:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F92A1F22944
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA64182B5;
	Wed, 24 Apr 2024 01:26:40 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BA417BA4;
	Wed, 24 Apr 2024 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921999; cv=none; b=YP6MswkW7mBnTY4MYRYlqci3altqTqSBskdxvBMAyBMdL2CiAAONKh9eKEcvSMh4YmqhPWgd73zuq+VkwRPjPY8mtSX2eqaW69QqASc1G/N7FtkdbIKIpB369DnUmRmsJx0tZVzHS0T4kC4ozyHrZQgszT/YyaYwTvVitL755ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921999; c=relaxed/simple;
	bh=HdbK1c5PH65Ln+NqTiHTHYmjfZk4I/zimd1Bd+VuGcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFCLm0T9tLl88OesNYestJM+feZGuiHL91/lBjTKsuANeexZH0U9LwDKyOImbn0dl1syRFMqO9Dus3K72yDAfxae3Px4J4a0t5g0br5NlhT431yzfvmx6MH5ZmtNwkP3HSLRvyjRs4KRt38HaPeQE6DeevrAP3kXG9ouFbUmZBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPLtF1nKjz4f3jkV;
	Wed, 24 Apr 2024 09:26:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 17E701A058D;
	Wed, 24 Apr 2024 09:26:34 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHGXyhmarAvKw--.54201S3;
	Wed, 24 Apr 2024 09:26:33 +0800 (CST)
Message-ID: <b7332fb7-4c49-3af2-7095-e728a6af8ff7@huaweicloud.com>
Date: Wed, 24 Apr 2024 09:26:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the
 erofs-fixes tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Gao Xiang <xiang@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Gao Xiang <hsiangkao@linux.alibaba.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 libaokun@huaweicloud.com
References: <20240424102445.53ba5ba2@canb.auug.org.au>
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <20240424102445.53ba5ba2@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHGBHGXyhmarAvKw--.54201S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4fuw15Jr4kZr4DWF4xXrb_yoWkCrX_Ww
	15Jan2vws8Zr42yw42yFsxZ3y7CFWjqr18tF1kKFsrZ3Z3Jan5GFn2y348A34vqryfWa98
	CF1agFy8Kw429jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0Ew4C26cxK6c8Ij28IcwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
	evJa73UjIFyTuYvjfU8VbyDUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

Hi Stephen,

On 2024/4/24 8:24, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>
>    fs/erofs/super.c
>
> between commits:
>
>    ab1bbc1735ff ("erofs: get rid of erofs_fs_context")
>    569a48fed355 ("erofs: reliably distinguish block based and fscache mode")
>
> from the erofs-fixes tree and commit:
>
>    e4f586a41748 ("erofs: reliably distinguish block based and fscache mode")
>
> from the vfs-brauner tree.
>
> I fixed it up (I think - I used the former version) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
>
Christian previously mentioned that the fix from the vfs-brauner tree
was an accident:

"An an accident on my part as I left it in the vfs.fixes branch."

So the two commits from the erofs-fixes tree are the final fixes.

I'm very sorry for any inconvenience caused.

Thanks,
Baokun


