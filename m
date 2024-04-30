Return-Path: <linux-kernel+bounces-163763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C78B6F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89301F22DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A03A13C66A;
	Tue, 30 Apr 2024 10:22:45 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F1FC02;
	Tue, 30 Apr 2024 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472564; cv=none; b=a2Zjq45DQHqs7YGYq2//ThztsfWaZt2zinfN142EESbr1Aejsak5xEU/JWN5a3BJ5zbnzm5O8NCJoZ48+cvHrXZHE0Ul4X6BDGxZnBnyFbA68mqH8YCed1uxP7CPp73NdwM3gy9uO52/ukjxBFD/MDrjPPVao/DqTfut2JDxpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472564; c=relaxed/simple;
	bh=JwmfaDotknqHOgQbV2+J/8gJzqZLFs/flluY6kHJkv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qg6BxctESneGqrmF8m80trn8nkwF0q9P4lmshddfEbHysau2WLXecpR4Kiq4SEqU5DF8f+o0Vbh2jwHxWX+hei3T7KVKGHFZ8okCeaS5f20Vm9pxvKGMz8fOTeWu5VdXM1xNLMPKoN3am0m09ufYQ6YTZOqc346ZJgsrbR9H+9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8660F61E5FE36;
	Tue, 30 Apr 2024 12:21:46 +0200 (CEST)
Message-ID: <94b41f0d-a32b-4854-8528-91341a0a3bb8@molgen.mpg.de>
Date: Tue, 30 Apr 2024 12:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] modify Signed-off-by field
To: Chia Li Hung <ppighouse@gmail.com>
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Kelly Hung <Kelly_Hung@asus.com>,
 joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org, Allenyy_Hsu@asus.com,
 linux-arm-kernel@lists.infradead.org
References: <20240430045853.3894633-1-Kelly_Hung@asus.com>
 <a21672d7-82dd-44a9-b301-94aa1537b75c@molgen.mpg.de>
 <CAK=2Bxt=WK4AdktNZDN2iXjk3ga9WRqUm9JQHoNjRnrW8hVt0Q@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAK=2Bxt=WK4AdktNZDN2iXjk3ga9WRqUm9JQHoNjRnrW8hVt0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chia,


Thank you for your reply. I am sorry, this causes so much trouble.


Am 30.04.24 um 12:04 schrieb Chia Li Hung:
> Paul Menzel 於 2024年4月30日 週二 下午2:48寫道：

>> Am 30.04.24 um 06:58 schrieb Kelly Hung:
>>> For the warning message:
>>> From: Kelly Hung '<ppighouse@gmail.com>' != 'Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>'
>>>
>>> I replaced Kelly_Hung@asus.com with my private Gmail account.
>>>
>>> Due to a security issue with ASUS's mail server, I am unable to use
>>> ASUS's mail system to send patches out from my build server.
>>> So I executed git send-email using my private gmail account.
>>
>> To put light on ASUS’ upstream work, using your company address would be
>> nice in my opinion. Do you have it configured everything in git
>> (`~/.gitconfig`)?
>>
>>       git config --global user.name "Kelly Hung"
>>       git config --global user.email Kelly_Hung@asus.com

> Below is my git configuration.
> [user]
>          name = Kelly Hung
>          email = Kelly_Hung@asus.com
> [sendemail]
>          smtpserver = smtp.gmail.com
>          smtpEncryption = tls
>          smtpUser = ppighouse@gmail.com
>          smtpServerPort = 587
> 
> I made sure the "From" value after executing git format-patch was my ASUS
> email address.
> 
> From: Kelly Hung <Kelly_Hung@asus.com>
> Date: Thu, 29 Feb 2024 16:45:02 +0800
> Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
> 
> Since my smtp server is Gmail, when I run send-gmail it replaces my "From"
> value with the Gmail account. I asked ASUS IT for assistance today and
> tried to get an SMTP acount.

*A thing you should know if you are using multiple email accounts with 
`git send-email`* [1] says to use

     git send-email --from ppighouse@gmail.com 000*.patch


Kind regards,

Paul


[1]: https://sjp38.github.io/post/git_send_email_multiple_email_caution/

