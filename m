Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D5C78276C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjHUKzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHUKzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:55:25 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFEDB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-649c6ea6e72so20395286d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 03:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=voaF9uP3moLZFKmDpjoVS5/VO/S6kYiSBNTYymR1j73z7PoSrQ1s6VP0BDhTvFbm55
         47+aPF1HBWybY5GORChwQ8XPjPvBxIHJjtb7/+tHXqLwoByMxyoRKpYiSM7V5TMGwBpc
         uaDXdSlNPlg7soenxcXG85MEaQX0KmZStM1bGmAH1+NX3+v26r+0H1NRUKqUFJqb3DkN
         PSxNi5d45d+AgRBY1HrtiDFQH4r7FmnixPJXuGuSlTi5LrqQgRl5QXFAoudUQheE0oTz
         ODeRABiRk4fXvbW8uYFfzprhwMY9FPETVIW3Ok4NmIlsN5liVC5mP6M8D4uu9dXgsvtG
         YzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692615322; x=1693220122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiI/WQOuZTfR/t2f6lJi1LF56QHzapL/gSCpBEw2/yI=;
        b=FCd74OrxjVXco6e0sFHnrhLfhRxwkusPvuiFBjBvqr/Xbd13DJHLE9OwzEPR9x4HI/
         0yNH+lcyQUagGgkrgUIQufUHlZeZ7CJfq6dL0iozbvEp0FafZdZfefE+Azd0jpH1/Ka5
         HoT6X4/37LISkRxCNhMCfCNB0OtMdFGbLdfXXhhfz8lnzN3h1eQLSxxmk55seR+5uDCr
         6vDJ5wB0PGyd5TMzhtoKkIVB+YYTZWCr0W2SalO5lagMWsqMwe9AuCPaoClecInjX24d
         8Dehi5l4haB9vchQonhUYX0AjvBNEQGySmqFcsB/RN+mlJ+6pPLcuVd+4spWjVM22gkQ
         Ptwg==
X-Gm-Message-State: AOJu0YyX8tdzIUn9VodmoE9imOWRRIO70RiBGcb71XsljbJQw9UB/7sw
        jfa4nsozVKdsebfgEEqq2dqQ0Xwe14ICMsOLBlDl8Q==
X-Google-Smtp-Source: AGHT+IGhBYQ09T4ZsvRgLhFVbDcJZ6bPFOy6hWqSHBVAWat7aAmK5pCE/wWJSXRBSvLxvq4t8vX4VWqE8CWt7pRFElg=
X-Received: by 2002:a0c:f910:0:b0:647:248b:3614 with SMTP id
 v16-20020a0cf910000000b00647248b3614mr6297972qvn.4.1692615322740; Mon, 21 Aug
 2023 03:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com>
 <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
 <CAHUa44HpkxDPgdh1B_bFOVPSOETk3F_ZicdnhmuVOux+5fd7sA@mail.gmail.com>
 <CAFA6WYMdROqkNbfbOkm22AYR1vnNa83dttf-4rF6pp1dZDym3Q@mail.gmail.com> <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
In-Reply-To: <CAFA6WYOhSAY68S=pqW5=YU=gCo7LHYELt1A7mAx-0revWH5XpA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 21 Aug 2023 12:55:11 +0200
Message-ID: <CAHUa44GjxLxzDSRsufvR35HRYpJ0S9iAXaN8cMz-V1B=HVBzHw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
[snip]
> Actually thinking about it more, let's rework
> tee_shm_register_kernel_buf() to be tee_shm_register_kernel_pages() to
> get aligned as we agreed here [1]. This would then shift the
> responsibility to check for duplicate pages to kernel clients rather
> than the TEE driver (don't need to bother about sub page buffers).
>
> [1] https://lists.trustedfirmware.org/archives/list/op-tee@lists.trustedf=
irmware.org/thread/Y224PTCQZPKLH2INVWWPRUZM4MDUPYL7/

Sounds good, I assume this will not affect tee_shm_alloc_kernel_buf().

Thanks,
Jens
