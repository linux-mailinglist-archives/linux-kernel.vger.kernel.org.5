Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E857A79C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjITKxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjITKxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:53:38 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E149CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:53:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-274dd099cd5so2787162a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695207213; x=1695812013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HU50GJakfit4skNHRT6DovjnNulHZNN9x8GJ1Pfq78=;
        b=BEpWP3YDGt7Z1h/+NLZKWhrpY2pNme7Cs2L5u+ofekZrwk2AJvNHs14K3McNTIRDAJ
         VdyG8bl4ULbmV9cQC/IYTvQD2i4Ri63/Lw7Uq2rjtMccaGbhcLJVX1bXZCWIx4Irxsf4
         uXJLXlQvfRY699TSh3mPI4CWJ2YCArEZepHRLUK7UMd0pRQ0ANK9F8AM5OcxXxObhKZB
         Nb1nyRNkT+GVnEdlTB1ZuBthxvp3q22qJe3ozg8mhGB9Xxyk4OozW7V3y0yeurx3aScn
         vE464LKmFaVDJK6VqZE34aKVnX1OuYaTllgFV2Vosn/QWYyyCLS7aXPslfGNynDPWfwC
         6bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695207213; x=1695812013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HU50GJakfit4skNHRT6DovjnNulHZNN9x8GJ1Pfq78=;
        b=fDld04nFmW8kxwxclWCX79mi4LH5N6uaWk6++KPWPwDzVcphzwGbxB6IqNneYW3Oxl
         OVuzVDdEnyx3Vp4UVv3437UYWMKRqE1EaVgzVYrzC79dQeeFEy829z42zpYOKVKTyzMC
         iAPYy23NPEP5IPoE4mtJRKmbi+25AyKhmkOCMjYkSLa1Jc+AFLTDbPJa2dB72Q82IgST
         YaETHlnsG4XKiBPTxvFZuul153Z2WRaTIlX0gdlwdinBdYVUXi//HAPjcrKzrKrxy1x9
         sR4rb834qQgAnbZb1+kNUAqEf0nE4XmmBvXnCH6gHNW9Nbwa0sACK2Bfrb3M2IFbDhpb
         19fA==
X-Gm-Message-State: AOJu0YzIpMKn4kouSdpNuOFhjCa/xA3Z1jH8wM/HlkJa+SdMb3+gKTQj
        7d8KAI3pNIwe7eKsC3aQhVLRkYUcU57WFTwxxP4LXHof/YQ=
X-Google-Smtp-Source: AGHT+IGHlILYd4/Yl86++MOCRIvl9UBpXr/2HiI9K0gZxhhE9PGh3GSuhqMMyNXEY7lu4kySxLGJNBELfoo3UVKfIGk=
X-Received: by 2002:a17:90a:c696:b0:271:9e59:df28 with SMTP id
 n22-20020a17090ac69600b002719e59df28mr2076379pjt.29.1695207212776; Wed, 20
 Sep 2023 03:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230920052139.10570-1-rdunlap@infradead.org> <20230920052139.10570-10-rdunlap@infradead.org>
 <86v8c5cgv4.wl-maz@kernel.org>
In-Reply-To: <86v8c5cgv4.wl-maz@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 20 Sep 2023 03:53:21 -0700
Message-ID: <CAMo8BfKMs797D+YSLG8ed6yPFfy1UqfxRC-coR+hHdKq_4CE2A@mail.gmail.com>
Subject: Re: [PATCH 09/16] irqchip: irq-xtensa-mx: include header for missing prototype
To:     Marc Zyngier <maz@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Chris Zankel <chris@zankel.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 2:51=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
> It also begs the question of the continuing support for non-DT driven
> systems.
>
> Max, Chris: are we any closer to being DT-only on the xtensa front?

I have never seen it as a goal. Let's see: iss doesn't have devices at all,
virt based on it is DT-only, xtfpga with DT loses USB host support, but
it hasn't really been all that useful. xt2000 is the only xtensa platform t=
hat
does not support device trees now. I can convert the code, but I don't have
the hardware to test it. I also know that it hasn't been in use in Cadence.
Maybe Chris has it? If not then I guess we can drop it.

--=20
Thanks.
-- Max
