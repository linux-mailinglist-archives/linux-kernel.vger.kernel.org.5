Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC757E1751
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjKEWS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEWSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:18:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C9CF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 14:18:50 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc2f17ab26so25805935ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 14:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1699222729; x=1699827529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbIKR0SHK/6vze23TumOHoZN2zuFH7uTxuat+3SKTaw=;
        b=hKOZM6NDUWN2yUUUb3ySoXLn3FVLRxt0i54tqVI4aAOwfiensTEtsjhPeOtxeG8+9d
         VKwahDSU0MFlw4qcTKxqjJuhpEwdS7FK5CQUK+V+jAMIbu7ayr1N/DIGZUvvvFjQEBef
         eKJUdvtiKaBdIs9neBmpOoD7r784Dbno31e2q0nhuenyMRTTXS5X3tOoYkcwqov7WIkh
         QR4KxhHQVDzkZznYUiSa+y+bUXaDA5ZI4qsTFiwL4W0KRkMhQLzecyQ74aNGKTPf8JKr
         2AcNRrVz9hX8hHPrhYXLf12nMIymYt56GSfMMi8KmhV2l09Yhp+/gbqdoqa8LBPYEHfL
         WK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699222729; x=1699827529;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbIKR0SHK/6vze23TumOHoZN2zuFH7uTxuat+3SKTaw=;
        b=YUrlIL6JuMFrdMTqT7vM62ai25ekhC3cNK7zIjD5BT7zxdvAOcbBVpW38m6f8Mu6Gz
         5NmkbK4RSRhVQCUJ7ugcQeQXo7iKhBaLph9DLwRcgTKtlowka9U+dU7DEJl8WZ5qYuUj
         XyGPU/b4IsexI0kDDgtk3iqGhzZJw9Dpvg4Bc6WkAIM5jue+xZYrEShZPu5MRypSIEYp
         k4Y6d4xYl5RE9MJsxyvf6X0mOls8eTWml68Rabh8nSfZHnBehDygWzaQKGyIaVpNbs1c
         iVc5WIkSRgWYpC2P87bs9b/OPAdkGR1ELJneOUvCC/DLbw7OJHC9bX/N0yLWjIRaxb5y
         W2cg==
X-Gm-Message-State: AOJu0YwY9W3dURIcxxkbwN0/g/7WywdYJTNWIkjL6XhmoNqvIzwuSijF
        xgyKKMyklFnievbxE/GPmwwxRA==
X-Google-Smtp-Source: AGHT+IFNtEFNcFhbMv695ZTN84gvrl6e0WmhjMH71U8XWQV7/WJDEf+qpL0mtAFB6T+LMD1d0CzqcA==
X-Received: by 2002:a17:902:ec82:b0:1cc:6acc:8fa4 with SMTP id x2-20020a170902ec8200b001cc6acc8fa4mr15274773plg.32.1699222729504;
        Sun, 05 Nov 2023 14:18:49 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001cc29ffcd96sm4597015pll.192.2023.11.05.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 14:18:48 -0800 (PST)
Date:   Sun, 05 Nov 2023 14:18:48 -0800 (PST)
X-Google-Original-Date: Sun, 05 Nov 2023 14:18:19 PST (-0800)
Subject:     Re: [PATCH v2] riscv: mm: update T-Head memory type definitions
In-Reply-To: <ZR1Vh6kXay3uNvs0@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, dfustini@baylibre.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-86aba837-61bd-4ab5-a52c-85ec9b77bc82@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2023 05:07:35 PDT (-0700), jszhang@kernel.org wrote:
> On Tue, Sep 12, 2023 at 03:25:10PM +0800, Jisheng Zhang wrote:
>> Update T-Head memory type definitions according to C910 doc [1]
>> For NC and IO, SH property isn't configurable, hardcoded as SH,
>> so set SH for NOCACHE and IO.
>>
>> And also set bit[61](Bufferable) for NOCACHE according to the
>> table 6.1 in the doc [1].
>>
>> Link: https://github.com/T-head-Semi/openc910 [1]
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> Reviewed-by: Guo Ren <guoren@kernel.org>
>> Tested-by: Drew Fustini <dfustini@baylibre.com>
>
> Hi Palmer,
>
> I believe this is a fix, could you please review and take it for 6.6
> fix?

Sorry for being slow, I'm still pretty behind from getting COVID and such.
This LGTM, it's queued up for testing and it'll show up on for-next assuming
everything passes.

>
> Thanks
>
>> ---
>>
>> Since v1:
>>  - collect Reviewed-by and Tested-by tag
>>  - rebase on linux 6.6-rc1
>>
>>  arch/riscv/include/asm/pgtable-64.h | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
>> index 7a5097202e15..9a2c780a11e9 100644
>> --- a/arch/riscv/include/asm/pgtable-64.h
>> +++ b/arch/riscv/include/asm/pgtable-64.h
>> @@ -126,14 +126,18 @@ enum napot_cont_order {
>>
>>  /*
>>   * [63:59] T-Head Memory Type definitions:
>> - *
>> - * 00000 - NC   Weakly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
>> + * bit[63] SO - Strong Order
>> + * bit[62] C - Cacheable
>> + * bit[61] B - Bufferable
>> + * bit[60] SH - Shareable
>> + * bit[59] Sec - Trustable
>> + * 00110 - NC   Weakly-ordered, Non-cacheable, Bufferable, Shareable, Non-trustable
>>   * 01110 - PMA  Weakly-ordered, Cacheable, Bufferable, Shareable, Non-trustable
>> - * 10000 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Non-shareable, Non-trustable
>> + * 10010 - IO   Strongly-ordered, Non-cacheable, Non-bufferable, Shareable, Non-trustable
>>   */
>>  #define _PAGE_PMA_THEAD		((1UL << 62) | (1UL << 61) | (1UL << 60))
>> -#define _PAGE_NOCACHE_THEAD	0UL
>> -#define _PAGE_IO_THEAD		(1UL << 63)
>> +#define _PAGE_NOCACHE_THEAD	((1UL < 61) | (1UL << 60))
>> +#define _PAGE_IO_THEAD		((1UL << 63) | (1UL << 60))
>>  #define _PAGE_MTMASK_THEAD	(_PAGE_PMA_THEAD | _PAGE_IO_THEAD | (1UL << 59))
>>
>>  static inline u64 riscv_page_mtmask(void)
>> --
>> 2.40.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
