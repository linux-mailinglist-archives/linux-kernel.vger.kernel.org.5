Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF5E812C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443505AbjLNKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443478AbjLNKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:01:25 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D7D91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:01:30 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1c7d8f89a5so1044751166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702548089; x=1703152889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B1Akq8V3bknfGJps/yFde6v1w7I15tVFGRLtdFJ361Q=;
        b=SkpUqCAgkjFwiau2TMxXcKjTCnVrTESj4C3mM4qe0C62vdqE4GDJtKzfM4TyqYncin
         HdCwGLTTYzpioo8b0bOAuCiDkLyZt5JyAUhxChf9+8pYSR4LTDQdGUNvmquDhkgn0rC0
         NDumcXsj2ABixcvxXabxT3ZQn+dm8LGplUkzZSLebRZJR3yWyWZUdmH3L1TbFmdnWelr
         TOkrCJY3DQPgI6wzgTwaK4ay2e5TVr0Mljhnz5Jk5LMqXVwr1AcJLKhdzrRtVZeqqX7M
         Ys3k33VFQwTigcw0wQE2Hsk/3vv2cWn1l4IK49Xk4lzEPtjlBmFMcWEvWre8NdGA3afs
         5d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702548089; x=1703152889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1Akq8V3bknfGJps/yFde6v1w7I15tVFGRLtdFJ361Q=;
        b=pM29dJ6K5Yjsff+Ar5dfl7E21cLHIKpc7y/tvDj4hhTtyUXKslxXlLwpEEP5cULEcI
         Dc4FKulaqtl4PhxiHwP6LgWDZFfYScjBwXG5Pth5OOSi9ZIRfq5ceBlY7SS2+oU17J+G
         VW+v2kTNDpSatVtZWqAQDPfqc+YjNsLA0zymTAhb4QIsu5xkl8y2yzDRdKLvI5kAsPAa
         U4+MWZL2B3i/sC06cF1k8+1PWZ6WbQD2VHlQTAncsUGKc5rQfGriM2KLPZILUi+4X7UX
         L9nN+NfLRe6s7n+Tx16Bv6yxuy8Pj7+mfFQoXuQSSYip7EpGHJkjsPnGk267cqF79lEt
         hJhw==
X-Gm-Message-State: AOJu0YyYlD2Y6vFLB5w4Uyx8UYd+bEPQTiI8P9Z4vtdADm1O1deaB/GK
        DR9E4S8YWj6TmDHqU3qlNqACuQ==
X-Google-Smtp-Source: AGHT+IEO/PF4PkRunvCCQIYpB8GCVvcgDib1ERF20CnB1/QvpCuOT0LoQF4Rxj9CHgFUTOChSzJRNw==
X-Received: by 2002:a17:906:5346:b0:a02:a2cc:66b8 with SMTP id j6-20020a170906534600b00a02a2cc66b8mr4653812ejo.14.1702548089098;
        Thu, 14 Dec 2023 02:01:29 -0800 (PST)
Received: from u94a (2001-b011-fa04-f750-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f750:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id vs6-20020a170907a58600b00a1fa6a70b8dsm5511673ejc.133.2023.12.14.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:01:28 -0800 (PST)
Date:   Thu, 14 Dec 2023 18:00:26 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     andrii@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/2] bpf: make the verifier tracks the "not
 equal" for regs
Message-ID: <zbqhpcp5labyt5spryxfshb54hijyysfyooxtteeq2iaydzwe6@tfa3f7ct7h6a>
References: <20231214062434.3565630-1-menglong8.dong@gmail.com>
 <20231214062434.3565630-2-menglong8.dong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214062434.3565630-2-menglong8.dong@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 02:24:33PM +0800, Menglong Dong wrote:
> We can derive some new information for BPF_JNE in regs_refine_cond_op().
> Take following code for example:
> 
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
> 
> In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
> 
> For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg.
> 
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
