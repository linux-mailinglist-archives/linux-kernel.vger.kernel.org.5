Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B8B7B8E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbjJDUbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 16:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbjJDUbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 16:31:10 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD4BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 13:31:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77432add7caso14707185a.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696451460; x=1697056260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=g8e0w7pJbdif+9RGf+dVEw0LrZYfR3sJaLxjMg0gnlnn4HMeMrUBO+GNp8xB7/LpzK
         nA2KqOSUgjCgKVb4mz/Tn6zla8NoD46tOa2O991QsS7XgshQAfLo6cceo4bx4jDBewJS
         VtLJotbpHrrHoh/73zHqouC9PhQw3rYWNuuhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696451460; x=1697056260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXYkNNwyK1dpfEtHp9sOFR0NjxTumXuiYxFY0CQML8E=;
        b=fqwK/acuNHf0rbC3fjQ/zR89G0fseFpIX8jkhKdP53WcYIpf9+zOzXyNhOJilSzlIW
         ojE/hhfaIoO9CSRqT5KtQosRMVgHzksbineYhg1+zvuTsf2ZQQ8JX8gX30/cFL1iq71m
         Wh4dEB/kZUGpvkVm5PJFCJPOQkT7uBddcx9b5BCCrrMKQ4MzE2jNoYVsZJytCdfbDTwP
         WEuXQUmF3h0TYHTRMJACZLA7h0VZH0b8AYYNOJw4fYrTCOsmHPzeSa5BAUqKgBS4LJ/P
         hlNFFuOixqS8+r58VmHSfovI/KPJhOPBdUC4wsHXcCvL0ej6YNDgV8f8CGkLXKqjuJOv
         oGNA==
X-Gm-Message-State: AOJu0YzMA4i66z97KZnts8/lIznKy1XMClmz5oooARns/LM79sO7whCY
        r4u44HRBumwxZujbGEZMXNfTnNAK8JjxbJ8A+lg=
X-Google-Smtp-Source: AGHT+IFwrbT5oqzEFYyQ3Z456pYFK/5cZwpOOwv5C0h6ITQNwwfh4msQ7JxOjsRwKi7pGNf/qucXVQ==
X-Received: by 2002:a05:620a:e10:b0:774:274a:b85d with SMTP id y16-20020a05620a0e1000b00774274ab85dmr3154856qkm.70.1696451460535;
        Wed, 04 Oct 2023 13:31:00 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id t7-20020a05620a034700b007758d87524esm1521047qkm.3.2023.10.04.13.30.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-419886c7474so15061cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 13:30:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1a92:b0:419:6cf4:244f with SMTP id
 s18-20020a05622a1a9200b004196cf4244fmr64519qtc.20.1696451458698; Wed, 04 Oct
 2023 13:30:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230928015858.1809934-1-linan666@huaweicloud.com> <ZR29mvoQMxcZcppw@slm.duckdns.org>
In-Reply-To: <ZR29mvoQMxcZcppw@slm.duckdns.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Wed, 4 Oct 2023 13:30:44 -0700
X-Gmail-Original-Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Message-ID: <CACGdZYLFkNs7uOuq+ftSE7oMGNbB19nm40E86xiagCFfLZ1P0w@mail.gmail.com>
Subject: Re: [PATCH] blk-throttle: Calculate allowed value only when the
 throttle is enabled
To:     Tejun Heo <tj@kernel.org>
Cc:     linan666@huaweicloud.com, josef@toxicpanda.com, axboe@kernel.dk,
        yukuai3@huawei.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 4, 2023 at 12:32=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Thu, Sep 28, 2023 at 09:58:58AM +0800, linan666@huaweicloud.com wrote:
> > From: Li Nan <linan122@huawei.com>
> >
> > When the throttle of bps is not enabled, tg_bps_limit() returns U64_MAX=
,
> > which is be used in calculate_bytes_allowed(), and divide 0 error will
> > happen.
>
> calculate_bytes_allowed() is just
>
>   return mul_u64_u64_div_u64(bps_limit, (u64)jiffy_elapsed, (u64)HZ);
>
> The only division is by HZ. How does divide by 0 happen?

We've also noticed this - haven't looked too deeply but I don't think
it's a divide by zero, but an overflow (bps_limit * jiffy_elapsed / HZ
will overflow for jiffies > HZ). mul_u64_u64_div_u64 does say it will
throw DE if the mul overflows

>
> Thanks.
>
> --
> tejun
