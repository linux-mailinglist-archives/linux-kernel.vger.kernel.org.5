Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F0D7D7651
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjJYVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJYVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:06:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448BD136
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:32 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-3575826ba20so26855ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698267991; x=1698872791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YfKUQfUVw2J0FwzBs8kRktoJX+okfytV+T+B1kRuBio=;
        b=Uzjc4i9Rw9syaHUHEzJ+R+rqVahROI2kY8UxdD3VMs7SMIA2KCDXIThzUVtRv2HuzT
         mRmt8kqehxt6FnN0hViy7d27MvNaJFzEx8DDXiizgt19Mz5As48mp9iZJ6eBFQETkXUG
         acS25QB184H3tszqJ5l4CmXeSmwxOVi+q4Mtc3vtFr//B2S8RzMBXjcyYfuSyx3cxGeq
         ZE7DgTHyJMzbr4UwEaz37oRDXd7T1B6s85IO8QypyWb1rCHCAf6Uh1GFetRR90YzL3sw
         tANFInQnsP52z0T9Jtcq51/sp5Z4Vz9esA1N+ucXctSf7ofeAcdxF3r0WhZHc0Bvj4wF
         DhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698267991; x=1698872791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfKUQfUVw2J0FwzBs8kRktoJX+okfytV+T+B1kRuBio=;
        b=FQt0mzKCaH4E8AVOvw0ZqU3oNvItXqJmOkaAtVcpM4hyhcAC1bV1jqgkty2HiWEisO
         nG51lQLcfeRnT6xQak4+vxLcso8mSJuuPJ58WNjHAx8vKN2axNpOK0R07Hv3HjcPwbip
         SPTWzsVnfBOcDk0BQJpTsWltMGWkFHrMFLnzcoVazEnuMvC+c8mtYDApMs+gS2CuXJbQ
         lGw5BwyYIp1Q4BdLzH0TYVlFXdqUENhpIP9cEbltARqoHB4mE86Bwx8wHPjZwApqF0Hy
         53xgNHqLRB0Cp2xUxtyiFhE6BoxZ3vSVZk9VKKW4HcCY9+BvvU1oHLX2UsoEK79Vb6xk
         wMfQ==
X-Gm-Message-State: AOJu0YyvDon6XI6I/ocBh3EQ9ylo/fcO/QakYCZnAPuqVIoa0lFdx4ax
        /45wLybakJ6AWSqevrRPuoWW2yxnz4cRoOvyWmu6ZA==
X-Google-Smtp-Source: AGHT+IEH7+hN0UnU2m4b/Gl5oLvAf7k4M9Ve15jrFHBr/Sc2DlZfGnPuEjrzAsXX50m1rLP8WUI0gf8alcW5t9Zj81w=
X-Received: by 2002:a05:6e02:b24:b0:357:cb1a:9621 with SMTP id
 e4-20020a056e020b2400b00357cb1a9621mr375512ilu.10.1698267991544; Wed, 25 Oct
 2023 14:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231024181600.8270-1-tony.luck@intel.com> <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
In-Reply-To: <ZTluypa9bCWv4k2n@agluck-desk3>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 25 Oct 2023 23:06:20 +0200
Message-ID: <CALPaoCj72V=o60tqsFMRzaeUw-1+rN7pyhsdCyVEV=0tN_CZ7A@mail.gmail.com>
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Wed, Oct 25, 2023, 21:38 Tony Luck <tony.luck@intel.com> wrote:
>
> On Wed, Oct 25, 2023 at 02:46:53PM +0200, Peter Newman wrote:
>
> > > +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int rmid)
> > > +{
> > > +       if (is_mbm_local_enabled())
> > > +               return &dom_mbm->mbm_local[rmid];
> > > +
> > > +       return &dom_mbm->mbm_total[rmid];
> > > +}
> >
> > That looks very similar to the get_mbm_state() function I added to
> > this same file recently:
> >
> > https://lore.kernel.org/all/20221220164132.443083-2-peternewman%40google.com
> >
> > I think the name you picked is misleadingly general. "local if
> > available, otherwise total" seems to be a choice specific to the mbps
> > controller. I think these functions should be reconciled a little
> > better.
> >
>
> Peter (and Babu, who made the same point about get_mbm_state().
>
> Do you want to see your function extended to do the "pick an MBM event?"

What I meant was I think it would be enough to just give the function
you added a name that's more specific to the Mbps controller use case.
For example, get_mba_sc_mbm_state().

It's only problematic that you added a function with an equivalent
name to an existing function that does something different.

-Peter
