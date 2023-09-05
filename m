Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEEE0792F1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbjIETkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjIETkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:40:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5854283
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 12:40:09 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26d50a832a9so1752818a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 12:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693942809; x=1694547609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3JoIdLXtum5k3l+D+Jgfb75PDibqNu9cKpZO/53M1U=;
        b=o5FWa8hzpV5Vr9CBZnztl/QxmMEt8CtGWWZTgaQzeDQvsDIr3DlCQBjje+f5oYBQeT
         e7+fXpFeHS3O7uGtL3FFdiAw2gA42i2TND1qmhTD27A5cg+RMAIERUCRTikAMtWDzKsm
         5X3dWaoznehugUDM1JAgBK6+Nex7P7ReZdAf0bwvLyLiTRWAb3s0QqLOKKvLXN/elJNZ
         Sv8TraLmxRWQOAH0qlzssqG4bOFVdDOG3ICMSrdOEczRGO6Ir8jSVT0CfhwCDQpu0BqO
         YG7iMPgGjsOsoq1/EP8HOEm7qqAAfWBFXdzGunNXhD2MyR/pBtnOG18lxnI/dKIqCxr7
         q1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693942809; x=1694547609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3JoIdLXtum5k3l+D+Jgfb75PDibqNu9cKpZO/53M1U=;
        b=f049AHOWK6JT8lvJjcQtRbdSONknGS3pU3Ot2oWUN8B7V7IfNORAlQAWDT84dsV8dD
         eA6ef0w/9WBdeu6Gm+a7Kf1BU63H5Cn/5bebJRHRs2SdcSB84XW23WcPI3vwuTlIJYZq
         cNEjm/J4tzyxySu9e07JoKKByWyvs60zF7SwbArkkOt0wp94GPJl3dhfaEN20ydS0U9d
         tXLBlrLKQl5ld12599eIXW8TB0L4tdnqtOnmf0qumf89+k5BN/PkoKEM9ucQ42yoiy6V
         8AMHPcU3ai10CMyrlNotufXLQ4d8hAlnMULD5SGIV6JAPk8bfIpM0LsaAxY90TA2yRvE
         w9Kw==
X-Gm-Message-State: AOJu0YygIZf5+QQZww4Utv2GOkojkpRRQmg3I1x/hNXDBTkhvSIif3f9
        Cxc5v82nZs+GiSPGXBYoPf/sOF0Wv9v1IukxEitViJyw3/ov+QFZ
X-Google-Smtp-Source: AGHT+IEPJxcZundO63bCDqfIc8khpXnGiihMK5NjNiHBG2uKgIfOrZ55TyG073a8ocRfpvxcE2WLPeKoDDT2jY1IASg=
X-Received: by 2002:a17:90a:6e0d:b0:26c:f6d2:2694 with SMTP id
 b13-20020a17090a6e0d00b0026cf6d22694mr11717461pjk.12.1693942808650; Tue, 05
 Sep 2023 12:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230903203732.585378-1-bergh.jonathan@gmail.com> <8ab11a98-5631-4ff2-93d7-dd0a7d72dd6a@kadam.mountain>
In-Reply-To: <8ab11a98-5631-4ff2-93d7-dd0a7d72dd6a@kadam.mountain>
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
Date:   Tue, 5 Sep 2023 21:39:56 +0200
Message-ID: <CA+MPq=W-HX0t2=PqzbrSX900RQ4Su2+Gf+X968KeXBKmq5xACw@mail.gmail.com>
Subject: Re: [PATCH] staging: vme_user: Fix block comments where '*' on each
 line should be aligned
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok

On Tue, Sep 5, 2023 at 1:28=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Sun, Sep 03, 2023 at 10:37:32PM +0200, Jonathan Bergh wrote:
> > Fixed checkpatch warnings where lines with '*' in block comments should
> > be aligned and were not as well as incorrect tab spacings at the start =
of
> > comment lines. Also removed spurious newlines between define statements
> > in define blocks
>
> Do this in two patches.
>
> patch 1: delete blank lines
> patch 2: change comments
>
> regards,
> dan carpenter
>
