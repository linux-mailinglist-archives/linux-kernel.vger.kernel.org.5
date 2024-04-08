Return-Path: <linux-kernel+bounces-135813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594B589CBB0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1523328234B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C4144D39;
	Mon,  8 Apr 2024 18:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgl/1v36"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190025753
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600782; cv=none; b=u4nbrKU/rKQxp8P5ZWw2VviYvRf+pOJVWdH5idCow6KV+MgEHL4UKHTJxCbtBmxJ2AifTBf/icRdL8Biwwc9tM9ey6XuQVc2o7q/PGHy3qzf0zhK8CS5GBKIRZhACVUJbGHtCD5xgXHLpwNE8wKsOBsl6eUcIPiXxcrCPSJfJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600782; c=relaxed/simple;
	bh=zHVhbDUXvIHrWkiMCgJm6IIlq6tLgPd0bdBaL4AIw+g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=GgqtS0wCJ7EBsaoM8kb+C3ObWmgmsmyohD5Mq4LNhLf0r8WPVNsdtPaRC6PG4B20WnCdwegNvqn5fWh7A+q4A+Qc1sbYotGSsN9SlHgi0cWmWEnVfwJPsIjQz5Eh+itEv6VZlt++Srcj0aPc9hJgpAqX3RilWYza+jVMFnRs5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgl/1v36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2073C433C7;
	Mon,  8 Apr 2024 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712600782;
	bh=zHVhbDUXvIHrWkiMCgJm6IIlq6tLgPd0bdBaL4AIw+g=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=Jgl/1v36x9gPDRGRtgHLpwSWPWCHyO0Au+aX1+oeGjrzJlGRsUOmUY1aLymZ1LD1l
	 uriWZpqBeVIymR/WovDHQoyS0iLtOWMaZ9T6TX6ZZDnAdBr1VVPrskaCTEUMzChLFF
	 b271khNSiAkAf9N/7A2kcLCykf4hAdXZSA5fMuGNmvAYNC1SC2tds+cnVaf3wcfzym
	 5upBRFtDc+qeB/F50U21OOXfzubYNKKNiLpLm+p2vsiyYnmoAG8gO70G+sU+R5kfTB
	 jQK90zKMDPSbIeJ+HSqnJbN2hPnWoyW5CQliIRm23OG+D2MvYaf1UCg8kslhr37SsL
	 RMbdKOukmcmZg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C1C131200066;
	Mon,  8 Apr 2024 14:26:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 14:26:20 -0400
X-ME-Sender: <xms:zDYUZnSXwNry391rmaAK2q6pWJ7P0xZmJqjLiKNUODDJ3Pk00Nb_og>
    <xme:zDYUZozQ-Krgj5gAi4w0A6kwSsFcIV-8dt9B-4wIyRh2cXKg42gpmJ8Jlp6Co3E4R
    xmMNRybm_uDDjY3Vo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpefgffejleeluddugfejueeiteefvddtgfeutefhvdfgudfhveekgeeh
    gfevledvudenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrg
    hrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zDYUZs3rvvfu67uhmCGEJAPq0TQAmvT7jZzbrj7k9JydV3_k6Zvy9g>
    <xmx:zDYUZnAABHBYRqtaQ-sy4qdjwWZ5twBGfpIp6UlPW9OgKyogl3P1qA>
    <xmx:zDYUZgiUnA3CotxjZrPEu_YvIt0FIAQQQTrD-b2MARoGg2OoNZYR0g>
    <xmx:zDYUZrrT8GCJZwI1mE0yIznln8ztL49PsAFRhw2fLcHjtuTVD2lhFw>
    <xmx:zDYUZrjT2JJ-Q1GpA_EUI3Mpg9KqHNMSXAZdTcxUwl0GX5MSayuguQmB>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 81795B60089; Mon,  8 Apr 2024 14:26:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1622d9ff-feed-4a12-9d8d-3f00088c9edf@app.fastmail.com>
In-Reply-To: <76214105-94ae-4540-8511-e9e2ff6d257e@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-11-arnd@kernel.org>
 <76214105-94ae-4540-8511-e9e2ff6d257e@moroto.mountain>
Date: Mon, 08 Apr 2024 20:26:00 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Viresh Kumar" <vireshk@kernel.org>,
 "Johan Hovold" <johan@kernel.org>, "Alex Elder" <elder@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 10/11] staging: greybus: change strncpy() to strscpy()
Content-Type: text/plain

On Thu, Mar 28, 2024, at 16:00, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 03:04:54PM +0100, Arnd Bergmann wrote:
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> This is from randconfig testing with random gcc versions, a .config to
>> reproduce is at https://pastebin.com/r13yezkU
>> ---
>>  drivers/staging/greybus/fw-management.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
>> index 3054f084d777..35bfdd5f32d2 100644
>> --- a/drivers/staging/greybus/fw-management.c
>> +++ b/drivers/staging/greybus/fw-management.c
>> @@ -303,13 +303,13 @@ static int fw_mgmt_backend_fw_update_operation(struct fw_mgmt *fw_mgmt,
>>  	struct gb_fw_mgmt_backend_fw_update_request request;
>>  	int ret;
>>  
>> -	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
>> +	ret = strscpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
>
> This needs to be strscpy_pad() or it risks an information leak.

Right, I think I misread the code thinking that the strncpy()
destination was user provided, but I see now that this copy is
from user-provided data into the stack, so the padding is indeed
stale stack data.

I could not find out whether this gets copied back to userspace,
but adding the padding is safer indeed.

>>  
>>  	/*
>>  	 * The firmware-tag should be NULL terminated, otherwise throw error and
>                                       ^^^^^^^^^^^^^^^^
> These comments are out of date.
>
>>  	 * fail.
>>  	 */
>> -	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
>> +	if (ret == -E2BIG) {
>>  		dev_err(fw_mgmt->parent, "backend-update: firmware-tag is not NULL terminated\n");
>                                                           
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> More out of date prints.

I had thought about changing it when I did the patch, but could
not come up with anything that describes the error condition better:
the cause of the -E2BIG error is still the missing NUL-termination
in the provided string.

Maybe we should instead not print a warning at all? The general
rule is that user triggered operations should not lead to
spamming the kernel logs.

     Arnd

