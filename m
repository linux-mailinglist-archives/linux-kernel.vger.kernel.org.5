Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B302A7CB670
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjJPWSE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Oct 2023 18:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjJPWSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 18:18:01 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E6695
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 15:18:00 -0700 (PDT)
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 4494BA0C2D;
        Mon, 16 Oct 2023 22:17:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 3132320018;
        Mon, 16 Oct 2023 22:17:57 +0000 (UTC)
Message-ID: <fdb7c6312ea52086566e279918b5b873c687fecd.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: correctly parse UTF-8 encoded names in
 files
From:   Joe Perches <joe@perches.com>
To:     Duje =?UTF-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Alvin =?UTF-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alvin =?UTF-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Date:   Mon, 16 Oct 2023 15:17:56 -0700
In-Reply-To: <5719647.DvuYhMxLoT@radijator>
References: <20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk>
         <5719647.DvuYhMxLoT@radijator>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3132320018
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Stat-Signature: ygjxazuck4ktnqqxjjymda1zqr357aq4
X-Rspamd-Server: rspamout08
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/yGgQOpBeutMkm96IvPb84ajsW0NsW21o=
X-HE-Tag: 1697494677-243909
X-HE-Meta: U2FsdGVkX1+2O3X7AO2S+v6HY07pA31HQfMIUD9IdwWlszmqzHxlZM0dNap96jmQQoD67io6SPRPtbXjOWACt+8Qn++rURrNJI2XqOmCKW17gZl6165F3f4k7dJVS505AibNxmQLNn2T27eowLedZu2PipNnxCyyrlUDP1SPe2dVr28u6D3qvuzqNvW76ORA77+HYkn82q4H6jZCezoCwFn9lhjrwFeZOSX5LadTEGtSlDCwgXMNuXvJ8L/DdOUBEGC2rpdQCyGX/EOHk+CUAVwr93Ta8GehjjqyW4mmdbwbEQk3KzyNwEsipbImWMwo
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-16 at 16:37 +0200, Duje Mihanović wrote:
> On Saturday, October 14, 2023 7:22:44 PM CEST Alvin Šipraga wrote:
> > From: Alvin Šipraga <alsi@bang-olufsen.dk>
> > 
> > While the script correctly extracts UTF-8 encoded names from the
> > MAINTAINERS file, the regular expressions damage my name when parsing
> > from .yaml files. Fix this by replacing the Latin-1-compatible regular
> > expressions with the unicode property matcher \p{Latin}.

Well, OK

> >  It's also
> > necessary to instruct Perl to open all files with UTF-8 encoding.

But I'm not at all sure this is actually desired.

