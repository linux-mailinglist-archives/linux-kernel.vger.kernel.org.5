Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A8783646
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 01:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjHUXbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 19:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjHUXbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 19:31:00 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D218E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:30:48 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-649edb3a3d6so17137246d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692660647; x=1693265447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRPhHLIFOC8+rZAMEC/eSxC1aQDd+7O3GdPrzvXAbeU=;
        b=FCO2jOTgybSwTEOoBWlDWVWb9EZGWHeqf3Y3WsTPfn2u6Pq2f9IowLNNIZjHp9UJO6
         vX/O9IWM8KxCSlXHDVdJd0vUdhqEosYyse6NhcR7Qo3sjd9gSeeOSDwxEA5qAUX1ag5J
         zYdl7C2+SeEmOzMDIZvDtbSJyRQC7wa3IgR6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692660647; x=1693265447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRPhHLIFOC8+rZAMEC/eSxC1aQDd+7O3GdPrzvXAbeU=;
        b=SkJy4uDDBhHGZE0HYUcPrcNKybgk3hyeEK9NUWdK3ysgJv9pGSggdzKFnN0O+J+FJr
         7XRwNpchGP7DBgDkn0FfJvs91Vv/5XbuJmXn6U7HwzR9mRBu0orFSw5fLHYID0xZZHnJ
         lQNEdOGd5ECS7b9f7ihT/42fDgngGmwaZNjV0kytYRof6wfaeW4UDFkRoL3B3Y2XqHrW
         FIHVUX0GTWR/jbRRK9NKPnxwweOHmO6h9/PK2IKMHKeC+nZMSxgrNJ747MS7qfYm5VGx
         iouCvLJdc1/s4nHpy5nPiZkvW2uRAUumuo4E4tjtpvBI2xf/lV/DqE4Hl0K39WTTDEOV
         LWqg==
X-Gm-Message-State: AOJu0YwgmdnJfGeNA3TffCDN+OOG5bnMf+QOSH9x4StZfOWeacKtkv5h
        wJOvZlq2hUklOkjaSm3GSElSkYDeoDHCWTGfGUlbwg==
X-Google-Smtp-Source: AGHT+IGrcSNzfqiuuSO6RekCnVY3lNO5U5gzbH6kH8e4H8ETUqnnzFAsUZP1EsPplBf++yOTPrLHRmenNM1FN3B2hiU=
X-Received: by 2002:a05:6214:29e8:b0:637:2eb:6c23 with SMTP id
 jv8-20020a05621429e800b0063702eb6c23mr222336qvb.18.1692660647465; Mon, 21 Aug
 2023 16:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230718024703.1013367-1-utkarsh.h.patel@intel.com>
 <20230718024703.1013367-2-utkarsh.h.patel@intel.com> <ZN+j/z97Yy0wv/if@chromium.org>
 <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB0048DAF02954ACC66C026533A91EA@MWHPR11MB0048.namprd11.prod.outlook.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 21 Aug 2023 16:30:36 -0700
Message-ID: <CACeCKacWhrZE6LFFwF=vDO8362u9feN71pPO8Qr8XoaRgwj5uw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 10:18=E2=80=AFAM Patel, Utkarsh H
<utkarsh.h.patel@intel.com> wrote:
>
> Hi Prashant,
>
> Thank you for the review.
>
> > -----Original Message-----
> > From: Prashant Malani <pmalani@chromium.org>
> > Sent: Friday, August 18, 2023 10:02 AM
> > To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> > Cc: linux-kernel@vger.kernel.org; linux-usb@vger.kernel.org;
> > heikki.krogerus@linux.intel.com; bleung@chromium.org
> > Subject: Re: [PATCH v4 1/2] platform/chrome: cros_ec_typec: Configure
> > Retimer cable type
> >
> > >  /*
> > >   * Spoof the VDOs that were likely communicated by the partner for T=
BT alt
> > >   * mode.
> > > @@ -432,6 +453,9 @@ static int cros_typec_enable_tbt(struct
> > > cros_typec_data *typec,
> > >
> > >     /* Cable Discover Mode VDO */
> > >     data.cable_mode =3D TBT_MODE;
> > > +
> > > +   data.cable_mode |=3D cros_typec_get_cable_vdo(port,
> > > +USB_TYPEC_TBT_SID);
> > > +

Here is the first call to cros_typec_get_cable_vdo(port, TBT)....

> > >     data.cable_mode |=3D TBT_SET_CABLE_SPEED(pd_ctrl->cable_speed);
> > >
> > >     if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE) @@ -
> > 522,8
> > > +546,10 @@ static int cros_typec_enable_usb4(struct cros_typec_data
> > *typec,
> > >     /* Cable Type */
> > >     if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
> > >             data.eudo |=3D EUDO_CABLE_TYPE_OPTICAL <<
> > EUDO_CABLE_TYPE_SHIFT;
> > > -   else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
> > > +   else if (cros_typec_get_cable_vdo(port, USB_TYPEC_TBT_SID) &
> > > +TBT_CABLE_RETIMER)

And here is the 2nd.

> > >             data.eudo |=3D EUDO_CABLE_TYPE_RE_TIMER <<
> > EUDO_CABLE_TYPE_SHIFT;
> > We shouldn't need to call cros_typec_get_cable_vdo more than once. Eith=
er
> > call it once earlier when you are crafting the data.cable_mode member a=
nd
> > then re-use that variable here. Or don't call it there and just call it=
 here.
>
> We are only calling it once depending upon which mode we enter TBT Alt or=
 USB4.

There should only be 1 "call site" and that should be sufficient to
grab the VDO from the
framework for all circumstances. Whether the other invocation doesn't get c=
alled
under certain circumstances isn't as relevant.
