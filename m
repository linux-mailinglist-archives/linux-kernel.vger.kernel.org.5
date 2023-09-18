Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B427A4CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIRPoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIRPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6062D46
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695051385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vr7GWd2VoXZupzZUaxFhlqO+6Z35WiBMgeAjc66b/jQ=;
        b=dCyjm5siOiajDnlWmcW+CCsfjVpAQykYL12mY8ax++zeqYT1KO0HK3Bj6rgEPHRvPUM4+b
        w872mcAwdVmaCtobcC+h/vfcIkfUptkLxAn4VSKI7klVFtpJI/HbVS7jvnT0YYwmvG8dCV
        rmH28Eo+zOvVMIy0lcUhfz5ZhxoJGz4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-370-sWxOBnh2MdiRMkc-uzAlkw-1; Mon, 18 Sep 2023 11:36:21 -0400
X-MC-Unique: sWxOBnh2MdiRMkc-uzAlkw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07C4E3800EA0;
        Mon, 18 Sep 2023 15:36:21 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.193.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB075492B16;
        Mon, 18 Sep 2023 15:36:13 +0000 (UTC)
Date:   Mon, 18 Sep 2023 17:36:07 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc:     "Lennart Poettering" <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, tglx@linutronix.de, dhowells@redhat.com,
        vgoyal@redhat.com, keyrings@vger.kernel.org,
        akpm@linux-foundation.org, "Baoquan He" <bhe@redhat.com>,
        bhelgaas@google.com, "Luca Boccassi" <bluca@debian.org>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
Message-ID: <20230918173607.421d2616@rotkaeppchen>
In-Reply-To: <0e1984af-88ca-4908-a5ca-3191d96aa63f@app.fastmail.com>
References: <20230911052535.335770-1-kernel@jfarr.cc>
        <20230913160045.40d377f9@rotkaeppchen>
        <ZQLTJFb3S/xn5CWo@gardel-login>
        <20230914205149.51031bc9@rotkaeppchen>
        <0e1984af-88ca-4908-a5ca-3191d96aa63f@app.fastmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Thu, 14 Sep 2023 23:04:32 +0200
"Jan Hendrik Farr" <kernel@jfarr.cc> wrote:

> On Thu, Sep 14, 2023, at 8:51 PM, Philipp Rudo wrote:
> > [...]
> >
> > In this context I hope it is also clear to you that when more and more
> > people rely on the spec you need a more formal process when including
> > changes. Especially when the change might break the implementation of
> > others. So no more making the .cmdline optional and allowing it to be
> > overwritten all on the same day.
> >
> > Having that said, what does "local override" exactly mean? Does that
> > mean a distro can allow a user to freely choose the cmdline without
> > checking any signatures?  
> 
> The behavior of systemd-stub is to allow the bootloader (or whatever
> called sd-stub) supplied cmdline when there is no .cmdline section in
> the UKI. That's how I understand "local override" here. For WIP v3 of
> this patch the behavior is to use the cmdline supplied by userspace to
> the kexec_file_load syscall if no .cmdline section is in the UKI.
> 
> empty .cmdline section -> empty cmdline always passed to kernel
> .cmdline section -> use bootloader/user supplied cmdline (which would
> be empty by default)
> 
> This setup does not make sense for a locked down / secure system though.
> 
> Maybe the word "override" is not ideal. There is nothing actually being
> overridden as there is no cmdline in the UKI in the first place.
> 
> sd-stub also allows the bootloader supplied cmdline if not using secure
> boot. So maybe the kernel could allow user supplied cmdline if not in
> lockdown mode for kexec maybe? If not in lockdown mode somebody can just
> kexec an unsigned kernel + unsigned cmdline using the kexec_load syscall
> anyways. For this case the word "override" makes sense.
> 
> The logic for all of this in sd-stub is in [1].
> 
> > I.e. does that mean we can get rid of this
> >      https://github.com/systemd/systemd/issues/24539  
> 
> This is a different usecase IMO.

Yeah, I expected that. The whole question was meant to be rhetorical.
The point I wanted to make was that when a spec uses terms like "local
override" it needs to explain what it means.

Thanks
Philipp

> >> Hence, seeing the spec as set in stone and as inherently low quality
> >> is the wrong way to see it I am sure. Instead, the goal here is to
> >> adjust the spec to make it work really nicely for *both* systemd and
> >> the kernel.  
> >
> > Sorry, I never wanted to intend that the spec inherently low quality.
> > Just that it doesn't meat my expectations, yet. But that is fine. The
> > spec isn't even a year old and there's only a single implementation,
> > yet. So it's more documentation rather than a spec.  
> 
> Let's make it happen.
> 
> 
> [1] https://github.com/systemd/systemd/blob/5898cef22a35ceefa068d5f46929eced2baab0ed/src/boot/efi/stub.c#L140
> 

