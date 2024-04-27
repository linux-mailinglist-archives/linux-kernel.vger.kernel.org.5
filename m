Return-Path: <linux-kernel+bounces-160989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2DC8B4580
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 12:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286791C2116D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 10:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD12481BD;
	Sat, 27 Apr 2024 10:18:28 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B5D1DA53;
	Sat, 27 Apr 2024 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213107; cv=none; b=TscUhQDLSwQ8yxNVPCSuoAjPkWk2/lxyq47J1C/Lqq+reg3Yx79gGFZxVMS2LCXsbxDMlU36QTqrDQH0Q1VooMIZG2pWhUG2OB7Ug6HAr/Rc6inqYsRbUpDrzLiUBPt4ua6HAlqFXnf8xZHHdLzaMvzDjUP9e1+NN39q/LD6GFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213107; c=relaxed/simple;
	bh=z6mwqFgyxp5ZCOGyEdKLjWCClL2JshaTbUqmbkTSIk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOcUVixjOlDHvIFAGYqrGpzk7XRa+dk/3BZqeI83IrpaSdSVodcLwSJnisHP5RkTdp1ZMnzjdv6tVoZGTD433svdO2FHGQ/vl4n+l6Sh4JsGADBeqtXrjaVjlBugBDlpUj6MeYn56tqger8tnTBiWRly+ESrEHviu+VCz2YUsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.218])
	by gateway (Coremail) with SMTP id _____8CxCurm0Cxmhe4DAA--.2836S3;
	Sat, 27 Apr 2024 18:18:14 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.112.218])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxnlfk0Cxm1kwHAA--.16390S3;
	Sat, 27 Apr 2024 18:18:13 +0800 (CST)
Message-ID: <4ca4f26c-8def-4409-9c74-f1e3e7237412@loongson.cn>
Date: Sat, 27 Apr 2024 18:18:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: add `check-trans-update.py`
To: Jonathan Corbet <corbet@lwn.net>, Cheng Ziqiu <chengziqiu@hust.edu.cn>,
 Alex Shi <alexs@kernel.org>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, hust-os-kernel-patches@googlegroups.com
References: <20240422065822.1441611-1-chengziqiu@hust.edu.cn>
 <8734rd4jq9.fsf@meer.lwn.net>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <8734rd4jq9.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bxnlfk0Cxm1kwHAA--.16390S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1kuF47JryxAFWxAFy7urX_yoW8Wr1xpa
	y5Ca4akayDJw47W3W3Gw10qF4rGFs7JFWSgF1xtr1DAwn8tr18GFWayayavrWDJF1rXry2
	vF1Yk3sIkFn7C3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yrW7UUUUU==


在 2024/4/22 21:20, Jonathan Corbet 写道:
> Cheng Ziqiu <chengziqiu@hust.edu.cn> writes:
>
>> The `check-trans-update.py` scripts check whether a translated version
>> of a documentation is up-to-date with the english version.
>>
>> The scripts use `git log` commit to find the latest english commit from
>> the translation commit (order by author date) and the latest english
>> commits from HEAD. If differences occurs, report the file and commits
>> need to be updated.
>>
>> Signed-off-by: Cheng Ziqiu <chengziqiu@hust.edu.cn>
>> ---
>>   scripts/check-trans-update.py | 176 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 176 insertions(+)
>>   create mode 100755 scripts/check-trans-update.py
>  From a *quick* look I see how this could be a useful tool.  I think a
> real requirement, though, is that a script like this start with a nice
> comment saying what it does and how to use it.  Most people will simply
> stumble across it while looking at files in scripts/; without such a
> comment, they will be hard put to know what it's for.
>
> Scripts for the documentation should be well documented :)

Yes, Ziqiu, can you describe the specific function of your script? just 
like:


1. What work does my tool replace?

2. How to use it?

3. What features did I implement?

4. What other features do I plan to add in the future?


Finally, it would be great if you could write it up as a

check_trans_update.rst and put it in the patch set,

but of course provide both English and Chinese.

Maybe we can put it here:

  Documentation/doc-guide/ ?


Thanks,

Yanteng




