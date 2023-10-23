Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFC67D41D3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 23:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjJWVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJWVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 17:43:10 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B85FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:43:09 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1e5bc692721so2560961fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 14:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698097388; x=1698702188;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC1AuNrnPb02mjlo1B2ii/cy1DNEJrEZsARzdachcns=;
        b=kR7tdkEFwfDuziRawD+0AR6ReCR4s4nNjceGYU16on9OCLW5YXxae6NBxv44HJtYnG
         bfghkk5FMZQ9sJ8A5Blfz39Q7elx08CYYc2t7Qdtlif4qgNDF7p9963UsrmClrOBV8Wc
         hBRDAeBPwEB5HQQw/Vj37U+J/RDyZBLVRjgT265nuk3LqXwo34ab7QaWb+/eXEcZyl5c
         vEXHL9L8LaYP40ZMwKD7lmtKJdwZMo9ZB+Gu51wWsfW9k7n0cQouXi/EkHMjn8adaE3k
         7TyDdc0MDdl1K6RiI36Cpimjq7zfq6Uc5Z5IUUcTgrnYYOfk+c3yz8bmeIRsLMmYv216
         Z9TQ==
X-Gm-Message-State: AOJu0YzAYw1piCZALvMYvAU+99RfPJEYiikDR0VI4m5lof00B1087Wfw
        DLKCwvIZuUnb0sQfjrbBXMw=
X-Google-Smtp-Source: AGHT+IEw47gEZcav+mMkiLaROb71EVO5ssYegSS2vy5BHRFDQnlDTLEW/qDNvTM2BI7d31zPQGJTXA==
X-Received: by 2002:a05:6871:4186:b0:1ea:ced9:616e with SMTP id lc6-20020a056871418600b001eaced9616emr14119850oab.46.1698097388228;
        Mon, 23 Oct 2023 14:43:08 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id w14-20020a0562140b2e00b0066db331b4cdsm1269584qvj.86.2023.10.23.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:43:07 -0700 (PDT)
Date:   Mon, 23 Oct 2023 16:43:04 -0500
From:   David Vernet <void@manifault.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, joshdon@google.com, brho@google.com,
        pjt@google.com, derkling@google.com, haoluo@google.com,
        youssefesmat@google.com, greg.marsden@oracle.com,
        willy@infradead.org, andrea.righi@canonical.com,
        andrealmeid@igalia.com, changwoo@igalia.com, gpiccoli@igalia.com,
        tj@kernel.org, colin.i.king@gmail.com, ast@kernel.org,
        julia.lawall@inria.fr, himadrispandya@gmail.com,
        redha.gouicem@rwth-aachen.de, admin@ptr1337.dev,
        lucjan.lucjanov@gmail.com
Subject: Re: Sched Ext slack channel / office hours
Message-ID: <20231023214304.GD32029@maniforge>
References: <20231018205431.GA4176@maniforge>
 <20231019093109.4c4406b2@gandalf.local.home>
 <20231023175326.GA4055@maniforge>
 <20231023144603.1e18b8bf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023144603.1e18b8bf@gandalf.local.home>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:46:03PM -0400, Steven Rostedt wrote:
> On Mon, 23 Oct 2023 12:53:26 -0500
> David Vernet <void@manifault.com> wrote:
> 
> > Yes, it could be beneficial to attend your meeting as well. Please feel
> > free to send us an invitation to any instance of your meeting that is
> > related to sched_ext.
> 
> It's a very informal meeting and the agenda is usually created at the
> meeting. So there will never be a "we are going to talk about sched_ext".

Got it.

> If that topic comes up, it will be because the people there want to talk
> about it. The people that usually attend are:
> 
>  Myself
>  Juri Lelli
>  Daniel Bristot
>  Joel Fernandes
>  Vineeth Pillai
>  Youssef Esmat
> 
> But it's open to anyone that wants to attend. I should send out more
> invites to others that participate in the scheduler work. I sent an invite
> to Peter, but he's never accepted.
> 
> And sometimes we get a few others. It's mostly just to discuss latest
> trends of the scheduler.

Sounds good, please send me an invitation and I'll join whenever I'm
available.

Thanks,
David
