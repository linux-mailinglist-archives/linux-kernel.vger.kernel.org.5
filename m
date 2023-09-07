Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BD27977C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbjIGQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbjIGQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:32:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EA61FD4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 09:32:17 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A47D5C00CC;
        Thu,  7 Sep 2023 06:16:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Sep 2023 06:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1694081767; x=
        1694168167; bh=E61v5F+OnpaiU4fxshVV4wXKb0uGpSwJ4z5TdXTl2B8=; b=V
        9Tdu0mqkTUCpeIdAOTke/Nm0JkmgrVHbYny+MVLwHVcc7SXZLmys+e+mNE0L2T26
        /mnWawPZQLRUvb84EBfUsgExlMrVaQH2+Tl9QTKbAd1qQjiNqqxedlUDf0wGDpFh
        ZGCumzx6qu8/qAY7UM0JlrAwqVpvWbWV2tar3KZSpATcjDvwNFsaTYoUFsPUj838
        5Dwvg6/5fstIN/jBowEOwB9P1vX+P/lrtuB56qmPxapGGWgsNGtjScBmg7GmrLVj
        onStIVZ4h2jPY9rUXIzbM1X/k5hQaKgGsQURnzMRR+C5AJ9Q2XfId0hJO2kTSgCq
        ENGNTOYFM3sUajD+T2nBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694081767; x=1694168167; bh=E61v5F+OnpaiU
        4fxshVV4wXKb0uGpSwJ4z5TdXTl2B8=; b=vw5fbmpli2yenuXkithQ2bTAVYvVu
        jEukvn7mzwnPCEE2z+stsG9Ge7XrJYgW7Wkep8yYDO3GIQH+1Pjkynt1mp1aN0Mi
        ylRVzuQXMwTrQrCGM4Ksg69j8q2H7wT4p+hmdOd+B4vEbcRH4y4wpjL2Gaoumb0M
        wsZRNyU5/5JNe8BZfX6jmF7qiUuWqr8eMVFe5tQpRiuPJdUsBstDlf2UzawNuCbs
        XUcBi6wTDtq0Ln0kWE70nQgk/mqdPf2bohFENKvvvgPMH3SJmqewWMQeKjLExGDA
        SPFwGlShAfKGQ3JiXVRhqAOdmu5nuFbAC3QRL0CORmgpQS8W5hau9qFDw==
X-ME-Sender: <xms:5qL5ZGC1VEbswvhTXElk8r8_bVvG-HpQmhKurTlx9lHrJcqOyFlpnA>
    <xme:5qL5ZAiWe8mTmgK-irbfLf3H1pPX6TyK-qDXYe0Ixe1yvhJEh2E73FW1ryUlaaCj-
    eLUrl2gT65S8dHc5vY>
X-ME-Received: <xmr:5qL5ZJlpKgmldxEMjRwhrqvov6ilQlTphD5MYpyLCXJIrCGrm6fQsGk55byV6BX-Z2ho-q2032_PYUVA9EH2lYM2tSAgaxrBnjc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:5qL5ZEzY3U03QYdlLINNaTVEEh8XP5DP38tjfb1AAoqn29YBlg8gPA>
    <xmx:5qL5ZLQkHQIFD_YaiM3OXIy-PQKUZizJEeLSIr7UnyND_95_BBCHGQ>
    <xmx:5qL5ZPb0OIS0tOZCAtBU5iFnXM2BFKuh0kbg-PC3kS4ohFjRmcETng>
    <xmx:56L5ZCIhQ2W3ownx00Wz7ouB19tHuTA9XrfaLesqi9iCtt13VFAv-Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 06:16:05 -0400 (EDT)
Date:   Thu, 7 Sep 2023 19:16:01 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: allow deactivating the IEEE1394 menuconfig
 section at once
Message-ID: <20230907101601.GA33589@workstation.local>
Mail-Followup-To: Jan Engelhardt <jengelh@inai.de>,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20230906081216.22849-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906081216.22849-1-jengelh@inai.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 06, 2023 at 10:12:16AM +0200, Jan Engelhardt wrote:
> Presently, one needs to enter "FireWire (IEEE 1394) subsystem --->",
> then deselect all options individually. Speed up that process by
> making the "--->" line be togglable in its own right.
> 
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  drivers/firewire/Kconfig | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

We are at the second half of merge window for v6.6 kernel, while the patch
looks good to me. I applied it to for-next branch and will send it to Linus
within a few days, after it passes check by for-next integration.

> diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
> index 0a6596b027db..be1a9e685782 100644
> --- a/drivers/firewire/Kconfig
> +++ b/drivers/firewire/Kconfig
> @@ -1,8 +1,18 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -menu "IEEE 1394 (FireWire) support"
> +menuconfig FIREWIRE_SUPPORT
> +	bool "IEEE 1394 (FireWire) support"
> +	default y
>  	depends on PCI || COMPILE_TEST
>  	# firewire-core does not depend on PCI but is
>  	# not useful without PCI controller driver
> +	help
> +	  Support for FireWire.
> +
> +	  The answer to this question will not directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about FireWire.
> +
> +if FIREWIRE_SUPPORT
>  
>  config FIREWIRE
>  	tristate "FireWire driver stack"
> @@ -96,4 +106,4 @@ config FIREWIRE_NOSY
>  
>  	  If unsure, say N.
>  
> -endmenu
> +endif # FIREWIRE_SUPPORT
> -- 
> 2.42.0


Thanks

Takashi Sakamoto
