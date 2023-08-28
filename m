Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21ECD78B37B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjH1OqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjH1OqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:46:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DA3DA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:10 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf078d5f33so25900105ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693233970; x=1693838770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4npd0hAMW5QgBLCOO7EqsULgww1yKj8yQ+a9KH8z4Q=;
        b=Maq+Rz29zVVisN4gq6DWEXY/HVHkOmD0zc5CbhmzF5uZXre7D11f1iGpEJd4sRdRPX
         GNWcCPs7qSvx/eGKMTgz+YdY+6wjXwG5k6m7+7ZOkIcVCJxP9ApMUsmBPy/tjd067Gx0
         JMKqAIofwvRRA/NEynSjfpY03XjnRT9hvHq0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693233970; x=1693838770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4npd0hAMW5QgBLCOO7EqsULgww1yKj8yQ+a9KH8z4Q=;
        b=J0CLUJpMAemNwBPHqHAI6KiGGOa6fIP6Z8WVhiV/sQekmPaZXdnXvU2dvKCCddwH/6
         /Z2DDCHiZ78XX9jojK/OhJx+VLGLJ7HgVCdEE7ej1KGAeKD8198EsPGGUoS6JN6ciu+R
         F0tXsqTl9RpH7jIMpXN6/eHp4oqRpwRuHoPWQbYdxd4b3H+NErWHZNctuExPv6UKrjpC
         hgd4rqDJT2axCGACMdBbCrpEtCHQc5HO/HzGCUCZdNVZuSzRDKyLcz3h081y5A0TwFzL
         RByyxFyNMBTWQA9aGduK+Pjtd43KmvDgjyIv/zsaEVmibA43m+YvzcvilHrOT3UXfJDd
         QbfA==
X-Gm-Message-State: AOJu0YwqruRbdNTRxWomrBi/KuKsdqm7I/tE+Fc88E4uVkFaWtuA7c5j
        TOeU9qgbn5E2ZspWDklmehkIrnE2NQSCNBv2zppqpw==
X-Google-Smtp-Source: AGHT+IEn0gYq5N3ObhOIUfNDRyBWLBonbxbmmLkx+/edttm2cPTObkBE+8Jw3sVr8cgcpKVYis1lMHAn/9fribjpmI0=
X-Received: by 2002:a17:90b:3753:b0:267:eefe:d0b5 with SMTP id
 ne19-20020a17090b375300b00267eefed0b5mr24427413pjb.46.1693233970214; Mon, 28
 Aug 2023 07:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230704153630.1591122-1-revest@chromium.org> <20230704153630.1591122-2-revest@chromium.org>
 <ZOtLBNQyysgNZzrA@arm.com>
In-Reply-To: <ZOtLBNQyysgNZzrA@arm.com>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 28 Aug 2023 16:45:58 +0200
Message-ID: <CABRcYmJhe+h+2CKqJPN5U0Gachwrp_-kmqWbr+NTeYyin+1s2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] kselftest: vm: Fix tabs/spaces inconsistency in
 the mdwe test
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        joey.gouly@arm.com, mhocko@suse.com, keescook@chromium.org,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 3:09=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Jul 04, 2023 at 05:36:25PM +0200, Florent Revest wrote:
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Florent Revest <revest@chromium.org>
>
> I forgot about this series until Kees started reviewing it. So:

No problem! I was hoping everyone was having a good summer break and
was waiting for September to re-send a v4 anyway... :)

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks everyone for the reviews and testing! Much appreciated.
