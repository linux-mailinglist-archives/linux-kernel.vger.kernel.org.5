Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7448379B664
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353894AbjIKVvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjIKI3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:29:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695BB18D;
        Mon, 11 Sep 2023 01:29:11 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfcI9-0004AU-UU; Mon, 11 Sep 2023 10:29:10 +0200
Message-ID: <03d60769-3fe1-4c62-922b-c2e4aa0415de@leemhuis.info>
Date:   Mon, 11 Sep 2023 10:29:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] comedi: add HAS_IOPORT dependencies
Content-Language: en-US, de-DE
To:     Linux Regressions <regressions@lists.linux.dev>
Cc:     Linux Stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <aaf05569-1564-43de-8706-d604e583bf42@mev.co.uk>
From:   "Linux regression tracking #update (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <aaf05569-1564-43de-8706-d604e583bf42@mev.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694420951;3228c2d0;
X-HE-SMSGID: 1qfcI9-0004AU-UU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: This mail in primarily relevant for Linux kernel regression
tracking. See link in footer if these mails annoy you.]

On 04.09.23 16:28, Ian Abbott wrote:
> Hi,
> 
> Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") in v6.5-rc1
> onwards makes it impossible to select some comedi configuration options
> that were previously selectable.  In addition to adding 'depends on
> HAS_IOPORT' directives (which is OK for most of the options), it also
> changes 'select COMEDI_8254', 'select COMEDI_DAS08', 'select
> COMEDI_NI_LABPC', and 'select COMEDI_AMPLC_DIO200' directives to
> 'depends on' directives.  Since there is no other way to select those
> options it renders the options that depend on them permanently disabled.
> It also adds a dependency on HAS_IOPORT to COMEDI_PCI_DRIVERS even
> though several configuration options that depend on COMEDI_PCI_DRIVERS
> are for drivers that neither use I/O ports nor depend on modules that
> call the I/O port functions (inb()/outb() and friends).
> 
> Arnd Bergmann recommends[1] reverting the patch and following up with a
> fixed version.  I intend to do that.  Niklas Schnelle confirms[2] that
> it will not break anything.
> 
> [1] Link:
> https://lore.kernel.org/all/33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com
> 
> [2] Link:
> https://lore.kernel.org/all/65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com
> 
> #regzbot introduced: b5c75b68b7de

#regzbot fix: Revert "comedi: add HAS_IOPORT dependencies"
#regzbot monitor:
https://lore.kernel.org/all/20230905090922.3314-1-abbotti@mev.co.uk/
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

