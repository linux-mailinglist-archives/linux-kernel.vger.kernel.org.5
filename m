Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CEE7528EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbjGMQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbjGMQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:39:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C0130FC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:38:20 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-783544a1c90so34717439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689266300; x=1691858300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dpNLb1w3EGlSPRkJSvTacSyEtmY8uhc/HKlCY3Dm9+c=;
        b=5TgMuIhJFoTef63PBgr+KWIT9sb7OH4jCP+ruQZEaXVJDcONU6wiyt0PgpHW9o0ZYe
         7n9aeMcxM3u54QRPs2BXLO8kt/5YdutzB8CXTjiBccjh8I9+d5rFbTck/ohiTG+5zwjq
         CY4Av7WpsGpA4Qsl6HkJ0v6ddxVuOfyzTyR8M8vpo02r/OcdBz0JvGtmZPbcS+cP585S
         tIHI+KenyPEdiwoYJlEKVG706Uprg2IRHbVZdR4QZoKYTS25W8ViAQyrGoeMeay91MhG
         NQlAnrIVSrc7IzTrYF4DHU0snkyA1ynlQr5q37iGgOMc+DxPt1wVLGDeOjEZF1RQ3OlK
         zgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266300; x=1691858300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpNLb1w3EGlSPRkJSvTacSyEtmY8uhc/HKlCY3Dm9+c=;
        b=QOTo+7uWbMAluLvuJAT84ZTby39LL5TWrMBMdspck8VSkHtocMdrWVy9sqNGPO3Epg
         w7+I6XYzn2eljnGUCPApqIecBu2SoMNNcaYwQJRLonipZhR4nSLcnLVmKq/kI/4ar1h4
         nPvRXl0HnhHH5Q8rNjm25rgFV4WQXa7F7xfXR6wEO6OsvwDghIBKLrWzP09yCbAK8K6X
         GpEMUBkQdIoCUZPQmyp9dynZpiG2qWpMWGXi4HnZgo2XdAViwHk91UJIlO/XPRLe07Zb
         gOYwwg0zT+OjXwTA4qU0YSpaho1t80/zgtRizjy2MwqC7uSRn9EwKCVSdUvAR4Aw40lS
         0sXw==
X-Gm-Message-State: ABy/qLY1hHclE1k0OHQu8Sk4FMv08Yw9qdax8kufSYaAgqSiDAhI3ZNG
        1gBjbd6GOSsZOJjRuG3vhzyRBMeVHi5EXwOXxKDZjw==
X-Google-Smtp-Source: APBJJlE+tpZ78AO/3yC29uBc/6MicrdJvK2LH4z8LA1cpL0SkHA7pE6V04kLVuTmPeUuVCqUo7K5KUNi/CGBeeC/mvQ=
X-Received: by 2002:a6b:da17:0:b0:787:4b5f:b5ef with SMTP id
 x23-20020a6bda17000000b007874b5fb5efmr2581895iob.4.1689266300071; Thu, 13 Jul
 2023 09:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com> <20230713125706.2884502-4-glider@google.com>
In-Reply-To: <20230713125706.2884502-4-glider@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 13 Jul 2023 18:37:43 +0200
Message-ID: <CAG_fn=VBUiVf5aN44SQX04ZdXOOtGu3DjbW3-ZNorzNZZ6M0CA@mail.gmail.com>
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Compress the data inline. */
> +static u64 ea0_compress_inline(int len, u8 *tags, short *sizes)
> +{
> +       u64 result;
> +
> +       ea0_compress_to_buf(len, tags, sizes, (u8 *)&result, sizeof(result));
> +       result = be64_to_cpu(result);
This be64_to_cpu() is leftover from the previous compressor
implementation which treated u64 as u8[8] (i.e. big-endian).
The new implementation works with the native u64 representation, so
the conversion is not needed anymore (and actually produces invalid
handles that can't be stored in Xarray).
I will drop this call in v3.


> +bool ea0_decompress(u64 handle, u8 *tags)
> +{
> +       u8 *storage = ea0_storage(handle);
> +       int size = ea0_storage_size(handle);
> +
> +       if (size == 128) {
> +               memcpy(tags, storage, size);
> +               return true;
> +       }
> +       if (size == 8) {
> +               handle = cpu_to_be64(handle);
Ditto.
