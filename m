Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091957B6DF3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240110AbjJCQEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239961AbjJCQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:04:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDC0B0
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:04:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C10DC433C7;
        Tue,  3 Oct 2023 16:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1696349085;
        bh=2On/qkTqbm10MdXL23I+Oxp4rttJLwBn1Qp7pFx8jrg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WLngFVkIoiK1RwDZP5NX97Ng0SWyqxQ6JOuNyMaFjIuTJtxK76q509aEHbhix01CI
         3oUR2B/D+SknZN+HuqkGwrA5Wq65b+7CJSexdJBLwVb1U6nP/zMiz/shH7DOfCMdqh
         2m+8aavUlOegf+fkrvbEtRaGpBAnTovivQbKivzo=
Date:   Tue, 3 Oct 2023 09:04:43 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Qinglin Pan <panqinglin2020@iscas.ac.cn>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH -fixes 0/2] Fix set_huge_pte_at()
Message-Id: <20231003090443.67a2e2692b68211e05b53248@linux-foundation.org>
In-Reply-To: <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
References: <20230928151846.8229-1-alexghiti@rivosinc.com>
        <305b4dec-c99d-3cee-4563-8d7dcbae9384@ghiti.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 17:43:10 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:

> +cc Andrew: Would=A0 you mind taking this patchset in your tree for the=20
> next rc? This patchset depends on a previous fix for arm64 that you=20
> merged in rc4 which is not in the riscv -fixes branch yet.
>=20
> I saw with Palmer and he should ack this shortly.

Well I grabbed them into mm.git's mm-hotfixes-unstable queue.  All
being well I'll move them into mm-hotfixes-stable within a week then
into Linus shortly after.

Unless something changes.  It's odd that the riscv tree(s) aren't set
up to merge fixes against -rc4?
