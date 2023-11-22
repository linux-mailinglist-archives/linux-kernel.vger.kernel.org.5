Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A327F4E91
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjKVRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVRmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:42:02 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964EDDD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:41:58 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 81ED03200AAB;
        Wed, 22 Nov 2023 12:41:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 22 Nov 2023 12:41:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1700674917; x=1700761317; bh=yS
        FRnjVXIn+mbgngaY9ZSCV315yJK2CgStdUpd2vf9c=; b=mecjN16jsUyEDNK8LN
        YJLDmsYwT0YrpMgokzQbmPzkdtogNjHbqHYSmZlFtbHd3Rt69TskDvXyDTcEruIp
        /cds067BfaGr5e9CXiJs9EvgojAdzJmpNQgFU5wCFB35ravobaEtpF2pMgFd64Ab
        oq1lsoYhPESycURCNiwDRUmZF70Y46rbzPHsN03pBwzOJLud5NHzPhcsIoc+qxP2
        xW0fRe0InPoN3yJAMwNtivIYw2TOKdVwZn0jkCuG1zwi0G6enAPOysOX9grJTC3f
        We3i8HZIDI1YGxu5wE3XXGRNDz9MW17zcyJvHKkcTReLUuq/wYstxjYhcD1/qF8m
        Jphw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1700674917; x=1700761317; bh=ySFRnjVXIn+mb
        gngaY9ZSCV315yJK2CgStdUpd2vf9c=; b=1ahuRQDZnBXsgsS05WBrfYgD7IJWe
        fu2h/8MRZM/gsebqOGAbh4xlxttUHZOgPkepUpzN7p+gDkZqTOEBxAg1z1rgPxgf
        1KE6ZEPG3i3TJZaclmgdOr4a9CzndeMSadQAAveZTngHtKUc1187HwylFmTACd5i
        OBlQyz4kToABKZD0LYMifnvxsTkUtHEgJuqZ0WighKuRydvtCZ8k1EGNHcVwFMgM
        i2D8S+3z58xcPFMRcMkoc5FuY+ICr+dxZPSyD1DihAXJPSpPG+N/sXi+B5euRPs3
        Gjyh8e9wia+PGLq2vKJ8ueTMkeAktQh1tgeiAUPk+CCAxAMLDLqQJ6fgg==
X-ME-Sender: <xms:ZD1eZXDWhjOFbIgIiIwB47NJANw3MvcDvBY7wiDo1ZxVioxAhy9LGg>
    <xme:ZD1eZdgJSCynpBxX-AOj0R30E1kjE9kh3J5_-UDPuyltzwBh94wrbDa_BVT6khg1C
    TXHdICAkNe0cAhuekM>
X-ME-Received: <xmr:ZD1eZSmZBO44WZCAOcR9B59l8e3zEvn_BOx2InB192bc9PElJjDWAwfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudehuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:ZD1eZZx4P359OA9CXRq5mZCI7qt1vcNgRFMhX7eUOsppIsXhE0-dbQ>
    <xmx:ZD1eZcRGdntUhYCq0R47UZjHv7xztw4p3krqVA71BbFiRMRIaXYENQ>
    <xmx:ZD1eZcbVhorKk8uNyS0xZBgtmTOzKYVx37jJeZU2VJ4rUTBCyB6QZg>
    <xmx:ZT1eZRJH3Dcxxp30LhuARhq59spH_yr_LXU9Si1UtsXPLQUHjG2r_A>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Nov 2023 12:41:53 -0500 (EST)
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-3-shr@devkernel.io>
 <b90ba995-5485-4dd3-974b-02453e67686d@redhat.com>
User-agent: mu4e 1.10.3; emacs 29.1
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/4] mm/ksm: add sysfs knobs for advisor
Date:   Wed, 22 Nov 2023 09:41:16 -0800
In-reply-to: <b90ba995-5485-4dd3-974b-02453e67686d@redhat.com>
Message-ID: <87y1epr8gx.fsf@devkernel.io>
MIME-Version: 1.0
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


David Hildenbrand <david@redhat.com> writes:

> On 28.10.23 02:09, Stefan Roesch wrote:
>> This adds four new knobs for the KSM advisor to influence its behaviour.
>> The knobs are:
>> - advisor_mode:
>>      0: no advisor (default)
>>      1: scan time advisor
>> - advisor_min_cpu: 15 (default, cpu usage percent)
>> - advisor_max_cpu: 70 (default, cpu usage percent)
>> - advisor_min_pages: 500 (default)
>> - advisor_max_pages: 30000 (default)
>> - advisor_target_scan_time: 200 (default in seconds)
>> The new values will take effect on the next scan round.
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> ---
>>   mm/ksm.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 154 insertions(+)
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index e18fecfb359d..042ecaeb0beb 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -351,6 +351,14 @@ static void init_advisor(void)
>>   	advisor_ctx.cpu_time = 0;
>>   }
>
>
> [...]
>
>>    * Use previous scan time if available, otherwise use current scan time as an
>>    * approximation for the previous scan time.
>> @@ -3719,6 +3727,146 @@ static ssize_t smart_scan_store(struct kobject *kobj,
>>   }
>>   KSM_ATTR(smart_scan);
>>   +static ssize_t advisor_mode_show(struct kobject *kobj,
>> +				 struct kobj_attribute *attr, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%u\n", ksm_advisor);
>> +}
>> +
>> +static ssize_t advisor_mode_store(struct kobject *kobj,
>> +				  struct kobj_attribute *attr, const char *buf,
>> +				  size_t count)
>> +{
>> +	unsigned int mode;
>> +	int err;
>> +
>> +	err = kstrtouint(buf, 10, &mode);
>> +	if (err)
>> +		return -EINVAL;
>> +	if (mode > KSM_ADVISOR_LAST)
>> +		return -EINVAL;
>> +
>> +	/* Set advisor default values */
>> +	ksm_advisor = mode;
>> +	init_advisor();
>> +	set_advisor_defaults();
>> +
>> +	return count;
>
> Can we instead use human-readable strings?
>
> "none" and "scan-time" should be clearer.
>

I'll change the interface to use strings instead of numbers.
