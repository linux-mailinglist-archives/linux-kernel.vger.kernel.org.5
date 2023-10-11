Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468AC7C541F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjJKMiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjJKMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:38:50 -0400
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14A68F;
        Wed, 11 Oct 2023 05:38:48 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98377c5d53eso1160745166b.0;
        Wed, 11 Oct 2023 05:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027927; x=1697632727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nNEKLUxE7+s53Ed73V9ijKCxoVE9YUCgxrMPyIdVmVY=;
        b=vSEKXRXu89lfp9YaW+PlutSs1qa4b+EcRze/UxcjN6YH5cJDEYIQfcjLESnyqfEJ0I
         JrAK53Jv74O+GXqFCNY8uZUVfHVAJc08AkfGF5wt1XKDMr5yk8Mj5CmGWmM9C0PGrRcz
         INVk75mO4EwZuAIUFr+hJvR+TjhyxTCsnp2pKX4NQI4e1j5mGsKBwje4A+RREqIqC6I2
         sGSOPnNGCuH0KQzYppQ69ml4dGdAlkjl7pSV/lwD2S2lAhT0QNT87ISmXjI3dfWkaMtd
         0wrlP4rVhPvwodeUUjBFl4o4dZxxfqvCiilsIu4PzAzE+VzztA8S3eipOrheeBXlE37x
         tjTA==
X-Gm-Message-State: AOJu0YwNcAJktpy3LoN0p+d9Qzffs1F/K/yBODYyLZ95oT0ByFn651/W
        zcEtQ3ljvDIpAWIjnCZOrIw=
X-Google-Smtp-Source: AGHT+IHk1nQIV/DZbLr8WMGhX4/13tSNLRbBd2yZvKyeaOQiw51MRld6YgCa3yNVVT5wNYKIdmUemA==
X-Received: by 2002:a17:906:301a:b0:9a5:b814:8254 with SMTP id 26-20020a170906301a00b009a5b8148254mr18668874ejz.24.1697027927317;
        Wed, 11 Oct 2023 05:38:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-010.fbsv.net. [2a03:2880:31ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id ec22-20020a0564020d5600b0053defc8c15asm276713edb.51.2023.10.11.05.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:38:46 -0700 (PDT)
Date:   Wed, 11 Oct 2023 05:38:45 -0700
From:   Breno Leitao <leitao@debian.org>
To:     kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        Eric Dumazet <edumazet@google.com>, hch@lst.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
Subject: Re: [PATCH net-next v3 2/4] netconsole: Initialize configfs_item for
 default targets
Message-ID: <ZSaXVQ+g5KkT23L/@gmail.com>
References: <20231010093751.3878229-1-leitao@debian.org>
 <20231010093751.3878229-3-leitao@debian.org>
 <ZSWlppHwravDLyZN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSWlppHwravDLyZN@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:27:34PM -0700, Joel Becker wrote:
> On Tue, Oct 10, 2023 at 02:37:49AM -0700, Breno Leitao wrote:
> > For netconsole targets allocated during the boot time (passing
> > netconsole=... argument), netconsole_target->item is not initialized.
> > That is not a problem because it is not used inside configfs.
> > 
> > An upcoming patch will be using it, thus, initialize the targets with
> > the name 'cmdline' plus a counter starting from 0.  This name will match
> > entries in the configfs later.
> > 
> > Suggested-by: Joel Becker <jlbec@evilplan.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/net/netconsole.c | 25 +++++++++++++++++++++++--
> >  1 file changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index d609fb59cf99..3d7002af505d 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -53,6 +53,8 @@ static bool oops_only = false;
> >  module_param(oops_only, bool, 0600);
> >  MODULE_PARM_DESC(oops_only, "Only log oops messages");
> >  
> > +#define NETCONSOLE_PARAM_TARGET_NAME "cmdline"
> 
> Perhaps `NETCONSOLE_PARAM_TARGET_PREFIX` is better.  Makes it clear this
> is not the whole name.

Sure, I can replace it by NETCONSOLE_PARAM_TARGET_PREFIX. I used
`NETCONSOLE_PARAM_TARGET_NAME` because you had suggested it in the past:

https://lore.kernel.org/all/ZR3EKnepIOKlVGgZ@google.com/

Let me update and send a new version.
