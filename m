Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4958002B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjLAFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLAFDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:03:06 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CB01722
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:03:12 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d7eb7ff384so103589a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 21:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701406992; x=1702011792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRgO3Me4RPteNIjeT7wKR86R3xO68rd3yf3Bruq3Mvk=;
        b=V9tv3rVt+urK+K0R1VIlumsWtyePU0NjIkPASi8HDAdUQ6e1Lz6Xq1wRv5+bz1jvea
         1Ce0JAMsA/X4HMHq2YBuBsHSfZy9+xfSBSYptPhIhx2af2LsgbCuCYSnCc51VldSu/gN
         K80//Yc3T9bwC1uOxcx2HCZWv8VpvsCglQsFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701406992; x=1702011792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRgO3Me4RPteNIjeT7wKR86R3xO68rd3yf3Bruq3Mvk=;
        b=nCrEY3cKcHZ94GaQL+P8VuMrSVXUJVc2umG6EswdBK4HECPinFxh9n6pCTM89Jhn3K
         W+OZjop/jKWEoa3EahcDgiGUJroyY/66x3tnE0vEg88HkKMJJKq2dnjiSBv2mp6w4L1Q
         1sRb8mOFJu2709Ge538vJUi3Ksi/F617InxK1W5JMweB3/jcgNAPf0h6LaM2Hq/RwWFT
         3ANHgLuPqZKdJdyvKf8adj4hydZy+NlbsEupd2bhk64endVh4y9giCnlN8Y76j9PyTvE
         IqKlBeMS+eRHTS6pw0hzxXfGMetKTQhWJfZ1MMIDreR/aUxQLkyHUAtpPZLmTO66tRdS
         BRPw==
X-Gm-Message-State: AOJu0YyYSdffsNjRQBGfaYLCZj2YPqfwO0BjdZVzP3QmV4a4+yhaBwkC
        ufhk0oYqrk9Hw55izh+e6GW8+s2h5N9JUapOnZo17g==
X-Google-Smtp-Source: AGHT+IGiqJl3vJ6vZ2muJrHHwI0tG4m8ZHNbXqBH/R+01uyvnqe8RJ4l1yCXKUjiYFbkSec8qXJazLNNZztc3hDCaM4=
X-Received: by 2002:a9d:5e8c:0:b0:6d8:2d13:3c68 with SMTP id
 f12-20020a9d5e8c000000b006d82d133c68mr1903142otl.28.1701406991784; Thu, 30
 Nov 2023 21:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20231201125648.71d7586d@canb.auug.org.au>
In-Reply-To: <20231201125648.71d7586d@canb.auug.org.au>
From:   David Regan <dregan@broadcom.com>
Date:   Thu, 30 Nov 2023 21:03:00 -0800
Message-ID: <CAA_RMS5THkAQxEPWvtpcbb=F-G1xdntZPTmzhAhvK6voWi6VOA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the nand tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        David Regan <dregan@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

from this post:
https://github.com/bbrezillon/linux/commit/e612e1f2c69a33ac5f2c91d13669f0f1=
72d58717

Looks like this comment needs to be added:

* @deassert_wp: set to true when the operation requires the WP pin to be
*                         de-asserted (ERASE, PROG, ...)


What's the best way to go about doing this?

Thanks!

-Dave


On Thu, Nov 30, 2023 at 5:56=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the nand tree, today's linux-next build (htmldocs) produced
> this warning:
>
> include/linux/mtd/rawnand.h:1016: warning: Function parameter or member '=
deassert_wp' not described in 'nand_operation'
>
> Introduced by commit
>
>   e82a5a014dd5 ("mtd: rawnand: Add destructive operation")
>
> --
> Cheers,
> Stephen Rothwell
