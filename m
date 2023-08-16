Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E637577EC32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346648AbjHPVsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 17:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbjHPVsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 17:48:24 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EA1FD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:48:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5232ce75e26so1682a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692222502; x=1692827302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pALAd9Pbd4YTL2fLKKBiq1e3CrfvbQPC79yqd1ReOvU=;
        b=MeD8631ZfLMMLqS78Y0ZUmwDSwjvRsHo5vwZVROQ+pWwsQ10wbwX3gF2IVqRmGs8bF
         Un8oErjMbaPgNutCGu3ybRi2nVN5mNxyC2i/U/MubzMQFwvNnrVD6WdRXLkR1TCfO4go
         /fOQzmvsrh2xG61aRbtjRj2XbHUSHSsKynD9D4yU3VJvpf0JY+8pMKwzGb618JEqeFLC
         877lJxGSSkG0w7zVL5OOIw+bsk+xCV07aTESzxs5djwzn47FgYvJxBQ5MGIfMXqklr1K
         TsZnlXzWyvbvXursHosfSwzrVO+skiT3ZTUVPZTlmRbjE62DT2HqtjkoPR0EJ9mmIXLo
         u5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692222502; x=1692827302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pALAd9Pbd4YTL2fLKKBiq1e3CrfvbQPC79yqd1ReOvU=;
        b=jFiaIDn8EvfMez9mLNZadAnut7RCEX6JDZcgBXBxdlpy4Yft58DMNn/q0ROJvjtw70
         lxMJ8w9JzmRd6yQ/aeM72jkHcPbiSVYSXxo7X2Sk/UA/YoZtEloXYl0IzlOfZXt4sg9p
         53Vo5Z/gE66XEUs7RuNV5/j6ShUO+67FBWRnthtAShlVNH1s97H0eNIgnAc86ptvGqCS
         9JxQjKuMsZA5iKxvBpCMS/0sy0lv6IRZhbl0nZzUbp3FlH294GWsef1w+jFQNapeG88z
         CV9KpK3GM7HnUlmHAggYHCph4Uu8lxuphzKPP1x3ZsKvdhMZIUKCyo1YCOjiaVUap4kU
         +xaQ==
X-Gm-Message-State: AOJu0Yy8Afh9Z26dYCeQZpa1PGx0Cxvggb5zToRpfo2ttRRsulKtuL7T
        c+ThFYwxPbXhjVhUegj1zSOkq80CLeCqg25rwAflgg==
X-Google-Smtp-Source: AGHT+IEcaOfALPggGelM3bPJnf7VZEInjtJc1J4uLKLiFnTicO7hYJjiRdcGRm/grhg7AcqNgSkOU+2vvWbTn/jOhp4=
X-Received: by 2002:a50:9b19:0:b0:522:4741:d992 with SMTP id
 o25-20020a509b19000000b005224741d992mr37164edi.4.1692222501966; Wed, 16 Aug
 2023 14:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PUZP153MB063529C4869A7A666C275B23BE15A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Wed, 16 Aug 2023 14:47:45 -0700
Message-ID: <CAAa6QmRrnRHEEQMMYe20GLXj7g+LVVHVRAKUdSLy=jUW=khb2A@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Saurabh Singh Sengar <ssengar@microsoft.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We have a out of tree driver that maps huge pages through a file handle a=
nd
> relies on -> huge_fault. It used to work in 5.19 kernels but 6.1 changed =
this
> behaviour.
>
> I don=E2=80=99t think reverting the earlier behaviour of fault_path for h=
uge pages should
> impact kernel negatively.
>
> Do you think we can restore this earlier behaviour of kernel to allow pag=
e fault
> for huge pages via ->huge_fault.

That seems reasonable to me. I think using the existence of a
->huge_fault() handler as a predicate to return "true" makes sense to
me. The "normal" flow for file-backed memory along fault path still
needs to return "false", so that we correctly fallback to ->fault()
handler. Unless there are objections, I can do that in a v2.
