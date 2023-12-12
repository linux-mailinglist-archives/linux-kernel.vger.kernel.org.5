Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CEA80F524
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377068AbjLLSCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377072AbjLLSCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:02:21 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1FDD3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:02:27 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3DBEB5C0274;
        Tue, 12 Dec 2023 13:02:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 13:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm2; t=1702404144; x=1702490544; bh=KEjNKWXCWF
        o0aaGshHfuAhiPFyNmIHyFQZWgfT5pa+Y=; b=f+FUOvrrc9NOMQU1WECMkwiC8p
        +xCvP3zljcMza/GUnPpVMhQ2+bKL/PMYBxIj74NiXtLXyX2ZlisWjgVmF/tzZzoF
        byxoQ4B7LRtjPFZ8gKy90OXJa7BlIl3d3utJ+S7KvVBYYyOngFst4ZF26Pb5FYXB
        uWWAgjQeJjC5HZuCjwAJda9f4zd5Q27EuQlXULnW2nktrvsqtp9CYJ/eqkAB9b+8
        nFdl3x01Ex1mUrt/1Tw5zbg46VKpl4OSuBA8FTQInaoOXX4LZW07cACR9uuqBq4U
        GQUH+CON2BxFUn4QQsNuXDgZ01waM/KlkzSPXmEyLQNLs/Fzs1gCslxS6uIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702404144; x=1702490544; bh=KEjNKWXCWFo0aaGshHfuAhiPFyNm
        IHyFQZWgfT5pa+Y=; b=iu5dDUpUhQT9PNPLgOcTfCFNzjKECP4fwZU+cZTd5VO1
        c/XcKROxgn6U3UU1RIZUNatpN8eUECqMuO4Ebd8SubAABIMMvy/ommLaUVC7eFvW
        o46O+KiZzFuQwiVzBDnzIFMxjQjz596n8PcRsjPjJjm6UkUJb7sISKXmXAY23RO9
        GmE9Fn0lrMYirll1fTOyaZTipJPBvvzwXcTBxHNsol5kwpvhHKbb5ga8WJtRi20u
        x/zM5HgD0HSEBic1eQooLZ34MkZVrTHrdKoBRyPzL+gybB8WL7jWRCqxhnXNviv5
        Wn/NAOBnQ+/BVcBiLG72JmZAJVuUKHLLk9PPd24pIA==
X-ME-Sender: <xms:LqB4ZbBNZeTSCcpn3ToVaergV92e5Lahad8x6mAX5CGRWJCwNTD53Q>
    <xme:LqB4ZRhQJMmjuaQPtyQXRka_aLQFp8kTjY4L9F5MZaGAFo_4IHxgaBLl4_3sexAs9
    sglv4RxWLN4dgi0vPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcutfhovghstghhfdcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecugg
    ftrfgrthhtvghrnheplefgteffgfejtdelfeekgfetjefftdejgfdvudffiedtueevvdej
    gfevvdfgleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:LqB4ZWkC7OG0i39DJMB-VVO8IWSB1aB7YDZa5u62Vn6LEByYu4Ajlg>
    <xmx:LqB4ZdzIVscjuW-4VVYdOq934MBxaZVdHK--lZhesKEoA6TZKceUjg>
    <xmx:LqB4ZQTyfAdzf06DPDuPvYLs1SfdTPNAm976AOIvHLVEMmQFrJ1IuQ>
    <xmx:MKB4ZWM1HFcTQyDy8-wQbBAu_uC0a5FxQpXaQU3ve5oo_01pDNgyGw>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 80F88B6008D; Tue, 12 Dec 2023 13:02:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <a0c4f60b-77de-44c1-b348-2fbf12494630@app.fastmail.com>
In-Reply-To: <ebea3b6f-efc0-4d98-bf4d-3e2b867fa886@redhat.com>
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-3-shr@devkernel.io>
 <ebea3b6f-efc0-4d98-bf4d-3e2b867fa886@redhat.com>
Date:   Tue, 12 Dec 2023 10:02:02 -0800
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



On Tue, Dec 12, 2023, at 5:45 AM, David Hildenbrand wrote:
> On 05.12.23 00:49, Stefan Roesch wrote:
>> This adds four new knobs for the KSM advisor to influence its behaviour.
>> 
>> The knobs are:
>> - advisor_mode:
>>      none:      no advisor (default)
>>      scan-time: scan time advisor
>> - advisor_max_cpu: 70 (default, cpu usage percent)
>> - advisor_min_pages: 500 (default)
>> - advisor_max_pages: 30000 (default)
>> - advisor_target_scan_time: 200 (default in seconds)
>> 
>> The new values will take effect on the next scan round.
>> 
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/ksm.c | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 127 insertions(+)
>> 
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index b27010fa2e946..18b7185bbc65b 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -3735,6 +3735,128 @@ static ssize_t smart_scan_store(struct kobject *kobj,
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
>> +	init_advisor();
>
> Is the "init_advisor()" really required?
>

The init_advisor is required for the following scenario:
- advisor is used
- advisor is turned off
- pages_to_scan is used and run for some time
- advisor is turned on again
   ==> Advisor would start with two high values for the first calculation

>> +	set_advisor_defaults();
>
> That function should go to this patch.
>
>
>

I'll move it to this patch. I'll also look if I can should move init_advisor() to this
patch.

> -- 
> Cheers,
>
> David / dhildenb
