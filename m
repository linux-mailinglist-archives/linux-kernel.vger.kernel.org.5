Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A027FB3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjK1IJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjK1IJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:09:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43DB0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701158995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ErHJSTWUH13Tzh/fJfcxrT+KDbZTOTcawxmYt6z8J8A=;
        b=Q8+2M8CkTzP2aEL80OGiAqId+/SH6gN0fUIS8fhdDPSGneKw4GxXaOiD7U4AL47oy0e8w6
        kYe33WVW1DhAt8R8eYouRe/A0KI9BsRWEOo9uCs/i4BTotLAg2nmQVq1kNC6j3Db6L8UPC
        5VbqikoXtWozy7fUDhijj200TTPHpIk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-OjmyGAgnP_6Sdv2cwUYi8A-1; Tue, 28 Nov 2023 03:09:54 -0500
X-MC-Unique: OjmyGAgnP_6Sdv2cwUYi8A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40b3e1cd487so22809885e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:09:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158993; x=1701763793;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErHJSTWUH13Tzh/fJfcxrT+KDbZTOTcawxmYt6z8J8A=;
        b=Da1IXo1uazs+YKwp5Lwz4L+S9WGeLdCjsKP/cUVzT1y1kCP1CMNJp12zHF3Yj86oPg
         f/sFvVPxb89P4cyK2yahUxTohxMRWLkxERQjNdhXdzbHuKDhGJ+NFx5vO+OuOLF47fPC
         7hI5SpuJzMpUZn+E1QA2iLiZcsMCUyaaixBCB47KooonW0jDO8a0JhGvDY+IrOYEBFET
         Ip6deMGtkzHhQ84APasT0oKpqrG98Y9/W6vU3Qe9xmY2hX3gJ6FsFEpssRG0M5kh3xZ2
         O8urzO4uyKxyqxwGEXDgX8awB3BQrmpUo5dh3IFSK4l/r9Kmf63xSruDiiTQ7I+5gvT/
         sCeg==
X-Gm-Message-State: AOJu0YwISdQ6X+DtANBa7wZvOHrvkdD8H+q0RyU3uP8gYpe3c3Vh1ncz
        SkQZ/rSjYI886jif2f9Y0TZUVCDZcusqA9dX7eOXqEN7tkwQyNdARVFEDvQdO3oAVBXIHuepikX
        4YgswS/QXxz2Fvk4zn2xRSjQK
X-Received: by 2002:a05:600c:4ed1:b0:40b:4e4e:2b22 with SMTP id g17-20020a05600c4ed100b0040b4e4e2b22mr465942wmq.38.1701158992929;
        Tue, 28 Nov 2023 00:09:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKamxmrkddqZbVzlLL5i3FN7MqA9Dph9hjqjQ12NPHZ75O5qHau4i2Sz0LlLlDMIiUQ2AYvw==
X-Received: by 2002:a05:600c:4ed1:b0:40b:4e4e:2b22 with SMTP id g17-20020a05600c4ed100b0040b4e4e2b22mr465920wmq.38.1701158992463;
        Tue, 28 Nov 2023 00:09:52 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6b10.dip0.t-ipconnect.de. [91.12.107.16])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm7076879wmq.33.2023.11.28.00.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:09:52 -0800 (PST)
Message-ID: <c05cc9a8-bcb7-4292-80e4-abb2bc74cf4c@redhat.com>
Date:   Tue, 28 Nov 2023 09:09:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/4] hugetlb: parallelize hugetlb page allocation
 on boot
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Gang Li <gang.li@linux.dev>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231123133036.68540-1-gang.li@linux.dev>
 <5c0e27f2-5826-4537-a1ab-1debfab65b9a@redhat.com>
 <28e28c2a-e72d-a181-e87a-39cecc8c3c76@google.com>
 <9d5de524-28ee-4d71-9493-f77967ea213c@redhat.com>
 <783f8bac-55b8-5b95-eb6a-11a583675000@google.com>
 <db1b593a-41d9-444a-b3f4-f6bffe98634b@bytedance.com>
 <13ad8d92-dc69-4088-b3db-16fade43bde3@bytedance.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <13ad8d92-dc69-4088-b3db-16fade43bde3@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.11.23 07:52, Gang Li wrote:
> Hi David Hildenbrand :),
> 
> On 2023/11/23 22:10, David Hildenbrand wrote:
>> Sorry to say, but why is that a scenario worth adding complexity for /
>> optimizing for? You don't cover that, so there is a clear lack in the
>> motivation.
> 
> Regarding your concern about complexity, this is indeed something to
> consider. There is a precedent of parallelization in pgdata[1] which
> might be reused (or other methods) to reduce the complexity of this
> series.

Yes, please!

-- 
Cheers,

David / dhildenb

