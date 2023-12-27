Return-Path: <linux-kernel+bounces-12276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C8081F23B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 22:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79B91F21CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 21:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B563B47F6A;
	Wed, 27 Dec 2023 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RK8j3mz6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B7F63AF;
	Wed, 27 Dec 2023 21:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=s1T79JusxVoyBT+vwk9LUpjehjg9hFZ+7ISsR89v6CE=; b=RK8j3mz6+CwLQms9nAD6ExIUoh
	d48NsJqPQQeVfhHK8JYyydqeLJulP0FkJpXFcn4e8JqPa+p8eJXQuXVG1/5SPYmi2rPhLsa84loqR
	qY1dX0tZmJWYEhJbc2foct+qv3EKNOnUMQQa4kEF3BYCvVWMqMr1SOoxpPYQqsILc48cVfLDDk3p8
	fnNu2giYBQvLRf8yjkMOERsvgTI4w2OIcP2lOKAhuY2EqYs0NFGOEXRIVIysCI5qkSMyFbemVTvLd
	IUK3a7T2eOOOJu/DNygc4S66K5sjcdn67FrmHKenQmQnS2iOo/UUdqq1QGHwaQk5EBod5FGHwZSie
	imiilOYw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIbdB-00FY8Y-15;
	Wed, 27 Dec 2023 21:40:03 +0000
Message-ID: <d752d157-659b-4d05-90a9-ebbf19c07068@infradead.org>
Date: Wed, 27 Dec 2023 13:40:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: linux/counter.h: fix Excess kernel-doc
 description warning
Content-Language: en-US
To: William Breathitt Gray <william.gray@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20231223050511.13849-1-rdunlap@infradead.org>
 <ZYw2SkkEzSW2C2gN@ubuntu-server-vm-macos>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZYw2SkkEzSW2C2gN@ubuntu-server-vm-macos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/27/23 06:35, William Breathitt Gray wrote:
> On Fri, Dec 22, 2023 at 09:05:11PM -0800, Randy Dunlap wrote:
>> Remove the @priv: line to prevent the kernel-doc warning:
>>
>> include/linux/counter.h:400: warning: Excess struct member 'priv' description in 'counter_device'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: William Breathitt Gray <william.gray@linaro.org>
>> Cc: linux-iio@vger.kernel.org
>> ---
>>  include/linux/counter.h |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff -- a/include/linux/counter.h b/include/linux/counter.h
>> --- a/include/linux/counter.h
>> +++ b/include/linux/counter.h
>> @@ -359,7 +359,6 @@ struct counter_ops {
>>   * @num_counts:		number of Counts specified in @counts
>>   * @ext:		optional array of Counter device extensions
>>   * @num_ext:		number of Counter device extensions specified in @ext
>> - * @priv:		optional private data supplied by driver
>>   * @dev:		internal device structure
>>   * @chrdev:		internal character device structure
>>   * @events_list:	list of current watching Counter events
> 
> Hi Randy,
> 
> Would you provide a Fixes tag for the commit that removed the 'priv'
> member so we can track when this warning appeared? You can respond with
> it to this thread and I'll add it in when I merge your patch.

Fixes: f2ee4759fb70 ("counter: remove old and now unused registration API")

Thank you.

-- 
#Randy

