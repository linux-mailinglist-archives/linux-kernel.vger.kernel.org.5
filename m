Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DB7BA274
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjJEPhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjJEPhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:37:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3A35C1B;
        Thu,  5 Oct 2023 07:53:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AC7C116B1;
        Thu,  5 Oct 2023 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696496221;
        bh=pVrbjUBz8B4tQzXARceL2fDR5Lj64WmB0u1Zx7kMTpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2wdIbPWHyAHClvpS9Kyn1G7hcCW1xtL5Cgatcdr8jg9vkdMAkhnpe1F/in0hczCdw
         PzglEJZgEFQEjOws+30EQEUstsEDQelJlPlciv8h3E+D72sFoQ1U9ps6ZwPYyEiP9E
         aWsWESqOXiZw6BC1ZW3OID0jsS/xQuZm07CTUwkQ=
Date:   Thu, 5 Oct 2023 10:56:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Clarify
 prenotifaction
Message-ID: <2023100546-unrelated-trekker-320b@gregkh>
References: <20231004004959.work.258-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004004959.work.258-kees@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:50:03PM -0700, Kees Cook wrote:
> There has been a repeated misunderstanding about what the hardware embargo
> list is for. Clarify the language in the process so that it is clear
> that only fixes are coordinated. There is explicitly no prenotification
> process. The list members are also expected to keep total radio silence
> during embargoes.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: workflows@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  .../process/embargoed-hardware-issues.rst     | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> index ac7c52f130c9..31000f075707 100644
> --- a/Documentation/process/embargoed-hardware-issues.rst
> +++ b/Documentation/process/embargoed-hardware-issues.rst
> @@ -25,15 +25,15 @@ Contact
>  The Linux kernel hardware security team is separate from the regular Linux
>  kernel security team.
>  
> -The team only handles the coordination of embargoed hardware security
> -issues.  Reports of pure software security bugs in the Linux kernel are not
> +The team only handles developing fixes for embargoed hardware security
> +issues. Reports of pure software security bugs in the Linux kernel are not
>  handled by this team and the reporter will be guided to contact the regular
>  Linux kernel security team (:ref:`Documentation/admin-guide/
>  <securitybugs>`) instead.
>  
>  The team can be contacted by email at <hardware-security@kernel.org>. This
> -is a private list of security officers who will help you to coordinate an
> -issue according to our documented process.
> +is a private list of security officers who will help you to coordinate a
> +fix according to our documented process.
>  
>  The list is encrypted and email to the list can be sent by either PGP or
>  S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> @@ -132,11 +132,11 @@ other hardware could be affected.
>  
>  The hardware security team will provide an incident-specific encrypted
>  mailing-list which will be used for initial discussion with the reporter,
> -further disclosure and coordination.
> +further disclosure, and coordination of fixes.
>  
>  The hardware security team will provide the disclosing party a list of
>  developers (domain experts) who should be informed initially about the
> -issue after confirming with the developers  that they will adhere to this
> +issue after confirming with the developers that they will adhere to this

Nit, whitespace change wasn't documented in the changelog :)

Thanks for this, it matches up with the list rules now much better (that
everyone gets when they join one of these lists), so I'll go apply it to
my tree now.

greg k-h
