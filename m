Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F237DC1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 22:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJ3Vfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 17:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjJ3Vfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 17:35:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1BCF1;
        Mon, 30 Oct 2023 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698701743; x=1730237743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0yyqaB5lmhPlXsvhKY5afCC2SJJ/dvbifhiAH09zkBg=;
  b=AGuJvEKsL0Je/n/ZXBzNGBeHiFeXmZ1+gnenH9QyxrBcIMg0bQAEdHLe
   Vr4LP2puE5e5k0tetnf4Wk3ljaCln+rX7nnrGtLfpc58AVnMkigmKuxVj
   kcD5ZWzfZIpmBRMFIEW2Mjzz+YIjAkrGr4W7zQE81ZdLtQAW7PVioWUOJ
   vRf/QlEM3wBDaaFi0LlNlBwGyc1NPhf+GgEWn1QaIvyY5Z7CtXele9TmV
   8cdeDHLL7FXkZE0ECki1VZTpoMgl6dYH2Enyga2tsW8YTyqMp7q0vsNOw
   O92pD6xEK2tl7Y7LitOMfGqWD/llcNMJ0Z1ZMrs/K+fH2KBt4gQatLInp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="474409350"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="474409350"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="710227022"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="710227022"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 14:35:40 -0700
Date:   Mon, 30 Oct 2023 23:35:37 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: tangier: Enable 910 Ohm bias
Message-ID: <ZUAhqX-3O6QcoWMZ@black.fi.intel.com>
References: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030141404.3242102-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 04:14:04PM +0200, Andy Shevchenko wrote:
> Family 7 (I2C) supports special bias value, i.e. 910 Ohm.
> 
> Enable it for configuring pin.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pinctrl/intel/pinctrl-tangier.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pinctrl/intel/pinctrl-tangier.c b/drivers/pinctrl/intel/pinctrl-tangier.c
> index 40dd60c9e526..007bca1cf224 100644
> --- a/drivers/pinctrl/intel/pinctrl-tangier.c
> +++ b/drivers/pinctrl/intel/pinctrl-tangier.c
> @@ -382,6 +382,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
>  		case 2000:
>  			term = BUFCFG_PUPD_VAL_2K;
>  			break;
> +		case 910:
> +			term = BUFCFG_PUPD_VAL_910;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -405,6 +408,9 @@ static int tng_config_set_pin(struct tng_pinctrl *tp, unsigned int pin,
>  		case 2000:
>  			term = BUFCFG_PUPD_VAL_2K;
>  			break;
> +		case 910:
> +			term = BUFCFG_PUPD_VAL_910;
> +			break;
>  		default:
>  			return -EINVAL;
>  		}

Ah, I failed to notice this was already preset in the getter.

Looks good,
Raag
