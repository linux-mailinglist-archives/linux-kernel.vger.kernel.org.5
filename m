Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A0680352A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjLDNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjLDNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:39:02 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D701728
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:38:55 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4647403bd3bso654783137.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701697135; x=1702301935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKB+uMlW5RGX9ZA5gMhf7/cK7rF96At60/fWmnTaGyU=;
        b=F8aQ2blYgefWHcGABhi/Z+Kx0yRP4RtOg5Xz/8jDKVLRHS9H+Bi7ZXlAZB7K9FAgsD
         9roG8gbFuV4rR2FudZgimSR7CJofFqnbqMydbdPubS2LC051Pg92S6ItrpuJe0D/E7HK
         t+7bYkw+dcDz4zbxHj3oAdPqV8RinEP5KIFtxFO+cI3glsgdVjFGICDCO85gqYm8RD5E
         GnZXErVhQ4tj5BDy7e5v4szDJBx+Ze6uvUv6DJVsHGtZi/YQgnXD763vls3SKNatlxha
         A6MgwVsv+QFQ/jb6xf/yT9QTMTeTjdkz1/zFBBDG+maJdbiQFWibPsvK+ClRst+o9IPu
         ZdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701697135; x=1702301935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AKB+uMlW5RGX9ZA5gMhf7/cK7rF96At60/fWmnTaGyU=;
        b=ITgeMEEGyb9eUxRtTexKEK3dLikfbCY2RKALJSDh1pt5Xfc01+USJopPbW4rzZ8DgM
         da+IK+b9Sjia/4WOsKHlzHN6s3u2wzob5Jr63JfgwM+ZFAs6SVEXx0oo1SLkVrG48jiJ
         OuEsKuDR4L9a1sJIqFRVNhDHsJB3YLQ96ZKlLcCk+UWtBKrXq4HHQQBDXnm7TpekFv0X
         s6zIVymz9jyMCiSyn6EYWSrZqSCelERNQFEyc4PD7EpgOKUBMx6U5e5x56tDrGufqYJn
         9uPfj+DxyyptyngniSQ8i0vz16NYdlHVl9DgD5YG/pEHiCsOUeKLxwG7pyl7HAGzPr5r
         qyig==
X-Gm-Message-State: AOJu0YxDK+aKXRa4C/qwvrH02XzMHCng/1nk8HbqS94AtMPlFUzTxlLi
        dwsbzDrunOsIGd8gY9JSncO2L8o1ME13i4Fs7vNRGA==
X-Google-Smtp-Source: AGHT+IFxp/ngB/jWWyxWf6QUNfeJHPSW53ZhCEky4m7MbK0NguMBdPuJ575nZkXXBgcTLxs+HynZzd0S3V9gYSFrylM=
X-Received: by 2002:a67:ff11:0:b0:464:4a8c:783b with SMTP id
 v17-20020a67ff11000000b004644a8c783bmr1717905vsp.12.1701697133511; Mon, 04
 Dec 2023 05:38:53 -0800 (PST)
MIME-Version: 1.0
References: <20231204093509.19225-1-brgl@bgdev.pl> <20231204093509.19225-8-brgl@bgdev.pl>
 <ZW3RwqZHvRRoYLXn@smile.fi.intel.com>
In-Reply-To: <ZW3RwqZHvRRoYLXn@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 4 Dec 2023 14:38:42 +0100
Message-ID: <CAMRc=Mcgi0_YFG+KSyXgmOTTjM+C+fc6oEGw+mcdv1PQgH6SUA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 2:19=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Dec 04, 2023 at 10:35:06AM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Use the new gpiochip_dup_line_label() helper to safely retrieve the
> > descriptor label.
>
> Fine by me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Still would be nice to have an immutable tag/branch with the first and
> this patches (at least) that I can incorporate into my pin control tree
> (TBH I do not expect collisions, but just in case).
>

Sure, I said in the cover letter, I will provide one.

Bart

> --
> With Best Regards,
> Andy Shevchenko
>
>
