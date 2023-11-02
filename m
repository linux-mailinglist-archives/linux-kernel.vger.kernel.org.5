Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DC27DF67F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376848AbjKBPeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376845AbjKBPd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:33:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8E413D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 08:33:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5b9a456798eso734121a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1698939230; x=1699544030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jGrzac9Ke25hyD7VfuBtsDHZigqOcYObR1W1e8Hntzg=;
        b=Gyne+yRSUFJHNI5jLRJSkgUTRUSbk8Zy/1fJCdEkqgBg6ZmE6HBqWnWCgr2BuP3e1G
         wT38rmmGMDOfWrXFqKEuH+826tm/c8p86RTjqHqzdoSDWX578GH8OVmrbfB9KOXMCVIC
         b8xOqJuYYcV2VDNTh3X5AUm0SDut868Phq8hyGw41dk9t5630+sPoZ1vC/AmCZfMmtlk
         wZEwAynHbs9QvrPNKxr+78ZFMHGNWmK1XJYIQ8O0sdZLAgX35qDecPhy2rX+LkJ6s4dX
         /NZoeeTm6RAuPmz+suUqBfUr6rxqJ7NLnEzdWgoiiUKzct2WFCUqPpv6X7cclmThNeLU
         39Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939230; x=1699544030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGrzac9Ke25hyD7VfuBtsDHZigqOcYObR1W1e8Hntzg=;
        b=BGjmodc0vRiO1DqNExPNzxFQrKRxP4i3GnQoFA0X6pdYfw4fpqFFuZugJS3zhjLBfX
         jxE71PJrkyCpbGEBJuOzvyuPbDV/A3do5FFgcs7OPou7dbgcSj+DkwZcnJ/xS2kdGewO
         z5FBdd5QUz8N86ak472KcHazHdsINGQ8HHgyvi5EO5cw0Y1QCdwQsmLAMlQVFYq9gCm2
         EXYxwaXEoC62qA4PS6T/Te8mrjCMaAjMmfjXnk3SshSCc+eyR9CyO9gqLg0IVU/EuuVR
         VVZY3E377dMw7TAKR1OXakwy6LPM6ALzbyv2xzB6iuz6/8ej4sQY6byou5AjDvEvnhp+
         EqtQ==
X-Gm-Message-State: AOJu0YwOhLBMgi2DACQwCSr4pIsdHQALiwdwmC7b+f5QcF4ray7Ad1hh
        wYomZU+IJgmwZuAt5c1BM0w9HCrYhSXCXOBBq4u6dQ==
X-Google-Smtp-Source: AGHT+IFnHU3rJNh7c+C1uFUmb2F/kNHMNOZqSXUAaW6ls82UIJxRLvlnNqvew//xl91JGebgjmRT8As3fkJE404qdJ8=
X-Received: by 2002:a17:90a:fd8e:b0:27d:1c70:23d4 with SMTP id
 cx14-20020a17090afd8e00b0027d1c7023d4mr15158905pjb.44.1698939229731; Thu, 02
 Nov 2023 08:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231005133059.917577-1-naresh.solanki@9elements.com>
 <f8dd6d53-7c0b-4a89-9ec4-400aa242c020@sirena.org.uk> <CABqG17iufSniSLZ2vU5fFduFwV2FL8jNzMcsveOgFUME1jXmgg@mail.gmail.com>
 <aa3f5615-dddf-4c94-88c7-494cf7cd80ab@sirena.org.uk> <CABqG17h949R+3NFgA1MvPLZFc6zkBi+WRPSE9qP4fCBv5gdXHw@mail.gmail.com>
 <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
In-Reply-To: <c2dd0533-3a60-4481-8621-86578e62aab6@sirena.org.uk>
From:   Naresh Solanki <naresh.solanki@9elements.com>
Date:   Thu, 2 Nov 2023 21:03:40 +0530
Message-ID: <CABqG17h0OnMD-L1vYkJobji+Z=QPuYrd=ra1d7DncAN0_TO23A@mail.gmail.com>
Subject: Re: [PATCH] drivers/regulator: Notify sysfs about status changes
To:     Mark Brown <broonie@kernel.org>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, 2 Nov 2023 at 20:31, Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 02, 2023 at 08:17:35PM +0530, Naresh Solanki wrote:
> > On Thu, 2 Nov 2023 at 18:36, Mark Brown <broonie@kernel.org> wrote:
> > > On Thu, Nov 02, 2023 at 05:35:42PM +0530, Naresh Solanki wrote:
>
> > > > > We probably should filter the events more, there's events for pre and
> > > > > post voltage change for example which aren't status changes so would be
> > > > > spurious.  It ought not to break anything but we should still avoid
> > > > > unneeded work.
>
> > > > Can you please provide me inputs on the additional filtering needed for this.
> > > > Like some list of events for notify on status?
>
> > > I think I'd start off with just reporting things that are obviously
> > > errors and not things that should ever go off during normal operation.
>
> > This is what I could come up with:
> >         if (event & REGULATOR_EVENT_VOLTAGE_CHANGE) {
> >                 name = dev_attr_microvolts.attr.name;
> >                 sysfs_notify(&rdev->dev.kobj, NULL, name);
> >         } else if (event & (REGULATOR_EVENT_DISABLE | REGULATOR_EVENT_ENABLE)){
> >                 name = dev_attr_status.attr.name;
> >                 sysfs_notify(&rdev->dev.kobj, NULL, name);
> >         }
>
> That's the opposite sense to what I was thinking of - we're reporting
> voltage changes and enables to userspace rather than just errors.  My
> concern here is that this could generate an awful lot of notificaitons
> for normal operation on systems that don't use the uevents, I was
> expecting this to be used for errors.  Could you remind me what the use
> case is here, I think I might've got myself confused sorry?
Sorry for confusion caused because I should first described my application
requirements.
Currently my application is interested in know regulator status i.e.,
ENABLE, DISABLE or ERROR.
Also events are needed specifically to get them logged like
UNDER_VOLTAGE, OVER_CURRENT, REGULATION_OUT,
OVER_TEMP.


Regards,
Naresh
