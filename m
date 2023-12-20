Return-Path: <linux-kernel+bounces-6486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AEB819980
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C29AC28367F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EFAA16436;
	Wed, 20 Dec 2023 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PMCPRzos"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E2B1D52A;
	Wed, 20 Dec 2023 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5Cp0brfPb+fyu6Yk+mtHotB5lP7dckOvawNH9gPrHx4=; b=PMCPRzosOokGKnRpAUl2VHGDKe
	0uHl0/wFnM3dnK7qurriPilNY7TWfknpJwTn6If8YmdkdrfVyp4rGb3hmDqhXinKtUgmQgdWzw806
	vYwWnpyB+9V2EPCJxyvIo+tRrnzZVPEyIUBgU/kloUGyZQr/gZAUJuVk5DG+3FDA/WMYGITKQe7t5
	/gsyOg9qGrAA/Nnc3Xkre+Tq3AmH2Cl4EeyJhInPTsk1Yw0O+Fi5PuYVRa8+BSAwqFS1G7h6V+tTb
	0PqDIxVBsxxTqh3mTYZERqWJ1o5/sJ6D0GswHlOXYTqPfHMGs5oHumPcLu9n8TJfCjHwARmZFnJcy
	mRm9ESzw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFr0X-00GQZN-0z;
	Wed, 20 Dec 2023 07:28:45 +0000
Message-ID: <f42f91eb-9425-4a18-89e4-3d25eae66032@infradead.org>
Date: Tue, 19 Dec 2023 23:28:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nilfs2: cpfile: fix some kernel-doc warnings
Content-Language: en-US
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org
References: <20231220065931.2372-1-rdunlap@infradead.org>
 <CAKFNMonArSVESPSrCn5ovsggFQAeywg+JfHmBKx9MUGbSmfwTg@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAKFNMonArSVESPSrCn5ovsggFQAeywg+JfHmBKx9MUGbSmfwTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/19/23 23:25, Ryusuke Konishi wrote:
> On Wed, Dec 20, 2023 at 3:59 PM Randy Dunlap wrote:
>>
>> Correct the function parameter names for nilfs_cpfile_get_info():
>>
>> cpfile.c:564: warning: Function parameter or member 'cnop' not described in 'nilfs_cpfile_get_cpinfo'
>> cpfile.c:564: warning: Function parameter or member 'mode' not described in 'nilfs_cpfile_get_cpinfo'
>> cpfile.c:564: warning: Function parameter or member 'buf' not described in 'nilfs_cpfile_get_cpinfo'
>> cpfile.c:564: warning: Function parameter or member 'cisz' not described in 'nilfs_cpfile_get_cpinfo'
>> cpfile.c:564: warning: Excess function parameter 'cno' description in 'nilfs_cpfile_get_cpinfo'
>> cpfile.c:564: warning: Excess function parameter 'ci' description in 'nilfs_cpfile_get_cpinfo'
>>
>> This still leaves a few kernel-doc warnings.
>> Also, the function parameters should have descriptions after them.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>> Cc: linux-nilfs@vger.kernel.org
>> ---
>>  fs/nilfs2/cpfile.c |    6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff -- a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
>> --- a/fs/nilfs2/cpfile.c
>> +++ b/fs/nilfs2/cpfile.c
>> @@ -554,8 +554,10 @@ static ssize_t nilfs_cpfile_do_get_ssinf
>>  /**
>>   * nilfs_cpfile_get_cpinfo -
>>   * @cpfile:
>> - * @cno:
>> - * @ci:
>> + * @cnop:
>> + * @mode:
>> + * @buf:
>> + * @cisz:
>>   * @nci:
>>   */
>>
> 
> Ah, thank you for pointing it out.
> 
> I would like to fill in the missing descriptions and send it upstream.

Yes, please do.

Thanks.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

