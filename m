Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B17DFD88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbjKCA3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjKCA3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:29:19 -0400
X-Greylist: delayed 167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 17:29:12 PDT
Received: from dsmtpq3-prd-nl1-vmo.edge.unified.services (dsmtpq3-prd-nl1-vmo.edge.unified.services [84.116.6.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA00318B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 17:29:12 -0700 (PDT)
Received: from csmtpq3-prd-nl1-vmo.edge.unified.services ([84.116.50.34])
        by dsmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1qyi11-00DazV-JX
        for linux-kernel@vger.kernel.org; Fri, 03 Nov 2023 01:26:23 +0100
Received: from csmtp3-prd-nl1-vmo.nl1.unified.services ([100.107.82.133] helo=csmtp3-prd-nl1-vmo.edge.unified.services)
        by csmtpq3-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <zarniwhoop@ntlworld.com>)
        id 1qyi0y-004aMt-Gc
        for linux-kernel@vger.kernel.org; Fri, 03 Nov 2023 01:26:20 +0100
Received: from llamedos.mydomain ([86.4.155.149])
        by csmtp3-prd-nl1-vmo.edge.unified.services with ESMTPA
        id yi0xqYtVvWDJgyi0xqOwM1; Fri, 03 Nov 2023 01:26:20 +0100
X-SourceIP: 86.4.155.149
X-Authenticated-Sender: zarniwhoop@ntlworld.com
X-Spam: 0
X-Authority: v=2.4 cv=CcvOppnl c=1 sm=1 tr=0 ts=65443e2c cx=a_exe
 a=69rpv3kaMhdJyoIRs2s4pw==:117 a=69rpv3kaMhdJyoIRs2s4pw==:17
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=pGLkceISAAAA:8 a=OoZU6Ry8AAAA:8
 a=25FfRqQPKazuXCWubbcA:9 a=QEXdDO2ut3YA:10 a=z0b38sRKn-l_H2hRgkIr:22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ntlworld.com;
        s=meg.feb2017; t=1698971180;
        bh=L6fPRAV8EIFORYnBwRckCuhndsuTofii356INfB2anw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=end5Vl06AV5jYmBKUt9GP2gAjqsTijw47DqRM6+bsoAA/aldLirK2uvBp2R7VOiRc
         CvkniJVM1XDGwOe+K4fAAquN4dWKzhZ5QMF0oPnY8V6ZaltVn7CzyH5IdcFfKx0/d2
         vFq6fLJKbtdJ6TFWy3OCRWLxUpxFRwKziIcrRjwhQb97gg7+FhVvkSOmbZYtzhvXW3
         FrQtTNYu5JhYQ555d30dZ/RXPseYgMuC6nolEGjuG3wbyX04ZUQzBWF3zDLg0hE+dd
         dpq94yOjvUYCJGFHx+fEsTCzeo+/BgfjX3W7n4flfRamfbfHMV7I+Q6MiqqzH2Pz/U
         Ph+D/hrWeGddw==
Received: by llamedos.mydomain (Postfix, from userid 1000)
        id 167C99D50; Fri,  3 Nov 2023 00:26:19 +0000 (GMT)
Date:   Fri, 3 Nov 2023 00:26:19 +0000
From:   Ken Moffat <zarniwhoop@ntlworld.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        David Vernet <void@manifault.com>,
        Miguel Ojeda <ojeda@kernel.org>, James Seo <james@equiv.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH RFC RESEND 0/4] Documentation: Web fonts for kernel
 documentation
