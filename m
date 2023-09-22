Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E17AB680
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjIVQyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjIVQya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:54:30 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8ECF1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:54:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-564af0ac494so1708283a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695401663; x=1696006463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0T607sMhgTfYruhqi8wwv+JLqEpq/mk4CQMx7i0zpfk=;
        b=Ix7wVnHF7+rysk8CvHxR2ql1bjHVV1EoQtTjthM0DJUlLWdB0OmSBZAEo9azvzNbOs
         78uL+oBMK7lCEN5cWWOLqk/RtMqLhHGr5LUlAIQYVCplXZalHqL7BGCVmF9gTqUKsMCi
         hjoSPmg92ZHfNuAQsAc1xR0DKj5oHKpCP1oB039EJRE6oICLKVsVukp6xHtm9PCLpvZ8
         er2Y2wKqPkoiN23ZnrUhF6r51Ph8ZIdGrdNZgdBh4ZIPLirwXeAPqDtCTpWSePMj50i9
         awEavyzpd0W3zqJAw09ig9ZTYUJJqjOrYMQHZ+BbSRQkcjwR6ZeWPREBLq4IqO82JLMI
         ZZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401663; x=1696006463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0T607sMhgTfYruhqi8wwv+JLqEpq/mk4CQMx7i0zpfk=;
        b=Ajtsy9aHw+5roAaGsRCMxm76K5BBJ44tTmMZ4/i36QeSHTGphaczqTIbfr3smvXYVP
         Mhrth03A463bvDJllHF71b909ApRPvZJ2SDfhsYH2PL05R83FK0o5fCuXQBXdR9UQbfy
         h1ua9a4l+lHU//w54Wv0Nhq7/wQb5ETYwOifxN7TlZNvgOONkd9NVS1hs3MMwWUBXM1L
         yT2xrgsoeNKo4rL/E78V+CT4yhf98gGY5XtuzZXAzmvbRazhA39G1i8++yXMiGTmu9aP
         UNqym+0TE4JQzUacNzKxjz9WGb0kdpNvrCTK15A87csj2vsx8JMU7pNCXEG4Y5ftQg6o
         gymg==
X-Gm-Message-State: AOJu0YwBG6zzmhUqIALkkCZxG9J8OiRVtFONf8FT5BRxazNCp5Tagig3
        2y/ipRfkj/bg4IynnNkgos6PhUhnTtUrRdycUhY=
X-Google-Smtp-Source: AGHT+IEaf8TDj8druJGx1h/K3t02CoXpiCXsWkvUn8BmOth8vUUzkumZGNAr07h5y9OJmxtZDfwynixe/JwROKF48UA=
X-Received: by 2002:a17:90b:4b41:b0:26b:219f:3399 with SMTP id
 mi1-20020a17090b4b4100b0026b219f3399mr215435pjb.35.1695401663298; Fri, 22 Sep
 2023 09:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <37c2b525-5c2c-d400-552c-9ccb91f4d7bf@redhat.com>
 <CAAa6QmSHF6-9aFa68WDcb+WATh2Yz=wXyp8VBLDNv6yPp2SS5Q@mail.gmail.com>
 <3e08d48b-7b70-cc7f-0ec1-12ad9b1a33db@redhat.com> <CAAa6QmSNvx7wbZzfhFOyhODTMoBbf6PimnOf2xeAw5NkD1eXVg@mail.gmail.com>
 <PUZP153MB06350A5DC9CCB8448C98E4EEBE1DA@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <3408ff54-f353-0334-0d66-c808389d2f01@redhat.com> <ZOijSwCa9NFD6DZI@casper.infradead.org>
 <9f967665-2cbd-f80b-404e-ac741eab1ced@redhat.com> <CAAa6QmQRFwzXWHEL2d74sX6JuciJeBzprk1NxCWKB6i53gmt6Q@mail.gmail.com>
 <20230906065817.GA27879@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20230920054454.GA26860@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To: <20230920054454.GA26860@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Sep 2023 09:54:11 -0700
