Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FB67577AF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGRJS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGRJRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:17:43 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7701919AE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:17:17 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-637aaaf27f1so7754936d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689671830; x=1692263830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJcVs2LgJCwb5O0XxcSvYoYLi10sNbkUreq5yDMEGUg=;
        b=MH/Vm+kw49meziT2GYy7ODWOF3LLqPW7nnmlvrwEcPTjw2cDtZ5KIGhRJA1Iz9HsHl
         2CJIG0ufbKlK8Qg72NmM55dLkCrKVeuUdUy8BrccSApC/QlveC+MqUc0g/SV1coo3B2o
         iTWx8Kdi4oz/7XeAb4vDqzlU/p1HVpDs0g2BXo9joOl9cv60OyS7ZQMqaVch3nQr0T3s
         eFWtZ3l/9MaF3hYc5xjbz2uePGELGd8nomEyaAQ2eBbyjYmHbG/85fC00dZudLZgFF2W
         Yuk1Z4rpjBsqYhKd3mNqaFxqksLY6zN03af1r3xZSqQFZmyNXX5tFVSHnP0dWatDF7ju
         S83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671830; x=1692263830;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJcVs2LgJCwb5O0XxcSvYoYLi10sNbkUreq5yDMEGUg=;
        b=anifAtvDJDsOvPvmuiZYABSXpXKsVu/yhtGho+yQxtQ1cGjleDlgRI7ggGgnDqU0KR
         fSNPdG5gx74gB7JW0XmxoGqRR9saRjem33MYxEtRNB4l4oHxoR8EKNXVXi293XFCIlJa
         MUB88s9RfQkFMvsuXXStJaotdBq1HQIjUmlYuh0a5KN2ME6nIPEOUJ3ZJTC1yNmelln2
         rGvNR9rkQa0I235pEpzAY9ibxPu/dAfB9XJ1755xVcHDXSHcre5NvsXN+QLTpvdVBAqE
         50h7IksSjKm5A7EQPFncbCVFV+OR5USABhYu3he3vlp090mp3HzsgYjkbEMaLoEI3cnu
         1/og==
X-Gm-Message-State: ABy/qLbDReigmI16tehzkajK0ny90BYGeEnNDyh0f+3Phv+2QCAYG37g
        YGs4tcs+en2aX0yRHCF6KrSu8CSrpB6HETTVa4c=
X-Google-Smtp-Source: APBJJlGeVxT3OiHo/zWCPHVTC9gYgms4ynClc8I6gkukgO8R/TmSV/wUW1vQhUj+zg/z/bBbUKTVONbzrNHgnzcMZOs=
X-Received: by 2002:a05:6214:2aa8:b0:635:da19:a67f with SMTP id
 js8-20020a0562142aa800b00635da19a67fmr11015276qvb.1.1689671830421; Tue, 18
 Jul 2023 02:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNc6mSOLHv1W5qPuvn56Yy0Bsjgg8X13qzg8uUwCaYkjw@mail.gmail.com>
 <DM5PR12MB24697E6B83397ADD6F8F6556F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24697E6B83397ADD6F8F6556F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 18 Jul 2023 14:16:58 +0500
Message-ID: <CABXGCsNXfk32HmEc+45qM7850N1PQhZS=2ypTkZhp9SpBJfxRA@mail.gmail.com>
Subject: Re: [bug/bisected] commit a2848d08742c8e8494675892c02c0d22acbe3cf8
 cause general protection fault, probably for non-canonical address
 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 7:13=E2=80=AFAM Chen, Guchun <Guchun.Chen@amd.com> =
wrote:
>
> [Public]
>
> Hello Mike,
>
> I guess this patch can resolve your problem.
> https://patchwork.freedesktop.org/patch/547897/
>
> Regards,
> Guchun
>

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Thanks, the issue was gone with this patch.

I didn't say anything above about how to reproduce this problem.
Case was like this:
On a dual GPU laptop, I ran Google Chrome on a discrete graphics card.
I used for it this command:
$ DRI_PRIME=3D1 google-chrome-unstable --disable-features=3DVulkan

--=20
Best Regards,
Mike Gavrilov.
