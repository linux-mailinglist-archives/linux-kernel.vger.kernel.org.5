Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9C753C71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjGNOCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235815AbjGNOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:02:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D32F269F;
        Fri, 14 Jul 2023 07:02:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 445C81F750;
        Fri, 14 Jul 2023 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689343351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Epn4M12EMMtIKIyIZc7yfNtOd8tKd2U0+jthECcmPvQ=;
        b=rfT7n0LgxtPmC4nzmdf7Syi+PrKAu8elVuE5rsv7TwOwbDBudf3ui9z6FNQM8DKsmo4W9J
        +gMmYQI4ZzT1fSue4GAL2h/yhfmly77Qg6+LLDRljkUelt2xzODFjd/WzVsFImunhmArJ2
        IqFXEsSSAo3G6gfmDJqVdVMHpl67BaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689343351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Epn4M12EMMtIKIyIZc7yfNtOd8tKd2U0+jthECcmPvQ=;
        b=7gCaZnBOYP7FxVS7nvoijBmJHxjFD+Q1UMxUAcrZxnYex5CIxZj9fSgzkAPMbQb7sawjhb
        3qfcJ1K6YdP/oDAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF1102C142;
        Fri, 14 Jul 2023 14:02:30 +0000 (UTC)
Date:   Fri, 14 Jul 2023 16:02:29 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 3/4] kmod: Add config command to show compile
 time configuration as JSON
Message-ID: <20230714140229.GJ9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230712140103.5468-3-msuchanek@suse.de>
 <429o975-ro63-o94r-qs96-76ro6o28on5@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429o975-ro63-o94r-qs96-76ro6o28on5@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jul 14, 2023 at 03:52:05PM +0200, Jan Engelhardt wrote:
> 
> On Wednesday 2023-07-12 16:00, Michal Suchanek wrote:
> 
> >Show prefix (where configuration files are searched/to be installed),
> >module compressions, and module signatures supported.
> 
> What about doing it like systemd and generate a .pc file instead 
> that can then be queried like so, e.g.:
> 
> $ pkg-config kmod --variable=modulesdir
> /usr/lib/modules

 - AFAICS tools packed with kernel generate but do not consume .pc files
   while JSON and jq are commonly used througout the kernel ecosystem
 - .pc files would be shipped with libkmod development package, not the
   kmod tool in a binary distribution

Other than that JSON and .pc files are roughly quivalent in usability.

Thanks

Michal
