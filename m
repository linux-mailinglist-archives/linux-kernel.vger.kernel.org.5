Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB627E4D75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbjKGXeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344359AbjKGXdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:33:53 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910285251
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:31:19 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7788f513872so404803885a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 15:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699399878; x=1700004678; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tydNgQiOMp3YV+RndotzaXK25ekNq4eLzdezzERvLsQ=;
        b=XQSPaINLHa/MgGSJFkpPaDccHGKJkBxuhsyssCC/lgDStILQ2tQUYFfdb3mQPD9CT7
         l45ZNFDv1uq9WbX6XiJUBLeUx1zs8EE3ffAXBN62Zy9qmW87Dipvfh5iAtuii40VPNGd
         jL2eFsCRvPy8Y1MFohYV/nahcVeZMJRzt0U3BW4kxORUlYUrzlZTmN3iBmpf7+hKxd84
         8p2rp0PNvhCX3pdPkv0S459k0b97E5IUg7WtqSdTwgfYRA+aM+WT871Xal7QP/FhXouo
         kCySYCL9jckC/KzrqDYoxDBukU8qNzcId4Hv/tdb5FEJHK+Z/Srwwd94IM33snwykFRy
         G16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699399878; x=1700004678;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tydNgQiOMp3YV+RndotzaXK25ekNq4eLzdezzERvLsQ=;
        b=NddElsaJz9AzyVIBp4Uu/6ayYnfLSbCMJMbhen8/W0hRrWfyPQtoeV/pvxetk5+s2h
         4yfsOye65SNcpG3iM5DvyNgkgKEVpCKtXRnNFCElmruJpJh9U+R0k+Xv1b/dq3Q4lgAQ
         bsZLugRabjhIGx3EJbKL+ZPvdiF+E0iCLAAjLUJiii14/59EhzBRXTQta8U1LeXdUyD4
         fJMDuodqs+YShwgwUD9WEPDZ5miMt0DyjxMeTmFohKMQrZqTw3GycUGtj5sCfKz7wvZ7
         cxScC7eAAgUln7jU4BxwTRPp7k9ZFFXDNk5hAcu+aHhGe8blTBkovNs7tao+G2oN8u7n
         Hslw==
X-Gm-Message-State: AOJu0YxnWGyWzxdgWXM45YuCav9zKMA1EeozljoTRB5h0uZ94v43eERE
        wRrAPph7SamqqEBiPWpVF8rx
X-Google-Smtp-Source: AGHT+IHM9avX7OkERLkdBlgwIoyCkgyZiUpJCJ1aoFFn6AJm7YWd10lY6xYl3NUjkWQFaxZ8280W7g==
X-Received: by 2002:a05:620a:c43:b0:774:2c35:3796 with SMTP id u3-20020a05620a0c4300b007742c353796mr76738qki.34.1699399878530;
        Tue, 07 Nov 2023 15:31:18 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id r12-20020a05620a298c00b0077407e3d68asm399576qkp.111.2023.11.07.15.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 15:31:18 -0800 (PST)
Date:   Tue, 07 Nov 2023 18:31:17 -0500
Message-ID: <c5f6bd1dee4ad9b43fc8c9dc1c7645b3.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in  auditd_set
References: <20231018092351.195715-1-chris.riches@nutanix.com>
In-Reply-To: <20231018092351.195715-1-chris.riches@nutanix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 18, 2023 Paul Moore <paul@paul-moore.com> wrote:
> 
> When auditd_set sets the auditd_conn pointer, audit messages can
> immediately be put on the socket by other kernel threads. If the backlog
> is large or the rate is high, this can immediately fill the socket
> buffer. If the audit daemon requested an ACK for this operation, a full
> socket buffer causes the ACK to get dropped, also setting ENOBUFS on the
> socket.
> 
> To avoid this race and ensure ACKs get through, fast-track the ACK in
> this specific case to ensure it is sent before auditd_conn is set.
> 
> Signed-off-by: Chris Riches <chris.riches@nutanix.com>
> ---
> 
> > I'm happier with the bool over the integer type for the @ack variable.
> > I'd suggest updating the patch and posting it again so we can review
> > it in full, but we weren't very far off last time so I think it should
> > be close, if not acceptable on the next revision.
> 
> Here's the latest iteration of the suggested patch. I've done it via git
> send-email so it should apply cleanly.
> 
>  kernel/audit.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)

This looks good to me, thanks for your patience and persistence Chris.

I'm going to merge this into audit/dev-staging now and it will move to
audit/dev once v6.7-rc1 is released and the merge window closes.

--
paul-moore.com
