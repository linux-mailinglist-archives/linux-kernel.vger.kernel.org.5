Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0271803ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344943AbjLDTy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:54:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDTy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:54:26 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2E7E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:54:32 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b35199f94so12745e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701719671; x=1702324471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSDyHZbgfMpfmtjpu3gf1dpo6B/sHbuEuqoPklbpWFU=;
        b=C+Jkfrq/NVra1BpqJgXDn626lGxFATBY10SfwGx+TZXs6ycCjL0FZFx88Cfa+ogfoY
         qc/Bz42nnYTEeoZRC0DHTRFUWGt6yBU6RNzkF21GTvjp36lWheRja8Y+E4fy6qnJkABn
         cd8c2KyqMZuKDITIwgW5Fn6NWHJ9v1VMS4QcCV5oFbn5VVodcEN5D8sDb9PLDEisx+ct
         ZvBYwLH1s4dN5w5+yfFZCFL+OdwBkUGZTYpq0G4mgAYX02LN+WBan5kg4DG+zgNXMCtj
         QAYqHxuh295Wmf7lxU3luEGB8v3b3KxfGuJFEGpGkh5uvNTUsXzEUTcj8CtWseR6o8G7
         +5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719671; x=1702324471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSDyHZbgfMpfmtjpu3gf1dpo6B/sHbuEuqoPklbpWFU=;
        b=iSJZSdh9R8Sa6E0V3PJS1Sv+ZLCdFMnP8JLkFu3XIwMUopGcrjog3T6adKBN3KWHrQ
         Posm8psHcWQQe3bt9do1cly8zc0/q61JzHoRRHxFnVeDU1U7mSQO6v2CW0yIXkSrjFCv
         STUXI5/uZn2SjHWlkdtq3sRC+F5Pp5rGbG2t2xS8mtgiVLAIQDJa0W34feXbnxkG1hq1
         rbvLSDPl0lUXcfw9oWAJSIft3ua2JqtifjKhtrFNBiPVqZVdIP9+JkHVIAiZEpq2Wgr+
         RXConxF1x6c7uIeqoYcRXMuJqIzkHp91uxg7acZBUS4XLOvFiznyPPLxY7lk1nBgu1gc
         3oFw==
X-Gm-Message-State: AOJu0Yy8htUXRNT/rM63Rqq4VM6rxO41W7QUEcJ1RcvlNVL6bY/0U/iU
        OT8iqkZaedGY/cYfaht39lSzLoNwCX4EuVhCC8WK3Q==
X-Google-Smtp-Source: AGHT+IF69oQBTeRFRue7IWvEd4nsZp7rfVR2VmwUwkEN/xvmD+fwtfix+pon5QY5xjC4NSHvqc4PKF3TCnSCPW50m+k=
X-Received: by 2002:a05:600c:6014:b0:40b:33aa:a2b9 with SMTP id
 az20-20020a05600c601400b0040b33aaa2b9mr466051wmb.4.1701719670907; Mon, 04 Dec
 2023 11:54:30 -0800 (PST)
MIME-Version: 1.0
References: <20231204185943.68-1-yx.0xffff@gmail.com>
In-Reply-To: <20231204185943.68-1-yx.0xffff@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 4 Dec 2023 20:54:19 +0100
Message-ID: <CANn89i+GBs23TzwMoRUSCNX60+FRLSm9KSv_T_prJUS=+9soCA@mail.gmail.com>
Subject: Re: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
To:     YangXin <yx.0xffff@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 7:59=E2=80=AFPM YangXin <yx.0xffff@gmail.com> wrote:
>
> key_eq() and hash() are functions of struct neigh_table, so we just need =
to call tbl->key_eq() and tbl->hash(), instead of passing them in as parame=
ters.
>
> Signed-off-by: YangXin <yx.0xffff@gmail.com>

Not sure, this might defeat inlining.
