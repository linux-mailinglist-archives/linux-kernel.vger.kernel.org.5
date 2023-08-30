Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC44E78DDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjH3Syd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244620AbjH3Nb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03201B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693402239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
        b=Oi4msi9VB3j0ZgJuqCfU42WZObDCxWJQgAsZSl+Ouk+H2iUVnUXEzIGaL5vwsQk/KvfAk+
        Sr4GcZdrMPg08zs5kLCFGQoaMKuXUfz9yJjGHRsG29qALHoCv4Fb+tdDPJPSONkvCBUdry
        EIquKv6LZqSAsIYytV/oq6fMaN3Xd9c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-gR0P0xu6OIuwaV7qYvrhCA-1; Wed, 30 Aug 2023 09:30:38 -0400
X-MC-Unique: gR0P0xu6OIuwaV7qYvrhCA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a355cf318so428861666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402237; x=1694007037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrmtevR+OHspc/c545A2F7OAMYEjllnCprVaLeVCRbQ=;
        b=Y2QiYCQB7m1w+7iYKIhkDvrflt1hrp9rBH5DtphfC0E2mBFSggjdv4/6sZ/wmTWnez
         MD/+ZCFRLRtfgpDktnm3drE6MHBLCbaWeS5aVHgXLFY3cZppiHGcUurnSZwRezVVQN8d
         1GxH7drzcPeHluNEh01vcASEPvD++J288JrbH0LMkLG8vCygNnFG8+Z37psWyYNxElue
         IdbjRhjWVIHRcBUHHenab1oLcBJzPY1vICbmrnvpcqI+Q4Z41kj1fmiAiwmfjlMwJnRQ
         34ymlNvZINgU0PuHCd9zKrUWgGhCjrgzE8EqqzmEcmZQpIWogn4AChB/kvFu5WNNuhGU
         /RTw==
X-Gm-Message-State: AOJu0Yxfsbthoh6vjyBtYpGSKgBnDOqR/qNvmluCGAv7wZkuhay5AAiq
        S+IdEnCp/vACRcq+/6jCvkn1ZXVykvMxC2fG57EBCWNk2g2WgHSjQRIluG09VVtPxrPt3zcnUTN
        onpkehLFxXZizmnlgtdFK4pNK
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id 11-20020a170906008b00b009a57887ef09mr1872773ejc.32.1693402237183;
        Wed, 30 Aug 2023 06:30:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYxUHeyUiFVorh4ZDehN292nCkRvDukdS6QYJWdvud4F+ML6iNTqT9rYxTEkbhUobIqpPlWg==
X-Received: by 2002:a17:906:8b:b0:9a5:7887:ef09 with SMTP id 11-20020a170906008b00b009a57887ef09mr1872753ejc.32.1693402236839;
        Wed, 30 Aug 2023 06:30:36 -0700 (PDT)
Received: from redhat.com ([2.55.167.22])
        by smtp.gmail.com with ESMTPSA id ju26-20020a17090798ba00b00982a352f078sm7183100ejc.124.2023.08.30.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:30:35 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:30:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Maxime Coquelin <maxime.coquelin@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, xieyongji@bytedance.com,
        jasowang@redhat.com, david.marchand@redhat.com, lulu@redhat.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230830091607-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
 <20230810150347-mutt-send-email-mst@kernel.org>
 <20230810142949.074c9430@kernel.org>
 <20230810174021-mutt-send-email-mst@kernel.org>
 <20230810150054.7baf34b7@kernel.org>
 <ad2b2f93-3598-cffc-0f0d-fe20b2444011@redhat.com>
 <20230829130430-mutt-send-email-mst@kernel.org>
 <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651476f1-ccae-0ba1-4778-1a63f34aa65d@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:27:18PM +0200, Maxime Coquelin wrote:
> 
> 
> On 8/29/23 19:05, Michael S. Tsirkin wrote:
> > On Tue, Aug 29, 2023 at 03:34:06PM +0200, Maxime Coquelin wrote:
> > > 
> > > 
> > > On 8/11/23 00:00, Jakub Kicinski wrote:
> > > > On Thu, 10 Aug 2023 17:42:11 -0400 Michael S. Tsirkin wrote:
> > > > > > Directly into the stack? I thought VDUSE is vDPA in user space,
> > > > > > meaning to get to the kernel the packet has to first go thru
> > > > > > a virtio-net instance.
> > > > > 
> > > > > yes. is that a sufficient filter in your opinion?
> > > > 
> > > > Yes, the ability to create the device feels stronger than CAP_NET_RAW,
> > > > and a bit tangential to CAP_NET_ADMIN. But I don't have much practical
> > > > experience with virt so no strong opinion, perhaps it does make sense
> > > > for someone's deployment? Dunno..
> > > > 
> > > 
> > > I'm not sure CAP_NET_ADMIN should be required for creating the VDUSE
> > > devices, as the device could be attached to vhost-vDPA and so not
> > > visible to the Kernel networking stack.
> > > 
> > > However, CAP_NET_ADMIN should be required to attach the VDUSE device to
> > > virtio-vdpa/virtio-net.
> > > 
> > > Does that make sense?
> > > 
> > > Maxime
> > 
> > OK. How are we going to enforce it?
> 
> Actually, it seems already enforced for all VDPA devices types.
> Indeed, the VDPA_CMD_DEV_NEW Netlink command used to add the device to
> the VDPA bus has the GENL_ADMIN_PERM flag set, and so require
> CAT_NET_ADMIN.

Hmm good point. Pity I didn't notice earlier. Oh well there's always
the next release.

> > Also, we need a way for selinux to enable/disable some of these things
> > but not others.
> 
> Ok, I can do it in a patch on top.
> Do you have a pointer where it is done for Virtio Block devices?
> 
> Maxime

It's not done yet - at the moment vduse device is always block so we
didn't need the distinction.

-- 
MST

