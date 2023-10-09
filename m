Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B97BEB7A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378594AbjJIUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378544AbjJIUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:20:11 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E74694
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:20:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a22eb73cb3so88386057b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696882808; x=1697487608; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6+GJ5cI4z2TlJw5nJFvkv7FETWY362gjhrvcMB9XFc=;
        b=LYMPNRYaGtJ0B7jCpzJLOeAOt4N5rEjxApu3zMBe7oeVCCTl5ExTQEGkDjkQ2VquMi
         5JzYk5VrNtmkSZEbCJr7LuTLXgPgdswazaskUq4r/nb2MwvQlY/7bin9K4mSEOb1nh23
         aQGNHQR5OCxv8ouCA5FnKE6fg5l2yOVe8wE0MnBeOdtEv7qlv4UWIW+YwoP7fCYOmhM7
         IcxngCv54vmqWR2K7rpaTfwzdEBwnwv880xHoxJbZg5AP9sNmeXJ1XIbmh7dlza/cfMf
         uAMOiB3KSGkQK0ZsaI/eD8AuVIIoMseYxZAZliaW6DQNB32qGbBHGpSYxiTQAKR6ts1H
         BB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882808; x=1697487608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6+GJ5cI4z2TlJw5nJFvkv7FETWY362gjhrvcMB9XFc=;
        b=E7CpW7ykcZzmXXwbd8+2w2ueW5nHjblkAAm8BnW3A3xBtiBEyhOdT3OGkMp6uDKWuE
         um/RhN7aWpauxnDYCwhuKLERosy7BZPcc3WzoYPvPDhtUNRXaPHlLgI+qNd936EJh+iH
         PfWR7c8kPRP4Kpf1V2vNLitgOnDVuROQNNj/EMZOKmM0CgORVS0QMh6gMqG19ea8txHe
         Yy9N5IpxuDIzU35xCdbu70KuehMudzAGDs+eV+b8rUUV8RUQZ026kdVEHlWlQctSNooj
         kSBfPc2cEA5rvsecaxJ7I5/ZuRcZ490EaIbm81AW58X4FZYehLLvsi09mwqfAXB+Q+DT
         FgqA==
X-Gm-Message-State: AOJu0YyIZitdcvcI7tCYE37ELz6qRuAPQ2YijN1LqIoXZSngbjML2BqH
        iNMwAHAU5kh8v8O/ys+/WYeyq3dC/c8=
X-Google-Smtp-Source: AGHT+IFY1JX42tQvUiQbHjxHOd20j5m7plZ8L4JheDy574ZvKTNtyQEZK75VDZPRx5P3o6rzL4rbdqXGQyM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:b50:0:b0:d80:904d:c211 with SMTP id
 b16-20020a5b0b50000000b00d80904dc211mr241176ybr.7.1696882808446; Mon, 09 Oct
 2023 13:20:08 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:20:06 -0700
In-Reply-To: <20231009200608.GJ800259@ZenIV>
Mime-Version: 1.0
References: <20230928180651.1525674-1-pbonzini@redhat.com> <169595365500.1386813.6579237770749312873.b4-ty@google.com>
 <20231009022248.GD800259@ZenIV> <ZSQO4fHaAxDkbGyz@google.com> <20231009200608.GJ800259@ZenIV>
Message-ID: <ZSRgdgQe3fseEQpf@google.com>
Subject: Re: [PATCH gmem FIXUP] kvm: guestmem: do not use a file system
From:   Sean Christopherson <seanjc@google.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023, Al Viro wrote:
> On Mon, Oct 09, 2023 at 07:32:48AM -0700, Sean Christopherson wrote:
> 
> > Yeah, we found that out the hard way.  Is using the "secure" variant to get a
> > per-file inode a sane approach, or is that abuse that's going to bite us too?
> > 
> > 	/*
> > 	 * Use the so called "secure" variant, which creates a unique inode
> > 	 * instead of reusing a single inode.  Each guest_memfd instance needs
> > 	 * its own inode to track the size, flags, etc.
> > 	 */
> > 	file = anon_inode_getfile_secure(anon_name, &kvm_gmem_fops, gmem,
> > 					 O_RDWR, NULL);
> 
> Umm...  Is there any chance that your call site will ever be in a module?
> If not, you are probably OK with that variant.

Yes, this code can be compiled as a module.  I assume there issues with the inode
outliving the module?
