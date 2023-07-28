Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7979C76720A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjG1Qks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjG1Qkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:40:43 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD13C35
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:40:38 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40631c5b9e9so01cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690562437; x=1691167237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCIwiRybbqPdL+GA2easp6/q5mEFWhkL8APip1GzAdM=;
        b=iUphQGDCq/P5HhC+B4wUCuShqcKB/O4cys8ksGxGvtLePX7+FMDl4tNiIlgooGBJDx
         U2WHRT0l4ZU8fSGyRypuXxpLDVMdNvQpm6CHSxbVorcJ8Sz3/CAKqRaSuavn0Z4VpxPR
         1LiYZL8Aw29mGThNJlIHO9zgRQr0g7JLfedKs+YgrLYNF8ETIn52a6zgcmjoNTP87VkT
         3kmTuM26TnV5neBSrxUqTCeVixR3g7N0svKUDbFNYKZHPJhYpbiYk3Q4ZvFYutNnkfo4
         Bib3hPVKzfNdI2PjgaWPCFx0rQkZJ2mg4D+cOw+c2fXYcSczcH4YJCG9F0woHQWJWSOc
         s6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562437; x=1691167237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCIwiRybbqPdL+GA2easp6/q5mEFWhkL8APip1GzAdM=;
        b=LDPuFrspml6kf5wurOrPuodFQ62joUo5DPsowmM5T9GHb38BKaHmANaokTy8dSKh8e
         bm7bpX+mCWfPfHs7tkUqna4FxwyvxiLGLkklYRuK+qkipVzkqTwWV+R/HAD/3Y1afRtU
         uFgYV07bRQX2+oHDIMKF4jtPW57EyGRjBXI77Ek7SdxyrpM9yzX6qqY2mlnyCvWgtsmu
         G0x7O71K+3ZkAWav4O6peKjXw90L0AkmtDxoMQF4/KlfKJs9SfFlrBMlB6w/03EDNoN+
         brkV/6Zh0VRfeFJPDJHNAoOer6TPBLZ0WoOqzz2I39XYlcU/C+eheZanmM0p7khMmJ8A
         YSfA==
X-Gm-Message-State: ABy/qLYGosdr3ZEbtdlQGmG6yBSbvCrWN1GQnqbeDKYECz9tISbtFks2
        +vDxmOLwqZDMNRktgP2kdaJqy4r14ijiiRDDVCw8Sw==
X-Google-Smtp-Source: APBJJlHgM67EtrkE4O/uKl+m1fTY3fGU+3E/kVtkUeSbuYgG0IcBcufA64tWxYrhYYykVVM758vi0LRGrXHA7crs93g=
X-Received: by 2002:a05:622a:15d0:b0:3f8:5b2:aef4 with SMTP id
 d16-20020a05622a15d000b003f805b2aef4mr7604qty.28.1690562437418; Fri, 28 Jul
 2023 09:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230715032915.97146-1-yangjihong1@huawei.com>
 <20230715032915.97146-3-yangjihong1@huawei.com> <CAP-5=fVysKhUn1YsUr0NBU2kVBDgkoczO861XwK5VCtkeYSRJA@mail.gmail.com>
 <993bd68c-c0ec-4960-d3b0-bd2dbda82402@huawei.com>
In-Reply-To: <993bd68c-c0ec-4960-d3b0-bd2dbda82402@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 28 Jul 2023 09:40:25 -0700
Message-ID: <CAP-5=fXmpaKrVLifHh5H7Lf_nhNLGWFS0=CLRT2yHK5guReNGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] perf evlist: Add evlist__findnew_tracking_event() helper
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, james.clark@arm.com,
        tmricht@linux.ibm.com, ak@linux.intel.com,
        anshuman.khandual@arm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:24=E2=80=AFAM Yang Jihong <yangjihong1@huawei.co=
m> wrote:
>
> Hello,
>
> On 2023/7/20 0:44, Ian Rogers wrote:
> > On Fri, Jul 14, 2023 at 8:31=E2=80=AFPM Yang Jihong <yangjihong1@huawei=
.com> wrote:
> >>
> >> Currently, intel-bts, intel-pt, and arm-spe may add a dummy event for
> >> tracking to the evlist. We may need to search for the dummy event for
> >> some settings. Therefore, add evlist__findnew_tracking_event() helper.
> >>
> >> evlist__findnew_tracking_event() also deal with system_wide maps if
> >> system_wide is true.
> >
> > I'm wondering if we can simplify the naming in the API, we have "dummy
> > event" which makes sense as we literally call the event "dummy",
> > "sideband" which refers to the kind of samples/events the dummy event
> > will record but "tracking" I think tends to get used as a verb rather
> > than a noun. So I think evlist__findnew_tracking_event should be
> > evlist__findnew_dummy_event.
> >
> Uh, from the discussion that followed, it seems that there is no
> consensus yet...
> If there is a clear consensus on whether to use "dummy event" or
> "tracking event", I will change the name of the API.
>
> I think sideband event is equivalent to tracking event (refer
> evsel__config(), tracking events include task, mmap, mmap2, and comm
> sideband events, which are all sideband).
>
> tracking event are instances of dummy event. For example, we create
> another dummy event to record the text poke event of ksymbol (refer perf
> record --kcore).
>
> An evlist contains only one tracking event, but can contain multiple
> dummy events.

Thanks for the feedback. So the tracking event is by definition the
first dummy event in the evlist? What is the purpose of the other
dummy events in this case? Perhaps we can get to an intention
revealing implementation something like:

/** The "tracking event" gathering sideband data is the first dummy
event in the list. */
struct evsel *evlist__findnew_tracking_event(struct evlist *evlist)
{
   struct evsel *dummy =3D evlist__find_first_dummy_event(evlist);

   if (!dummy) {
      dummy =3D evlist__add_dummy(evlist);
   }
   return dummy;
}

But I think the key thing for me is I'm still not sure what is going
on when there are multiple dummy events for you, what are the other
dummy events for other than tracking sideband data?

Thanks,
Ian

>
> Thanks,
> Yang
