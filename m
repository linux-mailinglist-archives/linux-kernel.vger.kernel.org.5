Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202AC7D5C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbjJXUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbjJXUAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:00:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7689F129
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:00:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso707696066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698177646; x=1698782446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIN4mCJWlF4t4OQZVRc6T503X62iqMXHjjCRO+p+TuE=;
        b=ICj9zbS0/2l2PzxgUsYWPQDsLzLoMz4pecmzKP+p1uXqnFGfrh9jqCTSDBYPEKvBLk
         ZkfJ2Kztb7T6ZYGgGTmZom4WkSU1wuZ1okoOcI2D8+7vHu5yaxFzKUtFwACeuEC/bU7J
         9aOlJOhZITTEaenQ9i46nhHBKEFQ86lQFT7mQFVCHZlGzZFC6FDWorStGbdtyP03QDLr
         1g0MxBqC8Ww8rkBqJ8enkHH3YITFl5R9bUbJflJi3N9JnUG6AYMneQZqN5ypRqTdUH1A
         RpQ70c/CTZ9rT1vhatMRejpWikzz3PKrDcl16Zo1Ab4heZLUMxtr10qC6Srx5PuI2ZkA
         ewLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698177646; x=1698782446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIN4mCJWlF4t4OQZVRc6T503X62iqMXHjjCRO+p+TuE=;
        b=qnIx+o4FMMx+MZb5NchKUVgLBScxlhCVLhyw6/iZF5szm8wFTRAytQU6UjIobzCpTO
         BK5WSKMhULmZ5Q+J8C4+CqV14P0INj59hO7gfy/25Foo+fWO3pylJEPZndzrXRlnX8+t
         RqFUBxzc/Jb5a/7H3iNcQAQmRUaim3A/eLmincr4Mtu4WbMLZttLrwjQoODGy3YwLhi0
         C8A0efkCwElEcrV2+sF+6jOVj04knkrJXF/ajG/sKLiJPc4pxlhI1kMGQ1DBjb7t8Rhv
         dWs3zNy+QiLFqcuR8zcFD5D1XkYOHkMdoHkviP8WQCeMMlk20aruloGbcADzBcEj0/dQ
         ERzw==
X-Gm-Message-State: AOJu0Yzx0u7L/s2SCSovC8YVZJHFpY+cpwldxhpK3pg2j9XX6J3fTW5J
        AgXGMEify8ijnamzABqFSc6D8VXa427qkaMRp7QBOA==
X-Google-Smtp-Source: AGHT+IHSDiGEpDlRFQz+bKGVmlKZp5PGS0+WG2f3oJM+9ttLUJWAN6XpGIIrNHgDHfyWjv+/K4v+f/tZG5rZeZnkllQ=
X-Received: by 2002:a17:906:dc89:b0:9bf:ad86:ece8 with SMTP id
 cs9-20020a170906dc8900b009bfad86ece8mr11330327ejc.25.1698177646233; Tue, 24
 Oct 2023 13:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231019185319.2714000-5-arakesh@google.com> <202310200457.GwPPFuHX-lkp@intel.com>
 <738df245-e7d1-4fc0-9076-3ac5afebaa44@google.com> <2023102103-casually-wavy-6a54@gregkh>
 <CAMHf4WKgzvMoL6tKCiQYsuudQWgGBKkhfbmYgUxVXvLEqxi1GQ@mail.gmail.com> <2023102440-retaining-eskimo-92b0@gregkh>
In-Reply-To: <2023102440-retaining-eskimo-92b0@gregkh>
From:   Avichal Rakesh <arakesh@google.com>
Date:   Tue, 24 Oct 2023 13:00:33 -0700
Message-ID: <CAMHf4WLoB-8mp9=J82EZ5T2RsYzpWYkyv4v3DZ4Ag+Bpsxh=0A@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 2:27=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Oct 23, 2023 at 02:25:30PM -0700, Avichal Rakesh wrote:
> > On Sat, Oct 21, 2023 at 3:05=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Thu, Oct 19, 2023 at 03:30:00PM -0700, Avichal Rakesh wrote:
> > > >
> > > >
> > > > On 10/19/23 13:32, kernel test robot wrote:
> > > > > Hi Avichal,
> > > > >
> > > > > kernel test robot noticed the following build warnings:
> > > > >
> > > > > [auto build test WARNING on usb/usb-testing]
> > > > > [also build test WARNING on usb/usb-next usb/usb-linus linus/mast=
er v6.6-rc6 next-20231019]
> > > > > [If your patch is applied to the wrong git tree, kindly drop us a=
 note.
> > > > > And when submitting patch, we suggest to use '--base' as document=
ed in
> > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > >
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Avichal-Ra=
kesh/usb-gadget-uvc-prevent-use-of-disabled-endpoint/20231020-025512
> > > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/us=
b.git usb-testing
> > > > > patch link:    https://lore.kernel.org/r/20231019185319.2714000-5=
-arakesh%40google.com
> > > > > patch subject: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-fre=
e for inflight usb_requests
> > > > > config: m68k-allyesconfig (https://download.01.org/0day-ci/archiv=
e/20231020/202310200457.GwPPFuHX-lkp@intel.com/config)
> > > > > compiler: m68k-linux-gcc (GCC) 13.2.0
> > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-=
ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/reproduce)
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310200457.GwPP=
FuHX-lkp@intel.com/
> > > > >
> > > > > All warnings (new ones prefixed by >>):
> > > > >
> > > > >>> drivers/usb/gadget/function/uvc_video.c:231: warning: This comm=
ent starts with '/**', but isn't a kernel-doc comment. Refer Documentation/=
doc-guide/kernel-doc.rst
> > > > >     * Must be called with req_lock held as it modifies the list u=
req is held in
> > > > >
> > > > >
> > > >
> > > > Greg, apologies for the newb question: do you want me to upload
> > > > the fix for this as a reply to [PATCH v6 4/4], or upload a new chai=
n of
> > > > v7s with this patch fixed?
> > >
> > > A whole new v7 series please.
> > >
> >
> > Had a feeling, so sent out v7 series preemptively. Let me know if that
> > doesn't work.
> >
> > v7: https://lore.kernel.org/20231020173626.2978356-1-arakesh@google.com=
/
>
> I have already dropped that from my review queue as your emails crossed
> with that, so I thought it was obsolete by now, sorry.
>
> Can you send a v8 please?
>
Sent out v8! PTAL when you get the chance.

https://lore.kernel.org/20231024183605.908253-1-arakesh@google.com/

Thank you!
- Avi.
