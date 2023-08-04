Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B02A7707A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHDSOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjHDSO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:14:28 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBE846A3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:14:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe0c566788so4058932e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691172866; x=1691777666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MqkTi9KL2+nZFUaTFkEZFlTawUXWajErpZyLi7GvckM=;
        b=Uiu4CR4SqcjIkfRlYt9IVv1nB+xm+BesOMVDXixl4B8+BUuMZYWJZHTakwRY4VXOXw
         rNMpUHHlCJ/5Z4ldhfvN9Zxni005VXw1uuyLLRO6CsST6+K83YHBTjlqE6ekuXcbh3Wy
         /55nZgEDfGqfM/7mSEuHXDH5KM+M6cE+fme10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691172866; x=1691777666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqkTi9KL2+nZFUaTFkEZFlTawUXWajErpZyLi7GvckM=;
        b=F3uOGLiIEEw1FVdUNUjR01+nUAizuU2CMpkee/wi//wwRjgAuxBfzvcsl2xuMRwUaz
         uEe5esvSOQfmedLlONm22YJgxa3+rWV2R4nRO2cwCU076uq60pZ1CUCGl/X3AdWagtJh
         1zAPsVSW/0MKCjM7nzWCObZcQPJYO6cvWQz6QTuSYGbgsdj/yo8OF3xUeEB285w6bmGY
         jmFZW9z9wMPm4P8CRF10Yd5DvIhE4ScBpX9BXGAUHB5MMfJyJcJSQiJ6SZVd+Ylyzjl4
         avYRKIwrDMNfdfqZq16Nt29Nv/gBI6Jn98m4RSxmO7jqOSkqLGEVO8dUmuiqkq27/dYP
         nRHg==
X-Gm-Message-State: AOJu0YwxJ7okmAGmz7etRSbaf9KPl2JlTnqxa4EyM8uDOnENI6LrvqGW
        CHA4bzncQ3rwGO7FQPnxnMIXccSICh8ciyIgE38JoQ==
X-Google-Smtp-Source: AGHT+IHVT+jMWoZr6wvYlhuftODEb6QSZpx6rYWQc5xrDFOOMRXlM1wyY506vDGpywVshs/K0eOxIA==
X-Received: by 2002:a05:6512:2026:b0:4fb:7592:7e03 with SMTP id s6-20020a056512202600b004fb75927e03mr1788096lfs.20.1691172865747;
        Fri, 04 Aug 2023 11:14:25 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id bo17-20020a0564020b3100b0051e0cb4692esm1557953edb.17.2023.08.04.11.14.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 11:14:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so2976422a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:14:25 -0700 (PDT)
X-Received: by 2002:aa7:c706:0:b0:522:2aba:bb32 with SMTP id
 i6-20020aa7c706000000b005222ababb32mr2134062edq.13.1691172864776; Fri, 04 Aug
 2023 11:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com> <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
In-Reply-To: <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Aug 2023 11:14:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
Message-ID: <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2023 at 03:56, David Laight <David.Laight@aculab.com> wrote:
>
> Convert constants between 0 and INT_MAX to 'int' prior to comparisons
> so that min(signed_var, 20u) and, more commonly, min(signed_var, sizeof())
> are both valid.

I really think this whole series is broken.

What does the "are both valid" even *MEAN*?

It's simply not valid to do a "min(int, 20u)". What is the meaning of
it? You seem to think that the meaning is to do the operation in
"int". Why?

You made up a definition of "valid" that I think is completely invalid.

                Linus
