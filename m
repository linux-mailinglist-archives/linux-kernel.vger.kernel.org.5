Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007237FFA38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjK3Sx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjK3Sx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:53:58 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2669B9;
        Thu, 30 Nov 2023 10:54:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E75DB5C00B6;
        Thu, 30 Nov 2023 13:54:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 30 Nov 2023 13:54:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1701370443; x=1701456843; bh=Uq
        /dQOL7MFyNckFZYlFPvqGMEvyj/U2ZF5ZHzHRYYpA=; b=mtpqR8DnPt7LIPU3zA
        18AYXoFwximEvSb/RzN0iZjqkYjwJcyVGgB6FmNMMqQ7/pG3U7nrbtQotMyX90jY
        f21xLfMpqmw9Gvv5Souba180t49U1gzdn9/IcH/pLI9RKNhfeqR3juCpljr3ieU8
        x52/SXNpevjI+Sl6VTizJv1LLuo9Nwk+wnU/vWJXSv/AC4vhYVWuh1vAfsf9aMyq
        SDjZ2HD7KAiTqqmCNO5UjcsFjRcD2TRhlu4/xxUbCGglvBBnTlDyQsyEpZOhWs9k
        oa0am5q8y10s+149KvmhcQDVu7rqwci9UkeXrRvAEFedKEl1tVMboHH7J3mmTyVl
        grWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1701370443; x=1701456843; bh=Uq/dQOL7MFyNc
        kFZYlFPvqGMEvyj/U2ZF5ZHzHRYYpA=; b=FHgPGGHTyi17r4j/eS+WA6oC5qTf1
        xDo6jDG+9HgyKjwVifWOZI+Q2FDeCQRDqyMwOl+nkKTz2rpoJobnBEa5ksZJUrbO
        ujj9ypm3J4nQAtdscJLqBXcXwFz2lwQwL5b5jtiST1Kb9764fV8GFjeW9MqOP785
        lQuNsjMf6kxmcfCSTk5e5ySQjd8O/Uurnku+mkGpFTP921DiiPjIoq+IQGRl1/jZ
        0tU+s+O9+3CiPmKaBop29xGB2urgaBQK0JEZ+vEZ6PlBq7/ICJZU49sZQusuyveZ
        k4OJqrVQ9q8XOF/R3JGd22oc4AEYMJNVc9dFFN2kyn7YsWzPTVC/JqXCA==
X-ME-Sender: <xms:S9poZYvgsZioHUKHknKKZtAci1K6PH0hOR-h-U_3QUn9SeiLyQ72qQ>
    <xme:S9poZVeZk6V1b2QoDh8eugsil-pU-qAlv-p4AfBm6DAfzvJkYuezMQQnXaBEJambq
    dv-HTjXp9Wp0z_GQQo>
X-ME-Received: <xmr:S9poZTzMMOEsAu03w2EJ-h58E6eBQ2YwI5y_jpZmjpzU0mzaiUTVd5-BCjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeijedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteek
    lefhleelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:S9poZbNJeE0bKLtUL1ulZQ8k4XlG1audW4TyUm520qxyiZVFqFV1Tw>
    <xmx:S9poZY_3tXURL2ewIakRkDEhc9V1xaldOLMGwwJxCV7yIveW-NSjTA>
    <xmx:S9poZTV-n1UmCxUE84hONNL9pPisuKcTk5j_T7zW1nryjqSemX-1uA>
    <xmx:S9poZYx-VLMqjZtlheH11cRyM7JXqZLGQlAQqvazlrWVlrrFw-lorw>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Nov 2023 13:54:02 -0500 (EST)
Date:   Thu, 30 Nov 2023 11:54:00 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        mathieu.desnoyers@efficios.com
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Message-ID: <ZWjaSAhG9KI2i9NK@tycho.pizza>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jh3t7e9.fsf@oldenburg.str.redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:37:02PM +0100, Florian Weimer wrote:
> * Tycho Andersen:
> 
> > From: Tycho Andersen <tandersen@netflix.com>
> >
> > We are using the pidfd family of syscalls with the seccomp userspace
> > notifier. When some thread triggers a seccomp notification, we want to do
> > some things to its context (munge fd tables via pidfd_getfd(), maybe write
> > to its memory, etc.). However, threads created with ~CLONE_FILES or
> > ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> > purpose, since their fd table or mm are distinct from the thread group
> > leader's. In this patch, we relax this restriction for pidfd_open().
> 
> Does this mean that pidfd_getfd cannot currently be used to get
> descriptors for a TID if that TID doesn't happen to share its descriptor
> set with the thread group leader?

Correct, that's what I'm trying to solve.

> I'd like to offer a userspace API which allows safe stashing of
> unreachable file descriptors on a service thread.

By "safe" here do you mean not accessible via pidfd_getfd()?

Tycho
