Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50007A51B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 20:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjIRSIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjIRSIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:08:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8A1114
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:07:47 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5d4a8242so57946117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695060466; x=1695665266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GmTnJV1ADdgeWLSdVtD0/++n9rF2F3zpNnWnlLAWBfc=;
        b=GgolAgTXkgd3VIcWP7ez1fL2XXc6EffJ/lZHJY+CaZmD4jVSs7DGfqajEaHeJcUNuW
         FkavDT6fVgLVQ5xkOGOJJnVLtWhrkkxlS1HxNL7qqHmZ/kzCz7vnHVdVkg9MKC3dEG73
         AOoTgxwQoGiOaYTgW43KnWApZ6N8oLXKjkaxD+mQ+tTSSvG31kNCNO8kTIXcrmPfJ3ZF
         1ObEDp++U8gHy1Ik4SdqWwJVtkmv3UCUicQmXjiJ/R8Ruxmjfu/qsZ4Sd7gxI/ix0M2D
         j67xIjfUbFDe2nJWRSUpW5FDCfcr3Cq1FFFQDtTEi2uBnbDtJD6OHIzX2wn+zgy5S8IK
         IQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060466; x=1695665266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmTnJV1ADdgeWLSdVtD0/++n9rF2F3zpNnWnlLAWBfc=;
        b=XtYnC0llTPWd3Pi1bBizmQI2TpD87RiSv0XDIKSMyz7kiARzIGcno9No1f46F4UtlQ
         c85AQuM8dWxFLjhCq3UMfl+bfC4sKjvrhNmiS+mLeIxK6lJzCiXcFYL9lhhsevhMA1T8
         jklBQE517TkuA4aD+6u+SpRXPu+YhuavBrc1WsicsXaTkuR/eo7XGqBbOBfXVzkcFldJ
         f8hzh6QKkS5hEVVpUOvCn9RKJkJhXVzlIh77dNXI260mUJ2hkukF63TWEdANeZvyZFSU
         FSJUQcuP9I+MPRtuNC8RIs+wP7Zo4rALGh6b8OgAXVqBRh9pLWymc1ml4P4ue8IeYK4E
         /dSw==
X-Gm-Message-State: AOJu0YyzH7OsvoE7qyNusTwOqiXW686VSaWoHo1aVaYGn3xNbTOJhm1v
        hsvu26xuyABFffS/RluqPHOzDe82VRs=
X-Google-Smtp-Source: AGHT+IEq7OsCrz76V3mWe/TIshYEHjDRsyEPSR2V+8pZ5m5ogKwdrddivlWbUzqfoZQCwHuHP6FyJ33Wqu8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af28:0:b0:584:3d8f:a425 with SMTP id
 n40-20020a81af28000000b005843d8fa425mr264367ywh.10.1695060466507; Mon, 18 Sep
 2023 11:07:46 -0700 (PDT)
Date:   Mon, 18 Sep 2023 11:07:44 -0700
In-Reply-To: <CAG48ez0YBOUGnj+N_MBp2WCvp0BLk1o7n6uSH2nrj1z-qgf+0A@mail.gmail.com>
Mime-Version: 1.0
References: <CAG48ez0YBOUGnj+N_MBp2WCvp0BLk1o7n6uSH2nrj1z-qgf+0A@mail.gmail.com>
Message-ID: <ZQiR8IpqOZrOpzHC@google.com>
Subject: Re: KVM nonblocking MMU notifier with KVM_GUEST_USES_PFN looks racy
 [but is currently unused]
From:   Sean Christopherson <seanjc@google.com>
To:     Jann Horn <jannh@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023, Jann Horn wrote:
> Hi!
> 
> I haven't tested this and might be missing something, but I think that
> the MMU notifier for KVM_GUEST_USES_PFN pfncache is currently a bit
> broken. Except that nothing seems to actually use KVM_GUEST_USES_PFN,
> so currently it's not actually a problem?

Yeah, the implementation is busted, and IMO the entire concept is a dead-end[1].
David Steven's series[2] doesn't actually rip out KVM_GUEST_USES_PFN, I'll add
that to the todo list.  There are no users, and I don't expect any to come along,
precisely because it's busted :-)

[1] https://lore.kernel.org/all/ZBEEQtmtNPaEqU1i@google.com
[2] https://lkml.kernel.org/r/20230911021637.1941096-1-stevensd%40google.com
