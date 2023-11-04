Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37D17E0DFF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 06:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjKDFuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDFuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 01:50:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE5D45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 22:50:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6c115026985so2904620b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 22:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699077003; x=1699681803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGamaTaWKR3LhrtF+DQPbS8E7DjUl3cEVZSu36pwK8g=;
        b=nPd9TN5b7mPG0A+YNRa3pEMybX48mjKlbPMIaWMMH+QIhsbAPqkgMsWztkK5RigWkY
         xHshWjcUdx5aAabRnQ4HRBloJuOr7jkFJviuob9f7ZbSoHw+/xlv8+QPuz8FprRWp+PW
         kSuP+sjn/M8vk8iYHLbXsVltdeVk9QIB2NTFVKZchd8skOuNUa1m86I1tmiwsaXgcQrp
         vwU3/3VaxPutAATUmtKUTpxDieaP2oFk1Qdg5r5ek8Abaohoi6e3imqUFYfG682J/EqV
         9RhxrHRUzKmc/+zs95kg4tlt1aFvoovbFNtgcyfdNSdDefGfuZWLG021qHSQOegbxxMi
         GIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699077003; x=1699681803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGamaTaWKR3LhrtF+DQPbS8E7DjUl3cEVZSu36pwK8g=;
        b=H1JKQ4V17i9Tg2V677PtlDMRTA1JyqeH5gHWxLhZ6Q8M2X0fMLL0AOfdIqIHbaJLz5
         4Hi8e7L5ZXdbRhbFlSSttiL7CjQp0c0nMkXL3DzRKhYuHpVqXVQDl+wjS3f87YYKUiHm
         OdWLpwJ37kJBkclK4B21eFpyOWrvRat3WjNnz5QVwLia81ycKwBvMH2PD+L3fhI/jhWv
         2/2cZGOHQrly6INrlqgHzZsvysNMNCkGUU+cW7Y6JzFqG1T+X64+SFsFztU6/Xp+OrHo
         8Gi2kRLirKY5Dp8XAnOaQQzuCae3sj1LglbQvuS1egAQJ7uLZ3/TFAcaWO67sXD8dfE7
         0Bzg==
X-Gm-Message-State: AOJu0Ywts5IQmBcF+B5JTuvurmPa+KD6v3G9GKxovN2LvafxNxPQ3v/H
        C5ax9VTJGVwwmy/2tRp5tp44AjEhtB9JNw==
X-Google-Smtp-Source: AGHT+IGSsHQd6OPJXfEWVa0wuVqgmRAWAqLLnQcZbq4nJetfFsHgoauxpapaaxmuxugII6Ef0056Xw==
X-Received: by 2002:a05:6a00:248b:b0:6be:130a:22a0 with SMTP id c11-20020a056a00248b00b006be130a22a0mr28381293pfv.14.1699077002624;
        Fri, 03 Nov 2023 22:50:02 -0700 (PDT)
Received: from barry-desktop.hub ([2407:7000:8942:5500:4e57:64bd:534a:1d8d])
        by smtp.gmail.com with ESMTPSA id h7-20020a62b407000000b0069323619f69sm2296275pfn.143.2023.11.03.22.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 22:50:02 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     ryan.roberts@arm.com
Cc:     21cnbao@gmail.com, Steven.Price@arm.com, akpm@linux-foundation.org,
        david@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, shy828301@gmail.com, wangkefeng.wang@huawei.com,
        willy@infradead.org, xiang@kernel.org, ying.huang@intel.com,
        yuzhao@google.com
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without splitting
Date:   Sat,  4 Nov 2023 18:49:40 +1300
Message-Id: <20231104054940.8971-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6641a14b-e3fb-4e9e-bb95-b0306827294b@arm.com>
References: <6641a14b-e3fb-4e9e-bb95-b0306827294b@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  #define __HAVE_ARCH_PREPARE_TO_SWAP
>> -static inline int arch_prepare_to_swap(struct page *page)
>> -{
>> -	if (system_supports_mte())
>> -		return mte_save_tags(page);
>> -	return 0;
>> -}
>> +#define arch_prepare_to_swap arch_prepare_to_swap
>> +extern int arch_prepare_to_swap(struct page *page);
> 
> I think it would be better to modify this API to take a folio explicitly. The
> caller already has the folio.

agree. that was actually what i thought I should change while making this rfc,
though i didn't do it.

>> +int arch_prepare_to_swap(struct page *page)
>> +{
>> +	if (system_supports_mte()) {
>> +		struct folio *folio = page_folio(page);
>> +		long i, nr = folio_nr_pages(folio);
>> +		for (i = 0; i < nr; i++)
>> +			return mte_save_tags(folio_page(folio, i));
>
> This will return after saving the first page of the folio! You will need to add
> each page in a loop, and if you get an error at any point, you will need to
> remove the pages that you already added successfully, by calling
> arch_swap_invalidate_page() as far as I can see. Steven can you confirm?

right. oops...

> 
>> +	}
>> +	return 0;
>> +}
>> +
>> +void arch_swap_restore(swp_entry_t entry, struct folio *folio)
>> +{
>> +	if (system_supports_mte()) {
>> +		long i, nr = folio_nr_pages(folio);
>> +		for (i = 0; i < nr; i++)
>> +			mte_restore_tags(entry, folio_page(folio, i));
>
> swap-in currently doesn't support large folios - everything is a single page
> folio. So this isn't technically needed. But from the API POV, it seems
> reasonable to make this change - except your implementation is broken. You are
> currently setting every page in the folio to use the same tags as the first
> page. You need to increment the swap entry for each page.

one case is that we have a chance to "swapin" a folio which is still in swapcache
and hasn't been dropped yet. i mean the process's ptes have been swap entry, but
the large folio is still in swapcache. in this case, we will hit the swapcache
while swapping in, thus we are handling a large folio. in this case, it seems
we are restoring tags multiple times? i mean, if large folio has 16 basepages,
for each page fault of each base page, we are restoring a large folio, then
for 16 page faults, we are duplicating the restore.
any thought to handle this situation? should we move arch_swap_restore() to take
page rather than folio since swapin only supports basepage at this moment.

> Thanks,
> Ryan

Thanks
Barry

