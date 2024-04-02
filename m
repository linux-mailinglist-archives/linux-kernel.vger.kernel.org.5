Return-Path: <linux-kernel+bounces-127854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182428951B4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443461C22350
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09776311D;
	Tue,  2 Apr 2024 11:22:06 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B65A4C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712056926; cv=none; b=LpoOY2Dr3eiWqQJW6wW94SLWh5oVaE0aLDDd2icAD70keyKrFwAjArfiBcNXOVjXdkVYveIE26eXeFZiXD09tKeKrHTUPwCevj5aQutzCgDjOHSYFkp5Z7lIYxNbXbotpffuB3sbgrLBCUf9dMd5vuceeh+O4cdH6gUOo4sxbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712056926; c=relaxed/simple;
	bh=K2KF0PpTcBGK9pz41kFknD/l+QfW5T0zNmdQF5t5FsE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qq0XOhhsDKYW615n8E5mFwp7l3rSXBrIKMqrYr63aXhgj/H9KOcKXF1AXC9Cqg9+lNX+N8/G1m8k/jfPrztSL1kQjmAc09obqiH+/OzA6XnLgtD38GzVoTvtmfaTsgcYGuJp7KnjTzdmsEt2Kzf2ndjQ1WYbHh+XKl20lWorIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8BxOPBX6gtmFU4iAA--.13833S3;
	Tue, 02 Apr 2024 19:21:59 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPBNT6gtmmctxAA--.23693S3;
	Tue, 02 Apr 2024 19:21:57 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Remove useless MODULE macro for
 MODULE_DEVICE_TABLE
To: Wentao Guan <guanwentao@uniontech.com>, zhaotianrui@loongson.cn
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yuli Wang <wangyuli@uniontech.com>
References: <20240402103942.20049-1-guanwentao@uniontech.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <31d39556-79d9-52eb-36aa-5897aea6e28e@loongson.cn>
Date: Tue, 2 Apr 2024 19:21:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240402103942.20049-1-guanwentao@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxPBNT6gtmmctxAA--.23693S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr1ruF1xKF1xtw1rGry7XFc_yoWDArb_Zr
	17Jwn7urW8Xw12v3Wvg3W5G347W3WkGFs0ka42yrn7uF1SqrWayrs7Gwn8Aw1jqrWFyFs3
	Aa95Z3ZIkw17tosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
	CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2DUU
	UUUUU



On 2024/4/2 下午6:39, Wentao Guan wrote:
> MODULE_DEVICE_TABLE use ifdef MODULE macro in module.h,
> just clean it up.
> 
> Suggested-by: Yuli Wang <wangyuli@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> ---
>   arch/loongarch/kvm/main.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/kvm/main.c b/arch/loongarch/kvm/main.c
> index 86a2f2d0cb27..7f2bd9a0814c 100644
> --- a/arch/loongarch/kvm/main.c
> +++ b/arch/loongarch/kvm/main.c
> @@ -410,10 +410,8 @@ static void kvm_loongarch_exit(void)
>   module_init(kvm_loongarch_init);
>   module_exit(kvm_loongarch_exit);
>   
> -#ifdef MODULE
>   static const struct cpu_feature kvm_feature[] = {
>   	{ .feature = cpu_feature(LOONGARCH_LVZ) },
>   	{},
>   };
Wentao,

Thanks for your patch, there is static variable kvm_feature
which is embraced by macro MODULE also :-), besides MODULE_DEVICE_TABLE.

Regards
Bibo Mao
>   MODULE_DEVICE_TABLE(cpu, kvm_feature);
> -#endif
> 


