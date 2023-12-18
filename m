Return-Path: <linux-kernel+bounces-4210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E2817922
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D81B1C25C09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63C07207C;
	Mon, 18 Dec 2023 17:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=devkernel.io header.i=@devkernel.io header.b="z/pegoU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vHjPhwBO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE867144B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=devkernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=devkernel.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 95FFB5C019C;
	Mon, 18 Dec 2023 12:45:15 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 18 Dec 2023 12:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1702921515; x=1703007915; bh=B1hbwygEFo
	hRj4Yp52V3eQwsKlwYbiDDgew0pf4ZCEk=; b=z/pegoU/LFJKCcNRa/GqSFQ69G
	8SnjSpvf2++/7aYn4ZmjeIMIohKcupzlJ3IZv9jRAls6PgI4ktB7/S+yFjH4p5rb
	xVOoSpMV4/HRwgLDKBWEDQSD+iC+IRSStz4foHMRiLO6MvOvTZVDlLDt3ECz3Ogi
	UnBsWORlWYM1Cciytt0E5dAWM25B8qo6/VfqrFA18qMvzKv0ovzP9/oUCbjNjQqz
	imppBhVlX207n7ZmS8ElhLP9dPyTq/9+rMuifYV1Pc8QTKaL9B9W6jlKyFBUTuzn
	sOAcEQ0nm/nIUEGxaBx5Q+MYpw4ztnYCf7NNwH9EkDb/vHBQbiX6BGdDWycw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1702921515; x=1703007915; bh=B1hbwygEFohRj4Yp52V3eQwsKlwY
	biDDgew0pf4ZCEk=; b=vHjPhwBOtyTxHjvPKxQlgtYOm8jw+rtUheDAOecd5Wgw
	xM0xK6ghd94IwD0nfMPlMiYvRPhQ2LuTqNCaP5r535Jsi2eSAJizlN5h7OkjHhGB
	CwzE5ehyqLzrLwdqtqogRbtVdggBq7JGctKLQZIC9ymvmeTzNss4M9XwA1nJbvr2
	dnd20sMtKh2umWl5uAuqBlE9Vhp9cEdM7LivfQzdQhcqF3D6uH4PCxxw5qRqMJZU
	13MnljDsv+MOEbIvAV4BR7uKlsT+/pCP+I4dIj3y89Qa7iiNFWQqBu65OISIVWkq
	5S8IClThTTbqUC32CJi3cU9hxBINNcplwe63hy7Egg==
X-ME-Sender: <xms:K4WAZT5XT5ufe6kEkenu-cFAbmsubi3pE7z4nbnLb54qayCT7YJwFg>
    <xme:K4WAZY71R-K7NBIqENBif1vdS56LgNfGPwYqU4DVpvSthuhsfv0hTTYIuhaI3NrRP
    oh3fE2JPoOTd0vix4I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcutfhovghstghhfdcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecugg
    ftrfgrthhtvghrnheplefgteffgfejtdelfeekgfetjefftdejgfdvudffiedtueevvdej
    gfevvdfgleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:K4WAZad5iXm2FvwJajqdoQBPfOFaBYqzTRxUQy27J50ECpvby8JG9A>
    <xmx:K4WAZUJCrH-rp-keF4p6-DqRrjZvfNo8Kp6xgHg9icjocNU6pTJaQA>
    <xmx:K4WAZXJG-6w5Vpr2jGvNxEFOW_WwCEVhKi-Hm_f3I53f7IAhdb3wsw>
    <xmx:K4WAZUFosvJjoPEk9jyDZo8XCElUK6slWv25whAqevjUBdPKQ_X9Wg>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 02447B6008F; Mon, 18 Dec 2023 12:45:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <867b7cff-1061-45e8-86b1-f8006ebbdf6a@app.fastmail.com>
In-Reply-To: <bca31bff-5d5a-43e6-876f-0d8d20b4000b@redhat.com>
References: <20231213182729.587081-1-shr@devkernel.io>
 <20231213182729.587081-3-shr@devkernel.io>
 <bca31bff-5d5a-43e6-876f-0d8d20b4000b@redhat.com>
