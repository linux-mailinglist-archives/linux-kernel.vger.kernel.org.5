Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BD7803BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 04:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357206AbjHRCPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 22:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357208AbjHRCPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 22:15:42 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361062102
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:15:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a800814122so327423b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 19:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692324940; x=1692929740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SaTHwiEjgsVhtsIihB7iyaYd7Jgod6PGPpwHIIV/U8=;
        b=klNiBE44VqNDhtXHWlh1kMNlbwPRgEsgWVhIaahN+PcLODg/+6KpIaKz4C4HENpf34
         YgOB0898laja6oXSqm0Axx7fzRUKn4WN9ZNhlPWZknzXLeC1yyG9x6GyqV/RI7hE9DUG
         jjoA/dvcgMlwnb49lR2jStH0qmKbxY6rH7131kLG932xsupiw2HqOf1z3R3Pw2hz7LLd
         yhe1QiZczXmyJEl01UTZoORRUOFpwUZnSZcakfXM1zW89DmVoYMT4YexpEswzvgO8/ab
         R9OBKObQOIClCh+p/qyZUatCdiHAAvNqvxAmwXRks2Yz+/IVPvQxpO9CJA0XYb5VnGrx
         VUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692324940; x=1692929740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SaTHwiEjgsVhtsIihB7iyaYd7Jgod6PGPpwHIIV/U8=;
        b=SXHvBlzLVYOwf2+7KZJyzRLrYiu/hlw3QWMAWaUShmmy8gs9x6F8YEL4ohCk1NC6JR
         Hf0LiG5DVxJgqH7a7EwPkGaTWwp8xha7wF3syWCQn0WWdKwd1/0tZtRgqFfcIXWZxRAe
         LKC59EUqoXyUzVGGDglgrKKVHzfH93e7nx6QP01IQmUd6g18DHxz6rAN46RhOkv2JlD+
         +34hfVcSfEywtCQXRnXmzy0nQt+pZHnBocEhm/+0TN/HYOUtsqsfZ9bzWGeqlQ83J+Qz
         /YSjWcBm2V0Vx01GHi+ZeJ8KyCueQ8rSHOu+GhDjf7vV0lV2+V9pIgVFGd3bY79ANf4W
         avXw==
X-Gm-Message-State: AOJu0Ywq0IuTyuO+iZQMt+YBH68qpiI1c+5x4C93VM0NgI4Ky6Sgm+R9
        JJL9O2ODPz2MtS9Et1H0xF3sMZJCtJ4=
X-Google-Smtp-Source: AGHT+IF6r5pEoBtxoShvOijBK04Aam8XvhJfd7tw/By5BxZxuXB6Z3WzByrf6TqMRWjz4V3bXZGydw==
X-Received: by 2002:aca:2414:0:b0:3a7:4f89:5b6d with SMTP id n20-20020aca2414000000b003a74f895b6dmr1145845oic.58.1692324940397;
        Thu, 17 Aug 2023 19:15:40 -0700 (PDT)
Received: from localhost ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id k17-20020aa78211000000b0066684d8115bsm419604pfi.178.2023.08.17.19.15.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Aug 2023 19:15:40 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:25:23 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH 2/8] erofs: avoid obsolete {collector,collection} terms
Message-ID: <20230818102523.00007553.zbestahu@gmail.com>
In-Reply-To: <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
References: <20230817082813.81180-1-hsiangkao@linux.alibaba.com>
        <20230817082813.81180-2-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 16:28:07 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> {collector,collection} were once reserved in order to indicate different
> runtime logical extent instance of multi-reference pclusters.
> 
> However, de-duplicated decompression has been landed in a more flexable
> way, thus `struct z_erofs_collection` was formally removed in commit
> 87ca34a7065d ("erofs: get rid of `struct z_erofs_collection'").
> 
> Let's handle the remaining leftovers, for example:
>     `z_erofs_collector_begin` => `z_erofs_pcluster_begin`
>     `z_erofs_collector_end` => `z_erofs_pcluster_end`
> 
> as well as some comments.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
