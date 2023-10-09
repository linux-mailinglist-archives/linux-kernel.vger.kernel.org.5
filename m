Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C8F7BE846
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377437AbjJIReZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377975AbjJIReR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:34:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A112DF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:34:15 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c3e23a818bso16222941fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1696872853; x=1697477653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nq2GQ2H1vuKyNiZmrzLAFN/nNn6hx8PmFL/I895kOhs=;
        b=KJl6r+wNby3JGHDV3gKCM1tx0/iaAAvTFAlmbgNXxX1LJk6GDoknrkNA32wMkWLOMd
         +CZ6WyFSh7ft0P8UpGMgtDP5TwDidZtnevFFyyALx2V2py/FFQszR0xrgUwW5gAeEkJ+
         ucUsWTOOP78wRSogUhjBE3gvuk0xrPbsYIxG2lzAQiaV7MB43E559HFNDqSi3kuvjOrb
         +JnNgVAwPFlMBo0h61nmgqAkh29qayDVa7emtmxuISiJBDso7nUV2FFPdWmICMDKkFfd
         OEX5yf79Uz/TE+G/QTB09Hj5OdYXg2MZCicD2IQfLD5JzAGagM1S1jjPuRBE7xYqCL82
         3UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872853; x=1697477653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nq2GQ2H1vuKyNiZmrzLAFN/nNn6hx8PmFL/I895kOhs=;
        b=JNaw2XAz5v0fdAqPCSKXK0PWsfgOftqTYRuaxCxOeDoijq6kWeaU9clnv/PzmFwpQ9
         x2UHkqrW4N2F5/taKIGYwXh5YwYUVj5bfZs8m6+yfRHwju3mZB0TVaYPgFX77Md3wg6/
         p879/O4c9PaoKp02rQjotGTYjtxTZyvpLqVOC0C4aAxG15Lz9K0zTKa6P5e3+J1oy+eq
         ejFW/VH17d+e+28R7snZ6O6NkINNPXx+UTDJeEKlf4lVLE/b6Q32Mp4NXvKdqaAQtX0F
         zW+b33z5vVv78GorQcLqg1KVirtqTKjYxz1qkUCzyNJiPK9a35DbX2Nw0VlPi/MFHqym
         RHxg==
X-Gm-Message-State: AOJu0Yz2S8cxIcN4OshUS6IeocUduXXYEfc/L8bux8y1FGNC4EjuEeWF
        fGWT+x4O+yZuNUDaxdcMB3q2pruIQL+scWkZfkPBnQ==
X-Google-Smtp-Source: AGHT+IEUfNwMkfCnl/XyTROOMWP8DgWZG5GKfUSxkquTClD6BL2TMDnYwX05Db3dT30tRnY5iL7b9D7W4IKm85ZfAGM=
X-Received: by 2002:a2e:870c:0:b0:2b6:cbdb:790c with SMTP id
 m12-20020a2e870c000000b002b6cbdb790cmr11318211lji.1.1696872853492; Mon, 09
 Oct 2023 10:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231009165741.746184-1-max.kellermann@ionos.com>
 <20231009165741.746184-2-max.kellermann@ionos.com> <2023100908-pouring-synapse-75bd@gregkh>
In-Reply-To: <2023100908-pouring-synapse-75bd@gregkh>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Mon, 9 Oct 2023 19:34:02 +0200
Message-ID: <CAKPOu+807-eZfGff7EHcWGn4PFCJACv2mGi54jtoHCy14_s5sA@mail.gmail.com>
Subject: Re: [PATCH 2/7] drivers/hwmon: add local variable for newly allocated attribute_group**
To:     Greg KH <greg@kroah.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 7:27=E2=80=AFPM Greg KH <greg@kroah.com> wrote:
>
> On Mon, Oct 09, 2023 at 06:57:35PM +0200, Max Kellermann wrote:
> > This allows the compiler to keep the pointer in a register and
>
> Maybe, maybe not, there's no guarantee for register usage.

Agree. But without this change, register usage is effectively
prevented (much of the time). With this change, there is a chance for
better code. Yeah, it's not a critical code path, and it's only a tiny
tiny optimization - but the real reason for this patch is ....

> > -             hwdev->groups =3D kcalloc(ngroups, sizeof(*groups), GFP_K=
ERNEL);
> > -             if (!hwdev->groups) {
> > +             hwdev->groups =3D new_groups =3D kcalloc(ngroups, sizeof(=
*new_groups), GFP_KERNEL);
>
> So you have a const pointer AND a non-const pointer pointing to the same
> thing?

.... so I can make "hwdev->groups" const, which wouldn't allow
modifying it. (This isn't obvious in this one patch, but a later patch
in the series does this.)

There are only few functions which allocate a new pointer-array
dynamically; all others are global variables which currently cannot be
"const". This patch set does some lifting to allow adding "const".
