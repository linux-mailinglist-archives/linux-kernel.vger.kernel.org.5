Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7990080958A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjLGWpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjLGWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:45:10 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C801709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:45:17 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4258b6df295so96591cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701989116; x=1702593916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkuIzoN396jqYT+Pk75+VoEYaTQnHg5zkQllCC1Stfc=;
        b=FXrxwxAifDQYaC3srMRdQ/4dqB/2siC0IOSk7q6n4KnMbt13LhSkjVCZXhSnwlWmFy
         E3RM+tdfjp3TiEgMae+a36yuxNHll6DSgxTRg5VbbTm2QPE234OivE9/ariGhsmL6mpT
         F13FRGqrYOk7dVkXmzweaBFdAAh5H5tXAxExGOuzf1XhWGEO34DsJ5xVNIWq8fSK/rNO
         1e75YWz0u4+iVi7xrW1sAbV+0ZMs903cSBUsMy4TDoyTA93+6IxgkMSHpvZh59/DvG4Z
         e03CjW+jLZjJZrCp1cnl9glLH3NzPjr9U5Mf+QQP3L7XVzzR7qkmrSSHEmGwfwIbG4ej
         8nPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989116; x=1702593916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkuIzoN396jqYT+Pk75+VoEYaTQnHg5zkQllCC1Stfc=;
        b=QUHXWcx3iQ1sW8bgGnFdrUDugzS25tHl1oAXudOTJbI4tftFJRHo6puEwhF5bXT52l
         zqQUCzVV3DZBscqX6+2BKtasvy711u82XQgtRY9meLi8sd5foqgwpYNzlGuDsHin1YUX
         Jmk1ihz+2lucbHS/ut9pxz3ctQ/7G1nWWmp3uxf9MkWPueqc0j2gZQBtfS16FDHYt7ty
         rR131Fsxa7MXn5+Mr8H58DwYJmj5b+0IS4xAbcTuBR5xKji83cNY8fK2G1rqVWrKOKy8
         JHc79cTyl96iK+2lhuWae/TzrLWKqOexfbdv8PEQQ7SWUzvjcXCiwjnimdaa258SCiUj
         krHw==
X-Gm-Message-State: AOJu0Yw5fSVHcKDMuLgFdZpsK8aSxRjqwkmjhWMwS2FiEyLd2XUcsdkj
        1NI8zy/i++SNKRlTItod2im0elkLXxvpK+KTANXwaA==
X-Google-Smtp-Source: AGHT+IH2Ee5fQ2BMKGV5V0CAb7d7P5bahZSNARWtZJJA7pnbKyLDlUQTzvbGMsPydmQi6PxASuAciYGntOuuhoIaNAo=
X-Received: by 2002:a05:622a:413:b0:423:98a3:422 with SMTP id
 n19-20020a05622a041300b0042398a30422mr39958qtx.11.1701989116154; Thu, 07 Dec
 2023 14:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20231111014933.1934562-1-davidai@google.com> <20231111014933.1934562-2-davidai@google.com>
 <865y231jvj.wl-maz@kernel.org>
In-Reply-To: <865y231jvj.wl-maz@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 7 Dec 2023 14:44:36 -0800
Message-ID: <CAGETcx9-n0z5buWgtLZ+6VxW2jEko1GWzkGtGhFiZEq-x_G4nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: cpufreq: add virtual cpufreq device
To:     Marc Zyngier <maz@kernel.org>
Cc:     David Dai <davidai@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Quentin Perret <qperret@google.com>,
        Masami Hiramatsu <mhiramat@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Gupta Pankaj <pankaj.gupta@amd.com>,
        Mel Gorman <mgorman@suse.de>, kernel-team@android.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Nov 15, 2023 at 12:49=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Sat, 11 Nov 2023 01:49:29 +0000,
> David Dai <davidai@google.com> wrote:
> >
> > Adding bindings to represent a virtual cpufreq device.
> >
> > Virtual machines may expose MMIO regions for a virtual cpufreq device
> > for guests to read frequency information or to request frequency
> > selection. The virtual cpufreq device has an individual controller for
> > each frequency domain.
>
> I would really refrain form having absolute frequencies here. A
> virtual machine can be migrated, and there are *zero* guarantees that
> the target system has the same clock range as the source.
>
> This really should be a relative number, much like the capacity. That,
> at least, can be migrated across systems.

There's nothing in this patch that mandates absolute frequency.
In true KVM philosophy, we leave it to the VMM to decide.

-Saravana
