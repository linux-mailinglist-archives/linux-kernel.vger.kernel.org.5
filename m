Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D579BAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIKUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbjIKMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:39:17 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5E8CF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:39:11 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26f7f71b9a7so3556524a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694435951; x=1695040751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=67gCs8f5mdy5XgNTerTC5kFAgH0Oc7zcxedUQ1vHbvQ=;
        b=pvlaalYRe6YZUv6v+XmbmBHZMMaqNgA4ItCgl/JYKRuiZGWONzrLvCWToZXoWuumlq
         xVkS0WBeykr0qlcGa2d52uCVWv3DNrLz2qZZv/9yj5c0AcYH0L7P5KgNGMgvJwTqsO/6
         jnhOYf19+i4RtMe/BltDK1ThsOkPHdn3LLuyN+mZUJfF72lXguBKkLiUpWVH4oC/HIPr
         i/bYRedOSPXWtlmCaut3TG/Byhg/qVSjZnA5jwsZxrMVu0MspWm69T4HKIsdgX3kcZ6J
         ZzSSjpudtq3usKXh8iT3flFvOu7uzWjjgnP1izGtBR8XDayygzDwXKqlyED1Ar+9F1ax
         U0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694435951; x=1695040751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67gCs8f5mdy5XgNTerTC5kFAgH0Oc7zcxedUQ1vHbvQ=;
        b=tqRit+B1v5mZv1/84/DwdsQD4Cir/Kh0BI7Gks6zKv4ux9WiZ8MecExoRrLBm0ZaHO
         xsU5lSrhvqXxvbQuMQMpRihG8ol27EiaNgczbrKgqdRk/aKapE3uwIZ0Frej1ifLJ7lS
         UWkTjI0AW9J+dEHD7/c2fItydFig2HfGDzFBMA38xv0Rx0VVyDXCvaSTNX5DF48XrDA4
         z3OumON+hq7hx6gPnuelE248YDyhSAhybFCJOFz8RA4LgU45Xiwg6LEm8w5sIogeN5Oa
         bzgV0R5RqXj/EymEHBJkGZ8JdTHxIuFhuNwYPXhaofiWViNXR2Gaqj/Bw6J7xn9UjjN+
         U3YA==
X-Gm-Message-State: AOJu0YzSHIfUOWXlJqs6snnAvG+8jBxcE4UXYIE9thnLuMACSECWodoj
        5a5zDvbhhuCxLkODtcakOfQ=
X-Google-Smtp-Source: AGHT+IEN3B/vp/Bz84j6bhpYODzTYGAD4HzUT+dgxsIzCZIrQdRUDOCEReBWrAFEKjKxEyeSc50bnA==
X-Received: by 2002:a17:90a:1548:b0:26d:17e0:2f3d with SMTP id y8-20020a17090a154800b0026d17e02f3dmr9014298pja.44.1694435951137;
        Mon, 11 Sep 2023 05:39:11 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([106.205.101.29])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a0d0800b00262fc3d911esm7968067pja.28.2023.09.11.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 05:39:10 -0700 (PDT)
Date:   Mon, 11 Sep 2023 18:09:06 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Type encoding info dropped from
 array name "byVT3253B0_"
Message-ID: <ZP8Kakx1sUjnjWrQ@ubuntu.myguest.virtualbox.org>
References: <ZPnLw+njcL/D391S@ubuntu.myguest.virtualbox.org>
 <2023090724-trial-ipod-93d2@gregkh>
 <ZPwwHY1TDOBEljxr@ubuntu.myguest.virtualbox.org>
 <ZPxCa/UOd7T2phqX@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPxCa/UOd7T2phqX@nam-dell>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 12:01:15PM +0200, Nam Cao wrote:
> On Sat, Sep 09, 2023 at 02:13:09PM +0530, Pavan Bobba wrote:
> > On Thu, Sep 07, 2023 at 03:43:53PM +0100, Greg KH wrote:
> > > On Thu, Sep 07, 2023 at 06:40:27PM +0530, Pavan Bobba wrote:
> > > > Below array names updated as per coding guidelines:
> > > > 
> > > >    1.byVT3253B0_AGC4_RFMD2959
> > > >    2.byVT3253B0_AIROHA2230
> > > >    3.byVT3253B0_UW2451
> > > >    4.byVT3253B0_AGC
> > > > 
> > > >    Conversions performed:
> > > >    a.type encoding info dropped from names
> > > >    b.names replaced by snakecase
> > > > 
> > > >    Issue found by checkpatch
> > > > 
> > > > Signed-off-by: Pavan Bobba <opensource206@gmail.com>
> > > > ---
> > > >  v1 -> v2: Name of the tool added in the body of explanation,
> > > >            which found this issue
> > > > 
> > > >  v2 -> v3: subject modified to more specific detail
> > > 
> > > Any specific reason you are not sending this to the maintainer that can
> > > take it?
> > i used scripts/get_maintainer.pl to get maintainers names and i am
> > adding all those people to the mail. kindly let me know the maintainer id
> > and the correct way to know the mainter of a file
> 
>     ./scripts/get_maintainer.pl ~/Downloads/PATCH-v3-staging-vt6655-Type-encoding-info-dropped-from-array-name-byVT3253B0_.txt
> Forest Bond <forest@alittletooquiet.net> (odd fixer:STAGING - VIA VT665X DRIVERS)
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:2/2=100%)
> Michael Straube <straube.linux@gmail.com> (commit_signer:2/2=100%,authored:2/2=100%,removed_lines:44/44=100%)
> linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
> 
> Greg shows up as one of the maintainers for me.
> 
> Either a bug with get_maintainer.pl (unlikely), or you did something incorrectly.
> 
> Best regards,
> Nam

yes. now it is showing Greg as maintainer for me too. i might have used
the script incorrectly earlier. added Greg to my mail while sending
next patch.

Thank you,
pavan
