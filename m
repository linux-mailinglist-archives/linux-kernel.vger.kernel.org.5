Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EF880F58F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376568AbjLLSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbjLLScy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:32:54 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93622BD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:33:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A1DF5C01A5;
        Tue, 12 Dec 2023 13:33:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 12 Dec 2023 13:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :subject:to:to; s=fm2; t=1702405980; x=1702492380; bh=tuYDtz0rZ+
        euf9UCS0pvvRidqHgRQ+VyODOTAYv7ja8=; b=OjznXwIljkD5vbMezWdOwRssOg
        x9/W71pB9uK1jpoBQnl3JKbr73M2t+4eMFrYPnFYBXvivVED7aMTJ55uf6Qw1lRY
        XVF/7fomrwZKGvLgN7RQ0RMeil8znUBwYCUhpuOtux7W3fRs0xIM9Jh9515g1zFV
        9P4lgW3uFeJ+fIEqaj08BRnJtfUsD8iZcTl6YdYEsY/KGMGGQXGDiyaSzJS+gZ/V
        KmsSmWdoIQCMsBHSFCtn3fMMCjdxrcwQ3JAiKBe6X/+Rhd4vCj0oyYPIHivLYD+/
        hWxMc6nVjQ46Subx65Q29fGa6QYiFstY6HC756WJll/WbysD+08jEyEjFgsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:subject:subject:to
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1702405980; x=1702492380; bh=tuYDtz0rZ+euf9UCS0pvvRidqHgR
        Q+VyODOTAYv7ja8=; b=3h22ptbbEq75fuK0Z6nfn+NXsIIF0aDChRlorH8dYI2H
        Dx1K9MN7JBD/PRVQRHofVyf3Q+DFDL0exrddaCiv8nrM0tdSPJaZiHOEMhpQhl6y
        J1SM3yMoxI67AduB2a1h0oLld8OAsCGuujMDoSQhsXVPR70AwdEoEkcf4dGdWjjM
        2nqH/ZfGLLGRQfBXUrdfPTXFF1NVu8BT3Q9j0JT/x0/cayb4Oun0LKAq8OOk7ozT
        aaaqQC8h7yLdwyNBPoybeque5/qvjxZPKSKwjq6J3ASJvY5YasgCa8HDr1cc2bTM
        9RZvAlYXdCbsMD8eoijTmjbfewsMuN+PNq/RxIvOBA==
X-ME-Sender: <xms:W6d4ZY9dCj4GDJvoLNNfvsiajKmYnL5S_-_KufwDk6yV_ISGRopswA>
    <xme:W6d4ZQtsQkQDaKP7oq8fcFB2XrEfTbS9Jey6JhtQZ4PdswHK3Inlwam_yK3fCDVjf
    3FtZFnvz8fydxOOyVo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcutfhovghstghhfdcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecugg
    ftrfgrthhtvghrnheplefgteffgfejtdelfeekgfetjefftdejgfdvudffiedtueevvdej
    gfevvdfgleetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:W6d4ZeA63thYYiB67rUhPiSAp7_-LPr_WeWa9_82UV3eR91BqePJ2w>
    <xmx:W6d4ZYe958rdZAiPi7mZWLBanvn9MXy86FdPesgBMyta2qSwhjuskA>
    <xmx:W6d4ZdPAqp-0_iX3tH6yfYYP0XlQ85QgnlWZrt8yBIeV2U0ftNTP7g>
    <xmx:XKd4ZSq0YctyZSuVEXJuIrJ5d-LyiibVpyTH0Tm9nrv_7eS2MuWDGA>
Feedback-ID: i84614614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD680B6008D; Tue, 12 Dec 2023 13:32:59 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
MIME-Version: 1.0
Message-Id: <b26fe1a4-1689-4640-a277-b1363453e0aa@app.fastmail.com>
In-Reply-To: <9f81f89f-c3ad-4cef-a619-ad36348c8ef5@redhat.com>
References: <20231204234906.1237478-1-shr@devkernel.io>
 <20231204234906.1237478-2-shr@devkernel.io>
 <9f81f89f-c3ad-4cef-a619-ad36348c8ef5@redhat.com>
