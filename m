Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F29180E270
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345776AbjLLDCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:02:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93436BC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702350128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NcUhW82kVg4Fgb3Dq1SvC66NLPOJJ84gCXl550jBOg=;
        b=YTAQLKmeRK52CKGEKwZvDgFRDUiOtUz0V6bQEdXiPYfn6dY/0pCCXCtrnhwMxVVih6uQj5
        3VQHz7sbTBhuTu2qQNfzp4GM1zMwNpMUKHOxjObviOQ/j1AHjEricSwPdILkPuoz5QZW7m
        buVzfXnfmzP4njL3LzsJ2/YtFBR8YBY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-h2tEYMXiPDOuYJTnXNXyrQ-1; Mon, 11 Dec 2023 22:02:07 -0500
X-MC-Unique: h2tEYMXiPDOuYJTnXNXyrQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-286ecc0e220so6170385a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702350126; x=1702954926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NcUhW82kVg4Fgb3Dq1SvC66NLPOJJ84gCXl550jBOg=;
        b=XkiivduKQiIXtxYDGb2pRXdtdBIYXtt1gHzZNfXR9GTR2y5/Fm54yExcBHH9KhXCwc
         0NiGGGg4OWdYfpFnkhN4T/RT/gkW81wnfQzJ3YDl23fNsHBferVxYUl9F2Gka1zz7B5x
         ht9/3nToRNeKoYbx7pnCZoZS76D6xyNH9leNnUeXJ5ViqR9NKxbNNWD6cszBFxdc7X29
         8AqAqkrQzWvyEDKxWlnOHllibHy9XAwI3QdDCRwJYvlptwBaxQl9JTOyE6HouP2KsYUw
         DKhtADMUNjMD6QzJEYmj4vSEA8/YmxV/BKTvklHfBTda2jVFwL2zWQj/mvetUsuEHyIE
         qh9w==
X-Gm-Message-State: AOJu0YyXjaOztuHfWCwrRZqULWd5L0twBKm4B7ml6rKHYJFl30ymkKLD
        ycwhlvnV4Oc4Wrda5fgvz0JgsaL6n6sAvxcHAzAEnEHQatekpkNapL7V+zlfqtDmiQFgPKoXlWl
        A9DTiYpOx6kRmpC+LttUP9Ha0fKjaUOU3E/48pRP5DEBc9UMTUfA=
X-Received: by 2002:a17:90b:152:b0:286:db83:a092 with SMTP id em18-20020a17090b015200b00286db83a092mr4170420pjb.20.1702350125880;
        Mon, 11 Dec 2023 19:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGo0L3DeFF6N2EfhNxrYtxwbIS2B3jOa/l8pkOd4cweE+LAc92ES33i4Vds/ETJ1R24YNUMPLgjbPbXCLyTOg=
X-Received: by 2002:a17:90b:152:b0:286:db83:a092 with SMTP id
 em18-20020a17090b015200b00286db83a092mr4170415pjb.20.1702350125585; Mon, 11
 Dec 2023 19:02:05 -0800 (PST)
MIME-Version: 1.0
References: <20231208070754.3132339-1-stevensd@chromium.org> <20231211113710-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231211113710-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Dec 2023 11:01:53 +0800
Message-ID: <CACGkMEs_MajTFxGVcK5R8oqQzTxuL4Pm=uUnOonDczWzqaucsw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Stevens <stevensd@chromium.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 12:37=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> > If a virtio_pci_device supports native PCI power management and has the
> > No_Soft_Reset bit set, then skip resetting and reinitializing the devic=
e
> > when suspending and restoring the device. This allows system-wide low
> > power states like s2idle to be used in systems with stateful virtio
> > devices that can't simply be re-initialized (e.g. virtio-fs).
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
>
> tagged, thanks!
> I'm still debating with myself whether we can classify this
> as a bugfix ... better not risk it I guess.

It might be suitable if there's a hypervisor that advertises
no_soft_reset (but it seems Qemu doesn't).

Thanks

>
> > ---
> > v1 -> v2:
> >  - Check the No_Soft_Reset bit
> >
> >  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index c2524a7207cf..3a95ecaf12dc 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
> >       return virtio_device_restore(&vp_dev->vdev);
> >  }
> >
> > +static bool vp_supports_pm_no_reset(struct device *dev)
> > +{
> > +     struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > +     u16 pmcsr;
> > +
> > +     if (!pci_dev->pm_cap)
> > +             return false;
> > +
> > +     pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmc=
sr);
> > +     if (PCI_POSSIBLE_ERROR(pmcsr)) {
> > +             dev_err(dev, "Unable to query pmcsr");
> > +             return false;
> > +     }
> > +
> > +     return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> > +}
> > +
> > +static int virtio_pci_suspend(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> > +}
> > +
> > +static int virtio_pci_resume(struct device *dev)
> > +{
> > +     return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev)=
;
> > +}
> > +
> >  static const struct dev_pm_ops virtio_pci_pm_ops =3D {
> > -     SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> > +     .suspend =3D virtio_pci_suspend,
> > +     .resume =3D virtio_pci_resume,
> > +     .freeze =3D virtio_pci_freeze,
> > +     .thaw =3D virtio_pci_restore,
> > +     .poweroff =3D virtio_pci_freeze,
> > +     .restore =3D virtio_pci_restore,
> >  };
> >  #endif
> >
> > --
> > 2.43.0.472.g3155946c3a-goog
>

