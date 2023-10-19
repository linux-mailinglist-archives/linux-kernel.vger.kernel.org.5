Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160577CEE42
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJSCyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670C95
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697684031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YbD/Q6ufbnNB3XAdhgE8oF7W+MQMG5bePwJCf8IlXBE=;
        b=B42Nir42UNzJ+nVD9dZTkFX75Z54K5f0cbWkoTtPorZLUAxpgkNtSTlqKvvWdzd8l2YFLr
        /V8p5RXiuWnMmuUe8FakrJLsA9KJtuLd7AQaZ2+ZeOA67+B7bqpc/KQbJw6ODmI/YzRbjg
        lkw2OnD9f07YX0Fu/gq9m+Smwsp4UY4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-o-7OFhm1N52gB9xCLcjiig-1; Wed, 18 Oct 2023 22:53:44 -0400
X-MC-Unique: o-7OFhm1N52gB9xCLcjiig-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507be692ce4so2603711e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697684023; x=1698288823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbD/Q6ufbnNB3XAdhgE8oF7W+MQMG5bePwJCf8IlXBE=;
        b=e7br9mMKy0T07tt+RgIAVHArA7RR9vVKOrOckXohT0APDoBtkUt3tUmi4ziojAgIXs
         nUULcv/QeiVKIdd4pJn61RLHgBYUL8e/iHU6/i5Vsj1zHkYDfx9O9+YeHt4Q7sfL7NBr
         zwP/lJw2Z4/J7L16h9GWN02CPL146SilSH7MhueHAmaJ0l7+7UwSOKJteyLTfI+cUZ0y
         MHeaWAx6mSMiA6AW2Omcd8+hzV+xUsNGhaIw+w3Px3DD76E3jtuOa+XlV+bLVgkopawP
         g+WOQbuXY1l6yB02nn3+TX2jWaLDdp4GqeVmYpvXxxg/clTOARx7qQS7IU6mIQiOYkXO
         TrGA==
X-Gm-Message-State: AOJu0YyVw5i+OZKxn6Zc+Vl1Pghi0qHcPw1MOjygOwETviZ8YVJfZwsg
        TB2HLWvYcNmwkVvu8AooolSXUXBLsCdVfsfUYBU1Ngqdp6kg9mgrMutcmu3jfu6RelLY9/5nY/G
        lsDtr7QkD1m0hr0bw9SS+Sbgo3LBuznbUY7d481Z2
X-Received: by 2002:ac2:4c08:0:b0:503:1913:ed8e with SMTP id t8-20020ac24c08000000b005031913ed8emr421714lfq.61.1697684023489;
        Wed, 18 Oct 2023 19:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc85HsbiaIk2VZkqptEI+PmzYF3FWWNi9G2ZmlHLHpwyPIJ1ic9T6Flkrq70D3hKlk1SxLp6WajJwV6MuFuxc=
X-Received: by 2002:ac2:4c08:0:b0:503:1913:ed8e with SMTP id
 t8-20020ac24c08000000b005031913ed8emr421711lfq.61.1697684023116; Wed, 18 Oct
 2023 19:53:43 -0700 (PDT)
MIME-Version: 1.0
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com> <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com> <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com> <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com> <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com> <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
In-Reply-To: <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 Oct 2023 10:53:31 +0800
Message-ID: <CACGkMEvebhMo5dfcyq2MFhBvFVNbwrqVofJXaBe9Vmn1O4qVjA@mail.gmail.com>
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 4:49=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
>
>
> On 10/18/2023 12:00 AM, Jason Wang wrote:
> >> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
> >> don't have a better choice. Or we can fail the probe if userspace
> >> doesn't ack this feature.
> > Antoher idea we can just do the following in vhost_vdpa reset?
> >
> > config->reset()
> > if (IOTLB_PERSIST is not set) {
> >      config->reset_map()
> > }
> >
> > Then we don't have the burden to maintain them in the parent?
> >
> > Thanks
> Please see my earlier response in the other email, thanks.
>
> ----------------%<----------------%<----------------
>
> First, the ideal fix would be to leave this reset_vendor_mappings()
> emulation code on the individual driver itself, which already has the
> broken behavior.

So the point is, not about whether the existing behavior is "broken"
or not. It's about whether we could stick to the old behaviour without
too much cost. And I believe we could.

And just to clarify here, reset_vendor_mappings() =3D config->reset_map()

> But today there's no backend feature negotiation
> between vhost-vdpa and the parent driver. Do we want to send down the
> acked_backend_features to parent drivers?

There's no need to do that with the above code, or anything I missed here?

config->reset()
if (IOTLB_PERSIST is not set) {
      config->reset_map()
}

>
> Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of
> backend feature negotiation in parent driver, if vhost-vdpa has to
> provide the old-behaviour emulation for compatibility on driver's
> behalf, it needs to be done per-driver basis. There could be good
> on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in
> .reset, and vendor specific IOMMU doesn't have to provide .reset_map,

Then we just don't offer IOTLB_PRESIST, isn't this by design?

> we
> should allow these good driver implementations rather than
> unconditionally stick to some specific problematic behavior for every
> other good driver.

Then you can force reset_map() with set_map() that is what I suggest
in another thread, no?

> Then we need a set of device flags (backend_features
> bit again?) to indicate the specific driver needs upper layer's help on
> old-behaviour emulation.
>
> Last but not least, I'm not sure how to properly emulate
> reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no
> .reset_map op implemented, or if .reset_map has a slightly different
> implementation than what it used to reset the iotlb in the .reset op,

See above, for reset_vendor_mappings() I meant config->reset_map() exactly.

Thanks

> then this either becomes effectively dead code if no one ends up using,
> or the vhost-vdpa emulation is helpless and limited in scope, unable to
> cover all the cases.
>
> ----------------%<----------------%<----------------
>

