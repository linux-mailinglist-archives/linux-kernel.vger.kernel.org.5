Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396797CF523
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 12:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345258AbjJSKZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbjJSKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 06:25:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D94129
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697711104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XntUvuhro1ALXornIv7c5rBfNf1FPsxFvHaqSzLuXQ=;
        b=TYM0CCuWNi9Lm5jqJynuUVpuGA6a3MJi4ZXAfe07N+0x/uBThG2d355Y/tv9bhDXdDIRHt
        2dfaiu2ZIjcqBWpJOaymobRWMXrT7r5yneErAS6kyGCnOTBB5FFn2urQVaRw/P509Vtxwt
        09iaSTN07/7Fc5chWGygUHJn1a7NJxU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-UrXD5yDUPka8mrcioWTlbw-1; Thu, 19 Oct 2023 06:25:03 -0400
X-MC-Unique: UrXD5yDUPka8mrcioWTlbw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53eaedf5711so704825a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 03:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697711102; x=1698315902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XntUvuhro1ALXornIv7c5rBfNf1FPsxFvHaqSzLuXQ=;
        b=uSrpObXl6S5MUBbl3ZIsOVNynGfjWVwtdr3JV6M0xkQH2QVZn7TKc2mBDYVmCnFUAr
         2zzkb8dVe5/pCgwFiNmjYF59rjhQ9lkSpeaUoz7eHCw69aPeKyNdmP/YISdWyWp3v2AJ
         3nDG/jj32xUAbMSIu+TsnIvPOxhuHeUewDqrZnqhWFQrm3N+sbY/FonH4fvrav9k+R+8
         tq7hyWy/+jeVGo0FLFzWSBJyLeqHeS2KtCcE6rVL8+HGqMH3r7KIlNl/+HVE4V2cJ4t5
         /zUN+w7FZ20ityP3d9t1EwD3u7lbAxoxiuTu32pULcxobI9wJZb1cNBFQtqgo0ZpawbU
         AwXA==
X-Gm-Message-State: AOJu0Yyl6PZomla+v46A9hmuhCCnAo1W7Zj8S4+G7jwilFVzXU2t82TX
        LGQlP7V4l+Bt/hwkML5XxBnbkIAutSk3a4qegDtSsNxtju9kzGEDuvMJiI/mj8mUrWSlEgb4XPh
        RV+OUeNhFP3m860OJ11zMPCDN
X-Received: by 2002:a50:c359:0:b0:53f:1aff:4dc2 with SMTP id q25-20020a50c359000000b0053f1aff4dc2mr1251334edb.4.1697711102122;
        Thu, 19 Oct 2023 03:25:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGF/kxTzU+9JHxinXDTjDZm13nI6jLL/SOYN5tFsvK+CZA1Q2UYBbHY6ENsgHZX0due/fqSyA==
X-Received: by 2002:a50:c359:0:b0:53f:1aff:4dc2 with SMTP id q25-20020a50c359000000b0053f1aff4dc2mr1251321edb.4.1697711101772;
        Thu, 19 Oct 2023 03:25:01 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-142.dyn.eolo.it. [146.241.237.142])
        by smtp.gmail.com with ESMTPSA id s10-20020a508dca000000b005340d9d042bsm4109287edh.40.2023.10.19.03.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 03:25:01 -0700 (PDT)
Message-ID: <84fbe8a5d47c81142c5eb07b77288711970051e1.camel@redhat.com>
Subject: Re: [PATCH net 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
From:   Paolo Abeni <pabeni@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        "Gan, Yi Fang" <yi.fang.gan@intel.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ong Boon Leong <boon.leong.ong@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>
Date:   Thu, 19 Oct 2023 12:24:59 +0200
In-Reply-To: <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
References: <20231018023137.652132-1-yi.fang.gan@intel.com>
         <ZS+IUo5q/AnYm1Gb@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-18 at 08:25 +0100, Russell King (Oracle) wrote:
> On Wed, Oct 18, 2023 at 10:31:36AM +0800, Gan, Yi Fang wrote:
> > From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> >=20
> > Upon boot up, the driver will configure the MAC capabilities based on
> > the maximum number of tx and rx queues. When the user changes the
> > tx queues to single queue, the MAC should be capable of supporting Half
> > Duplex, but the driver does not update the MAC capabilities when it is
> > configured so.
> >=20
> > Using the stmmac_reinit_queues() to check the number of tx queues
> > and set the MAC capabilities accordingly.
>=20
> There is other setup elsewhere in the driver that fiddles with this in
> stmmac_phy_setup(). Maybe provide a helper function so that this
> decision making can be made in one function called from both these
> locations, so if the decision making for HD support changes, only one
> place needs changing?

Indeed that looks both straight-forward and more robust.

@Gan, Yi Fang: please send a v2 introducing and using such helper,
thanks!

Paolo

