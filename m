Return-Path: <linux-kernel+bounces-127996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC8895439
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABE01C21D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1C181203;
	Tue,  2 Apr 2024 13:07:03 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A2681721
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063222; cv=none; b=nZ+kWBlmPKfu9/YxKHOv5e3moM7hhwEeji9eenVJThKK0stA9ia9YBvls5VEc/PEYKkqiJyAyGYEsBcdoWDBb45QJ2pqsz8w2xrPBxmtZdklFWz6PbhDMKXbxBJC5kF+8KEabKg+2JqwzcoSoALgduWSY3Pu9hSimRcGl253qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063222; c=relaxed/simple;
	bh=2pwW/L80mNXkfO0ONij8M4+gNmy+QVEEYfMISxXbzYc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RtDUB3KJGoK9N+yBn+Elx26d7Uj0i+nVvElJs+DJa+0B3qoDq6ohPhgIhwtCWb4aS6UaDPyme6cXegWqlhJmz/1//ZC5lhkhSgY6ficmDpbZ7y54scJVOTwztXJnll/b+xgyDW31dljgXy31LriWYOwSqNP9BNypaLsrr/7QE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.173])
	by gateway (Coremail) with SMTP id _____8AxafDxAgxmH1UiAA--.14009S3;
	Tue, 02 Apr 2024 21:06:57 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxCBLuAgxmG9hxAA--.13009S3;
	Tue, 02 Apr 2024 21:06:56 +0800 (CST)
Subject: Re: [PATCH] LoongArch: KVM: Remove useless MODULE macro for
 MODULE_DEVICE_TABLE
To: Wentao Guan <guanwentao@uniontech.com>,
 zhaotianrui <zhaotianrui@loongson.cn>
Cc: loongarch <loongarch@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?546L5pix5Yqb?=
 <wangyuli@uniontech.com>
References: <20240402103942.20049-1-guanwentao@uniontech.com>
 <31d39556-79d9-52eb-36aa-5897aea6e28e@loongson.cn>
 <tencent_0ED20EAF678A7C93309EA4F6@qq.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <2ca6c120-858c-7c52-73c4-71609cd8c10c@loongson.cn>
Date: Tue, 2 Apr 2024 21:06:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <tencent_0ED20EAF678A7C93309EA4F6@qq.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxCBLuAgxmG9hxAA--.13009S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2
	jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
	AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAV
	WUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U8I38UUUUUU==



On 2024/4/2 下午8:47, Wentao Guan wrote:
> Hello,Bibo,
> 
> I change this that we see other guys use "MODULE_DEVICE_TABLE(cpu,..."
> without use that MODULE macro,and mark cpu_feature struct "__maybe_unused",
> do the same way to avoid unused variable compiler warning  :).

yeap, it looks good to me with __maybe_unused added.

Regards
Bibo Mao
> 
> BRs
> Wentao Guan
> 


