Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27327E6DBD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjKIPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbjKIPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:41:51 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE335BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:52 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6cd0a8bc6dcso563487a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699544451; x=1700149251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tJ1Dsj0sBlosFzA+sYRVfNMl8UsSGIcTKFZYaCY0JM=;
        b=G7RfGLP6OeVF2RWgmsgRPsyug71R2QUQcasvdHHh0iUzTqZz9EGaN+IDZxJ3z+reNd
         ftSKxWBbkqwjbhrihMKweu81JlyRHbYcwQOrVYt9F2bq8sHHAKjBeJzwHaQiX9J/t4Hf
         Rx451pKlFuFwMcBBkNWm0uNKq4OSMImA5XxnpuVURMpVgRjdQYINRzPAHaGaq2pF2tOz
         aZgw+tvDC9YlY5HIUrcnwVt5UWVdIpucPOhMxJzmVxIoArArUcZAm4uK6mZsSR5EpLQ7
         7Y+T1vZJ5dtBmGtok14V4eDhxzNOZYpURRWnjWcfqEIUUixMkG+8ls43doS7NPYfPOtk
         uweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699544451; x=1700149251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tJ1Dsj0sBlosFzA+sYRVfNMl8UsSGIcTKFZYaCY0JM=;
        b=h4uqdbX2F6x4OJNbZ56FUu2s4hItHD1EM9B7ClYRgO844OJbYrivj1tD9wvpDzK5yO
         WSLm5ZAj73lq1YXkGQQf0Fi+MXATeBO5rV7DU94Vcs0pOQJdijFeUU0o49ktbnTj1Aza
         wPSV5rw2rWqn3BmFF2lxnUFJ9lHzv3J7o9h5NGOR30IGcGQFFAqbyteku0MWaPUptWZo
         Mazqc9KUhLootPFhc99mKn59Q844F9lN7d4RTLh4otmLY9tjCTFyL8e6XP21/n1RZs3q
         o51BjocaJ4cc0groVuxVCTU2vqnl2o93iUXVRJFmn7TlAWDQUFRcJWmhTXnXsuo9axAW
         LX9Q==
X-Gm-Message-State: AOJu0YzhtKd8V9VWMXAkithBvvdrDsHiB56lZaPDY9mmhrmgr5fBybFe
        DdMYI4QTSt8b+xHXdXWu526r+sUi5fzX9srxivDrUDgn
X-Google-Smtp-Source: AGHT+IHGb5T1Tjsn2NDbFSsu++9csRaaO97POdLeDCVVirsyx83kvphtEll/o76pdM1pmmV6U7zau4teA/GgQfxY/S0=
X-Received: by 2002:a05:6870:f602:b0:1e9:9bec:c01d with SMTP id
 ek2-20020a056870f60200b001e99becc01dmr5837083oab.6.1699544451085; Thu, 09 Nov
 2023 07:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20231108065436.13969-1-jose.pekkarinen@foxhound.fi>
 <2023110835-magnolia-prune-02d0@gregkh> <1b20f2e4ddc0b0e94aa9a1f9c76ff75c@foxhound.fi>
 <2023110916-tinfoil-concur-77d8@gregkh> <ee757d648a601ba3530e0eeb1c5d178e@foxhound.fi>
In-Reply-To: <ee757d648a601ba3530e0eeb1c5d178e@foxhound.fi>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 9 Nov 2023 10:40:39 -0500
Message-ID: <CADnq5_PGyR=6iyFNrmjcimFc+y7ietqVybV89z3zqUcxbkJSNA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array members
To:     =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Xinhui.Pan@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org,
        alexander.deucher@amd.com, evan.quan@amd.com,
        christian.koenig@amd.com, linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 7:14=E2=80=AFAM Jos=C3=A9 Pekkarinen
<jose.pekkarinen@foxhound.fi> wrote:
>
> On 2023-11-09 11:06, Greg KH wrote:
> > On Thu, Nov 09, 2023 at 10:43:50AM +0200, Jos=C3=A9 Pekkarinen wrote:
> >> On 2023-11-08 09:29, Greg KH wrote:
> >> > On Wed, Nov 08, 2023 at 08:54:35AM +0200, Jos=C3=A9 Pekkarinen wrote=
:
> >> > > The following case seems to be safe to be replaced with a flexible
> >> > > array
> >> > > to clean up the added coccinelle warning. This patch will just do =
it.
> >> > >
> >> > > drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h:76:38-63:
> >> > > WARNING use flexible-array member instead (https://www.kernel.org/=
doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> >> > >
> >> > > Signed-off-by: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> >> > > ---
> >> > >  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h | 2 +-
> >> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > >
> >> > > diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> >> > > b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> >> > > index c7b61222d258..1ce4087005f0 100644
> >> > > --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> >> > > +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.h
> >> > > @@ -73,7 +73,7 @@ struct smu8_register_index_data_pair {
> >> > >
> >> > >  struct smu8_ih_meta_data {
> >> > >          uint32_t command;
> >> > > -        struct smu8_register_index_data_pair register_index_value=
_pair[1];
> >> > > +        struct smu8_register_index_data_pair register_index_value=
_pair[];
> >> >
> >> > Did you just change this structure size without any need to change a=
ny
> >> > code as well?  How was this tested?
> >>
> >>     I didn't find any use of that struct member, if I missed
> >> something here, please let me know and I'll happily address any
> >> needed further work.
> >
> > I don't think this is even a variable array.  It's just a one element
> > one, which is fine, don't be confused by the coccinelle "warning" here,
> > it's fired many false-positives and you need to verify this properly
> > with the driver authors first before changing anything.
>
>       My apologies to you, and anybody that feels the same, it is not my
> intention to bother with mistaken patches, I just assume that this patch
> or any other from me, will go to review process, where it should be fine
> if the patch is right, wrong, need further work, or further testing
> either
> from my side or anybody else, and at the end of the day I need to do
> patches if I want to find my mentorship patches, and graduate.
>
> > In short, you just changed the size of this structure, are you _sure_
> > you can do that?  And yes, it doesn't look like this field is used, but
> > the structure is, so be careful.
>
>      I don't know, let check it out together and see where this goes.

I think it may have been used with the SMU firmware.  I'll need to
check with that team to determine if this was meant to be a variable
sized array or not.

Alex
