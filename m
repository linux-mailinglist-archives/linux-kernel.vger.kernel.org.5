Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA9E76D8BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjHBUl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHBUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:41:55 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17383171D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:41:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a74d759be4so133655b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691008913; x=1691613713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOTW7tSWYTyx7UDF6T+TXg8EIzNOXTAibUlBcE38vs8=;
        b=NG+5rMrhgt8ajv9MPHJRkksDamIASvOjqTTUPHyRoobNVDQSWi0PwWWph2HSzMcdMl
         A9HE9kmImry6AtWp2gUbGM/jK8r16N1j7DiuzIHODeQu+mzVZ4Nc5x80Zx5JkiFmSnHO
         uOPUvvmMKURIHUCoWtfp9Rlg7pLfP0EZa3t0rZOpEmSucSQRceq09vtlxx1NioyJNNkD
         4fSrS7ibFXvZGGzqE3oJeBJyMSPtz7hFdkn4SO1BzNbBZRtfBvnbzCIbSBnhKY/50gMF
         g9/Y7yRXXe9yhQWo6eyNbq0BU8fTMdr0BTKZOgC0cNhC2TxijnG1xbfqy5nF/bsinVyn
         22ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691008913; x=1691613713;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOTW7tSWYTyx7UDF6T+TXg8EIzNOXTAibUlBcE38vs8=;
        b=SVlngyB8ZRiUAjDWngkavif4tz90ailra/X2SenSaHHpNoSJyxm7gDNgVuIhiHBNwH
         jUO7LAlqvRqSYSOOgw3BFYv7FyvXlwaJPeoC4eTBWTV+nNQdPkihBW3KkAvL3DasGi/2
         kya1eASfS8jVEmYTrukxnvEEw7wucFco/agBa4kA0/75sMeuJF/F/issahCyjfb2VeKW
         LZqNXE6xLs40jxvSbk6KZBxHB5hqtdk6ShLbXWf6+XbG4zh+vJ+Cx0R6IUV6feYWMBH1
         gkhs03xM9YEHhSpVjLHoFkEs6za0ggMzYQ0ZVfs8FxfPQonbuPLAE3M+HnV1bZExL12Z
         TC5w==
X-Gm-Message-State: ABy/qLb5MCZj6t21KEy77vDgSNfAhTAioiTPxfaHVFwnMX8ce11WAezC
        ky7pSLGPproro9ocXTA7uBm1Uw==
X-Google-Smtp-Source: APBJJlEXOupr/w6qEt7CH3EMjhe/cVyQh8/dfxz/mVjhJayN0odRX4LdG0uM3l2H+YiBj1QobSkLpg==
X-Received: by 2002:a05:6808:21aa:b0:3a3:dc0e:4d0f with SMTP id be42-20020a05680821aa00b003a3dc0e4d0fmr20856581oib.22.1691008913338;
        Wed, 02 Aug 2023 13:41:53 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id l4-20020a63be04000000b0055386b1415dsm10930827pgf.51.2023.08.02.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:41:52 -0700 (PDT)
Date:   Wed, 02 Aug 2023 13:41:52 -0700 (PDT)
X-Google-Original-Date: Wed, 02 Aug 2023 13:41:50 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
In-Reply-To: <202308021335.8010D08B@keescook>
CC:     justinstitt@google.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        linux-hardening@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-93dd039a-f342-4239-a0a8-f1e31f7d8b5e@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2023 13:36:03 PDT (-0700), keescook@chromium.org wrote:
> On Wed, Aug 02, 2023 at 12:21:58AM +0000, Justin Stitt wrote:
>> `strncpy` is deprecated for use on NUL-terminated destination strings [1].
>>
>> Favor not copying strings onto stack and instead use strings directly.
>> This avoids hard-coding sizes and buffer lengths all together.
>>
>> Link: https://github.com/KSPP/linux/issues/90
>> Cc: linux-hardening@vger.kernel.org
>> Suggested-by: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> I like it! ;)
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks, I just queue it up for fixes (might take a bit to build test, 
I'm a bit backed up).

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

If you wanted to take it for some hardening thing, though -- otherwise 
it'll likely end up on my fixes later today.
