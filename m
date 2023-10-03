Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A697B69B0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjJCNCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjJCNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:02:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39060CE;
        Tue,  3 Oct 2023 06:02:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5333fb34be3so1509719a12.1;
        Tue, 03 Oct 2023 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696338118; x=1696942918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUm4k8YFZsdrzLTC0JYCtRb9Jw4K2/14b8pIJen40pU=;
        b=dQOeC0ioQNCumsXXTQz4yukLx1YDy8k2bZYlVENBr+SXwP/mi9Tkjbt5Q25Wwkcd+l
         o1RkLEA325eHOEkW+1COYdr62bJeEuMcxZQSAzsIJq4G+i7juJWzLLoukRHal9HEDGsU
         3TKfmyFWmJV680/NKgaZPmUHrGNPDILbG2djgSVCqjRUU0hbM7oFw7amFhkiDIRM6oRG
         2qat3qFBYjh6v0LZO8sOw82z9UIRZ4TJpguTcnXzSA3z/vNEd4Clm/KobuV2oEPvOYem
         WtDjvnu833V7SRpj49s3B3ghxBn3dN00vXsxa+rlE6an9ilqgEALyzWLtd5BlkSuc2Wh
         b05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696338118; x=1696942918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUm4k8YFZsdrzLTC0JYCtRb9Jw4K2/14b8pIJen40pU=;
        b=ThPYCanO0yb9a4cDCqaGMrzHbRe6nmt76cO+/EtpQf+8cpL4+02Pw/EAA/aSgHAuND
         885FA8kyUUhYyEM1X2hZo6qEeNFERd3xyzIJ0nogyH/Z8EOcVom5iAnTym1z2R3cM6Yo
         fLtO+SySyFkIS4zP/FvDRcpygohrKzVLePIevv8e5HraSilnNWpZCAJgGNvjDbuMqKpg
         YnDgLNckGzKvKVvhvYBMWMtA4cD2JWbDVxRFJ3gFSzKertkv15GcwVwfOSjHrpRvaOqv
         A4HQNSIWrcVnO8YzTraytHX61duIIId/D1ly4LRJRPLqyIa94wlk3NvTE902gnilGFz5
         vYDQ==
X-Gm-Message-State: AOJu0YwOvx3DqfxTLadhBXsX3jx8YNN92P0dO3HJPWXk2Z459hV+tyS+
        ZC44J5d96YtTnajdhHTGzCA=
X-Google-Smtp-Source: AGHT+IFbjy2IsLkWB8B7QOKKUxqEBmkpvjB1hKKPFYLMHL5edqTjDDQyLjMU050zt5sydT7vi3EX5Q==
X-Received: by 2002:a05:6402:610:b0:522:ca6b:ad7d with SMTP id n16-20020a056402061000b00522ca6bad7dmr12698274edv.9.1696338118243;
        Tue, 03 Oct 2023 06:01:58 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id r19-20020a056402035300b0053448f23b33sm836886edw.93.2023.10.03.06.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 06:01:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 15:01:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Elliot Berman <quic_eberman@quicinc.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, kernel@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prakash Viswalingam <quic_prakashv@quicinc.com>
Subject: Re: [PATCH v4 0/2] Avoid spurious freezer wakeups
Message-ID: <ZRwQw7YP5MsiPoTg@gmail.com>
References: <20230908-avoid-spurious-freezer-wakeups-v4-0-6155aa3dafae@quicinc.com>
 <ZRMEHb3_0Ku1UuK_@google.com>
 <20230926200238.GB13828@noisy.programming.kicks-ass.net>
 <a0456690-1917-4d82-877a-f23d871049b5@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0456690-1917-4d82-877a-f23d871049b5@quicinc.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Elliot Berman <quic_eberman@quicinc.com> wrote:

> Hi Peter,
> 
> On 9/26/2023 1:02 PM, Peter Zijlstra wrote:
> > On Tue, Sep 26, 2023 at 04:17:33PM +0000, Carlos Llamas wrote:
> >> On Fri, Sep 08, 2023 at 03:49:14PM -0700, Elliot Berman wrote:
> >>> After commit f5d39b020809 ("freezer,sched: Rewrite core freezer logic"),
> >>> tasks that transition directly from TASK_FREEZABLE to TASK_FROZEN  are
> >>> always woken up on the thaw path. Prior to that commit, tasks could ask
> >>> freezer to consider them "frozen enough" via freezer_do_not_count(). The
> >>> commit replaced freezer_do_not_count() with a TASK_FREEZABLE state which
> >>> allows freezer to immediately mark the task as TASK_FROZEN without
> >>> waking up the task.  This is efficient for the suspend path, but on the
> >>> thaw path, the task is always woken up even if the task didn't need to
> >>> wake up and goes back to its TASK_(UN)INTERRUPTIBLE state. Although
> >>> these tasks are capable of handling of the wakeup, we can observe a
> >>> power/perf impact from the extra wakeup.
> >>
> >> This issue is hurting the performance of our stable 6.1 releases. Does
> >> it make sense to backport these patches into stable branches once they
> >> land in mainline? I would assume we want to fix the perf regression
> >> there too?
> > 
> > Note that these patches are in tip/sched/core, slated for the next merge
> > window.
> 
> Can the changes be scheduled for the next 6.6-rc? I'd like to get the
> changes backported to stable sooner since we observed the regression on
> real systems.

These are pretty risky and go beyond fixes for regressions introduced
recently: the original commit is more than a year old.

But I agree with having the fixes in stable once it hits upstream in the v6.7 
merge window - the difference would only be a couple of days vs. -final.

Thanks,

	Ingo
