Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0217AB694
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjIVQ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjIVQ5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:57:09 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B770CA1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:57:00 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53368df6093so267a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695401819; x=1696006619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7acKa9vg/VWzTL8BaOiKje9AL2xB6Xnf1TelKGJcqls=;
        b=LOx/WZE5tIM7SsXBGc7TlDBE597kS7JoIG4OFBEmJm2rGP5z8HG3w46+KGRPJ4ZueE
         pYd0ajnO/7OugU+bmd/i0UU/vpaaoqQc5XBWVfciwgeouaHecuxsQKMIH/Zr//5y+5G0
         rUaIL75WGVEKIY9Q7wZxxT0Z4VVwZxtFxygI+GBZJqnmQKDcEB5FnLTMlgeFMxqGjlT2
         i4oUM67Lh8UM7ozKqC9AyeYBlyEBK5kyZx5q36Fc/3MqSgA9hGTwYjcH6mkJJkqLppdX
         2jnofRruYOtBH1ZEgwkJlC8AAcmBl8qtihwfUTmiSkAS7yViBMJZUYNfImNfaHAoYDG7
         uAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401819; x=1696006619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7acKa9vg/VWzTL8BaOiKje9AL2xB6Xnf1TelKGJcqls=;
        b=Re5W3f9wztYr7XyqXo4PaCcVx+ti3wnxZBuuAcgPXbCCgroSh7cS6f6p8BlKR5RtPs
         5NZxSLeJaSk7MwT18VrI7yIHuV3OsT97cxEAcW76l43Ctb8g5meeAYvCRloEaLLmj/lu
         rHw35r/97HcIBVKCOaD6+mufUhZCPnVjDbguChHXLPTsD8+tZh0zk/hbLNC5HFjKg9h+
         GSYrt/CRBvAORnjh/Lb4/2VeKHSuFI+SnpoJAT3fikQdGAOr0H0M8aoel4Wa5IQezWr2
         oE63vZbeczeh4x5MbQzWTjuEduxW5+u9u5Ytw7cYLpZ8/oQ3iZ3m8H66b3agEVs4knza
         M68A==
X-Gm-Message-State: AOJu0YwAFMIgxK37WTvGQEdUc10v+MuB/aBU4soNuuwz6yCprmjIvzY4
        G+4h43dLtGtU2Diindm9+uJrlbA23u6gr5cfsyMohg==
X-Google-Smtp-Source: AGHT+IG5cHClY82H0qF3KKmCwyJ734Out2F/bsDJOo9ukZYK24El35SdIJZgzp3rV1XqCgEWNwAq0ykaaXCtOVvlIrA=
X-Received: by 2002:a50:a41d:0:b0:525:573c:6444 with SMTP id
 u29-20020a50a41d000000b00525573c6444mr3940edb.1.1695401818931; Fri, 22 Sep
 2023 09:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com> <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com> <ZOijSwCa9NFD6DZI@casper.infradead.org>
 <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com> <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
 <20230906065817.GA27879@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230920054454.GA26860@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <CAHbLzkouAZg5BSvnwv_EN6G3qV-nzeX2ced1GRqQDf2rkm992w@mail.gmail.com>
In-Reply-To: <CAHbLzkouAZg5BSvnwv_EN6G3qV-nzeX2ced1GRqQDf2rkm992w@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Fri, 22 Sep 2023 09:56:21 -0700
Message-ID: <CAAa6QmTnx=kEijosNfq0DEPz4TeHFeOrgtwO0wfEeFUS5hgROw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Yang Shi <shy828301@gmail.com>
Cc:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 9:54=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrot=
e:
>
> On Tue, Sep 19, 2023 at 10:44=E2=80=AFPM Saurabh Singh Sengar
> <ssengar@linux.microsoft.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 11:58:17PM -0700, Saurabh Singh Sengar wrote:
> > > On Fri, Aug 25, 2023 at 08:09:07AM -0700, Zach O'Keefe wrote:
> > > > On Fri, Aug 25, 2023 at 5:58=E2=80=AFAM David Hildenbrand <david@re=
dhat.com> wrote:
> > > > >
> > > > > On 25.08.23 14:49, Matthew Wilcox wrote:
> > > > > > On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wro=
te:
> > > > > >> Especially, we do have bigger ->huge_fault changes coming up:
> > > > > >>
> > > > > >> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infra=
dead.org
> > > >
> > > > FWIW, one of those patches updates the docs to read,
> > > >
> > > > "->huge_fault() is called when there is no PUD or PMD entry present=
.  This
> > > > gives the filesystem the opportunity to install a PUD or PMD sized =
page.
> > > > Filesystems can also use the ->fault method to return a PMD sized p=
age,
> > > > so implementing this function may not be necessary.  In particular,
> > > > filesystems should not call filemap_fault() from ->huge_fault(). [.=
.]"
> > > >
> > > > Which won't work (in the general case) without this patch (well, at
> > > > least the ->huge_fault() check part).
> > > >
> > > > So, if we're advertising this is the way it works, maybe that gives=
 a
