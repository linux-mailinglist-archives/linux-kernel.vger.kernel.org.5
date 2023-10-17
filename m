Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1FB7CCF8C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbjJQV4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbjJQV4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:56:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972DB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:56:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so1859a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697579807; x=1698184607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6SecveUSZbKWLbjiW04X4UH95hRKYmyzqJ3SXHAuOw=;
        b=XibKjnOlZ5UN+m2meVnEjGK9m3/4nXPq8SuLH0d3JwOvXMIurzEXFDdlQSzhd+z+N6
         S1pMM8qsu8XkLT7vC/2UdpejID+of8zyWV3Hsk48+jJF2ID24bcJIso3HsXDnY+Gts0T
         qjpnRGIwiCWE0x+X8PWR7UhAXZrjz/V2yNtdVjSt9GKA2oc7OoYMhrumA7lSoUkDdoGx
         PcmNC1iSaJz2sBdqGENMSJ1+SG9KST4deVamdX4qJ1K74Q/fPPUsgmMXhC83hgtzVzU2
         AWcj2cxQhzw7uknH5jfn4E35nPwfWou0pFpzx59r50sHmud4unhq7dTNwmZB5kbqxrYX
         uJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697579807; x=1698184607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6SecveUSZbKWLbjiW04X4UH95hRKYmyzqJ3SXHAuOw=;
        b=qdBo+k5cFWVRJaw14swDfBp9JJw3fTGaYH5kAO8nmarzXiewB/hLvV+DA0DS7fqAJw
         XKBjFD446h1AEMh87WRo+Vo8aE4+8xjZGaUyqR5ezfAqHt0/Zr06KaU8rHOFjrhgFq+X
         flT6mx5SY1+LXEZwCadkHQsc6nUjPqsBOd7djkjmBlFpcRa+tg9FKTc72jsA8KIDijHQ
         b2oEIHyxTNOUgOpHP6oxADVAGLVXYczz5LjM+ZRDyI6GEiXTEqbSHmeyEodjsHzcYM0C
         7Cn/FhaG1nMMPncndbZsZNEWU+hQDjKBUHL3RB7/1hvlztJ8XIMN+qltywaxLm+fgE9f
         vj8g==
X-Gm-Message-State: AOJu0Yz22E0Dmh3Lhp6mLhhg1/TSJ1D47BgjA5tArIgxt/JeXyB6cFFE
        osWXHhI+77+y+KyumHAHQvs8a7mYc422hExAhl6r8w==
X-Google-Smtp-Source: AGHT+IFeNB7FV7GubzleZU617rN/G/xjqDvjL6DLVrnWjcz/iKRbu0lAMqNk3YpZxQbGcqm0l6q3ZvoAaaFRp6ONXrE=
X-Received: by 2002:a50:a6d9:0:b0:53e:7ad7:6d47 with SMTP id
 f25-20020a50a6d9000000b0053e7ad76d47mr19944edc.5.1697579807512; Tue, 17 Oct
 2023 14:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231017182026.2141163-1-danielmentz@google.com>
 <DM6PR04MB6575C45CF299649DF41FD963FCD6A@DM6PR04MB6575.namprd04.prod.outlook.com>
 <52a248fc-465e-4050-8692-5105b6aaa764@acm.org>
In-Reply-To: <52a248fc-465e-4050-8692-5105b6aaa764@acm.org>
From:   Daniel Mentz <danielmentz@google.com>
Date:   Tue, 17 Oct 2023 14:56:33 -0700
Message-ID: <CAE2F3rCcEC=fMd+_gxwksTW=07ZzAt-vA5SO3w8AdAXGy1OVDg@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: Leave space for '\0' in utf8 desc string
To:     Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mars Cheng <marscheng@google.com>,
        Yen-lin Lai <yenlinlai@google.com>
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

On Tue, Oct 17, 2023 at 12:33=E2=80=AFPM Bart Van Assche <bvanassche@acm.or=
g> wrote:
>
> On 10/17/23 12:20, Avri Altman wrote:
> >> Fixes: 4b828fe156a6 ("scsi: ufs: revamp string descriptor reading")
> > I think this code goes back to commit b573d484e4ff (scsi: ufs: add supp=
ort to read device and string descriptors)
>
> Hmm ... it seems to me that there was no buffer overflow in commit
> b573d484e4ff but that the buffer overflow was introduced by commit
> 4b828fe156a6?

Thank you for the review Avri.

To me, it appears as if those two commits had different issues:

commit b573d484e4ff ("scsi: ufs: add support to read device and string
descriptors") failed to reliably NULL terminate the output string (in
the case where ascii_len =3D=3D size - QUERY_DESC_HDR_SIZE).

commit 4b828fe156a6 ("scsi: ufs: revamp string descriptor reading")
potentially performs an out-of-bounds array access while NULL
terminating the output string.

I would argue that the proposed fix wouldn't even fix the former and
older commit b573d484e4ff, because that commit might have required
more fixes like using kzalloc instead of kmalloc.
I find that the newer commit 4b828fe156a6 did enough of refactoring
for it to be considered the commit that needs this fix.
