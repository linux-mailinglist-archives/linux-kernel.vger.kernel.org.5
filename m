Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC1B7D90CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjJ0ILv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235062AbjJ0ILs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:11:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E88D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:11:46 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-778a108ae49so234349785a.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698394305; x=1698999105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFOnKD8/bJ/Ea9yuM+CcRFxiSiazRL976uMcMGUKdAw=;
        b=hxtVKyt2GftVwlZYtPBoILwZn+Rbw3rokBGnQqLRAsI3BQnIgayzWtKFkuQ+cQ/dOG
         0B8IWo+kfI8xnv7nKvo2d1CInmd3pu00KrWVeRr30jUk4V7il+8d9p2oCUJIMHFC8Okt
         xMGYy4eMlfZZyXKGihc9KYkU9Tx+1Y/Ac3vspTfmPI+bIBD9JxKzY2ZVOvTmwY+cEHuz
         qOK6smHqIRxay5FoGU5u+OM3GBC1J0Whnd3M80j6kbaiH3+bdlsAmqRZONRkVWqBheQ4
         6YaAh6TioxCl2EtGm0kHBLXmEYRI64V6q3zMuq7O5c6zSZ0mONjt5xyJpahYzM7GZwuA
         uVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698394305; x=1698999105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFOnKD8/bJ/Ea9yuM+CcRFxiSiazRL976uMcMGUKdAw=;
        b=WEhc6+x9ehvKks6aFDhc/RA+fLDI506OwjmCNw4UGKNu4G/M5mjMIgSyzV+R00qoEj
         /c/cmYXFu6fRpfbNkV9Tq1+jQwV9psVFcMeHeb58kiMDX+42WOlTnh8J2uobSWj9Cl92
         Hznzx5zLv1CIVlhaAjc6P1+V8pOo7Lac1gIpUb/QKoxAIaoq/+yOLvVH+I43aEU0OLTb
         MfK0gNgxRpaTjgchNlEKnbGHY7NLWR13M4Vfd94GJUgMgHlNo6AzBP41Ag4lSRQSZWW5
         UZbkzPdfVyKgdgws3XgOmA2oemtaVUVHYkqCw88EhDME9MJ7kETTp/c589QsCl7eM1Ek
         CmhA==
X-Gm-Message-State: AOJu0YxytjYwoTNegiPULKIdNWFiVXwwpuNotoJRGHGjObfApledBygL
        H2h9l1OMejW5kbO4wdIX9OiiJLmx+FnPQMXrivYyDg==
X-Google-Smtp-Source: AGHT+IG8NYfB6u1nz0s3i6ewZxAxieW/pHmsvVKVygjqt49QCatLeAoyLB4h9kuYVHcTdX2jRo/0bLyw9PtwXpqyMN0=
X-Received: by 2002:a05:6214:925:b0:66d:2ce2:8651 with SMTP id
 dk5-20020a056214092500b0066d2ce28651mr5452314qvb.0.1698394304909; Fri, 27 Oct
 2023 01:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231026135912.1214302-1-glider@google.com> <ZTp2oLST3nR9AZk4@smile.fi.intel.com>
 <CAG_fn=VSYNk=k1kqKo1vQ7Bd87x9evy6GQBfjdNatOp51x8DZQ@mail.gmail.com> <ZTrIoaFE+c5XQXFs@smile.fi.intel.com>
In-Reply-To: <ZTrIoaFE+c5XQXFs@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 27 Oct 2023 10:11:07 +0200
Message-ID: <CAG_fn=U2mWhct--3H9_-ECtNkxzROjFtRZ0uUVvjCfhrjqeZcw@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] lib/bitmap: add bitmap_{read,write}()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:14=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 26, 2023 at 04:48:46PM +0200, Alexander Potapenko wrote:
>
> ...
>
> > > > +static inline void bitmap_write(unsigned long *map,
> > > > +                             unsigned long value,
> > > > +                             unsigned long start, unsigned long nb=
its)
> > >
> > > While noticing strange indentation (you have space for the parameter =
on
> > > the previous line,
> >
> > I believe I do not, maybe that's something on your side?
> > There are tabs in the source, and in the original email.
>
> I meant that you can use 2 lines instead of 3:
>
> static inline void bitmap_write(unsigned long *map, unsigned long value,
>                                 unsigned long start, unsigned long nbits)
>

Sorry, my previous reply was incorrectly attributed. I will fix bitmap_writ=
e.
