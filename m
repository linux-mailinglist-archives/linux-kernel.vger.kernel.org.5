Return-Path: <linux-kernel+bounces-40386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEEE83DF57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6318D1C220A1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD03D200DD;
	Fri, 26 Jan 2024 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlPUSpF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C81F602;
	Fri, 26 Jan 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706288285; cv=none; b=Jv0ht8g6/nVLli5uFRRyCwL7mtH+vD4fKl303/ALMpGydAFJtpqeDsNRAsCz8F+x51ZMKbKoGeHjr627rj/6LCagt6lmm7wokEYewNhAR6kEfYqAapyUahdM9Zz2pC01m+Moza/uUXl3Q8jUkjbKk/ew/xCDFLrHepPvEl3zfNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706288285; c=relaxed/simple;
	bh=LKbSijtIdNMn8T6q3qa1VMH8YHHC0Jz5qhIZ/xmxj3A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=IlZPkDGtnFuTAgJMajGdMrRWcVFaNFsIbnhLtjw1e3ksVKTGg7XMJ+DWuQCfDAJHlUk7wEvNQxl8kxbRUrBJ4p/vo/kD/OO44l6B0xBZwkTYMhpQ1SZshPRR6nfMsfRcLAI+/NlRkmAT34UnLnabP0oP6P3kruCb/07qba5wc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlPUSpF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B248C433F1;
	Fri, 26 Jan 2024 16:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706288284;
	bh=LKbSijtIdNMn8T6q3qa1VMH8YHHC0Jz5qhIZ/xmxj3A=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mlPUSpF0KMNRqGwNPiq9jyj0+UKTFguItIwVOYO/wZgm9zy85NsNCfLWyCuG4XJlz
	 6JGOlrujCsunFHkq8hHXDdE2wo/yKPM2l508uz72EJSEdLqcNfZFncsrF6kjD4lcw2
	 H2RUFomJcvY40RDLIw6/CfCMpzxJge4Cfuy5I6vGPaumlPBxi63/XtEYqADPywX4+F
	 a6tv8XEI7Ts6U+GDlXUQoNT0J5p3OAscsu9wqoy2pu7hZGT7WSsnpqvdT/wY/vZG0n
	 qcqLpUazDVSeaZQAOktqQJI0tkqaVrJmhfTtL9mbBBw8NMVFFAmVnvb2Z9x9URIy1V
	 A9s471DVsIrWg==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: document HAL_RX_BUF_RBM_SW4_BM
References: <20240111-document-hal_rx_buf_rbm_sw4_bm-v1-1-ad277e8ab3cc@quicinc.com>
	<874jfg7xm4.fsf@kernel.org>
	<b4f29511-e001-4964-b88d-208dabf88121@quicinc.com>
	<875xzq526o.fsf@kernel.org>
	<fc6ca019-83e9-4571-bfce-2b4e5c233aef@quicinc.com>
Date: Fri, 26 Jan 2024 18:58:01 +0200
In-Reply-To: <fc6ca019-83e9-4571-bfce-2b4e5c233aef@quicinc.com> (Jeff
	Johnson's message of "Thu, 18 Jan 2024 07:44:10 -0800")
Message-ID: <87ttn0xc9y.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/18/2024 3:08 AM, Kalle Valo wrote:
>> * To make sure there are no kernel-doc warnings we would have to add
>>   checks to ath11k-check, which would slow down it considerably and it
>>   would again slow down our workflow (I run it several times a day).
>
> I currently run the following on every upstream patch series I review:
>
> scripts/kernel-doc -Werror -none \
> 	$(find drivers/net/wireless/ath/ath1*k -name '*.[ch]')
>
> It takes a trivial amount of time.

Hehe, indeed. It takes 0.2 seconds on my workstation, that's fast enough
for me :)

Thanks for the idea, I added this to ath12-check:

https://github.com/qca/qca-swiss-army-knife/commit/ef11ea4c7a866247f23f3d0825f9b08bd29c4989

So from now on I will always run kernel-doc for ath12k.

>> * To use kernel-doc formatting alone doesn't really make sense so we
>>   would have to start creating a kernel-doc book or something. But who
>>   would read it?
>
> Due to the sparseness, nobody would read the actual rendered
> documentation; only the documentation as it exists in the code would be
> read. However note that Linux cross-reference tool also links to the
> documentation, which I often find useful when looking at core kernel
> code, and would find it useful when looking at driver code.

It's just that in my experience it's SO hard to get people reading
documentation, even something really small. I'm not really optimistic
that using kernel-doc in drivers is any different and people ignore that
as well, like any other documentation.

>> * kernel-doc moves field documentation in structures away from the
>>   actual fields which I find confusing.
>
> kernel-doc does support in-line commenting as well:
> <https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#in-line-member-documentation-comments>
>
> Although I don't see that used much.

That's good to know. But in a way I understand why that style is not
used, at least the example in the link is hard to read.

>> * The risk of having outdated kernel-doc documentation is high, it would
>>   need active maintenance etc.
>
> Agree, but that is true of any documentation.

But the existing style is to provide documentation only when it's
necessary. With kernel-doc we have to provide documentation when it's
not even needed, no? For example, if only one enum needs documentation
and all others obvious,

>>> I'm curious what others think of the ath10/11/12k level and style of
>>> documentation.
>> 
>> IIRC iwlwifi uses kernel-doc to document the firmware interface, not
>> sure how much it's used elsewhere in the driver.
>
> They have the same problem I'm trying to fix ;)
> % scripts/kernel-doc -Werror -none \
> 	$(find drivers/net/wireless/intel/iwlwifi -name '*.[ch]')
> ...
> 322 warnings as Errors
> %

Ouch. But I'm surprised why nobody has reported these before? Are the
kernel-doc warnings ignored by everyone?

> I'm not looking to change the status quo.

I have no problems changing the status quo but having extra work without
a clear benefit is my concern here.

> Let me get the last of the ath10k cleanups in place, and I'll continue
> to run kernel-doc to make sure the existing ath1*k documentation is
> kept up to date.

Thanks. If you have time, maybe you could update ath11k-check and
ath10k-check? Every developer should use those scripts so having them
notice the warnings earlier is easier for everyone.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

