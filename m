Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2E776750
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjHISbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHISbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DECE1BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691605829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbjndyEV18fW8Q6aaYiEgoKrYM26FczR+bnw1W1kYtY=;
        b=fBHPGzvnoCT3FRv9J/h6acDhRmx8AHzGu/EwxJkitLUbemN1/pAh05usrFmL7UUuUqOF6L
        ssndMksdYhVa8jqp8T0PzUqXJGopbW3HA7a27w5WmncSJkf5+5BllIZJyQbAzdbYD6ZMHS
        Se6qiPMaY9u9AM/TN2QlmZzqTh+i+EE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-_gr1D6XHM0WUy0X12EK9ew-1; Wed, 09 Aug 2023 14:30:26 -0400
X-MC-Unique: _gr1D6XHM0WUy0X12EK9ew-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso260381fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 11:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691605825; x=1692210625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbjndyEV18fW8Q6aaYiEgoKrYM26FczR+bnw1W1kYtY=;
        b=jnzCggvmskpO9l9zizhdoOEwE+yOaJMKMPIh/AJ0goRKdPmMfZgSwQEXA1OK55gNjs
         E+e4ZNfwAQAa9m4y3z1CoCEaaUtMZvGNUFuJnPEQeB2+FEIESSp8IxLom7iPZKTc/2fo
         k7eb8PqNDo0t9gGaxSPQItCdGSUR0tpoKOa9y4qcFRlm7CNryYoqZJ7EVIZmc6EBl0ve
         N09G+vmteTWCU/CJFwtM5dBJGs53pQNa0NSynyc4eOTCNH+3w8FCdHE/6l2kyjBf93Cn
         XjzMYUtPYeScwj/HK1XVvJMIJaYAkKD0V7Wu7boQTES0vRJTmChXZgddMZlrALRSEsu4
         k5xQ==
X-Gm-Message-State: AOJu0Ywpirlh63wf1DgbO82wpdOzWTtqAFNfcd8gyyX/ZuK1+JhIl8zD
        bQFXhEqCPJY2SE/eWQannqUjZ53tqNTtm0LYAa2mwPaqi1Kfq0MMu0wcdeJDr7zBMMldY6vIIW7
        CNm6rYqM0pqA2Vc6I40AeA36kKPm2UCYWwNTaCVRG
X-Received: by 2002:a2e:bc26:0:b0:2b9:6610:d7ca with SMTP id b38-20020a2ebc26000000b002b96610d7camr2960814ljf.5.1691605825383;
        Wed, 09 Aug 2023 11:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyvglv3LGH/ukn+Eb+jsR7KbtrzIbPTNwruMlpHnbwXO1CT5AZMoySQQYEHX6dyFsxo+vCB9UAiYpnP5/b6aw=
X-Received: by 2002:a2e:bc26:0:b0:2b9:6610:d7ca with SMTP id
 b38-20020a2ebc26000000b002b96610d7camr2960796ljf.5.1691605825099; Wed, 09 Aug
 2023 11:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
 <CACO55tvZD5U4J8DawFTRVnV-dLYLngfhuqO29_sWNEGofKfnBg@mail.gmail.com>
 <20230807150521.GGZNEIMQ9rsyCmkpoA@fat_crate.local> <CACO55tvWuSdwdirj7S3Dk-r4NAw8jC8g5RHKFd62WXi43iQP-w@mail.gmail.com>
 <87fs4sfu54.wl-tiwai@suse.de> <CACO55tszwFEgt=8xn4auAE7KJVs3ybGG68OzL9HJt19XGVhhHQ@mail.gmail.com>
 <874jl8fngo.wl-tiwai@suse.de> <CACO55ts9YWF7nLi3Zs4xKySpdHyUFgf4r566cKx3FwNTCaz0Sg@mail.gmail.com>
 <87wmy4e4uk.wl-tiwai@suse.de> <60ef0646-b0ab-b4e0-9eaa-a2c431c5d682@leemhuis.info>
 <CACO55tt=RosBaYPc_wf3NnRC-+prFg2G9E0GEjnV7TSkWjB2HQ@mail.gmail.com>
In-Reply-To: <CACO55tt=RosBaYPc_wf3NnRC-+prFg2G9E0GEjnV7TSkWjB2HQ@mail.gmail.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 9 Aug 2023 20:30:13 +0200
Message-ID: <CACO55ttZUVCVuWpBiTcr1goWWxs2KP1Xxg00X+hYhbpeJzUEFA@mail.gmail.com>
Subject: Re: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not
 PMGR AUX interrupts")
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Takashi Iwai <tiwai@suse.de>, nouveau@lists.freedesktop.org,
        Borislav Petkov <bp@alien8.de>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 8:28=E2=80=AFPM Karol Herbst <kherbst@redhat.com> wr=
ote:
>
> On Wed, Aug 9, 2023 at 4:04=E2=80=AFPM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
> >
> > On 09.08.23 15:13, Takashi Iwai wrote:
> > >
> > > If this can't be fixed quickly, I suppose it's safer to revert it fro=
m
> > > 6.4.y for now.  6.5 is still being cooked, but 6.4.x is already in
> > > wide deployment, hence the regression has to be addressed quickly.
> >
>
> feel free to send reverts to mainline and add my r-by tage to it and I
> can push those changes up. Sadly those patches fixed another
> use-after-free, but it seems like we have to take another shot unless
> somebody does have time to look into it promptly.
>

uhm and the two patches around that one,
752a281032b2d6f4564be827e082bde6f7d2fd4fand
ea293f823a8805735d9e00124df81a8f448ed1ae

> > Good luck with that. To quote
> > https://docs.kernel.org/process/handling-regressions.html :
> >
> > ```
> > Regarding stable and longterm kernels:
> >
> > [...]
> >
> > * Whenever you want to swiftly resolve a regression that recently also
> > made it into a proper mainline, stable, or longterm release, fix it
> > quickly in mainline; when appropriate thus involve Linus to fast-track
> > the fix (see above). That's because the stable team normally does
> > neither revert nor fix any changes that cause the same problems in main=
line.
> > ```
> >
> > Note the "normally" in there, so there is a chance.
> >
> > Ciao, Thorsten
> >

