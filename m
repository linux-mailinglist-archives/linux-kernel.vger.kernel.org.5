Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B00755741
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 23:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGPVB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGPVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 17:01:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5C83
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:01:54 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-403aa9d4991so10655701cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 14:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689541314; x=1690146114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7GA2pIxc3tCMB97REJHMJ4sl/a9xHf+iGcJZUZdRHA=;
        b=g3nLrD0/bVrmh0+FICTCDKq50fXeZdg2UUxsaZUaD0YMSIq8o5xjXAzAptw3fa3pwq
         ZMgexubM9e19RLxnPmvSfJG95vF1SQByINLrbnTddsrMIlIN+tgk7Vddxha7JgtFDpiz
         Tfocq+6/sfnSP7NqcmEK2Nv4DPPPgE7FogE5+JiGde6eMgL1N3pXthZJEQufpnKVVHWY
         nOkYL+fqt0w0c1QwbbDVVQuaNuY8clN90zHicLmTPEKJrQchul7B4IfrkrrHSV8lHdDm
         xSqoAcGzTy145TLVfu83GAqvSfrlxC5mdcgbgg3f6gUchFxMdLEhxqUXtqd4vcHT3EpN
         jhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689541314; x=1690146114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7GA2pIxc3tCMB97REJHMJ4sl/a9xHf+iGcJZUZdRHA=;
        b=cgojt99xRkG3bmJtPUDnlK4Tzy3WgfNDXdtsX5vX61R+HgwUf3ekARDpSY4DFRVKNV
         xbrRsTHA8D3d/VqU+kqPJ9N8tS7wbsMbUEq4Wp4JTT9OzMg1ZndLhs0ifGiglP8wiV3k
         NVL3Kr0bpl1ywEJDQ8lME9kCrK84PUA+Y9BFN1Q6lxJjcCkij/fAktt1YWXNTbQry5KB
         OpYH1LAriiwj5HGT4dzcKTFqaYCU4ApOIs6RZnu8iKtCk01bzLuRMV84PO99Cwxc0qF6
         EVgV00E9NVmfRKmD7IUnjGT+Op+rwiTnlqvIoEL7ZDRQSS7+JwMvR7iZQVrsLTUViMMn
         3qzQ==
X-Gm-Message-State: ABy/qLbIegBDXXN9U4QCqaS/sudU+P4G7/+l3YyrYTCfZfCznQu6Dky6
        f32ZPY06NSpE0RDZTMbtyMpe9EkIgptyBCiQkAxysYGLoBxHwMh7
X-Google-Smtp-Source: APBJJlFnTwF5qzx8wDrMYT4xJMAfUAlb8oqK6X3ZnQMBeJaEl9CjyIA8mG9k1/s1Erhlg9HEchSVwkRe67p3a0bM9wI=
X-Received: by 2002:a05:6214:2301:b0:635:dfe1:c1f2 with SMTP id
 gc1-20020a056214230100b00635dfe1c1f2mr2424990qvb.0.1689541313639; Sun, 16 Jul
 2023 14:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN3LS2mvXOe5g8WFC=b3N=bF1u4RCQYJN-u+k=ZEWWrcA@mail.gmail.com>
 <BL0PR12MB24653A38A6D914CFF3DB2342F12DA@BL0PR12MB2465.namprd12.prod.outlook.com>
 <CABXGCsN1cnGgMn=Jg6nYfg1GccZhPX8sa=izrr9sMxZdzLiTJg@mail.gmail.com> <DM5PR12MB246926D9E7812B792B12446CF134A@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB246926D9E7812B792B12446CF134A@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 17 Jul 2023 02:01:42 +0500
Message-ID: <CABXGCsN3hH0eKgep6KqTfT0VYvdv10XT8Z15ca1yZ427Eg-4jw@mail.gmail.com>
Subject: Re: [regression][6.5] KASAN: slab-out-of-bounds in
 amdgpu_vm_pt_create+0x555/0x670 [amdgpu] on Radeon 7900XTX
To:     "Chen, Guchun" <Guchun.Chen@amd.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
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

On Fri, Jul 14, 2023 at 4:09=E2=80=AFPM Chen, Guchun <Guchun.Chen@amd.com> =
wrote:
>
> Thanks for your patience on this, Mike. I think https://patchwork.freedes=
ktop.org/patch/547592/ can help this, please take a try.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Thanks it looks good. I spent the whole weekend with these patches on
top of 3f01e9fed845 and didn't notice any regressions.

--=20
Best Regards,
Mike Gavrilov.
