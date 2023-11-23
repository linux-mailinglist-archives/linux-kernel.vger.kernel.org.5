Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC117F5E79
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbjKWL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345167AbjKWL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:57:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D4D50
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:57:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E33C433C8;
        Thu, 23 Nov 2023 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700740654;
        bh=d1KKFj+DyjKk6+RozV1+DoTTJKQS2amb7hIMgX6LAvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=asew1abrsIY6gEFKiHpdM4HgeUYNjUYxkfJwcM8AY78HdsjF4c9X1ruoxfVSCYRR0
         BijnDVaEp+5V652iMAyaNcFpJTJ83/LaTU6XjfUjCxUN5fRucLY4oL7/vMQBhwEcG0
         mdGWod2B+3HjqG9YXstRAHHBUwzhGTC7OcoO1RCfWQ4jI7howUKc7AxJj/HY4m2Aty
         HO7bSH0KskPl+uUYUYDHRRSYtfHNjI646+EMzwNl6fhsFAC/jcVlOWgrayEyyndjZb
         whWdGZ/h8GS29BhGv0gYhOtXXtVQeH7WET3kL2Sh72T4aBFa0cbAGdd03SwK72sy/4
         0XqdT/k64sCiw==
Date:   Thu, 23 Nov 2023 11:57:29 +0000
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
Subject: Re: [PATCH v4 1/3] igb: Use FIELD_GET() to extract Link Width
Message-ID: <20231123115729.GA6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:34:26PM +0200, Ilpo Järvinen wrote:
> Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
> custom masking and shifting.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, nice to see FIELD_GET() used here.

Reviewed-by: Simon Horman <horms@kernel.org>

