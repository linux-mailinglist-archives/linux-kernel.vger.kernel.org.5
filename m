Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD8F7880B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbjHYHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjHYHO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 03:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78712E6B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692947622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89RAPJXu3l0nu+Qr7Ul5eYhcLbxfZVRVayP8mEU740g=;
        b=TbOThrBO0xB2v3Z20L48x8NFudlHbkyme96jWNwtdDOj51nwBjp230JdUZ8Ed51NNJlaFw
        1iuWb+EQuG3zs3vUtKaPOj6fiJ5GmPW45ioFw8/e42RCxXSKyHYjI/85W4TkYWykmowbeK
        vX/5G54SDv2LmAU2NgksAI5cqPVU36M=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-zoCsgvrqOou_LNRgffGueg-1; Fri, 25 Aug 2023 03:13:39 -0400
X-MC-Unique: zoCsgvrqOou_LNRgffGueg-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5009796123dso677038e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 00:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692947618; x=1693552418;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89RAPJXu3l0nu+Qr7Ul5eYhcLbxfZVRVayP8mEU740g=;
        b=iYfakb9UqFwDcJKY/T1aIBB2TOn6mAS7upc3f4DLMr5CJhNi452hgJazFzcZX1arp3
         OdWrqpZXBHETMqYbcwFJLSuCrZrpYlvy3CNbIQVsGvwaFJrw3rOGrX3vZqmb7GTtQ3GL
         n2rrh4i2avnZYFXAZ9xoHuAh65pwn9WxxQDaBdRPUtXjKVRDB0K4SMdGxfAsRcBV70dD
         3h4YEjLtAL6at9CCQP/MmSmeT53+A8UPXRfxb5oveAxzZbRqQH0OIelmF8sBDpiKr03w
         4Z+kgjnjKRJy91YRM5dt6D3Na/1cjn9O0oDxaXIz07A/R5Tq4uAoi+G4hyqjv67fqpul
         tAHQ==
X-Gm-Message-State: AOJu0YzE3gBqmGVaVyZlOrmEWomiVE8P8yNgQoKSwUi59sOfP4bjTPj2
        oWZsVRAO5/BQP/WwT2kqJLp6t04ycQWPCR7h6srkxguHC0aYLsZg1vLoA9TVh8mJo8og2kU8biW
        3C1S3Ed5ExMBl2/JBTvpyXYNB
X-Received: by 2002:a05:6512:1584:b0:4fe:1c40:9266 with SMTP id bp4-20020a056512158400b004fe1c409266mr14578141lfb.17.1692947618087;
        Fri, 25 Aug 2023 00:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3Cv6J318zXRMFfrc43ddrKRkBL8efv+MD14IYUTrlxPGXzW9AmHYYZLa+xablU/kO5QDyPQ==
X-Received: by 2002:a05:6512:1584:b0:4fe:1c40:9266 with SMTP id bp4-20020a056512158400b004fe1c409266mr14578112lfb.17.1692947617632;
        Fri, 25 Aug 2023 00:13:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4? (p200300cbc70e9200ce93b5e68aa965d4.dip0.t-ipconnect.de. [2003:cb:c70e:9200:ce93:b5e6:8aa9:65d4])
        by smtp.gmail.com with ESMTPSA id y14-20020adfee0e000000b0031c56218984sm1317562wrn.104.2023.08.25.00.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 00:13:37 -0700 (PDT)
Message-ID: <75337a54-da9e-c50a-395d-1c6c93b087f8@redhat.com>
Date:   Fri, 25 Aug 2023 09:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 4/4] mm/mmu_gather: Store and process pages in contig
 ranges
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Ryan Roberts <ryan.roberts@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Yu Zhao <yuzhao@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230810103332.3062143-1-ryan.roberts@arm.com>
 <20230810103332.3062143-5-ryan.roberts@arm.com>
 <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZOgpb1Qo5B0r+mhJ@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.23 06:09, Matthew Wilcox wrote:
> On Thu, Aug 10, 2023 at 11:33:32AM +0100, Ryan Roberts wrote:
>> +void folios_put_refs(struct folio_range *folios, int nr)
>> +{
>> +	int i;
>> +	LIST_HEAD(pages_to_free);
>> +	struct lruvec *lruvec = NULL;
>> +	unsigned long flags = 0;
>> +	unsigned int lock_batch;
>> +
>> +	for (i = 0; i < nr; i++) {
>> +		struct folio *folio = page_folio(folios[i].start);
>> +		int refs = folios[i].end - folios[i].start;
>> +
>> +		/*
>> +		 * Make sure the IRQ-safe lock-holding time does not get
>> +		 * excessive with a continuous string of pages from the
>> +		 * same lruvec. The lock is held only if lruvec != NULL.
>> +		 */
>> +		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
>> +			unlock_page_lruvec_irqrestore(lruvec, flags);
>> +			lruvec = NULL;
>> +		}
>> +
>> +		if (is_huge_zero_page(&folio->page))
>> +			continue;
>> +
>> +		if (folio_is_zone_device(folio)) {
>> +			if (lruvec) {
>> +				unlock_page_lruvec_irqrestore(lruvec, flags);
>> +				lruvec = NULL;
>> +			}
>> +			if (put_devmap_managed_page(&folio->page))
>> +				continue;
>> +			if (folio_put_testzero(folio))
> 
> We're only putting one ref for the zone_device folios?  Surely
> this should be ref_sub_and_test like below?

I suspect put_devmap_managed_page() then also needs care?

-- 
Cheers,

David / dhildenb

