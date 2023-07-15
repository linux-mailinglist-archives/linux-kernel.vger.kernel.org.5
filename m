Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7275474B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGOHw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:52:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C51358E;
        Sat, 15 Jul 2023 00:52:55 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b6f943383eso40424631fa.2;
        Sat, 15 Jul 2023 00:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689407573; x=1691999573;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XICKv7iip3MX1RFnTjF/KQz1iwO2NUYvEEXm4nzQgNQ=;
        b=n7GBFw0VA8g9+MovuidzqH1rtNUx4NWKs08ia7oDqD+egQk2zED4a5ArwLhc0H7xkr
         1s6YxbUWC+aF1E+FBFRJEEdNe59Dah6E2YefZL8FxWM8cAIiB5OEjIkMcONnul4LUshj
         NKELF2LPD/t6pzxOcRth+uxClGGR4/Q7Qiaz94uKJN12VTQ04boaYRRQs1VKZpfNKaQd
         eB4aQrdj7vSHx+l5nDmtcCJpJBKpSn4RkSn/C0RkA3jGrzh5pf9l1uuKE3iy3eOZSACV
         Qjc1hoF6KIunIvIaRzk+3eC/dWP7PvcOF7kA7pzFFs+dh+KR8z2ffmHesY7brEsClwRv
         o9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689407573; x=1691999573;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XICKv7iip3MX1RFnTjF/KQz1iwO2NUYvEEXm4nzQgNQ=;
        b=hTpwyE8qNOpxVv9X/zi4NplW2UVEaQRIxFlCQ7QpqM+ecx3/Xlg1aCb8vAB2UszYhq
         h4jjoZMGfI7Aj6DcKdqZHv9gbnjXEH8PBJXaxGT6vFL/9RFeJZR2k+/E1Tdiii2fZRVB
         sZIZuctCqobTfqLt5e4HYOiH2m0UaBlWGGoQHa5s31Ck87Slnqd2AcDryGcwaV0lZfOe
         Kzfk+KKx+N2dN+SlSBXooG7PfnocySkLlL1QwJJuGuGwHTRAF0Qdv3l1lyeZmasRCNXF
         xKg97vLMG+tGoGWal3ki01V5kJ5NL6iFR+sSuS5/HtKP5ZbZcxviyd2WKzVjf0/dteLf
         g3Ow==
X-Gm-Message-State: ABy/qLYXzaJ1pWQlnz7xRhLgnXx1hzUfhmd3ftjRAJdc6he3JsqMqEbi
        0ApNuRo3MwpuoTCg4L3wt2Qhlufyi7rkPHdT8rMWvhQb8zfFVQ==
X-Google-Smtp-Source: APBJJlHuM5uaVxOoW6CXKvDuoa2N/p6vZb0IHe56Mkz0y4mpOlYt0tjacW01U5xP6PE4CX9/ET8ktR9Ec43kLf2A7cs=
X-Received: by 2002:a19:f618:0:b0:4fb:74da:989a with SMTP id
 x24-20020a19f618000000b004fb74da989amr5403336lfe.3.1689407572670; Sat, 15 Jul
 2023 00:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230708054052.45967-1-src.res.211@gmail.com> <87351q1fcw.fsf@meer.lwn.net>
 <d2da2720-ebcb-ee77-f732-a23184c560a6@gmail.com>
In-Reply-To: <d2da2720-ebcb-ee77-f732-a23184c560a6@gmail.com>
From:   src res <src.res.211@gmail.com>
Date:   Sat, 15 Jul 2023 15:52:40 +0800
Message-ID: <CADztU2OQ+5GWZrFw-2oXOGU99WGrs1tCT11vWXU0koN6T21Rog@mail.gmail.com>
Subject: Fwd: [PATCH] docs/zh_TW: rewrite index.rst
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/15 03:07, Jonathan Corbet wrote:
> Hu Haowen <src.res.211@gmail.com> writes:
>
>> Update zh_TW's index.rst to the version of commit 0c7b4366f1ab ("docs:
>> Rewrite the front page") with some reference from commit f4bf1cd4ac9c
>> ("docs: move asm-annotations.rst into core-api") and commit eef24f7054a6
>> ("docs/zh_CN: Rewrite the Chinese translation front page").
>>
>> Signed-off-by: Hu Haowen <src.res.211@gmail.com>
>> ---
>>   Documentation/translations/zh_TW/index.rst | 156 ++++++++-------------
>>   1 file changed, 56 insertions(+), 100 deletions(-)
>
> So your two patches conflict with each other.  I've sorted it out and
> applied this, but it would be nicer if I didn't have to do that...

Sorry for bothering you. The conflict might be caused by my attempting
to split the patches belonged to one ensemble originally into two
independent parts. Only after sending the first one patch did I recall
remaining some work which was supposed to be patched and sent together
with the former. But that was late.

The next time I will check if my work is done wholly before sending and
send the patches altogether so as to ensure that they won't cause any
conflicts. Apologies to you again.

Thanks,
Hu

>
> Thanks,
>
> jon
