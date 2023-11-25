Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2887F892E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 09:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbjKYIWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 03:22:06 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FDCDB;
        Sat, 25 Nov 2023 00:22:12 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso2535761b3a.1;
        Sat, 25 Nov 2023 00:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700900532; x=1701505332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXAMT1m/Mn+bDDg8lCVh+2sMt2ufqIKuHwMzy74xes8=;
        b=iHzxbxUYCaJf9UxQflyjp1LehTgiKwq2qfRukvaqrx0MnsDxrT3x2Hy27gMjGo8kBO
         wDQ67EKvc+CLxMlj92NExqDyObcNy5/38CyyBCD89SPtG3dNwWz5JEqBb6vHjm2unsv2
         kIs9H2xcQRCnDo7QHKPq6uzSqZfNRhOWDb+vGx7yj4ifj+DRvCBw/5QUMlw7ccHc9hmS
         jhpRUPSydFXCPFcYY8AgdIw9OemJeOITyyUD97eXrPoyZp0exPGKBhTyVU6CsaRhcnHR
         4m3zF12ITm43Vk+g3QuwW4KI0l8rucROtIesetgUG6/AT0D+g2r1D6lu7BVnil/7mI4S
         Mv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700900532; x=1701505332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXAMT1m/Mn+bDDg8lCVh+2sMt2ufqIKuHwMzy74xes8=;
        b=lS8C9MSEPjStTnPCPuckcWDUe1baljTaTGem1c2y7DQ3EJ2OMPbEkUlycynNNwFEFV
         jDtMrX93TQKTQKORZOI2x6RRocdZLxB4I6zpOZrr2PtpgxUOuc2szdsQsmbgBYODdfPv
         8+InsiKh48ltiSE71TMgFTBcrJ1cl11++AuxBSDhpsWrruEb0OM23T/Xx2/xpF89t6i5
         LYq1wWdk1d4EidjYE2qLJbs0dZATqdzUyQWXWl+dqM0GLSZPYZDX0BGxmwYMevsjgxAb
         NQRpGE2AZ9Wdfi8GrkJ5B8c41UpdSL/+G4mOO/LMohv/p4j0n2uYi16O8ifLLh+hX9Qf
         Bcpg==
X-Gm-Message-State: AOJu0YxGSnPPzIpeSX+lY8Dt8/1GsqzP650md3WWOyGRd3Rk/hrMNMCP
        2EBviyOplSx71IScrBB7nPmYn27a/+8aVvwEQAI=
X-Google-Smtp-Source: AGHT+IGIERX2T7/D9zdX3uAWBmI3HkeyREbrc0bFp4tUviYv26xYWhn+7W1oa8oyCvK0VLx70DDaHtjBNsFax/WpcLg=
X-Received: by 2002:a05:6a20:8421:b0:185:876f:4f4d with SMTP id
 c33-20020a056a20842100b00185876f4f4dmr8211221pzd.32.1700900532019; Sat, 25
 Nov 2023 00:22:12 -0800 (PST)
MIME-Version: 1.0
References: <20231125073738.649948-1-ghanshyam1898@gmail.com> <2023112554-bagginess-banker-089e@gregkh>
In-Reply-To: <2023112554-bagginess-banker-089e@gregkh>
From:   Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date:   Sat, 25 Nov 2023 13:51:35 +0530
Message-ID: <CAG-BmocpXo5GY7KSh-nnw7Z6ExkMGKxetoeSdbyNjrqFCGJLQA@mail.gmail.com>
Subject: Re: [PATCH V3] media: stk1160: Fixed high volume of stk1160_dbg messages
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Phillip Potter <phil@philpotter.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 1:18=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Nov 25, 2023 at 01:07:38PM +0530, Ghanshyam Agrawal wrote:
> > The function stk1160_dbg gets called too many times, which causes
> > the output to get flooded with messages. Since stk1160_dbg uses
> > printk, it is now replaced with printk_ratelimited directly.
> >
> > Suggested-by: Phillip Potter <phil@philpotter.co.uk>
> > Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> > ---
> > V3:
> > Fixed the issue with my patch needing previous versions being applied
> > first.
> >
> > Used printk_ratelimited instead of dev_warn_ratelimited because
> > of compiler error "incompatible pointer type".
> >
> > V2:
> > To add KERN_WARNING in printk_ratelimited, and later as per warning by
> > the checkpatch script, replaced  printk_ratelimited with
> > dev_warn_ratelimited.
> >
> > V1:
> > The function stk1160_dbg gets called too many times, which causes
> > the output to get flooded with messages. Since stk1160_dbg uses
> > printk, it is now replaced with dev_warn_ratelimited.
> >
> >  drivers/media/usb/stk1160/stk1160-video.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/=
usb/stk1160/stk1160-video.c
> > index 4e966f6bf608..98417fa31d70 100644
> > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > @@ -107,8 +107,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *sr=
c, int len)
> >
> >       /*
> >        * TODO: These stk1160_dbg are very spammy!
> > -      * We should 1) check why we are getting them
> > -      * and 2) add ratelimit.
> > +      * We should check why we are getting them.
> >        *
> >        * UPDATE: One of the reasons (the only one?) for getting these
> >        * is incorrect standard (mismatch between expected and configure=
d).
> > @@ -151,7 +150,7 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *sr=
c, int len)
> >
> >       /* Let the bug hunt begin! sanity checks! */
> >       if (lencopy < 0) {
> > -             stk1160_dbg("copy skipped: negative lencopy\n");
> > +             printk_ratelimited(KERN_WARNING "copy skipped: negative l=
encopy\n");
>
> You changed a debug message level to a KERN_WARNING level?  That feels
> like a step backwards.
>
> thanks,
>
> greg k-h

Hi Greg,

Thanks for your response. The log level should indeed be DEBUG
as it was earlier.

I only wanted to add a rate limit there because it was printing too
many log messages as mentioned in the todo. Shall I update the
log level  to DEBUG and resend the patch? Thank you very much
again.

Regards,
Ghanshyam Agrawal
