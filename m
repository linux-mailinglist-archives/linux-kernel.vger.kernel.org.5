Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD7753C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235900AbjGNN7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235849AbjGNN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:59:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5CF2708;
        Fri, 14 Jul 2023 06:59:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 66682220DA;
        Fri, 14 Jul 2023 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689343159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=971iQ9AGUSNF0XgKLALtIXjvlYcq/Akq7wgISeHEfjI=;
        b=ahegt4WZRpcUhEtPmf6KV/zPWl0VszIuhyctJuOD8gAXPhuPaXh8+wlj336usPRSRQm7Zk
        upg+cjimedHbZ6nRFicirXUfgEHhe8s2Ul53c8ohc5ILjbRbWuz/lwan36YnQcZPVyX15q
        4Y9GHiTN/WXvLgE4NJ38EPGzM9t9h/Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E121138F8;
        Fri, 14 Jul 2023 13:59:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yQVJCrdUsWS6DwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 14 Jul 2023 13:59:19 +0000
Date:   Fri, 14 Jul 2023 15:59:17 +0200
From:   Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Michal Suchanek <msuchanek@suse.de>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
Message-ID: <mg5c43nynzgrp6mn47shxjobquqjs3klxwwheesjmsotvlalbx@axhwgiehelfx>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com>
 <20230714122111.7528-1-msuchanek@suse.de>
 <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7wpvbt37zgrl7ken"
Content-Disposition: inline
In-Reply-To: <s4sr75q4-5120-5sp5-7751-noqs9q67904q@vanv.qr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7wpvbt37zgrl7ken
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2023 at 03:38:18PM +0200, Jan Engelhardt <jengelh@inai.de> wrote:
> Ok, so if the problem statement is that hardcoded paths are bad, then why
> continue to hardcode the "/lib/modules" fragment? Just make it so that
> KERNEL_MODULE_PREFIX can be set to the exact string "/usr/lib/modules" and not
> just "/usr".

That sounds cleaner but I'm worried it would be a BC break in setups
that expect the existing layout under INSTALL_MOD_PATH, wouldn't it?

Michal

--7wpvbt37zgrl7ken
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQpEWyjXuwGT2dDBqAGvrMr/1gcjgUCZLFUswAKCRAGvrMr/1gc
jq8fAP9QUfy7J0GWTgsdUWNVhpouCUlQBkAT3u/M/BymxjbfHgD+L8w8hVaJPhOv
MhrghO6GZrd0Ynt/nc/A0csJDBITaQE=
=zM4P
-----END PGP SIGNATURE-----

--7wpvbt37zgrl7ken--
