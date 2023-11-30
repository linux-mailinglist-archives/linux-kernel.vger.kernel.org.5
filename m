Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2845F7FF33A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346156AbjK3PKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346053AbjK3PKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:10:48 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3F194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:10:54 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a51d80a02so4928966d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701357054; x=1701961854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65x8xs7/Ug+eGRF3Q+RLiswQEr4hdxkkx4yPgUFKNFs=;
        b=Adoyg17DzTPrgrP9gEdn5Nis5Nm4Qd9wjk7tRQylZX2hSFIMb4NWZnMfqmV5eelkgh
         Iqoqw+khqUx+uMxd7BBCHBfOlJwc4QPDNhcvBmoKNiZd0iSoABcG0LlioOcgrLbn7L9N
         5hDbmeKekE5PyBJbz5faSRblKD0zcV4zDvyrNITcbU5wVlSRjMxqxhIT2JFnuHmznrpp
         hspxQJh2lSySzONINeLrREU89s9eFOGu6efmToV3s3haKHv+RSJVlOafMF9rGEjYDGZI
         yehSfSJUGnLDmVvHTsa+rXY8CYbKkGV4zT1iFkfrX7hRwWCLYXZhcGuVUv9abm3rZ+b4
         zYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701357054; x=1701961854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65x8xs7/Ug+eGRF3Q+RLiswQEr4hdxkkx4yPgUFKNFs=;
        b=P6rx2sc2tx6uXPgLSWFN+Rj+0USWtzIY3WrtTJFTDNS+3s6Dtw0apK1/2XPWxmyw5O
         YIcV8B4v8PJd6HPCQgejOrbpqmMtovAkoXFUzeB/JNMjwi7ztK8Uog8UN9qm05TNVTXS
         zAgXxTTzLZS+hWZ1TJD/pBZZsUtc1Fn4gOdyTDs7MSpxW8ENME0EagcLZ4slgg2oabv3
         PE9Lw9cp1YNR36jINeio98KReUz/mGhX3dSHic8NIEeJoJtiXntvc/hNdT+S1rL2q6m0
         lvS+VQ2TuLbCrdm51Rb3cFkCd2CwMV+rcWVIhv8VupwJdmljuDu1UUG9oJAzy9zAFFBw
         Couw==
X-Gm-Message-State: AOJu0YyZLF2urgsWbkOCuIc/OcRiuj9s7B9RSWLbaj6IW9d9ZEgQgy7M
        xEGCgwnPyP/0ouCktbw9H4285PoYqxe36doWBRk=
X-Google-Smtp-Source: AGHT+IF6r6Hqut2xxDnLLGZ0zV3Mm7WbcEszTpidDJPRE7gu9zzpLCsMhh1T3nEibhhCyDEeOEfRFx/4XoUPmDHnnUU=
X-Received: by 2002:ad4:5f8d:0:b0:67a:2e8f:90cd with SMTP id
 jp13-20020ad45f8d000000b0067a2e8f90cdmr21597719qvb.37.1701357054019; Thu, 30
 Nov 2023 07:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20231130135232.191320-1-marc.ferland@sonatest.com>
 <20231130135232.191320-5-marc.ferland@sonatest.com> <d123196b2c5d486cbf3b2e7e4b1fc774@AcuMS.aculab.com>
In-Reply-To: <d123196b2c5d486cbf3b2e7e4b1fc774@AcuMS.aculab.com>
From:   Marc Ferland <marc.ferland@gmail.com>
Date:   Thu, 30 Nov 2023 10:10:41 -0500
Message-ID: <CAMRMzCCW9dsCLL0karbWOsbunCO=JGaiDEcT4ZD50O7wRqCfsw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] w1: ds2433: use the kernel bitmap implementation
To:     David Laight <David.Laight@aculab.com>
Cc:     "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "marc.ferland@sonatest.com" <marc.ferland@sonatest.com>,
        "jeff.dagenais@gmail.com" <jeff.dagenais@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 9:52=E2=80=AFAM David Laight <David.Laight@aculab.c=
om> wrote:
>
> From: marc.ferland@gmail.com
> > Sent: 30 November 2023 13:53
> >
> > The ds2433 driver uses the 'validcrc' variable to mark out which pages
> > have been successfully (crc is valid) retrieved from the eeprom and
> > placed in the internal 'memory' buffer (see CONFIG_W1_SLAVE_DS2433_CRC)=
.
> >
> > The current implementation assumes that the number of pages will never
> > go beyond 32 pages (bit field is a u32). This is fine for the ds2433
> > since it only has 16 pages.
> >
> > Use a dynamically allocated bitmap so that we can support eeproms with
> > more than 32 pages which is the case for the ds28ec20 (80 pages).
>
> Dynamically allocating seems excessive.
> Why not just make the maximum a compile-time constant (say 96 or 128)
> and just check that the actual size isn't too big.
>
> > As an added bonus, the code also gets easier on the eye.
>
> and slower :-)
>
Sounds reasonable to me. Thanks for the tip!
Marc
