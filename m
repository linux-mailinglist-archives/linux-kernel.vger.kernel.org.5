Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4980F584
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjLLS2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjLLS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:28:02 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C77ED3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:28:08 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F2FB55C03E7;
        Tue, 12 Dec 2023 13:28:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 13:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm2; t=1702405687; x=1702492087; bh=ByMLCrgGmG
        DFrbIZSJUQUarY0bYPrEjGYeN84abVNZM=; b=VBPVgbSF6tXt6d5NnsWb3ygDa5
        W2oOSvk32nPFLq2q5dwWDPpY64o8GckAPy6W57r2VJk/XaR2y0OKa9DLDUTjlhUp
        ZCKgvpeiECRTJTz/1G8YoAlmqiWzjVdq1ZxQWK02N+iSDiFtS7cOQzrzUIFOyvwZ
        LUF/8YxM7ZwJzyUaK/3Loqpsy+m/9Usuhcjhkd0SVzGeYZnCO3NVftlafy18Dp13
        OlEqD0B8Hh4NML7p79ePIUYG9jEhjv1xb1riz1JSWna7kPb7ry89272plSjWi85P
        +0gcT7cBExKOr8W6P4jePqL5vW6N1JQ0Gom2rQgl2TCdSr21PTNeBNFG9TAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702405687; x=1702492087; bh=ByMLCrgGmGDFrbIZSJUQUarY0bYP
        rEjGYeN84abVNZM=; b=Zzv9FsfkJoJ6ek7dEdJxF3FSDy8LyHvcTHOO14MTxOU0
        VoMRkSzPR6MG8fZRJVEQ1VhL9R4MjlB1wZbN9hCmIoZd+BMX0zFRyKWd9sJX2mtm
        BcsEeNQcQnBuYoxApnJDJB6UjcxAtSNHE+pZMNgrhe+u71X2+SqwH+sZNrvBM+u6
        4mgIfw0xcpwHguO3hw5d86XwABgHZmLI/FaxphfThovDvtjeE6j3j1vEuZkkkYzI
        JGu8zS3SpZ/+vP/ZmNtcyB3newlgm+xKlma0Mgu+jXXT8UlnNSfAI0ACxHPg4O6u
        BxgJDGdye1Sq2ZLM35sfvUS7Ks5RI5rw9dWOd0DDuA==
X-ME-Sender: <xms:N6Z4ZSpzpWiYVFMy2feYROdPG_LdPynu78FEh_Chp3rG50eEjACk5g>
    <xme:N6Z4ZQrhlxKZ5jZioOLayNd_kKX9cv1Jd3-5c9VmAhQiQZErcf3ZeN_rp5TCtv-ES
    MNULYmpLjaL2fdO_VY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcutfhovghstghhfdcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecugg
    ftrfgrthhtvghrnheplefgteffgfejtdelfeekgfetjefftdejgfdvudffiedtueevvdej
    gfevvdfgleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:N6Z4ZXMlcnfDkvBYql5_F98Wudq09tMQrot5GuqRhSk9WQV01Lsnuw>
    <xmx:N6Z4ZR6wJu4hfuqIV_6PvjIixxq5t5MJc99NZWhHvIMjIWTvkMPQkg>
    <xmx:N6Z4ZR61n8Q9QHxNWRWxZokFQci-o8SSXoxwU41oCWj9yNnSwB7tag>
    <xmx:N6Z4ZU0KccwXizA3KNszFMhaSjNY8npeX3KAniRB-CUO_99Co1c1Bw>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23E89B6008D; Tue, 12 Dec 2023 13:28:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <2ce7945d-a3c0-4bc6-8713-a36281cb793e@app.fastmail.com>
In-Reply-To: <2e22fe80-2280-4003-923d-8749fe85b81a@redhat.com>
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-3-shr@devkernel.io>
 <ebea3b6f-efc0-4d98-bf4d-3e2b867fa886@redhat.com>
 <a0c4f60b-77de-44c1-b348-2fbf12494630@app.fastmail.com>
 <2e22fe80-2280-4003-923d-8749fe85b81a@redhat.com>
Date:   Tue, 12 Dec 2023 10:27:46 -0800
From:   "Stefan Roesch" <shr@devkernel.io>
To:     "David Hildenbrand" <david@redhat.com>, kernel-team@fb.com
Cc:     "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/4] mm/ksm: add sysfs knobs for advisor
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Dec 12, 2023, at 10:07 AM, David Hildenbrand wrote:
> On 12.12.23 19:02, Stefan Roesch wrote:
>> 
>> 
>> On Tue, Dec 12, 2023, at 5:45 AM, David Hildenbrand wrote:
>>> On 05.12.23 00:49, Stefan Roesch wrote:
>>>> This adds four new knobs for the KSM advisor to influence its behaviour.
>>>>
>>>> The knobs are:
>>>> - advisor_mode:
>>>>       none:      no advisor (default)
>>>>       scan-time: scan time advisor
>>>> - advisor_max_cpu: 70 (default, cpu usage percent)
>>>> - advisor_min_pages: 500 (default)
>>>> - advisor_max_pages: 30000 (default)
>>>> - advisor_target_scan_time: 200 (default in seconds)
>>>>
>>>> The new values will take effect on the next scan round.
>>>>
>>>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>>>> ---
>>>>    mm/ksm.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 127 insertions(+)
>>>>
>>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>>> index b27010fa2e946..18b7185bbc65b 100644
>>>> --- a/mm/ksm.c
>>>> +++ b/mm/ksm.c
>>>> @@ -3735,6 +3735,128 @@ static ssize_t smart_scan_store(struct kobject *kobj,
>>>>    }
>>>>    KSM_ATTR(smart_scan);
>>>>    
>>>> +static ssize_t advisor_mode_show(struct kobject *kobj,
>>>> +				 struct kobj_attribute *attr, char *buf)
>>>> +{
>>>> +	const char *output;
>>>> +
>>>> +	if (ksm_advisor == KSM_ADVISOR_NONE)
>>>> +		output = "[none] scan-time";
>>>> +	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>>>> +		output = "none [scan-time]";
>>>> +
>>>> +	return sysfs_emit(buf, "%s\n", output);
>>>> +}
>>>> +
>>>> +static ssize_t advisor_mode_store(struct kobject *kobj,
>>>> +				  struct kobj_attribute *attr, const char *buf,
>>>> +				  size_t count)
>>>> +{
>>>> +	if (sysfs_streq("scan-time", buf))
>>>> +		ksm_advisor = KSM_ADVISOR_SCAN_TIME;
>>>> +	else if (sysfs_streq("none", buf))
>>>> +		ksm_advisor = KSM_ADVISOR_NONE;
>>>> +	else
>>>> +		return -EINVAL;
>>>> +
>>>> +	/* Set advisor default values */
>>>> +	init_advisor();
>>>
>>> Is the "init_advisor()" really required?
>>>
>> 
>> The init_advisor is required for the following scenario:
>> - advisor is used
>> - advisor is turned off
>> - pages_to_scan is used and run for some time
>> - advisor is turned on again
>>     ==> Advisor would start with two high values for the first calculation
>
> Can't set_advisor_defaults() handle that?
>

Yes, I can move the

advisor_ctx = (const struct advisor_ctx){ 0 };

into set_advisor_defaults().

> -- 
> Cheers,
>
> David / dhildenb
