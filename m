Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17A17D8157
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344711AbjJZKyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjJZKx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:53:58 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F6195;
        Thu, 26 Oct 2023 03:53:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-32f5b83f254so540796f8f.3;
        Thu, 26 Oct 2023 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698317633; x=1698922433; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfM7+/5S6tv36A7gcla7bfJJw/bBuZjPJgSkhs5PVuk=;
        b=VnDVxBQRgNhm9h1PA5dje+sQcwojrxmgkHDzjT9xpZuxVDe0XrEDB0L9W9od+VybFh
         qB3WAyoDhER403BdFFC34CAt2yABG92lk3Vzq+khozjqYVc/ajN/IpCTNeohbxGai9Ka
         wfdjEaLnVmaXbMLr0iWp4INSpfgnl8W07Ez5cSuxz4kYJMLLWeoPib9lGjT6wQPTm4O9
         3c3LFSJjKnyqrDJa3O0EIBYhSc0JhJVvTF0jk+5DTvBQDIoUeyEisl4oNrzTOIqyrrpy
         uymBoXNpospH04MdNmRAf2xuvpwBplzNlxB8NcQrr8cMfYFW5T+6jZcp+YgmcNX//3r5
         ysiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698317633; x=1698922433;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfM7+/5S6tv36A7gcla7bfJJw/bBuZjPJgSkhs5PVuk=;
        b=s2+q3U8vkMju2J3NSeFAbZxNOU/G7gOywwex1qqxTSE8Zp+eDAP87FSP62vUDSsTH9
         3XbJ5rWD/COcQ76P1bKyOpJbdUjRDpOQCChA2L5GqEl8KLmRdg4B6gT+hJw5qcp/6ltf
         IyU7RW659/4/s5V+3W054CHI0DSc+edCgeiF+ZVcIL4kJavBeB9udxQCFb+m1eRmPsv8
         AP1lOinlaZh5UQ1oY+LLR2vB9A0dnLKg0IUZyOnBy6TlBsikaKUi6fEaA2lUFlZ4GEpE
         brZ9J7WzqR8m4leSZBQMq2/xwtUAP2rtnS9OSGjfA60Yxnf0vjIJlGpU2RG2K0L4Brho
         FCPg==
X-Gm-Message-State: AOJu0YzbFBFUzx/sfRNTzVlvQ7ivhwUR6oabfGPYtCQxkrfvvxEGRh6S
        tCKyriP5hr1LOs6NRpgCoCPslU/LjFM=
X-Google-Smtp-Source: AGHT+IGKs2TdCo2eJyoLGjqt05bnjp6G41CClsYEykzy4hfL4dcFFqhk8HNQoex+Ffy/4q/bZXA64w==
X-Received: by 2002:a5d:598d:0:b0:32f:649f:aa2b with SMTP id n13-20020a5d598d000000b0032f649faa2bmr1205623wri.17.1698317633054;
        Thu, 26 Oct 2023 03:53:53 -0700 (PDT)
Received: from Ansuel-xps. (host-82-61-188-111.retail.telecomitalia.it. [82.61.188.111])
        by smtp.gmail.com with ESMTPSA id m21-20020a056000181500b003271be8440csm13985084wrh.101.2023.10.26.03.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 03:53:52 -0700 (PDT)
Message-ID: <653a4540.050a0220.1e832.01c8@mx.google.com>
X-Google-Original-Message-ID: <ZTpFPqtcf6pnZQcO@Ansuel-xps.>
Date:   Thu, 26 Oct 2023 12:53:50 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Takashi Iwai <tiwai@suse.de>,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/3] cpufreq: fix broken buffer overflow detection in
 trans_stats
References: <20231024183016.14648-1-ansuelsmth@gmail.com>
 <CAJZ5v0gzV+nX+dSEShAopkcvx1Zx2Rc2=pjcdH07U9nQhHRe4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gzV+nX+dSEShAopkcvx1Zx2Rc2=pjcdH07U9nQhHRe4Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:03:35PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 24, 2023 at 8:30 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> >
> > Commit 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential
> > buffer overflow") switched from snprintf to the more secure scnprintf
> > but never updated the exit condition for PAGE_SIZE.
> >
> > As the commit say and as scnprintf document, what scnprintf returns what
> > is actually written not counting the '\0' end char. This results in the
> > case of len exceeding the size, len set to PAGE_SIZE - 1, as it can be
> > written at max PAGESIZE - 1 (as '\0' is not counted)
> >
> > Because of len is never set to PAGE_SIZE, the function never break early,
> > never print the warning and never return -EFBIG.
> >
> > Fix this by fixing the condition to PAGE_SIZE -1 to correctly trigger
> > the error condition.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 3c0897c180c6 ("cpufreq: Use scnprintf() for avoiding potential buffer overflow")
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/cpufreq/cpufreq_stats.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> > index a33df3c66c88..40a9ff18da06 100644
> > --- a/drivers/cpufreq/cpufreq_stats.c
> > +++ b/drivers/cpufreq/cpufreq_stats.c
> > @@ -131,23 +131,23 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >         len += sysfs_emit_at(buf, len, "   From  :    To\n");
> >         len += sysfs_emit_at(buf, len, "         : ");
> >         for (i = 0; i < stats->state_num; i++) {
> > -               if (len >= PAGE_SIZE)
> > +               if (len >= PAGE_SIZE - 1)
> >                         break;
> >                 len += sysfs_emit_at(buf, len, "%9u ", stats->freq_table[i]);
> >         }
> > -       if (len >= PAGE_SIZE)
> > -               return PAGE_SIZE;
> > +       if (len >= PAGE_SIZE - 1)
> > +               return PAGE_SIZE - 1;
> >
> >         len += sysfs_emit_at(buf, len, "\n");
> >
> >         for (i = 0; i < stats->state_num; i++) {
> > -               if (len >= PAGE_SIZE)
> > +               if (len >= PAGE_SIZE - 1)
> >                         break;
> >
> >                 len += sysfs_emit_at(buf, len, "%9u: ", stats->freq_table[i]);
> >
> >                 for (j = 0; j < stats->state_num; j++) {
> > -                       if (len >= PAGE_SIZE)
> > +                       if (len >= PAGE_SIZE - 1)
> >                                 break;
> >
> >                         if (pending)
> > @@ -157,12 +157,12 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
> >
> >                         len += sysfs_emit_at(buf, len, "%9u ", count);
> >                 }
> > -               if (len >= PAGE_SIZE)
> > +               if (len >= PAGE_SIZE - 1)
> >                         break;
> >                 len += sysfs_emit_at(buf, len, "\n");
> >         }
> >
> > -       if (len >= PAGE_SIZE) {
> > +       if (len >= PAGE_SIZE - 1) {
> >                 pr_warn_once("cpufreq transition table exceeds PAGE_SIZE. Disabling\n");
> >                 return -EFBIG;
> >         }
> > --
> 
> Applied (with some edits in the subject and changelog) as 6.7 material, thanks!

Hi, I just notice this landed in linux-next but I can't find the devfreq
change. Only the cpufreq patch has been taken and the devfreq ones are
still pending?

-- 
	Ansuel