Message-ID: <CAHbLzkouAZg5BSvnwv_EN6G3qV-nzeX2ced1GRqQDf2rkm992w@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Zach O'Keefe" <zokeefe@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:44=E2=80=AFPM Saurabh Singh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> On Tue, Sep 05, 2023 at 11:58:17PM -0700, Saurabh Singh Sengar wrote:
> > On Fri, Aug 25, 2023 at 08:09:07AM -0700, Zach O'Keefe wrote:
> > > On Fri, Aug 25, 2023 at 5:58=E2=80=AFAM David Hildenbrand <david@redh=
at.com> wrote:
> > > >
> > > > On 25.08.23 14:49, Matthew Wilcox wrote:
> > > > > On Fri, Aug 25, 2023 at 09:59:23AM +0200, David Hildenbrand wrote=
:
> > > > >> Especially, we do have bigger ->huge_fault changes coming up:
> > > > >>
> > > > >> https://lkml.kernel.org/r/20230818202335.2739663-1-willy@infrade=
ad.org
> > >
> > > FWIW, one of those patches updates the docs to read,
> > >
> > > "->huge_fault() is called when there is no PUD or PMD entry present. =
 This
> > > gives the filesystem the opportunity to install a PUD or PMD sized pa=
ge.
> > > Filesystems can also use the ->fault method to return a PMD sized pag=
e,
> > > so implementing this function may not be necessary.  In particular,
> > > filesystems should not call filemap_fault() from ->huge_fault(). [..]=
"
> > >
> > > Which won't work (in the general case) without this patch (well, at
> > > least the ->huge_fault() check part).
> > >
> > > So, if we're advertising this is the way it works, maybe that gives a
> > > stronger argument for addressing it sooner vs when the first in-tree
> > > user depends on it?
> > >
> > > > >> If the driver is not in the tree, people don't care.
> > > > >>
> > > > >> You really should try upstreaming that driver.
> > > > >>
> > > > >>
> > > > >> So this patch here adds complexity (which I don't like) in order=
 to keep an
> > > > >> OOT driver working -- possibly for a short time. I'm tempted to =
say "please
> > > > >> fix your driver to not use huge faults in that scenario, it is n=
o longer
> > > > >> supported".
> > > > >>
> > > > >> But I'm just about to vanish for 1.5 week into vacation :)
> > > > >>
> > > > >> @Willy, what are your thoughts?
> > > > >
> > > > > Fundamentally there was a bad assumption with the original patch =
--
> > > > > it assumed that the only reason to support ->huge_fault was for D=
AX,
> > > > > and that's not true.  It's just that the only drivers in-tree whi=
ch
> > > > > support ->huge_fault do so in order to support DAX.
> > > >
> > > > Okay, and we are willing to continue supporting that then and it's
> > > > nothing we want to stop OOT drivers from doing.
> > > >
> > > > Fine with me; we should probably reflect that in the patch descript=
ion.
> > >
> > > I can change these paragraphs,
> > >
> > > "During the review of the above commits, it was determined that in-tr=
ee
> > > users weren't affected by the change; most notably, since the only re=
levant
> > > user (in terms of THP) of VM_MIXEDMAP or ->huge_fault is DAX, which i=
s
> > > explicitly approved early in approval logic.  However, there is at le=
ast
> > > one occurrence where an out-of-tree driver that used
> > > VM_HUGEPAGE|VM_MIXEDMAP with a vm_ops->huge_fault handler, was broken=
.
> > >
> > > Remove the VM_NO_KHUGEPAGED check when not in collapse path and give
> > > any ->huge_fault handler a chance to handle the fault.  Note that we
> > > don't validate the file mode or mapping alignment, which is consisten=
t
> > > with the behavior before the aforementioned commits."
> > >
> > > To read,
> > >
> > > "The above commits, however, overfit the existing in-tree use cases,
> > > and assume that
> > > the only reason to support ->huge_fault was for DAX (which is
> > > explicitly approved early in the approval logic).
> > > This is a bad assumption to make and unnecessarily prevents general
> > > support of ->huge_fault by filesystems. Allow returning "true" if suc=
h
> > > a handler exists, giving the fault path an opportunity to exercise it=
.
> > >
> > > Similarly, the rationale for including the VM_NO_KHUGEPAGED check
> > > along the fault path was that it didn't alter any in-tree users, but
> > > was likewise similarly unnecessarily restrictive (and reads odd).
> > > Remove the check from the fault path."
> > >
> >
> >
> > Any chance this can make it to 6.6 kernel ?
>
> ping

I think we tend to merge this patch, but anyway it is Andrew's call.
Included Andrew in this loop.

>
> >
> > - Saurabh
