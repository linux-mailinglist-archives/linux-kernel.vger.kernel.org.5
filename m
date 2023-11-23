Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989987F5E85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345195AbjKWL5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjKWL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:57:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF649A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014FAC433C8;
        Thu, 23 Nov 2023 11:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700740675;
        bh=wl9oNNHOLEXop5o0ArpCVRXBXQS6LvZBy1Xs2D72YlQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RBtfNhqgVf2DOEg6I9Ifs5PmN+q9wsTnGe+qHhbeEJKlV8I3wzrxM4I2f5G51Q6I2
         rYG1IMBn7OTW+y1uEZcyfOUd+/AcRqbZEM3uigEqI97iQgNZLWzo1Bb6wlbzq0C9An
         xoPhMmQyKzAEvEbnekNqT89fst8W1GZVYnGv/8DFHntwaOie+yuRdTkDp9dN7MDmo/
         D62Pp6nSt3IQLkaCFiWQT153LIol6TSYcPB5GtiWGB2g5qINJ6P9Y7QELDfkOtUrwh
         M6CxD1zlgZX6MhtInT6OppoHdLT6VcWlTPaN3dz1G6jojeO1ku1/qcFbqRqy+q2xSf
         ysgI+NwGKBteA==
Date:   Thu, 23 Nov 2023 11:57:50 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET()
 instead of custom defines/code
Message-ID: <20231123115750.GB6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-3-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:34:27PM +0200, Ilpo Järvinen wrote:
> e1000e has own copy of PCI Negotiated Link Width field defines. Use the
> ones from include/uapi/linux/pci_regs.h instead of the custom ones and
> remove the custom ones and convert to FIELD_GET().
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

