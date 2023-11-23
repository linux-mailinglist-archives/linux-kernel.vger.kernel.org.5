Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC227F5E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345201AbjKWL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345171AbjKWL6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:58:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8AD47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 03:58:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7262BC433C7;
        Thu, 23 Nov 2023 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700740703;
        bh=6rq3wbNnETxmGO38nmjeAXuf2R7yIaTdB+RurHtR94s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ReK8N3T9qK44A4ISJlFiWiFFDjP+AZ13R55LmXzAECstsIG0PbM/mCm8RJjxXX5hJ
         kP9D7KIB7sZeE8u/K9w89wgKRsDzRyuI1K1TmykhD4+SS9syKgtHAlrXwy4uOs4s5D
         321wrppn1hKNaJDxT2IFPnSGOgehxTCQNAMkfwxw84yZrQqxk8E/0dARIP0r4fXcg0
         uhN2iyBqwUOSBX+64+bJscIjZV/wajbCSQwZz/AiiwVlWMpUss+Ok1+A+8bTrOfUzJ
         1iw9GrbgfP87j6gT92nwY0dNnSZgxR9o6HL8O9Q7GuJmoZzqD7aYCNQDWN3qCkDKlt
         ZZ03JRsa1RdbA==
Date:   Thu, 23 Nov 2023 11:58:19 +0000
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
Subject: Re: [PATCH v4 3/3] e1000e: Use pcie_capability_read_word() for
 reading LNKSTA
Message-ID: <20231123115819.GC6339@kernel.org>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
 <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 02:34:28PM +0200, Ilpo Järvinen wrote:
> Use pcie_capability_read_word() for reading LNKSTA and remove the
> custom define that matches to PCI_EXP_LNKSTA.
> 
> As only single user for cap_offset remains, replace it with a call to
> pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
> pci_dev because both users are interested in it.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

