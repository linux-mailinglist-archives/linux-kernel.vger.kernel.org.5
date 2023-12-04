Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ACF802E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343621AbjLDIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjLDIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F88A4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 00:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701679684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1O1GHkZ2Qe7CcODotGlaFEj1pA1PKM1puCHikGn9aeQ=;
        b=S2SvPfDuELzRzONtyUTByXhBQgumhnCzcKZPkn+brvRTulegrbRXsBazaf7e/p5mQNPuag
        YiPtKPPXmiZ7ANnhClO/Z6l3a9GQ0cEztDzBKQurulZR8VXocl7oUqnGTbcxANN+3hO6Zw
        l5nMYxKUh0zZuYOWPeMEccbHY+Pa7aQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-HFNOY1cAPGaL1bgsQpnzAw-1; Mon, 04 Dec 2023 03:48:03 -0500
X-MC-Unique: HFNOY1cAPGaL1bgsQpnzAw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bec76ae18so1186843e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 00:48:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701679681; x=1702284481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O1GHkZ2Qe7CcODotGlaFEj1pA1PKM1puCHikGn9aeQ=;
        b=avE4oXaLaD6ktRYdRM1c2Wj7CmKcdWOnkOXkBEPYh/PDR3HrcXsP45LSw8z55/aAAj
         DrL4donkq0wMXCZYAwE2v8+659T4pjyTp6vgn3iiggNfto4cxlBmrxFLCMC+RX3bAPMr
         YFqM05co6/vn9f4H02p9GCvKN178Mk95ZQhQxiIhOxESABGr1IagO+hWfScwVSa8t6a3
         2OvJqs2mVjLmAJoewwziYXdSy5uUZ8ZB2yQaLLgmg3JwuZgoEjHI8/ky0+1eGLrOqEGg
         P3TGGc6iiLwHiPgGODIGDATHWB8RV99kqe3IB+uXQ42MdC7wZjEZHUB0T7f5mz2FucWM
         gTxw==
X-Gm-Message-State: AOJu0YwtnvV4pKu+MYFQ3knZ8GcS6FHhWn3hbmwk6aMmWOHY4ypWENTE
        yDbVMzBf8G8Drwcyvfd2WAZXbtRmzvi+vM7fNKKQ6QKGDBEF6tW1uY9qEpC4dtH/Cz+/2Jm+pAA
        NBQwO1lVoR0oPo1b0SNnPazFVI4rAUPmt2u+UDFTP
X-Received: by 2002:a05:6512:31c4:b0:50b:d764:9682 with SMTP id j4-20020a05651231c400b0050bd7649682mr3453479lfe.102.1701679681535;
        Mon, 04 Dec 2023 00:48:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNpyZl3CwMVFLh53IQjaLkzKjbxZ1SQYuv9EPSLS5561Kpl2BVkIh6xEnVf/SBfcuxpc2n7FrGmD2cINj4zVM=
X-Received: by 2002:a05:6512:31c4:b0:50b:d764:9682 with SMTP id
 j4-20020a05651231c400b0050bd7649682mr3453465lfe.102.1701679681197; Mon, 04
 Dec 2023 00:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20231102143507.840-1-jiangkunkun@huawei.com> <87msvt6cc7.wl-maz@kernel.org>
 <1fb8353e-e9c4-2570-c2ca-ec537c18ac4d@huawei.com> <86edh228xx.wl-maz@kernel.org>
 <952bd5dc-dd20-acc3-d77e-c9b14e5728d3@huawei.com> <87fs0k94og.wl-maz@kernel.org>
 <CACGkMEt5sapZjpyBSM5oX_=k1AcefEe5D4wtX=HqtHy4AD3j_g@mail.gmail.com>
In-Reply-To: <CACGkMEt5sapZjpyBSM5oX_=k1AcefEe5D4wtX=HqtHy4AD3j_g@mail.gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 4 Dec 2023 16:47:49 +0800
Message-ID: <CACGkMEub4f0FWsrJzSK4e+9cC6LUNFm3vAcfSkpsp6pD=WM5qA@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm/arm64: GICv4: Support shared VLPI
To:     Marc Zyngier <maz@kernel.org>
Cc:     Kunkun Jiang <jiangkunkun@huawei.com>, dongli.zhang@oracle.com,
        cohuck@redhat.com, stefanha@redhat.com, mst@redhat.com,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "open list:IRQCHIP DRIVERS" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        wanghaibin.wang@huawei.com
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

On Mon, Dec 4, 2023 at 4:39=E2=80=AFPM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Sat, Dec 2, 2023 at 8:20=E2=80=AFPM Marc Zyngier <maz@kernel.org> wrot=
e:
> >
> > Hi Kunkun,
> >
> > On Wed, 08 Nov 2023 09:45:51 +0000,
> > Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> > >
> > > Hi Marc,
> > >
> > > On 2023/11/6 23:33, Marc Zyngier wrote:
> > > > On Mon, 06 Nov 2023 14:59:01 +0000,
> > > > Kunkun Jiang <jiangkunkun@huawei.com> wrote:
> > > >> The virtio-pci driver write entry1-6
> > > >> massage.data in the msix-table and trap to QEMU for processing. Th=
e
> > > >> massage.data is as follow:
> > > >>> entry-0 0
> > > >>> entry-1 1
> > > >>> entry-2 1
> > > >>> entry-3 1
> > > >>> entry-4 1
> > > >>> entry-5 1
> > > >>> entry-6 1
>
> It looks like a bug from the driver. It should only use vector 0 and 1
> in this case.
>
> Could you please check the queue_msix_vector for each queue in this case?

Or did you actually mean queue_msix_vector here? I'm not familiar with
ARM but 0 doesn't seem to be a good message.data anyhow.

Thanks

