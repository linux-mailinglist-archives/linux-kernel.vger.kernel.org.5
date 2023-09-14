Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A5F7A0FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjINVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjINVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568E26B2;
        Thu, 14 Sep 2023 14:14:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEC1C433C7;
        Thu, 14 Sep 2023 21:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694726049;
        bh=L/MzC7ioV9UUQjtz4gA9VmoBaXGgFXYV9zbRrFAiiFw=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=Ewp1ys3K6A4pyPc53Gx06gClHlc24FZ88ldRltat23EhQEUdBKzj3JnQUJPYDRABc
         cTHeiDHrwYJtBrQ7O/StXRmkqaagwfZeLYnu9XjfXXlwtu23OhU323F9tCysqO8Dxs
         DomnnOwA8iM7Tsk60cCPys+QHnZIHw7MbeLwnOKTO3/00W+l55rmSvqfC8webDEL2l
         KvojDtjH3+kE+fMbv5kWrG7j1nHSlw+1pTCuxcnN0EGjly4oaa/d2ji9U+frrb50LE
         hSMRcJej1x5vQ86ur2dO0tzPGYhMCtaW/YaxODSl6gmmm1W9PozWX9nvqdbyr8TdVN
         7hKYJEyHFnsIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 15 Sep 2023 00:14:04 +0300
Message-Id: <CVIY8SX1DPRH.J1EE2T4RDZZ4@suppilovahvero>
Cc:     <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <x86@kernel.org>, <tglx@linutronix.de>, <dhowells@redhat.com>,
        <vgoyal@redhat.com>, <keyrings@vger.kernel.org>,
        <akpm@linux-foundation.org>, "Baoquan He" <bhe@redhat.com>,
        <bhelgaas@google.com>, "Luca Boccassi" <bluca@debian.org>,
        <mjg59@google.com>, <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jan Hendrik Farr" <kernel@jfarr.cc>,
        "Lennart Poettering" <mzxreary@0pointer.de>,
        "Philipp Rudo" <prudo@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230911052535.335770-1-kernel@jfarr.cc>
 <20230913160045.40d377f9@rotkaeppchen> <ZQLTJFb3S/xn5CWo@gardel-login>
 <CVIN0M3IHRKL.3U005Y5QTOJL5@suppilovahvero>
 <CVIR0BGHX3VS.39FY5QL8KXR0F@suppilovahvero>
 <e215acd4-52fd-429c-a569-a20ba5a49d7e@app.fastmail.com>
In-Reply-To: <e215acd4-52fd-429c-a569-a20ba5a49d7e@app.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Sep 14, 2023 at 7:11 PM EEST, Jan Hendrik Farr wrote:
> > BTW, would not be a bad idea to extend CC list to at least Matthew and
> > James Bottomley on this patch.
>
> Sure. Added Matthew and James in CC
>
> Also, I already made some minor changes. cmdline is now used from the
> syscall if there is no .cmdline section included in the UKI.
> find_section now returns the section_header as an ERR_PTR. You can
> find them in the uki-v3-wip branch at
> https://github.com/Cydox/linux/commits/uki-v3-wip

Hey, I discussed about IKU at the Linux Linux security module
maintainers monthly meeting and we concluded that it would be nice if
this had a spread to linux-integrity and linux-security-module mailing
lists.

It is x86 feature at this point but obviously that will work as
reference model to other architectures too.  So it would be nice
if those mailing lists would be also included to the loop.

I do not have time to check if this is relevant but this I think
the last version seen of encrypted hibernate:

https://lore.kernel.org/linux-integrity/20221111231636.3748636-1-evgreen@ch=
romium.org/

Just adding it as a reference since I mentioned it earlier.

I'm on holiday for the next week but will look forward to the next
version after I'm back.

BR, Jarkko
