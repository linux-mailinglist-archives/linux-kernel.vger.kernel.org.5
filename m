Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACAF75DEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 23:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjGVVtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 17:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGVVtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 17:49:11 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48B010FA
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:49:09 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403aa5d07caso24665391cf.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1690062549; x=1690667349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFT73tDs5bq+8tXOEzAl6xxcGjb8CYVIC9WQ3Nlj2+U=;
        b=C4+k+Z/sPWnkTz6g4tZlvc095VmUecXV7UlBTJrUc5Z0X+RNtogpdHI41KzMGbsZMI
         dEh5cuNnFUoPIUDM71Y6k57vsMmIdpbDIrEzq3M+ssuoaeqVt4+wXUbpECJ9IVQh2S6q
         +0Lp/l1EncHi8RLdOvM+nVegp2zV7BchkzXjlLowpc8OoAWv9JWM8V0EFSlj30g/7yBG
         UQkgqREF4LZfd1cpYK8/Sn49ebPB+GMa8o5NZOnA1iCDv7i2Pf2D4VXF4aGjGNwOaaOI
         cPed6Dwpury3UJTvbNhy92AYmngOhDmqgkci21vcc1mAX+DU9p2LMAoZ5QXD9DporPBL
         VOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690062549; x=1690667349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFT73tDs5bq+8tXOEzAl6xxcGjb8CYVIC9WQ3Nlj2+U=;
        b=h1wipwV6GP3rldBNXc/ql8bdc1m/OJqOSc27PAUq7g+8wN4Ye+0E+TxAYSm6FRqVHI
         cjtSVIHz8iZm1s6s9r+BkcGA+40YcQwOHFZVssa6e6PFGHncEW8+9NcN04onPHtsyNRG
         sYmOgMcn5cSPjyWUvOqHacVlQFyRxbfGxCUu8kO8XxwnLzeWJTHqnDNH5zjpe1FbeLIC
         6HPO2XavHV+rbtx03KxOpE/LgfNEcz4Nu/xFigqikZb59VJvgnkCCkCmyr1zDLB5UK/h
         ij0Q/XNEz66Tjg0nlQCzv1v7AX/Z3oqtwUe6kh8oOaLTJBQ2oeZlJQQFOrjAI6S2yu45
         cioQ==
X-Gm-Message-State: ABy/qLaTUSIciUdEX/TzkXesw1LWzCgLL5mlngVirsUIONaee6/V24v0
        uOE2XlTZmvr1HHNJ4ck/e5cWc0PisFyParWCWzJscW5DmrSJPR8mSic=
X-Google-Smtp-Source: APBJJlG6wYMmFmsXZyQeCcMjr+jC03p7qKzxkb/2YA02gsPiQTpkOKYsIXX8LBz/BleMqul7hyptW8zi3qdpjQ/DKbg=
X-Received: by 2002:a05:622a:11cb:b0:403:ea90:dfa9 with SMTP id
 n11-20020a05622a11cb00b00403ea90dfa9mr4863969qtk.60.1690062548963; Sat, 22
 Jul 2023 14:49:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
In-Reply-To: <20230713172636.1705415-1-shikemeng@huaweicloud.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Sat, 22 Jul 2023 17:48:31 -0400
Message-ID: <CA+CK2bBb1YPXSU_YswN6hmf5pqDcc0O6KMw7C3nNCM0ztqm76Q@mail.gmail.com>
Subject: Re: [PATCH 0/8] Remove unused parameters in page_table_check
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 5:25=E2=80=AFAM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> Hi all, this series remove unused parameters in functions from
> page_table_check. The first 2 patches remove unused mm and addr
> parameters in static common functions page_table_check_clear and
> page_table_check_set. The last 6 patches remove unused addr parameter
> in some externed functions which only need addr for cleaned
> page_table_check_clear or page_table_check_set. There is no intended
> functional change. Thanks!

NAK

Both, mm and addr are common arguments that are used for PTE handling
in many parts of memory management even when they are not used in
every function.

Currently, they are not used in page table check, but it is possible
we may need to use them in the future when support for other arches or
different types of page tables (i.e. extended page table) is added. It
is going to be hard to again modify all arch dependent code to add
these arguments back.

Also, internally at Google we are using these arguments, as we have a
module that maps user memory in a way that is incompatible with
upstream, and these arguments are used to support this module.

Thank you,
Pasha
