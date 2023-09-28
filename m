Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AC87B165C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjI1Irt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjI1Irn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:47:43 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CF1A4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:47:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c60128d3f6so144295ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695890854; x=1696495654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N19yixq+6GIBI3tMHHjDyP2IQdLTgvat6sicgG9VWZo=;
        b=D77aHiTIh5O7OqlXh/K2yrpimUYDc3X1r+PwjmtVZx3lZchaodPrghYdtvCi9RLsit
         oee3k56lRoDezuQKF7ixpYvUdfho2tZYYlhFW1GQdx6zy1pUjwmvKKAfKeF5HIWb/TzF
         76QVgr0W2aCTNwR9RXM34J1UKFI9YEoFCCk0hzgseT9kGXfa+NesVK+A7uGUJN6mXckR
         7ATqzPAlewCzey9p13zjQXxFTRDTJjIvzk6CLvzo9gRANNl1b0qFNOJL5VeyiN4fyCZc
         y0QLLdRIhwn8eitOf5Vwda2rQBkOLzRaOx1+rbfVRzVz9m1tN/+8b1Jo8QhA+M9Wkjgy
         atXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695890854; x=1696495654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N19yixq+6GIBI3tMHHjDyP2IQdLTgvat6sicgG9VWZo=;
        b=CwxWCLPlNiXefHWawfdvU3dZ9H9jepFgNumsQu+pBjcWBuj+smIEjncmDuSRL9RxMz
         dgwoXDI44Cx8dovLrqXjYQcH7/wNrum9ushJKis4WxvT2klZJAQgZBayHz+8eg3LWCMd
         1QpiTmgrO+vekWmOcDVY0Jv+Pip69TCayJscEL6UGONPXbeQ+HB2K/ksI+i4VXqtQPNz
         2/LJDJ/bHS2SXfO/69QnVGscIJSLS6qYQu/dBA/6yRwJVBPVelDVina6qLUSB3X2S1vs
         9aUK/lTUZzZeycZu27KE7ZdDKfAUALP7PvcIEW0GyNMBQQtfRuMIzzZmd7uvbTb5mYeg
         87/A==
X-Gm-Message-State: AOJu0YwOTjLPFlexEHlVCDDTqmRKztzCcraR0AxxFSCwOFHUZZ1/kUSA
        TYfRWqzXb6QBVl+tPIhuZXMSzxQaBBCiM6U/rEhS7ShiekURmuul6BcMpw==
X-Google-Smtp-Source: AGHT+IGYKCWt5pl3KRgwnFL/dHyjbz/4QkMSeD6U3CGLTG4uB00JMZEXJNyZlxUzb2lRLy9q/ZHaKBuyH/4bmVBdI/U=
X-Received: by 2002:a17:902:ec8a:b0:1c1:efe5:cce5 with SMTP id
 x10-20020a170902ec8a00b001c1efe5cce5mr635798plg.3.1695890853541; Thu, 28 Sep
 2023 01:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
 <ZOkU+d4AsLGSAG+y@agluck-desk3> <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
 <ZOlRNTq3lE7VNHjU@agluck-desk3> <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
 <ZPjDHN0nvHz9kWFn@agluck-desk3> <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
 <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com> <ZPuqsupe+BevodqO@agluck-desk3>
 <ZQSY5P8R5Q+OuvXB@x1> <20230918114420.000058c3@Huawei.com>
In-Reply-To: <20230918114420.000058c3@Huawei.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 28 Sep 2023 10:47:22 +0200
Message-ID: <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
Subject: Re: resctrl2 - status
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Drew Fustini <dfustini@baylibre.com>,
        Tony Luck <tony.luck@intel.com>, babu.moger@amd.com,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jon Masters <jonmasters@google.com>,
        Stephane Eranian <eranian@google.com>
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

On Mon, Sep 18, 2023 at 12:44=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
> Drew Fustini <dfustini@baylibre.com> wrote:
> >
> > This reminds me that Linux Plumbers Conference [1] is in November and
> > I think resctrl2 could be a good topic. The CFP is still open for Birds
> > of a Feather (BoF) proposals [2]. These are free-form get-togethers for
> > people wishing to discuss a particular topic, and I have had success
> > hosting them in the past for topics like pinctrl and gpio.
> >
> > Anyone planning to attend Plumbers?
> >
> > I'll be going in person but the virtual option works really well in my
> > experience. I had developers and maintainers attending virtually
> > participate in my BoF sessions and I felt it was very productive.
>
> FWIW I'm keen and should be there in person.  However, I'm not on the mus=
t
> be available list for this one ;)   Agree that hybrid worked fine for BoF=
 last
> year.
>
> Jonathan

I got us a BoF session to talk about resctrl and porting it to new
architectures:

https://lpc.events/event/17/contributions/1567/

To anyone planning to attend, while the schedule is still easy to
adjust, please let me know if the proposed time (Nov 15, 4:30-5:15pm)
doesn't work.

Also I got one registration code for scheduling this. Let me know if
you want it.

Thanks!
-Peter
