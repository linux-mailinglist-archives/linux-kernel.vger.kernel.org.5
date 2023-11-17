Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D272F7EF261
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbjKQMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345914AbjKQMKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:10:14 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D4F1A5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:10:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cbcb392e5so4175591cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700223010; x=1700827810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVa/xkTnX+o0TolBxebC81ZLWvNl5aLTfGLyraWx7PY=;
        b=F4DO/TOTRLPVhVqIArGNQ6acUL/o2+u011Xlx5pR/+q5h0i4NabxH8n2McIazIcQqC
         ddvxrqll7qiG3VORPZtNXWT3AYcinI1G7UPLbcfY8ElgceiKEEKcRmRXkVRpybYSykEK
         hrB9PAwkcVD+XKevKzJe/echn44hqMZX5+fOJsNf1tL5E34k2HH/iV9ayoASYmtt8571
         U/VHU8CEQyNMgljojTGTfqvl3osaxyV1tH41hvaX7fyNbJchlMnPZ3xEhdkPEo/qZqDh
         NKl/wLGh8fh0AM3q+oRwa1dw7TOjSV4CfwxXtt+UdUY8TJWpdCeEK8/6nqDkf1r97rKM
         BCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700223010; x=1700827810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVa/xkTnX+o0TolBxebC81ZLWvNl5aLTfGLyraWx7PY=;
        b=d0q5g77ZvS/0gpc+V3LH+kqZZ9VhdeN9LXM2Z2UdGKmx3xmd1SOM7xkm2ZOHc/qp3+
         kyHLad4c2nmiM0IiCsag0pyGLP/x53S7HfhU/DTkvbbQ+IeQMDt6chx9+HypO10xP/+o
         okoFVkgjny6mFLoJBOCbYkv9Y92zA7uoO9mTT5J7wQjdUQxC8/17I0R69dYbXMlsC+lu
         IVoCtAr+/FPzoqT1ZXug1gV9/PLGQknv4VEnL5Re6CNtUdpv28iljv8/zd9A0J2mHJNF
         emVYqwCeiPYYKeRndwgdJMuTgHuSlM0/vnpWxL9k9krlPJPWxJx5PtBh+297Ew4OqVFv
         Ze+Q==
X-Gm-Message-State: AOJu0YwRBl38sijAylhSsFCcz41ygsB+knEYP4ydhTOz+0WMFMm0ZmvA
        soaUCYpuP/iaTsPuPy/DsmJfMeI5nKuOY3Z3+ls=
X-Google-Smtp-Source: AGHT+IGQWdUNxYScc/HdVKMkk9g/NaGEp1SceyCrjV0PWCrQMXOP7v9jiNsVMIVNUupRtR3LRAwJ3IUYvKiACT3Zru4=
X-Received: by 2002:ad4:522b:0:b0:677:f339:f896 with SMTP id
 r11-20020ad4522b000000b00677f339f896mr1795868qvq.6.1700223009882; Fri, 17 Nov
 2023 04:10:09 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNsDLvZR8RGf9ji5938QreSix89FCpGHju+9in2x6OfDw@mail.gmail.com>
 <CADnq5_ObMvxN4pFAsWU7OM3SAtYCNHKE_fHsLqizGm0p1ubp=w@mail.gmail.com>
 <CABXGCsPXp_pWZcyVQajYSTZKeViRqjfXK2=jmuRXh0yug_OoWQ@mail.gmail.com>
 <CADnq5_ND_aBmsD3X=tx2==EM7VOz4EBwid4hRVZ79mbi6bWq1w@mail.gmail.com>
 <CABXGCsOn2a9vZj_1yET96mum=wjGmer6tHG=XgToS76L9ihdUg@mail.gmail.com>
 <CABXGCsOKs33zOC-X7p5QOVWbSzDnSzuxAyGL-oxFBMVFx10pmQ@mail.gmail.com> <CADnq5_Ndk0Z14gnk9=f6nsiQFHU9F3z9Vd2ca8fKsbrmyyTKxw@mail.gmail.com>
In-Reply-To: <CADnq5_Ndk0Z14gnk9=f6nsiQFHU9F3z9Vd2ca8fKsbrmyyTKxw@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 17 Nov 2023 17:09:58 +0500
Message-ID: <CABXGCsOUm3oMJ2mox558=2v7p9O68K=WRysDe5REdMS8d63dFQ@mail.gmail.com>
Subject: Re: 6.7/regression/KASAN: null-ptr-deref in amdgpu_ras_reset_error_count+0x2d6
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 11:56=E2=80=AFPM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> This patch should address the issue:
> https://patchwork.freedesktop.org/patch/567101/
> If you still see issues, you may also need this series:
> https://patchwork.freedesktop.org/series/126220/
>
> Alex

Thanks.
The first one patch is enough.
Tested-on: 7900XTX, 6900XT and 6800M.
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
