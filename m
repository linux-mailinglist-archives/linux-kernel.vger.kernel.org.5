Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDB97EE08F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjKPMQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbjKPMQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:16:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F6E9C;
        Thu, 16 Nov 2023 04:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700137014; x=1731673014;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=fG2kDFOySIVUpLkO0CBCrE4Itv+obpd1DzcFnAf/iq0=;
  b=ej7MdeX/AK2XqdN+nyM1jIEEYQzPiDBB38QMnFbgX6SgzaK4udvaQ0CT
   3V/5gIUp2kC6E+FWO+96LqvDrrUKGqlgl8npcl3Ng12NcT5DKqy1Ir9Ew
   LLmh53uWKe/ZFRN5AFVl5ND7DtFBU9T1o5AEikZtyu8NZyMhIQECKKRQU
   ltc4aWJiXTdL6j5NkmZnyRtffncwPOtKPwbAj17tQfg+UlcmYA3UUL8MF
   CxqKYO9OOdBB2nt97j7NE45dACKvxbnNeuFqM5h7V/B0DoBrblD/dV2TD
   wdY9HxQmuZrORMfZSrK/mVoR+rv5hxEYXXQBnwJ3rNpvOZusRsof48NN+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="390865429"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="390865429"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:16:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938825905"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="938825905"
Received: from jhsteyn-mobl1.ger.corp.intel.com ([10.252.40.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:16:50 -0800
Date:   Thu, 16 Nov 2023 14:16:47 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Th=E9o_Lebrun?= <theo.lebrun@bootlin.com>
cc:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?ISO-8859-15?Q?Gr=E9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 3/5] tty: serial: amba-pl011: cleanup driver
In-Reply-To: <20231116-mbly-uart-v2-3-863f665ce520@bootlin.com>
Message-ID: <971f533-261a-3095-38a-586c74da543e@linux.intel.com>
References: <20231116-mbly-uart-v2-0-863f665ce520@bootlin.com> <20231116-mbly-uart-v2-3-863f665ce520@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1437232929-1700137013=:1886"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1437232929-1700137013=:1886
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 16 Nov 2023, Théo Lebrun wrote:

> Follow recommandations from:
> 
>     $ ./scripts/checkpatch.pl --strict --file \
>             drivers/tty/serial/amba-pl011.c
> 
> It does NOT fix alerts relative to TIOCMBIT which will be dealt with in
> another patch. Fixes following alerts:
> 
>     CHECK: Alignment should match open parenthesis
>     CHECK: Blank lines aren't necessary after an open brace '{'
>     CHECK: Comparison to NULL could be written [...]
>     CHECK: Lines should not end with a '('
>     CHECK: Please don't use multiple blank lines
>     CHECK: Please use a blank line after function/struct/union/enum declarations
>     CHECK: Prefer using the BIT macro
>     CHECK: Unbalanced braces around else statement
>     CHECK: Unnecessary parentheses around [...]
>     CHECK: braces {} should be used on all arms of this statement
>     CHECK: spaces preferred around that '/' (ctx:VxV)
>     CHECK: spaces preferred around that '|' (ctx:VxV)
>     ERROR: do not initialise statics to false
>     WARNING: Comparisons should place the constant on the right side of the test
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
>     WARNING: quoted string split across lines
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> @@ -2916,9 +2911,12 @@ static int sbsa_uart_probe(struct platform_device *pdev)
>  	if (qdf2400_e44_present) {
>  		dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
>  		uap->vendor = &vendor_qdt_qdf2400_e44;
> -	} else
> -#endif
> +	} else {
>  		uap->vendor = &vendor_sbsa;
> +	}
> +#else
> +	uap->vendor = &vendor_sbsa;
> +#endif

IMO, this would look a lot nicer if you make a function out of it (but 
perhaps it can be changed in a follow-up patch):

#ifdef CONFIG_ACPI_SPCR_TABLE
static void qpdf2400_erratum44_workaround(struct platform_device *pdev,
					  struct uart_amba_port *uap)
{
	if (!qdf2400_e44_present)
		return;

	dev_info(&pdev->dev, "working around QDF2400 SoC erratum 44\n");
	uap->vendor = &vendor_qdt_qdf2400_e44;
}
#else
static void qpdf2400_erratum44_workaround(struct platform_device *pdev,
					  struct uart_amba_port *uap) { }	
#endif


static int sbsa_uart_probe(struct platform_device *pdev)
{
	...
	uap->vendor = &vendor_sbsa;
	qpdf2400_erratum44_workaround(pdev, uap);
	...
}


Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1437232929-1700137013=:1886--
