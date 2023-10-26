Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC77D842D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345112AbjJZOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjJZOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:05:45 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5185128;
        Thu, 26 Oct 2023 07:05:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 75961735;
        Thu, 26 Oct 2023 14:05:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75961735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698329142; bh=gPmQecDXHzcTOT8HCq8cWu7IAndzVIEptXImht37IBg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AxBCAlBVV6EODx3CFle7qOQD/elpu7cIUDePeE+yVaFagigLU4B5UzzHyEyp7UKHk
         9rgPP2dDRchzlakozXZj+ZsSYvJUt/vOlgt+7tjAGgRv8vn6VH4v6k2IrKIpZnMCsa
         BOoWSKbA7fac3vEqgbAZ5R37QGD37HyDjyWxPij5+YmKql8bFHA/9fiNAOaiRHzHDX
         ZK9zPkcu8lEtDtBJcsq3fJzwYQBdwhwXBsqpP+8SaLg8/NPUHja9e5L53qN/k/GNoa
         x7kwWbxCpWolRxjp4pxeISdD6LNzccPsZoS89NCHMiE4AyDB1VLlOeGFVXQ7Oo/719
         Om8BGKuIUBNIw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
In-Reply-To: <20231026095235.760f5546@gandalf.local.home>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook> <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
 <20231026095235.760f5546@gandalf.local.home>
Date:   Thu, 26 Oct 2023 08:05:41 -0600
Message-ID: <874jid8one.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 26 Oct 2023 07:39:44 -0400
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
>
>> While it's nice in theory to have everything documented, it's not much
>> use if no one can actually find the information ...
>
> Does kerneldoc provide an automated index?

If you go to https://www.kernel.org/doc/html/latest/ and type a symbol
into the search box on the left, you'll get directed to the right place
(if it exists).  For James's system_state example, it makes it clear
that there's only one reference - in the coding-style document, of all
places...

I've never looked into that index to see how hard it would be to access
without a browser.

jon
