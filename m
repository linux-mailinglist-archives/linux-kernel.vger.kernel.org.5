Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D7B79D564
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbjILPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236475AbjILPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:54:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1E010EA;
        Tue, 12 Sep 2023 08:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694534087; x=1726070087;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3jTuqh4N0hikfcv6YdLFg6ihQkSrNyUM0fJiVYX+uhs=;
  b=I9JyLd2VYHkcBemXPD5vFPU07oqSoUYS1h5EkiMyFykpkMswK1Mr79qt
   ek5MXUUJtFkrDZNzopEol5rCRErHTeFPYtST8fW2KI3Sr5z2tcv0l6aNg
   RyxVEwA6/rs8cLm4NgykAmkQcF72LfR9Xg+107bS3GTUGieoyjYXk5yCn
   +FevaxiO5OJX9eZv7w7TcJO/FSAvaCDk6D+CNP7X9IKl348n6f8RtgY0L
   U6jFCN553Vvr0Lc+z8KIABdV5VOq7cVF1sdKK3cwAplkR3/5o5WPvMNH1
   Suk7EnQ/xFoKvDe2bxX5V6yrhL+rb6iu5fJNm574vHQkVQscH1SGqCqIZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409369514"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="409369514"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 08:54:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="833951803"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="833951803"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Sep 2023 08:54:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2881F248; Tue, 12 Sep 2023 18:54:43 +0300 (EEST)
Date:   Tue, 12 Sep 2023 18:54:43 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        dan.carpenter@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: baytrail: fix debounce disable case
Message-ID: <20230912155443.GF1599918@black.fi.intel.com>
References: <20230912154815.28975-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230912154815.28975-1-raag.jadav@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:18:15PM +0530, Raag Jadav wrote:
> We don't need to update debounce pulse value in case debounce is to be
> disabled. Break such a case where arg value is zero.
> 
> Fixes: 4cfff5b7af8b ("pinctrl: baytrail: consolidate common mask operation")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-gpio/d164d471-5432-4c3c-afdb-33dc8f53d043@moroto.mountain/
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
