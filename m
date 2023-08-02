Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745FC76D8C9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHBUrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjHBUrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:47:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2C81FF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:47:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so183664b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691009235; x=1691614035;
        h=message-id:to:from:cc:in-reply-to:subject:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xCeI4cJM5i/F1g7PTNSHGiGltpi2DPORCAOXe5MxMI4=;
        b=4dpu5FcCNCNRIyqjOzWmgL+NQSi4gYkmtcikJLhem4DJKp7bF2as4gU6+ek8eDxshQ
         pgFoE3rV9JVD/M8in3QjCrCvkcekpvSzciVT22TjMLAE3O3wrcK/TtbL4Sh9kbqDAWba
         xpjhQ/VuZLvlfZcxte6bI9tyAtiNQ+1xq8jwNCn55eMrG4AaeKjIRRYfIVr5rF0cg6y4
         aajuwqzz/F+O/8NnTRJX+/fXOsaEbW4+tJ+u1nG2YZD79SwC7VBQZT8kOyAKJvH7tMlR
         orrDNtcbh55emdbGrx5asBu7QIxNqdhGBd4RSFkJl3fQCRIi5JuEfbOIwJWYmebYvnKy
         b86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691009235; x=1691614035;
        h=message-id:to:from:cc:in-reply-to:subject:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCeI4cJM5i/F1g7PTNSHGiGltpi2DPORCAOXe5MxMI4=;
        b=MrgTkHspCuPtCPtOpGJK/r+3t6LAizv018wjJNiHP7CUT+aN2DEtgb1rVkiqUE8tb5
         d8I0O+aI4N/SD26Jsvuaqbw7Guc88CRQb4623KhfPoPNXj7WeKReLSkIvP8p5MPscoXx
         wppbI5BY+kne8xDp7tFRFKBsoxFnIQC9Yicc3G7cNZeObN2VXMQD4DyIkQPsHKGkAB/u
         cHsnc+GIWX/4H3QXZMHq+4965XhkOHw3QVmiSaPzoY906p3lRBnk2HngAO5xHZcN6ZWO
         6NDhBi+KZ0EpOZucaECTH/O6irDFkFa/ur2X8+7Ln6sG6ybd0TSGKlJK92jzefGFkuA+
         nzYQ==
X-Gm-Message-State: ABy/qLbs04vupggTeLbc4QgQQcgl4Lclguqr/I7J0phhhoazY2ZLmapF
        YuSxywpOkiVrlHKpi6fLImHHeerm/moZtkq7htQ=
X-Google-Smtp-Source: APBJJlFjxO+AHPyhX+rLY3nb8bkP8ra4T4tKVG4BPwAGhMlm1XsJK9F47UMjzYiGC9qC+vSrulmZIA==
X-Received: by 2002:a05:6a00:1687:b0:668:83b7:fd02 with SMTP id k7-20020a056a00168700b0066883b7fd02mr20214796pfc.31.1691009234798;
        Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id e7-20020aa78247000000b0066f37665a63sm5852206pfn.73.2023.08.02.13.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
Date:   Wed, 02 Aug 2023 13:47:14 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Aug 2023 13:47:11 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
In-Reply-To: <mhng-93dd039a-f342-4239-a0a8-f1e31f7d8b5e@palmer-ri-x1c9>
CC:     justinstitt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-724de287-da99-4f58-af50-5d728a28d4ab@palmer-ri-x1c9>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 13:41:52 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 02 Aug 2023 13:36:03 PDT (-0700), keescook@chromium.org wrote:
>> On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
>>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>>
>>> Favor not copying strings onto stack and instead use strings directly.
>>> This avoids hard-coding sizes and buffer lengths all together.
>>>
>>> Link: https://github.com/KSPP/linux/issues/90
>>> Cc: linux-hardening@vger.kernel.org
>>> Suggested-by: Kees Cook <keescook@chromium.org>
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>
>> I like it! ;)
>>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Thanks, I just queue it up for fixes (might take a bit to build test,
> I'm a bit backed up).
>
> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> If you wanted to take it for some hardening thing, though -- otherwise
> it'll likely end up on my fixes later today.

Sorry this is for-next as it's not a fix, I was just looking at other 
fixes.  It's queued up aimed at for-next.
