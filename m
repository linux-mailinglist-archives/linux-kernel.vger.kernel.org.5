Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE157617DD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjGYL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGYL7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F951FC1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690286328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKY2MPeb4smYu5MumkdrZH64DY2ngZB1voGt9dh+JFo=;
        b=EN1xA8aiKg6G7QRsDOisloPj3gmnPObgZubme5pSgLoTSTVjuEh/UrGorNT0yrAlmJGT/C
        DCNd3cxy4MLxbd7fP1ZhSIK2irt4mOgaZafvkWlEEn6jHNKFpoXZ2N29I4KE8SeR19ZJgo
        SuByPYrI/1YgvJIi+R6PbqVhrloXq44=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-2e1dUen9O_S2LTm_YzNdpQ-1; Tue, 25 Jul 2023 07:58:45 -0400
X-MC-Unique: 2e1dUen9O_S2LTm_YzNdpQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-997d144f31dso320025866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 04:58:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690286322; x=1690891122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKY2MPeb4smYu5MumkdrZH64DY2ngZB1voGt9dh+JFo=;
        b=P7K4Z9jGtcjSMhIndT8PEjgsKuCF4vQakzJDE9cJlH3KEyxcu3E1QwtVaDmT5VvscN
         Sc+Z4Oovt5ZYMO1oMbxe030nEMipIcsnUZZWP6FWMMr5h9EPyGUf/kvfmn3Yld18rotA
         SCXEoKOaXaaHJoGrMKZ7Fcf4DBhhjh3PE6Kk9LPSmNiPf7bfOonZHtfrMwlvB5VZ1P24
         86vw/yTYR+818pP7xl7Qk7kdkDW78lIz55gpQycb5BRgrRJIR7MhvCm5yJNiI3GzcQq2
         W+bt50jI54VXWrtx3EYehCofDvYvbUGCUAhSmHBV/MjXjhXDPvk4b5cTHJVq3vFchfAW
         lRxA==
X-Gm-Message-State: ABy/qLah6D+lGZsoJxw5SxwgO0PD13Y/D4QgU6iRcmWGVeabldpqO7gw
        fuST3MIJCaV/Bg2SxvPO3PsoZGmcCOT0KRWEPGa5Gvlz5WRr0NXftnSgGCKNHTORq7g3It59Mzr
        xqPO4VvPekKuBs4iEo8PG1tR2b0mWkEe9
X-Received: by 2002:a17:907:2bd7:b0:94e:4489:f24d with SMTP id gv23-20020a1709072bd700b0094e4489f24dmr13455010ejc.61.1690286322745;
        Tue, 25 Jul 2023 04:58:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF8XjFaubLjf5xjlqvjWeOHrAsSfNf1ItjGgd+HwNMXv4SAHImD2/nVnuly/gLkvw5uOJLVtw==
X-Received: by 2002:a17:907:2bd7:b0:94e:4489:f24d with SMTP id gv23-20020a1709072bd700b0094e4489f24dmr13454996ejc.61.1690286322505;
        Tue, 25 Jul 2023 04:58:42 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id pk4-20020a170906d7a400b00993004239a4sm8086695ejb.215.2023.07.25.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 04:58:41 -0700 (PDT)
Date:   Tue, 25 Jul 2023 13:58:40 +0200
From:   Igor Mammedov <imammedo@redhat.com>
To:     Woody Suwalski <terraluna977@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, mst@redhat.com
Subject: Re: [PATCH] hack to debug acpiphp crash
Message-ID: <20230725135840.1edbbf61@imammedo.users.ipa.redhat.com>
In-Reply-To: <d1333a63-c6b8-fe9a-24ce-05d2198323c2@gmail.com>
References: <11fc981c-af49-ce64-6b43-3e282728bd1a@gmail.com>
        <20230724135902.2217991-1-imammedo@redhat.com>
        <92150d8d-8a3a-d600-a996-f60a8e4c876c@gmail.com>
        <20230725100644.6138efb6@imammedo.users.ipa.redhat.com>
        <20230725104237.0c8d0dc1@imammedo.users.ipa.redhat.com>
        <d1333a63-c6b8-fe9a-24ce-05d2198323c2@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 07:45:08 -0400
Woody Suwalski <terraluna977@gmail.com> wrote:

> Igor Mammedov wrote:
> > On Tue, 25 Jul 2023 10:06:44 +0200
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >  
> >> PS:
> >> What happens is that on resume firmware (likely EC),
> >> issues ACPI bus check on root ports which (bus check) is
> >> wired to acpiphp module (though pciehp module was initialized
> >> at boot to manage root ports), it's likely firmware bug.
> >>
> >> I'd guess the intent behind this was to check if PCIe devices
> >> were hotplugged while laptop has been asleep, and for
> >> some reason they didn't use native PCIe hotplug to handle that.
> >> However looking at laptop specs you can't hotplug PCIe
> >> devices via external ports. Given how old laptop is
> >> it isn't going to be fixed, so we would need a workaround
> >> or fixup DSDT to skip buscheck.
> >>
> >> The options I see is to keep old kernel as for such case,
> >> or bail out early from bus check/enable_slot since root port
> >> is managed by pciehp module (and let it handle hotplug).  
> > scratch all of above out (it's wrong). Looking at DSDT
> > firmware sends Notify(rpxx, 2 /* Wake */) event. Which
> > according to spec needs to be handed down to the native
> > device driver.
> >
> >  
> I agree that this laptop is a tricky one. I had to adjust my kernel 
> config NOHZ just to make it suspend to ram, otherwise it was waking back 
> right after going to sleep (and the same nohz kernel worked on all my 
> other machines)...

Blaming laptop is likely red herring in this case after some more reading.
Anyways I've just sent a new round of patches to test.

