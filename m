Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CCE813656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjLNQeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNQeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:34:09 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DAF10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:34:15 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5cf4696e202so96499817b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702571654; x=1703176454; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dgQLvbaqZFtHigUp/EtkoVbLXyham3BzC/5JXoUn+l4=;
        b=gK+FOFhAVl3PwgI3iS9BejvlarVDZflJr7QhpAqXpl72Ivi79wfMikHl+C4cyb2VPm
         Ax9PkOYgXCAdEGtWZhn612Q/igA/Pe3DOkCaoNxl18+h3MUxW1Ca63ybW6fkwGWy7HZL
         IALEV1cnD2NZ7gr/vwQ9AUJqfhkflZH2X1nrbo8NHYJiTKwfASA2/fgNtbVaN9dXO2rh
         wfwSHVyeDTT3LX8V16Kkift9w7vZyuGuW8pEvyqKNxbvaovg/InGNVfKS/1GZRA4LxOk
         HfK9qH2aU81RDeYaqq04IEkiwAM9uvizqK9GuIe4i1oBzZqeXY0ZlPWk1erMKSAdoSrl
         afQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571654; x=1703176454;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgQLvbaqZFtHigUp/EtkoVbLXyham3BzC/5JXoUn+l4=;
        b=S4R09VjaxroR05bhSas+yFzlnNjoTzQgcUjlxmKp+Y21AD0OliT6jqSYE0/GQmtvHt
         y0AfY1zch1yLeyoQ5Yt1IEN/7nbSl7aZtzsvroYGVi+BsDO8CO7OORCGVjFdqaBS20HW
         c9lJYhGDtYPoViwlf6upVueBOQNgy96jOKSsIQyzzp5nWz6sg4zeZDQR12o7bVw5hQok
         fJIsQhB+W3SD3cH1Cr/H4wvvVlj/OpN63S0yDn9MoYM9IshlxPGGo7mACkUfbDsoPbZf
         bAIH+R7Oiuyao8qQqqAGhYRfpfnKN8OM6vuvAqFj4i34lTLGnKlWlHxqpXA/Cl+scFy5
         ZHHw==
X-Gm-Message-State: AOJu0YymBZrg9cITz/y0JRC6/w3T+rPVb0M1s7IY4bRcbKf6xd28NDnM
        kyYVVcwyIx0tpMSOi+2ZA+1BTwlkIh8=
X-Google-Smtp-Source: AGHT+IGyuwsOx8hONotcvinU2TL/jZLWZjMBvbCKpQOSyVHlnfNq//5voUQE6Lf7ldDRVqln11okKSYy69w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:c9c:b0:5e2:1d4d:bb78 with SMTP id
 cm28-20020a05690c0c9c00b005e21d4dbb78mr63397ywb.2.1702571654638; Thu, 14 Dec
 2023 08:34:14 -0800 (PST)
Date:   Thu, 14 Dec 2023 16:34:12 +0000
In-Reply-To: <864jglbgsh.wl-maz@kernel.org>
Mime-Version: 1.0
References: <20231214001753.779022-1-seanjc@google.com> <864jglbgsh.wl-maz@kernel.org>
Message-ID: <ZXsuhF5Rns1H53zK@google.com>
Subject: Re: [ANNOUNCE / RFC] PUCK Future Topics
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Isaku Yamahata <isaku.yamahata@linux.intel.com>,
        David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023, Marc Zyngier wrote:
> On Thu, 14 Dec 2023 00:17:53 +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> > 
> > Hi all!  There are a handful of PUCK topics that I want to get scheduled, and
> > would like your help/input in confirming attendance to ensure we reach critical
> > mass.
> > 
> > If you are on the Cc, please confirm that you are willing and able to attend
> > PUCK on the proposed/tentative date for any topics tagged with your name.  Or
> > if you simply don't want to attend, I suppose that's a valid answer too. :-)
> > 
> > If you are not on the Cc but want to ensure that you can be present for a given
> > topic, please speak up asap if you have a conflict.  I will do my best to
> > accomodate everyone's schedules, and the more warning I get the easier that will
> > be.
> > 
> > Note, the proposed schedule is largely arbitrary, I am not wedded to any
> > particular order.  The only known conflict at this time is the guest_memfd()
> > post-copy discussion can't land on Jan 10th.
> > 
> > Thanks!
> > 
> > 
> > 2024.01.03 - Post-copy for guest_memfd()
> >     Needs: David M, Paolo, Peter Xu, James, Oliver, Aaron
> > 
> > 2024.01.10 - Unified uAPI for protected VMs
> >     Needs: Paolo, Isaku, Mike R
> > 
> > 2024.01.17 - Memtypes for non-coherent MDA
> 
> DMA?

Doh, yes, DMA.

> >     Needs: Paolo, Yan, Oliver, Marc, more ARM folks?
> 
> Do we need anyone from the other architectures? I wouldn't be
> surprised if RISC-V was at least as picky as ARM on that front
> (assuming this really is about DMA and not something else).

Ah, yeah, probably.  I had just heard rumblings about ARM, and so ARM was on my
mind.  I added people from all the other flavors of KVM.
