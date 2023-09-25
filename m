Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAC7AD2CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbjIYILV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjIYILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:11:15 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF6AD3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:11:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c6052422acso265655ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695629465; x=1696234265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NKbf24bNvP0D/RfBWBt2avTfFTOlwhX9Npr4nrglv4=;
        b=H/G6uBqZ74aycw8cwD5GJSQcKu3RJ1khbjaMXFMKzEqGyWUD0Q6nIjBjVoi9DykCVN
         CQYZ7i1p7zRPJkMaPjW43U6hxavvZqamrDx8QhhVCfVVp4AxXFC8jRAoAQYR3U+EQLLK
         YMT8V1kPkiSpEylYkM6wDjsJ5cGc6qA9YmqbgmSg+5Ad0lO/zC+MJglga0D8ue1vEz28
         /moT7hAp3omjrOiaDPdWSqZEy21+ulW5jQjVYVrToDFoTXea+pk7l9uWWplSBFB/scEv
         rWoUcRyHjJ2WXJyydW4YCJ9ZEJZY0I4m0WMgIcjYkirfxvSYjq89YJTpWRRhJsgXDDKr
         v3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629465; x=1696234265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NKbf24bNvP0D/RfBWBt2avTfFTOlwhX9Npr4nrglv4=;
        b=OGHVWS0ieqDU8RLXs0Ml/mWQ/Dd40TL1flDlWgnQ0sVCtGS/NK5Qsy/H5PX+Gh7/+4
         so713fO2L5ccUp9arBHXgNXcdeseMYtWDoLeTJNiqET42Ybl5xUT720c04WN+Iq6pJAg
         iuJ3GyJ/WQkdUMzqBbkLcdccg4Qf1bkQOZqhMQccKZ/GlskVHgXKMeHZ/JeLVUAb4DEE
         rrfPtuKksUKWeRkWVsRfjjvxXY915x7BE2XoBAy84kTABSldlSV2DKCsRyFEKxlUDA90
         qe8mOOOzYd/iO1QAnga3I2dPQl9geth4k0+nAVkBm0GL8AWxspAMFLl6XsJQgCUyn2qd
         nE7A==
X-Gm-Message-State: AOJu0YxsRZIz9OQuGUeNNgvjm31O0z4pKbfz1JOloa8+dZZPZ58559ws
        MQfB8Jy56r97WW7PFHZGWnA2HCExwadVD6CHiPZ5Zg==
X-Google-Smtp-Source: AGHT+IE+w+w7FisAIKMCvVvdSU7Kdj+p72iJcD6MKJoVENHTMobP+6ZpHG0BZJUOkJ1HCgoTl47F61X72+oxWFSetsc=
X-Received: by 2002:a17:902:ce89:b0:1c3:35c8:e55a with SMTP id
 f9-20020a170902ce8900b001c335c8e55amr273492plg.28.1695629464753; Mon, 25 Sep
 2023 01:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-11-babu.moger@amd.com>
 <CALPaoCj46dDCFruHW3EcqRQ90SZpOsKK2UVPzb+88rzs5aTTJg@mail.gmail.com> <51ff0094-5c7b-824b-8b3c-2439e5477725@intel.com>
In-Reply-To: <51ff0094-5c7b-824b-8b3c-2439e5477725@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 25 Sep 2023 10:10:53 +0200
Message-ID: <CALPaoCi+dqg-D6Ebn8UAoMPpdmPyVDZ_fUhWiwfUW0S9N6rZOg@mail.gmail.com>
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com
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

On Fri, Sep 22, 2023 at 7:59=E2=80=AFPM Fenghua Yu <fenghua.yu@intel.com> w=
rote:
> On 9/22/23 07:36, Peter Newman wrote:
> > On Sat, Sep 16, 2023 at 12:42=E2=80=AFAM Babu Moger <babu.moger@amd.com=
> wrote:
> >>
> >> In x86, hardware uses RMID to identify a monitoring group. When a user
> >> creates a monitor group these details are not visible. These details
> >> can help resctrl debugging.
> >>
> >> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface=
.
> >> Users can see these details when resctrl is mounted with "-o debug" op=
tion.
> >
> > When I reviewed this, I went through the whole series second-guessing
> > the wording above and wondering whether "monitoring groups" applied to
> > CTRL_MON groups.
> >
> > I was able to confirm that mon_hw_id did appear and had a believable
> > value in CTRL_MON groups which had allocated monitors. (and I added
> > some comma-separated PID lists to the tasks node)
> >
> > for the series:
> > Tested-By: Peter Newman <peternewman@google.com>
>
> Please use "Tested-by" instead of "Tested-By" (the "By" is wrong).

Tested-by: Peter Newman <peternewman@google.com>

> >
> >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/=
cpu/resctrl/internal.h
> >> index a07fa4329b65..b4910892b0a6 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> >> @@ -296,6 +296,11 @@ struct rdtgroup {
> >>    *     --> RFTYPE_BASE (Files common for both MON and CTRL groups)
> >>    *         Files: cpus, cpus_list, tasks
> >>    *
> >> + *             --> RFTYPE_MON (Files only for MON group)
> >
> > If monitoring is supported, all groups are MON groups. I think the
> > "only" above caused me to second guess whether this takes into account
> > CTRL_MON groups getting the RFTYPE_MON flag set dynamically.
> >
> > However, I think the documentation above is still technically accurate.
> >
> > for the series:
> > Reviewed-By: Peter Newman <peternewman@google.com>
>
> Please use "Reviewed-by" instead of "Reviewed-By" (the "By" is wrong).

Reviewed-by: Peter Newman <peternewman@google.com>