> > > > stronger argument for addressing it sooner vs when the first in-tre=
e
> > > > user depends on it?
> > > >
> > > > > >> If the driver is not in the tree, people don't care.
> > > > > >>
> > > > > >> You really should try upstreaming that driver.
> > > > > >>
> > > > > >>
> > > > > >> So this patch here adds complexity (which I don't like) in ord=
er to keep an
> > > > > >> OOT driver working -- possibly for a short time. I'm tempted t=
o say "please
> > > > > >> fix your driver to not use huge faults in that scenario, it is=
 no longer
> > > > > >> supported".
> > > > > >>
> > > > > >> But I'm just about to vanish for 1.5 week into vacation :)
> > > > > >>
> > > > > >> @Willy, what are your thoughts?
> > > > > >
> > > > > > Fundamentally there was a bad assumption with the original patc=
h --
> > > > > > it assumed that the only reason to support ->huge_fault was for=
 DAX,
> > > > > > and that's not true.  It's just that the only drivers in-tree w=
hich
> > > > > > support ->huge_fault do so in order to support DAX.
> > > > >
> > > > > Okay, and we are willing to continue supporting that then and it'=
s
> > > > > nothing we want to stop OOT drivers from doing.
> > > > >
> > > > > Fine with me; we should probably reflect that in the patch descri=
ption.
> > > >
> > > > I can change these paragraphs,
> > > >
> > > > "During the review of the above commits, it was determined that in-=
tree
> > > > users weren't affected by the change; most notably, since the only =
relevant
> > > > user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which=
 is
> > > > explicitly approved early in approval logic.  However, there is at =
least
> > > > one occurrence where an out-of-tree driver that used
> > > > VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was brok=
en.
> > > >
> > > > Remove the VM_NO_KHUGEPAGED check when not in collapse path and giv=
e
> > > > any ->huge_fault handler a chance to handle the fault.  Note that w=
e
> > > > don't validate the file mode or mapping alignment, which is consist=
ent
> > > > with the behavior before the aforementioned commits."
> > > >
> > > > To read,
> > > >
> > > > "The above commits, however, overfit the existing in-tree use cases=
,
> > > > and assume that
> > > > the only reason to support ->huge_fault was for DAX (which is
> > > > explicitly approved early in the approval logic).
> > > > This is a bad assumption to make and unnecessarily prevents general
> > > > support of ->huge_fault by filesystems. Allow returning "true" if s=
uch
> > > > a handler exists, giving the fault path an opportunity to exercise =
it.
> > > >
> > > > Similarly, the rationale for including the VM_NO_KHUGEPAGED check
> > > > along the fault path was that it didn't alter any in-tree users, bu=
t
> > > > was likewise similarly unnecessarily restrictive (and reads odd).
> > > > Remove the check from the fault path."
> > > >
> > >
> > >
> > > Any chance this can make it to 6.6 kernel ?
> >
> > ping
>
> I think we tend to merge this patch, but anyway it is Andrew's call.
> Included Andrew in this loop.

Sorry for delay -- just back from (another) OOO,

From this back/forth with David/Matthew, seems like we're OK saying,
"this was a mistake", and that we can take the patch (need some form
of Ack or Reviewed-by from them first, to confirm)

> > Fundamentally there was a bad assumption with the original patch --
> > it assumed that the only reason to support ->huge_fault was for DAX,
> > and that's not true.  It's just that the only drivers in-tree which
> > support ->huge_fault do so in order to support DAX.
>
> Okay, and we are willing to continue supporting that then and it's
> nothing we want to stop OOT drivers from doing.
>
> Fine with me; we should probably reflect that in the patch description.

But, I don't know about timing. We are in 6.6-rc2, and this hasn't
been exposed in Andrew's trees yet. 6.6 is looking like it could be a
LTS candidate, in which case this patch could flow backwards from
-stable (which would also land in 6.1-y) .. but I don't know if that
path is suitable for this.

Otherwise, perhaps you could include this fix
when you're ready to upstream your driver?

> >
> > >
> > > - Saurabh
