Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98E801650
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjLAW35 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 17:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAW3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:29:55 -0500
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C58CB2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:30:02 -0800 (PST)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 99887C0353;
        Fri,  1 Dec 2023 22:30:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 3232618;
        Fri,  1 Dec 2023 22:29:58 +0000 (UTC)
Message-ID: <8d846c564461af99c27d81a69888d73f3622de8b.camel@perches.com>
Subject: Re: [PATCH v1 1/1] checkpatch: Add dev_err_probe() to the list of
 Log Functions
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 01 Dec 2023 14:29:57 -0800
In-Reply-To: <ZWoS3gyJukQkndqY@smile.fi.intel.com>
References: <20231201151446.1593472-1-andriy.shevchenko@linux.intel.com>
         <3c709cc1-0da8-4d23-9f75-8c18d4d18779@roeck-us.net>
         <ZWoHLkcPk2084gQH@smile.fi.intel.com>
         <8fff7625-69b7-4c32-a3bb-d3ca24f149bf@roeck-us.net>
         <ZWoS3gyJukQkndqY@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: cxkb6dt39n4ho47e1synzehy4yn6or5w
X-Rspamd-Server: rspamout03
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 3232618
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX190xDXCP3i7iNh3gaKN1Esa/zfj00BlQ6c=
X-HE-Tag: 1701469798-838526
X-HE-Meta: U2FsdGVkX18tO43hiZol7B+VzlMrlwOmQNyIq3vBQzI2fDWyZ+qN7bp62t+yPOgaZVEudqvFKwPOu+47vFhwwOtGwAUtStJ5+uPr8qnGudJ9LVMf0448VHDlFzbb2O5jxNsDmy/ElzVue4SLgpsE4CxGRM1N8OEksVuI7fzMdHGFfyungRV8kac3/y3UqFvj70GJNMwZu6LN33i6O/vXVicr5U6JvkqwsSvH3enH1omzXO7K/aiRklxvq3eHeJADFibynteUp/Uq0F1eqRrdGcqXmhbef+3ziIOAqa+3UvIyYYcM0PJcdFmz5h9DwTWH
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-12-01 at 19:07 +0200, Andy Shevchenko wrote:
> Currently the [style] behaviour is
> inconsistent independently on somebody's preferences...

<shrug>  Which is IMO perfectly fine.

The ratio of multiple line and single line uses
of dev_err_probe is ~50:50

$ git grep -w dev_err_probe | grep -P ';\s*$' | wc -l
1532
$ git grep -w dev_err_probe | grep -P ',\s*$' | wc -l
1871

