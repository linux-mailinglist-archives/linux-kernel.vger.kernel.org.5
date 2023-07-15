Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6F7546DC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 06:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjGOEbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 00:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOEbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 00:31:19 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0928C35AE
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:31:15 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-4036bd4fff1so154201cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 21:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689395474; x=1691987474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fY7WqLus7jVclsKOgyv5P2i48ZMgYiFyiuJB7T/iYJw=;
        b=y3dyDswLm3NG+cpBXivvLpSQvnVsie+3RNQD59vC88TeX5oQlKJWglbWb6NaoPiIxR
         vTpVITn+vdMr1SiSU+03FlOhPQ4ghz50pXAYzN9ukMPtRGnQlJ+6zzuHSaTm7KvjgJYc
         7x+0inTyoU07FtS0QsqwAtSBBgp58Pbkn8gN3euUXpTS87wyXqM48JTk4DuhLoyX8Frp
         r1SUzOKQCccxN6jt5CMNHFmjM3I3zRi/DXsgKurWcsj7mEUHImgQosgFXVjIn51PBvar
         UCQWrHchg+e5Zm1TEOI+R7EYg7weo5PGoOMEc66nWIf/UOpWBd+fx38x4TYx+mJtuhUj
         /iJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689395474; x=1691987474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fY7WqLus7jVclsKOgyv5P2i48ZMgYiFyiuJB7T/iYJw=;
        b=aRQx84ueljLF5655AoIVlRvtUxsUmGr8fQrYzh0pi0eIOV4jKaRcUityEEbtz5tRSi
         0MF/QveAyp2OmrUpqKnejDvM7Vo1VuYI7OPfX8+1DSnxtRslK//P+mG6b3jvE3tPc67H
         5fsrpALDiBb8t/Vorv5EAQiK1y1iyPudhck/icQIHVVFdGSLjD7aAyIn4ijAERdMsZsg
         9Ku9hFvEiWsUiRoRvkC/YacpbK6KhE/FjAnuoq2dNUi2afiOZe37liY5p2SIWifCzq/1
         RPusA2omUfjHnisFFYak3SKWMGzve/czGyrmJzIjjACE8U0WdDYZ9rWOVxo24e8d8a8O
         3f/A==
X-Gm-Message-State: ABy/qLbSQ5XNPuJZ9S5HClb2tfbaqg6KvXVo2fiw9qDZiy/T+bafmLMF
        2DyUO7vCgYy4KniXLM0LBBhp7ZGiGChPNN7zG2Cwhg==
X-Google-Smtp-Source: APBJJlGIFcWJSqqngk2GWrPEK8zfKLY3hsUwvEUwu0jYYsPNxLQ98GaZ1Sd7MjT1sMxYMMf5myapc+mTDlqwLOVhUp4=
X-Received: by 2002:a05:622a:208:b0:403:e1d1:8b63 with SMTP id
 b8-20020a05622a020800b00403e1d18b63mr39255qtx.24.1689395474099; Fri, 14 Jul
 2023 21:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687991811.git.isaku.yamahata@intel.com>
 <bbd17dbe371d6b12b2e7670bef6a4f080267c300.1687991811.git.isaku.yamahata@intel.com>
 <ZLB2Ro55dKGElB9B@google.com>
In-Reply-To: <ZLB2Ro55dKGElB9B@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 22:30:37 -0600
Message-ID: <CAOUHufady0XkgFWSL6-Mb+HFEyaQ33DJCinsjidRw2DTR9F8yQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/11] KVM: Add new members to struct kvm_gfn_range
 to operate on
To:     Sean Christopherson <seanjc@google.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sagi Shahar <sagis@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        linux-coco@lists.linux.dev,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Michael Roth <michael.roth@amd.com>,
        Yuan Yao <yuan.yao@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> +Yu
>
> On Wed, Jun 28, 2023, isaku.yamahata@intel.com wrote:
> >  void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 1a47cedae8a1..5ca0c8ee4292 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -260,7 +260,13 @@ struct kvm_gfn_range {
> >       struct kvm_memory_slot *slot;
> >       gfn_t start;
> >       gfn_t end;
> > -     pte_t pte;
> > +     union {
> > +             unsigned long attributes;
> > +             pte_t pte;
> > +             unsigned long callback_arg; /* needs a better name */
> > +     };
>
> Making the union needs to be done in a separate patch.  And coming back t=
o this
> with fresh eyes, I think it makes sense to give the union a name.  I thin=
k an
> anonymous union is actually worse in the long run, and there aren't _that=
_ many
> instances to update.  E.g. that way a single build-time assertion can cap=
ture
> all uses, and it makes it more obvious that the usage is poking into a un=
ion.
>
> I'll post a patch separately so that it can be picked up for the MGLRU se=
ries
> (and maybe even merged ahead of both).

Thanks a lot, Sean. And sorry for having not addressed your comments
on v2 -- I'm wrapping up a few other projects and will be focusing on
addressing all pending comments in a couple of weeks.
