Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4E75112E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjGLT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLT0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:26:06 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEE61FC1;
        Wed, 12 Jul 2023 12:26:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-57764a6bf8cso84174327b3.3;
        Wed, 12 Jul 2023 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689189964; x=1691781964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3NLC7atfJJsYoIzJOjRPYIOxthVMt03n8zToq5Ub4E=;
        b=jIla5nm+kACeRc+UraotMgVfcbmtdX9GwY5VRaIBkEkWPY3pt3FzaVQHXs9YMLQxZI
         GarJgLxvGDjevNEr7RLpxGvpJ5+ltqEDgegwPmlo6T3oFU61s+pR30IZkdDieosK9wdS
         iiSmlXsAq/V7C8Fqb6PDpSK+24NXqIZOIjodYagtAlZPBDEVSkAoQO7lIVtGic2MIhQ4
         yrrNUEsElywTo8MtMkPXzr7VK/LKV9CZQSbZgk82qoF3V5eFOoXIhc1pPkjCUDFa0sNf
         QomTc1hb1mkbau105cZ1AeRKMUKcrMVnqruOMu5x7Ucqz0WbnWb4tmy11LkICwqnKDiT
         /dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689189964; x=1691781964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3NLC7atfJJsYoIzJOjRPYIOxthVMt03n8zToq5Ub4E=;
        b=aFHtQ0IA+gNXlDni6VmaRHVmYNr2Z2KomIZPcEPMZhRnlM5rf8JYBZ0XKjDGSYRQIv
         B4018iKdj/OsfjuaFw5D3NPxoI7uC9LKc7iDIxc1l+HA+l2TMw2YQVsOuAxRJrfgJ0JD
         w8Jj3QLQvXsDNQOaMqkDTUj5WprMLVwrQbhYFmW17a0u09NQNVxgJwRRxVvFPuo7Q4D+
         Fkkjw37U/1pj6Q2yyrmsO1eqygIGQYmZp7n36h9BrpaiCBvxfUnUnRET54RgbWWcWpXK
         QFPKOJHy82VNtx3FpB3xFRSXaT+Hl4tIVdcuENQVqir7+h3d8OkuQEnkiQg08H6ygH41
         fwKw==
X-Gm-Message-State: ABy/qLYBfe5RIgpP7FsCJYXLX45MU4h4mbozifs54pCyu7lGM3VSffCz
        89BAASVIqsl3qt1Fxbrh6HjD781opxam2mN09pPQOh8XaZozng==
X-Google-Smtp-Source: APBJJlGvTEroD7+OVZ6alFtQq/nLKt30xH0xv5++6k9See/OnfymBucoDonuQ4Oy8u8/k1Fl4JwVSz1K1S50lY8gG+A=
X-Received: by 2002:a0d:e8d3:0:b0:570:8856:5dbc with SMTP id
 r202-20020a0de8d3000000b0057088565dbcmr20120192ywe.41.1689189964551; Wed, 12
 Jul 2023 12:26:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
 <3034082b-4ec8-2a8d-35a2-2551e9feef34@roeck-us.net> <202307121100.A6E650B@keescook>
In-Reply-To: <202307121100.A6E650B@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Wed, 12 Jul 2023 15:25:53 -0400
Message-ID: <CADmuW3WfOwAD2MLmNkua5d3Tzjh3RWDSjZomQ_Tu6ucJ+B+bqA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: Remove strlcpy occurences
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 2:04=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Jul 12, 2023 at 08:16:39AM -0700, Guenter Roeck wrote:
> > On 7/12/23 07:44, Azeem Shaikh wrote:
> > > [...]
> > > +   len =3D strlen(result);
> > >     return simple_read_from_buffer(buf, count, ppos, tbuf, len);
> >
> > This still copies tbuf, meaning all those constant strings won't actual=
ly
> > be reported.
>
> Ah dang, thanks for catching that. Yeah, "tbuf" should be replaced by
> "result" in the simple_read_from_buffer().
>

Thanks for review folks, will send out a v2 shortly.
