Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E852D7E25D3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjKFNkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 08:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKFNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:40:15 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D543134;
        Mon,  6 Nov 2023 05:40:12 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5bbfc735572so1141067b3.0;
        Mon, 06 Nov 2023 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699278011; x=1699882811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jewR5NoRMz4cQc4UcviSvb0/aGqCk/tL3bfyVAdf58g=;
        b=HJeaFhyjzlSP8wpL4jziB/moodtAhy7rs/bLzaXrIPhyz9BgPllR13wLlp8cDBov/9
         8YAiZLnOItEslf/LmIzqt9gJSjq9mF8NDeSen44OZ9Ygjomo1gDZ0nwlaj6iP2WimUjh
         huhS/yBDnY3lZ1/h/kThJ2QwKa9stbYAwyJ5W7dm8Rgt8Fu9Nwqy/74rU3k7qRbZ1E1x
         jTAz6PvgWREOC2iSsmAdbxuxk2KvB88UhEdPhja+hQsaCZ5WgJTfaJTktrvaWy5cPHIm
         haCIcwD+Yl2XXVUXEGFw4WtPuNfVKQ4ljKjZVs6HQKDuNmhwVDm4IKmuL1yD8S+evZKZ
         Jfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278011; x=1699882811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jewR5NoRMz4cQc4UcviSvb0/aGqCk/tL3bfyVAdf58g=;
        b=t5219eC2mnEur+053zdOwsG1cNxVkOGxb3AIk1k8hIzaqfWkHUf7w+i3Lk0Sj+lRHb
         RavJswrr0kqi71GqvwwG7ECjDWjBD5RLWvlPFr/jc1ZTRB014UzvHJoPttGR6UKKUHEk
         EnS1KF+h4w5tu4Osj/GBdxW2YecDQfjlHdFgp5F15JnD1/t9nZFK7ToRzhBxybVvJYCM
         h71gKMkkacfmTS0GhfPTHOQ2ygYTMqFVHQ4RzgA3ixduJFrIMvIfzKAgCJ44S9UUvuYC
         10h3+yveRF4JRTBpQx1ghr+xsyPj5pn2VYI1c+zQchsHzV6KQ3QnHAUcwAVJEmHOF8Av
         fevA==
X-Gm-Message-State: AOJu0YyTYbsicdDbey1Jwg69TJP2wGZ/y8FyLua/4fEszSIDgPOldr7u
        0H8I1OwUTtyx7UAZImIOfjUPMbw7tOmJEQGIR3g=
X-Google-Smtp-Source: AGHT+IEF0AcUDMb8VcTXj4YSTL5VwrOIm5LmtYwWV9jJVvlhBE7F+vAtQvRICYYPVCS6INyjnN1pv1Dpvxex83kuyew=
X-Received: by 2002:a25:5051:0:b0:d9c:410b:c364 with SMTP id
 e78-20020a255051000000b00d9c410bc364mr16862879ybb.6.1699278011034; Mon, 06
 Nov 2023 05:40:11 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsMQXiNZHXoqa5_ypO8xSiGCAPhpUrXMyjx5poZ=kiGSow@mail.gmail.com>
 <d2792e3513899a4e4cfd9a8a6c24dbf19b5fe1d3.camel@mediatek.com>
In-Reply-To: <d2792e3513899a4e4cfd9a8a6c24dbf19b5fe1d3.camel@mediatek.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 6 Nov 2023 18:40:00 +0500
Message-ID: <CABXGCsP16Mx0=tXv0dFQA9aS_vCy5rk7DpJcoeYJzfhFYqrGJA@mail.gmail.com>
Subject: Re: 6.7/kasan/regression/bisected: mt7921_regd_notifier+0x3e2
To:     =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= 
        <Mingyen.Hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 4, 2023 at 3:37=E2=80=AFAM Deren Wu (=E6=AD=A6=E5=BE=B7=E4=BB=
=81) <Deren.Wu@mediatek.com> wrote:
>
>
> Based on this stacktrace, I think we have the patch here.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/net/wireless/mediatek/mt76?id=3D169b7acb847e8dc656cd2289a91ff668f7=
2405a0
>
> Please help to verify your issue with this patch.

Thanks, I can confirm that this fixes KASAN: null-ptr-deref in range
[0x0000000000000178-0x000000000000017f] at mt7921_regd_notifier+0x3e2

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
