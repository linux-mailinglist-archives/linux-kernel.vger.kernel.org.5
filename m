Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFF7A468C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241120AbjIRKCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbjIRKBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:01:54 -0400
Received: from out-220.mta0.migadu.com (out-220.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78C116
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:01:42 -0700 (PDT)
Message-ID: <d3b22c8c-a69a-22a7-74c5-88c2336ad9e0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695031300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uk+zVvfdVv7MKNngERnvzAMpm0IuiTXaieS80CZjc84=;
        b=iKeSM+REZz4FieSgC9pIJiY95kdpMJOHBWEmy6JSu9vGsxUJNU9pdo/DREH6a5+hHiW8/N
        x5JVlqSIitpyLqsVOGHEWPW3LuNELYk3aactu4/g7jKwritJSexjo7joYGwCOIfhHXsaTs
        ZaHAy+yn2tQbPA6+IKbIwAS2MCfRml4=
Date:   Mon, 18 Sep 2023 11:01:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Documentation: dpll: Fix code blocks
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20230918093240.29824-1-bagasdotme@gmail.com>
 <20230918093240.29824-2-bagasdotme@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230918093240.29824-2-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/2023 10:32, Bagas Sanjaya wrote:
> kernel test robot and Stephen Rothwell report htmldocs warnings:
> 
> Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 18 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> Documentation/driver-api/dpll.rst:444: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 21 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> Documentation/driver-api/dpll.rst:474: WARNING: Error in "code-block" directive:
> maximum 1 argument(s) allowed, 12 supplied.
> 
> .. code-block:: c
> 	<snipped>...
> 
> Fix these above by adding missing blank line separator after code-block
> directive.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309180456.lOhxy9gS-lkp@intel.com/
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20230918131521.155e9e63@canb.auug.org.au/
> Fixes: dbb291f19393b6 ("dpll: documentation on DPLL subsystem interface")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> ---
>   Documentation/driver-api/dpll.rst | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
> index bb52f1b8c0be31..01eb4de867036f 100644
> --- a/Documentation/driver-api/dpll.rst
> +++ b/Documentation/driver-api/dpll.rst
> @@ -425,6 +425,7 @@ The simplest implementation is in the OCP TimeCard driver. The ops
>   structures are defined like this:
>   
>   .. code-block:: c
> +
>   	static const struct dpll_device_ops dpll_ops = {
>   		.lock_status_get = ptp_ocp_dpll_lock_status_get,
>   		.mode_get = ptp_ocp_dpll_mode_get,
> @@ -442,6 +443,7 @@ structures are defined like this:
>   The registration part is then looks like this part:
>   
>   .. code-block:: c
> +
>           clkid = pci_get_dsn(pdev);
>           bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
>           if (IS_ERR(bp->dpll)) {
> @@ -472,6 +474,7 @@ The registration part is then looks like this part:
>   In the error path we have to rewind every allocation in the reverse order:
>   
>   .. code-block:: c
> +
>           while (i) {
>                   --i;
>                   dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);

