Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9D7C6A0F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235457AbjJLJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjJLJ5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:57:33 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC02D9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:31 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bb6a2481fso399838eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697104651; x=1697709451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwdR5UfKZdkaWRIAkpPnNZMh5uS4lp1PwggWWgtXHKw=;
        b=mbDcQa5pbAaSeFPk/14Q5/a5dstosnaFlrMaENvP5wcB4S8S/5Se15eL8Hq46RDqfL
         SG9ipX6PWjBFBOUNQWaD9GG5TnxfinI9Z9tQOZB/S4dD7+5CvCetjCZjO4PjKXUAAC9D
         H+GvW1O5ZjppOvXcoFroi77Vw5m0sMVXKF/VfmJD8KZvEh3/slE7/WTa0P/8ygDSm8bb
         q3deCzDhciMX6uLFkFbDwavCQtQJZO43ZGLsoHOIOoT8KUT1ZL7nBWNof6G186SqqRza
         kGNQefR33rD+bWxvWL+a51nElk78azeD9IImhKCHnYNZpgJL713jcNAYqIqDfeeMJlj0
         XnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697104651; x=1697709451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwdR5UfKZdkaWRIAkpPnNZMh5uS4lp1PwggWWgtXHKw=;
        b=ZSN42TKMuU8LMV7bm4F/caMePKz1QofQPOoQOwvBms27h/mBo9iqkS7OTuy/Z4YIBZ
         +TwqjvEr3n4TRI+lIpWFzTFnstdhj4Fdu4DklnVe34ALmKkGPVpcV+Qu/HERjExTUx7/
         nTcvhnPF/0bv0H0HuFZU2FmCuSxbRrPTEiutlIinkZegZRlokrqZ1p4kKr9ppiRuHptL
         HsOBpr8Vm462WI4gzNKXJxDrrf+iQ2jGp8KdiqYqcbzywk809U/OyGIfQgp1k3JeKUFy
         pHWZy+Kr6fn8xWUp/4Vo3EwYmbOWAKeqRZ1f9z02dJkWOSa8CwlTTMt7kuuIgr4Y7Hkk
         Z41w==
X-Gm-Message-State: AOJu0Ywo6Sjsx7JXYPimZzJUcv7xXDEEON5CIUhXlqReDW/HJP29ksS2
        PRlGo6mwmvmy2t1AwUFiG3GXB7n++nuu9wg8GghLfrexP1RYPxiY
X-Google-Smtp-Source: AGHT+IF203hK+9NVxRy43xv7sJ3KAyfzjvWa14O47XbIsgfVV5/DnyirAzXXOjXkmqnHjtBT6L4wpBPa6G8sZiG97vI=
X-Received: by 2002:a4a:301c:0:b0:56c:dce3:ce89 with SMTP id
 q28-20020a4a301c000000b0056cdce3ce89mr22961387oof.5.1697104651071; Thu, 12
 Oct 2023 02:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZSeD1UojAgrsOh16@lab-ubuntu> <1e2cfefb-c4dd-4611-867a-2b2e9e5f7467@gmail.com>
In-Reply-To: <1e2cfefb-c4dd-4611-867a-2b2e9e5f7467@gmail.com>
From:   Calvince Otieno <calvncce@gmail.com>
Date:   Thu, 12 Oct 2023 12:57:19 +0300
Message-ID: <CADFX3OT4fAGjVrp-D2fPTi6DtxUMbk+-Z0OcwRTWDBEEwb8ukQ@mail.gmail.com>
Subject: Re: [PATCH] staging/wlan-ng: remove strcpy() use in favor of strscpy()
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <error27@gmail.com>,
        Archana <craechal@gmail.com>, Simon Horman <horms@kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, strscpy() has the same behavior as strncpy(). It is preferred to
strncpy() since it always returns
a valid string, and doesn't unnecessarily force the tail of the
destination buffer to be zeroed.

On Thu, Oct 12, 2023 at 12:17=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
>
> On 12/10/2023 12:27, Calvince Otieno wrote:
> >               if (j =3D=3D -1) {  /* plug the filename */
> >                       memset(dest, 0, s3plug[i].len);
> > -                     strncpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - =
1);
> > +                     strscpy(dest, PRISM2_USB_FWFILE, s3plug[i].len - =
1);
>
> Is this strscpy() behavior same as previous strncpy()?
>
> --
> An old man doll... just what I always wanted! - Clara
>
