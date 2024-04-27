Return-Path: <linux-kernel+bounces-161000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BBC8B459C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AAFB21681
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9636B4204C;
	Sat, 27 Apr 2024 10:45:03 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499C4405FC;
	Sat, 27 Apr 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714214703; cv=none; b=VMhBj4o5OBOWNIHoCYRepbSGdborZFOjD/Zpim4pZrGYazpbjNjGfV4qzJse/0qtvWp0r1cDpea/yMOb6Eb9RW62DDyeimVmDAlvpH+EOytcFFX77Pg9WeV5w599KC2PWdpKTXSjyxSZcGB8LixyiIuOyfBZZLp5etRDZ9p4ODU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714214703; c=relaxed/simple;
	bh=MLacY6aG8bo9wwwwbKKlBJEsS83ygocXS1Ntn3xYnC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZHyEE6Edk7yUyG9w07mYtlSPrFVdHwshORA8+OqJrD9YO9Hy/kkbKa4RYlZZ2TtjW0yvO+m3SlV7CtAVkEwNTKZWQOPE4iGMZP04ZOeyWfn9GXorEOyjMpBA9HSpE4jHGBW4hRlzKNt43exj74ez1wgW7FVWGYcnAqkSjp1tts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8AxaOkn1yxmme8DAA--.2815S3;
	Sat, 27 Apr 2024 18:44:55 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnlcl1yxm4E8HAA--.16414S3;
	Sat, 27 Apr 2024 18:44:55 +0800 (CST)
Message-ID: <4ef9835e-b3dd-4b05-b09a-047f941a0870@loongson.cn>
Date: Sat, 27 Apr 2024 18:44:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: add `check-trans-update.py`
To: Cheng Ziqiu <chengziqiu@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hust-os-kernel-patches@googlegroups.com
References: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bxnlcl1yxm4E8HAA--.16414S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww48Cw17GrW8Ary3XryrGrX_yoW8Kw17pa
	909rsIya1UGF1xWw13Gr18XFs0kF95J398Wrnrta4Iqrs7tF1kWrsIyFsIy3WUCryrXa43
	uF4UAry2ka1FkFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW7UU
	UUU==


在 2024/4/22 14:58, Cheng Ziqiu 写道:
> The `check-trans-update.py` scripts check whether a translated version
> of a documentation is up-to-date with the english version.
>
> The scripts use `git log` commit to find the latest english commit from
> the translation commit (order by author date) and the latest english
> commits from HEAD. If differences occurs, report the file and commits
> need to be updated.
>
> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
> ---
>   scripts/check-trans-update.py | 176 ++++++++++++++++++++++++++++++++++

Because we'll be typing its name a lot, it's important to consider 
tabulating the

name. If it's easy to understand, choose a name that will slow down the tab

button's wear.


I gave your script a quick test and got the following output:

[siyanteng@kernelserver linux-next]$ ./scripts/check-trans-update.py 
Documentation/translations/zh_CN/process/1.Intro.rst 
[siyanteng@kernelserver linux-next]$

It seems that your script can't handle documents that never get updated. 
You need to print a warning or hint.

[siyanteng@kernelserver linux-next]$ ./scripts/check-trans-update.py 
Documentation/translations/zh_CN/rust/arch-support.rst 
Documentation/translations/zh_CN/rust/arch-support.rst (8 commits) 
2f4fe71fdd25ebb4e41aee3b467b54fbef332643

This seems to be just a merge, try to drop it?

81889e8523e63395b388f285c77ff0c98ea04556 
01848eee20c6396e5a96cfbc9061dc37481e06fd 
724a75ac9542fe1f8aaa587da4d3863d8ea292fc 
90868ff9cadecd46fa2a4f5501c66bfea8ade9b7 
e5e86572e3f20222b5d308df9ae986c06f229321 
04df97e150c83d4640540008e95d0229cb188135 
0438aadfa69a345136f5ba4f582e0f769450ee0d

Hmmm, How about printing it this way?

We need to update the following commits.

commit 81889e8523e6 ("RISC-V: enable building 64-bit kernels with rust support")
commit 01848eee20c6 ("docs: rust: fix improper rendering in Arch Supportpage")
commit 724a75ac9542 ("arm64: rust: Enable Rust support for AArch64")
commit 90868ff9cade ("LoongArch: Enable initial Rust support")
commit e5e86572e3f2 ("rust: sort uml documentation arch support table")
commit 04df97e150c8 ("Documentation: rust: Fix arch support table")
commit 0438aadfa69a ("rust: arch/um: Add support for CONFIG_RUST under x86_64 UML")


Thanks,
Yanteng


