Return-Path: <linux-kernel+bounces-70147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D284F8593F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F38281FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F4315C0;
	Sun, 18 Feb 2024 02:08:37 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D32A5F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222117; cv=none; b=HaydLRjat6KRvMbYQ5gBJ4L4BeZufzQPxv5fVcKNGbux+s7iuaVn1ic0Tw7+imdQMS/f9fSkU6KqyncLxslZVHVV/hQqI+VxCQA09Fn5zO4dxR40boTTNeQuU6pDSHeV5/2MKeT5F98H9O35opy3bjz5U71npDkBqESwvYY/lV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222117; c=relaxed/simple;
	bh=WPCpUFL7rDpPjQy9WWh1kqNzocjIj2cXFT0bFMaZdhk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IyYpkzBA1LhyJNs/8TVtqrsajmab1pC94dm2c88LuWHWvrJiGlvOYHJ2/+F6M2VqRjckw4hGK4qiHIxlDcDO0Jz0pW+jdYtg+7fp1ztIKmGrBwUWYmqI77ENDgGRDn3DASKE57qmzaxN+OY8wi0QEditnI6b6UopdhaYdBTqwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Tcpx66ybJz4f3jsb
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:08:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id CDA581A027B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:08:31 +0800 (CST)
Received: from [10.174.178.55] (unknown [10.174.178.55])
	by APP1 (Coremail) with SMTP id cCh0CgAn+RGcZtFlFZhoEQ--.55451S3;
	Sun, 18 Feb 2024 10:08:28 +0800 (CST)
Subject: Re: ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function
 kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of
 range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
To: kernel test robot <lkp@intel.com>, Zhen Lei <thunder.leizhen@huawei.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <202402061302.HkByW9x0-lkp@intel.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huaweicloud.com>
Message-ID: <bd30f81c-9e6a-578e-d496-6b7f355a3b79@huaweicloud.com>
Date: Sun, 18 Feb 2024 10:08:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202402061302.HkByW9x0-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAn+RGcZtFlFZhoEQ--.55451S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWDKr4kur48Gr48KF1rZwb_yoW8Wr4xpF
	48Ga98AF18Gw1IqwsrKrWjvF4Ygan8Gr4fGa4DGr1DZF4qvr1vv3WIkr4avr9I9rsrKrWF
	yws7Xw1fta4jqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/



On 2024/2/6 13:19, kernel test robot wrote:
> Hi Zhen,
> 
> FYI, the error/warning still remains.

I'm trying to reproduce it. But I'm having a little trouble getting
the environment ready.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478
> commit: 60443c88f3a89fd303a9e8c0e84895910675c316 kallsyms: Improve the performance of kallsyms_lookup_name()
> date:   1 year, 3 months ago
> config: riscv-randconfig-r064-20240120 (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240206/202402061302.HkByW9x0-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402061302.HkByW9x0-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: vmlinux.a(kernel/kallsyms.o):(function kallsyms_lookup_name: .text+0x90): relocation R_RISCV_PCREL_HI20 out of range: -524416 is not in [-524288, 524287]; references kallsyms_seqs_of_names
>    >>> referenced by kallsyms.c
>    >>> defined in vmlinux.a(kernel/kallsyms.o)
> 

-- 
Regards,
  Zhen Lei


