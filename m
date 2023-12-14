Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49182813A76
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573072AbjLNTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 14:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 14:05:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA9112
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 11:06:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D752C433C7;
        Thu, 14 Dec 2023 19:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702580762;
        bh=rMMbprCSgIlMQDOFJO2zSoGk4wxg+cuQ04IE/7PyMQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6YyB8XM4mimLaJ42oY3UMyx6nDDSyinNQci0/3ACt/y32eQklmHkpGYm1mlg8rdB
         PrMSEuTljuDXuPDCAuX55XHk8xHjuX35iDighXEP5U/aRmcykUr3lSinYdA6xlLZeG
         JD8n1Xdp1J9hVeb6QtNLQ1x874PjDYCi44pe4HU+MVgf1YnhyPvmSFfFsT+ocN+b3s
         Qal1GuVPICXlLJXnzSVYg7uGLnD/VkjVjryZhBD30+NKqu4UDJqNd+T7gkmq/RtuRU
         4QG+7ohmBD6J69fyC+IUZt6Kix2EW4Zl6V4ktFVYB1fjE/U32WDItatJ9v7TPI54ET
         PdZjmQeZst5EQ==
Date:   Thu, 14 Dec 2023 11:06:01 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     <deepakx.nagaraju@intel.com>
Cc:     joyce.ooi@intel.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH 4/5] net: ethernet: altera: sorting headers in
 alphabetical order
Message-ID: <20231214110601.593f8013@kernel.org>
In-Reply-To: <20231213071112.18242-5-deepakx.nagaraju@intel.com>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
        <20231213071112.18242-5-deepakx.nagaraju@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 15:11:11 +0800 deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Re-arrange the headers in alphabetical order and add empty lines
> in between of groups of headers for easier maintenance.

This breaks the build, please make sure allmodconfig build works.
-- 
pw-bot: cr