Date: Mon, 18 Dec 2023 09:44:54 -0800
From: "Stefan Roesch" <shr@devkernel.io>
To: "David Hildenbrand" <david@redhat.com>, kernel-team@fb.com
Cc: "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.org,
 riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 2/4] mm/ksm: add sysfs knobs for advisor
Content-Type: text/plain



On Mon, Dec 18, 2023, at 3:25 AM, David Hildenbrand wrote:
> On 13.12.23 19:27, Stefan Roesch wrote:
>> This adds four new knobs for the KSM advisor to influence its behaviour.
>> 
>> The knobs are:
>> - advisor_mode:
>>      none:      no advisor (default)
>>      scan-time: scan time advisor
>> - advisor_max_cpu: 70 (default, cpu usage percent)
>> - advisor_min_pages_to_scan: 500 (default)
>> - advisor_max_pages_to_scan: 30000 (default)
>> - advisor_target_scan_time: 200 (default in seconds)
>> 
>> The new values will take effect on the next scan round.
>> 
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/ksm.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 139 insertions(+), 3 deletions(-)
>> 
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 4f7b71a1f3112..f7387a6d02050 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -302,10 +302,10 @@ unsigned long ksm_zero_pages;
>>   static unsigned long ksm_pages_skipped;
>>   
>>   /* Don't scan more than max pages per batch. */
>> -static unsigned long ksm_advisor_max_pages = 30000;
>> +static unsigned long ksm_advisor_max_pages_to_scan = 30000;
>>   
>>   /* At least scan this many pages per batch. */
>> -static unsigned long ksm_advisor_min_pages = 500;
>> +static unsigned long ksm_advisor_min_pages_to_scan = 500;
>>   
>
> That renaming should go into the previous patch.
>

Moved it to the previous patch.

>>   /* Min CPU for scanning pages per scan */
>>   static unsigned int ksm_advisor_min_cpu =  10;
>> @@ -341,6 +341,16 @@ enum ksm_advisor_type {
>>   };
>>   static enum ksm_advisor_type ksm_advisor;
>>   
>> +static void set_advisor_defaults(void)
>> +{
>> +	if (ksm_advisor == KSM_ADVISOR_NONE) {
>> +		ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
>> +	} else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME) {
>> +		advisor_ctx = (const struct advisor_ctx){ 0 };
>> +		ksm_thread_pages_to_scan = ksm_advisor_min_pages_to_scan;
>> +	}
>> +}
>> +
>>   static inline void advisor_start_scan(void)
>>   {
>>   	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>> @@ -434,7 +444,7 @@ static void scan_time_advisor(void)
>>   
>>   	pages = min(pages, per_page_cost * ksm_advisor_max_cpu);
>>   	pages = max(pages, per_page_cost * ksm_advisor_min_cpu);
>> -	pages = min(pages, ksm_advisor_max_pages);
>> +	pages = min(pages, ksm_advisor_max_pages_to_scan);
>>   
>>   	/* Update advisor context */
>>   	advisor_ctx.change = change;
>> @@ -3722,6 +3732,127 @@ static ssize_t smart_scan_store(struct kobject *kobj,
>>   }
>>   KSM_ATTR(smart_scan);
>>   
>> +static ssize_t advisor_mode_show(struct kobject *kobj,
>> +				 struct kobj_attribute *attr, char *buf)
>> +{
>> +	const char *output;
>> +
>> +	if (ksm_advisor == KSM_ADVISOR_NONE)
>> +		output = "[none] scan-time";
>> +	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>> +		output = "none [scan-time]";
>> +
>> +	return sysfs_emit(buf, "%s\n", output);
>> +}
>> +
>> +static ssize_t advisor_mode_store(struct kobject *kobj,
>> +				  struct kobj_attribute *attr, const char *buf,
>> +				  size_t count)
>> +{
>> +	if (sysfs_streq("scan-time", buf))
>> +		ksm_advisor = KSM_ADVISOR_SCAN_TIME;
>> +	else if (sysfs_streq("none", buf))
>> +		ksm_advisor = KSM_ADVISOR_NONE;
>> +	else
>> +		return -EINVAL;
>> +
>> +	/* Set advisor default values */
>> +	set_advisor_defaults();
>
> It probably makes sense to not reset the defaults if the ksm_advisor 
> didn't change.
>

Added the above change.

> Apart form that, LGTM.
>
> -- 
> Cheers,
>
> David / dhildenb