Message-ID: <ZUQ-K7MXzHZ_oyVK@llamedos.localdomain>
References: <20231102123225.32768-1-bagasdotme@gmail.com>
 <874ji48658.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Clacks-Overhead: GNU Terry Pratchett
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ji48658.fsf@meer.lwn.net>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-CMAE-Envelope: MS4xfBt+HkC6XWi6CNM3jtC/N2UC1BZhvAJIOawbUJnp8i6tpoCt/zDGdfaRrKpCQn8f2Oej/7JHZ4cXPinEU5vqHYJlkzGRjhbDNHfhI8emDahREapB1BM4
 V/ZuW4TREC+K3MM+PLpNdqxGXshsEMY5KnFyhLvAyO5hKc5oco/Blk98AZ7XKK9Jg2fkALCyfb65I2809kY+avH2KvRC+HxQwx43ZzAK9J9V6h8quVxTsrsx
 LZJVZYipqvZl8w40sMue55BF9Drw9Y/3hjRq4YNy6Oozt1tPhr88oD+eDwTKhKDpK6l/dJASPyaG1OVU+8UXX1U9njXA8dhNqrKA+uE4PnWcrxP6xONH/mr9
 ElqFZzgVBwHiiSo5dyz+xq7+6jqN0xtIJjovhunzfN2mrCaiAUEaYaFQxzwd5tK76awm9whZ7ajDedDATQLz8OR1Dcve4qq5FBLySrPXDrDvVtOvnDEc1I0G
 nCd8ARtaFh6pOpEda1yx5jOLs4Jj+t9pzp248AsALela/wsmqwDvyXI7GmPysoHscAH9xcZgYEVy36lsxfe0NkbxSdsOYzvI7CqJyAbAVy3VW7pN9v0tuxw1
 /hRN9OnXyioLvpsWDEtg8uxy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 10:35:47AM -0600, Jonathan Corbet wrote:

Jon, some slight nit-picking below, after comments on the stated
problem.

> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
[...]
> >
> > The solution
> > ============
> >
> > Uniform the font choices by leveraging web fonts. Most of people reading
> > the kernel docs should already have modern browser that supports this
> > feature (e.g. Chrome/Chromium and Firefox). The fonts are downloaded
> > automatically when loading the page, but only if the reader don't
> > already have ones installed locally. Subsequent docs page loading will
> > use the browser cache to retrieve the fonts. If for some reasons the
> > fonts fail to load, the browser will fall back to fallback fonts
> > commonly seen on other sites.
> 
Bagas,

If loading the web font fails, you will get whichever fallback
fonts are enabled by fontconfig and whichever fonts you, or your
distro, have installed.  If those fonts are not generally adequate
you should complain to your distro, or install different fonts in
~/.local/share/fotns and perhaps change your fonts.conf entries.

> So my immediate response to this is pretty uniformly negative.
> 
> - If you don't like serif, tweaking conf.py is easy enough without
>   pushing it on everybody else.
> 
> - I'm not thrilled about adding a bunch of binary font data to the
>   kernel, and suspect a lot of people would not feel that the bloat is
>   worth it.
> 

Jon,

As I understand it the (woff) fonts would be downloaded on request
by the browser if this went in.  So not a bunch of binary font data
in the kernel, but a download from google (adding to the popularity
of the font) and yet more font data in the browser cache.  I don't
have any desire to see woff fonts referenced in the docs, just
nit-picking about the details.

However -

> - The licensing of the fonts is not fully free.
> 

AFAICS, the SIL OFL allows everything except changing the font name.
If you have the right tools you can apparently fix things like "that
specific glyph looks ugly" or "you put a latin breve on a cyrillic
letter" (apparently they should differ) or "You mismapped this
codepoint to the wrong glyph". What you cannot do, if those changes
are not accepted by the font designer/maintainer, or if the font is
no-longer maintained, is fork it and provide it under the same name.

You can fork, but the font name has to be changed (e.g. LinLibertine
-> Libertinus and then the serif forked to CommonSerif).

Oh, and you cannot sell the fonts by themselves, but you can bundle
them with a distro or embed them.
https://www.tldrlegal.com/license/open-font-license-ofl-explained

Question: is that not free enough, or is that site wrong ?  If not
free enough, is there a better licence for fonts ?

ĸen
-- 
This is magic for grown-ups; it has to be hard because we know there's
no such thing as a free goblin.
   -- Pratchett, Stewart & Cohen - The Science of Discworld II