Date:   Tue, 12 Dec 2023 10:32:39 -0800
From:   "Stefan Roesch" <shr@devkernel.io>
To:     "David Hildenbrand" <david@redhat.com>, kernel-team@fb.com
Cc:     "Andrew Morton" <akpm@linux-foundation.org>, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/4] mm/ksm: add ksm advisor
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



On Tue, Dec 12, 2023, at 5:44 AM, David Hildenbrand wrote:
> [...]
>
>> +
>> +/**
>> + * struct advisor_ctx - metadata for KSM advisor
>> + * @start_scan: start time of the current scan
>> + * @scan_time: scan time of previous scan
>> + * @change: change in percent to pages_to_scan parameter
>> + * @cpu_time: cpu time consumed by the ksmd thread in the previous scan
>> + */
>> +struct advisor_ctx {
>> +	ktime_t start_scan;
>> +	unsigned long scan_time;
>> +	unsigned long change;
>> +	unsigned long long cpu_time;
>> +};
>> +static struct advisor_ctx advisor_ctx;
>> +
>> +/* Define different advisor's */
>> +enum ksm_advisor_type {
>> +	KSM_ADVISOR_NONE,
>> +	KSM_ADVISOR_SCAN_TIME,
>> +};
>> +static enum ksm_advisor_type ksm_advisor;
>> +
>> +static void init_advisor(void)
>> +{
>> +	advisor_ctx = (const struct advisor_ctx){ 0 };
>> +}
>
> Again, you can drop this completely. The static values are already 
> initialized to 0.
>

It is needed for patch 2, I folded it into set_advisor_defaults

> Or is there any reason to initialize to 0 explicitly?
>
>> +
>> +static void set_advisor_defaults(void)
>> +{
>> +	if (ksm_advisor == KSM_ADVISOR_NONE)
>> +		ksm_thread_pages_to_scan = DEFAULT_PAGES_TO_SCAN;
>> +	else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>> +		ksm_thread_pages_to_scan = ksm_advisor_min_pages;
>> +}
>
> That function is unused?
>

I think you already saw it, it is used in patch 2, moving the function to patch 2.

>> +
>> +static inline void advisor_start_scan(void)
>> +{
>> +	if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
>> +		advisor_ctx.start_scan = ktime_get();
>> +}
>> +
>> +static inline s64 advisor_stop_scan(void)
>> +{
>> +	return ktime_ms_delta(ktime_get(), advisor_ctx.start_scan);
>> +}
>
> Just inline that into the caller. Then rename run_advisor() into 
> advisor_stop_scan(). So in scan_get_next_rmap_item)( you have paired 
> start+stop hooks.
>

The next version has this change.

>> +
>> +/*
>> + * Use previous scan time if available, otherwise use current scan time as an
>> + * approximation for the previous scan time.
>> + */
>> +static inline unsigned long prev_scan_time(struct advisor_ctx *ctx,
>> +					   unsigned long scan_time)
>> +{
>> +	return ctx->scan_time ? ctx->scan_time : scan_time;
>> +}
>> +
>> +/* Calculate exponential weighted moving average */
>> +static unsigned long ewma(unsigned long prev, unsigned long curr)
>> +{
>> +	return ((100 - EWMA_WEIGHT) * prev + EWMA_WEIGHT * curr) / 100;
>> +}
>> +
>> +/*
>> + * The scan time advisor is based on the current scan rate and the target
>> + * scan rate.
>> + *
>> + *      new_pages_to_scan = pages_to_scan * (scan_time / target_scan_time)
>> + *
>> + * To avoid pertubations it calculates a change factor of previous changes.
>
> s/pertubations/perturbations/

Fixed.

>
> Do you also want to describe how min/max CPU comes into play?
>

I added additional documentation for it in the next version of the patch.

>> + * A new change factor is calculated for each iteration and it uses an
>> + * exponentially weighted moving average. The new pages_to_scan value is
>> + * multiplied with that change factor:
>> + *
>> + *      new_pages_to_scan *= change facor
>> + *
>> + * In addition the new pages_to_scan value is capped by the max and min
>> + * limits.
>> + */
>
>
>
> With that, LGTM
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> -- 
> Cheers,
>
> David / dhildenb
