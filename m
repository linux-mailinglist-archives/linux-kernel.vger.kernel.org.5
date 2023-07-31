Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE69769D49
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjGaQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGaQ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:56:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27391722;
        Mon, 31 Jul 2023 09:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690822591; x=1722358591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U7roQ+XUWlcaav2uFYpJOY2fwBdNYfkUnYbQlW3JYsQ=;
  b=nHgM+gjCTDnDrNVY/ToZPx1YbypoRAnl1HmS+nVGAytNemgFVHrp9Ljt
   q/Fzpk/RI4EAoGyhBBGhK2z5FVVaCENJoUzvSQedgqUVKiDpiM4VKnKEd
   FI93+PvLNFjb4C013RHpJlu7KR5+qLI5lCO+cCQbk9CD6DOQI29otroyl
   Jn8pHi2oic8xRFpbPPCFiW8e0eDmoZSLEaFBYCBAXQyrZCCi/Goi6pYIM
   1aD9TPqklwSv8REB7AKnaoRDFut33KzNy/xiwU0rkK7Fl6Nvff9PSpksg
   9Ohdr7aOVe/Itie275038CLOMBf732tUBGgz6t/e51oso33JC7krPKz7d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="348671180"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="348671180"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 09:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852115896"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="852115896"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.229.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 09:56:04 -0700
Date:   Mon, 31 Jul 2023 09:56:04 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     ztarkhani@microsoft.com, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lsm: add comment block for security_sk_classify_flow LSM
 hook
Message-ID: <ZMfnpPe3WCHgSDFQ@aschofie-mobl2>
References: <ZMfG/w5FWqCGE4pn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMfG/w5FWqCGE4pn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:36:47PM +0500, Khadija Kamran wrote:
> security_sk_classify_flow LSM hook has no comment block. Add a comment
> block with a brief description of LSM hook and its function parameters.

When referring to functions, in the one line commit message, or here
in the commit log, it is customary to add the parenthesis to be clear
it is a function name.

ie. security_sk_classify_flow()

> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  security/security.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index d5ff7ff45b77..ffc5519e49cd 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -4396,6 +4396,13 @@ void security_sk_clone(const struct sock *sk, struct sock *newsk)
>  }
>  EXPORT_SYMBOL(security_sk_clone);
>  
> +/**
> + * security_sk_classify_flow() - Set a flow's secid based on socket
> + * @sk:  original socket
           ^errant space

> + * @flic: target flow
> + *
> + * Set the target flow's secid to socket's secid.
> + */
>  void security_sk_classify_flow(struct sock *sk, struct flowi_common *flic)
>  {
>  	call_void_hook(sk_getsecid, sk, &flic->flowic_secid);
> -- 
> 2.34.1
> 
