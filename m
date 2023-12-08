Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856F280A9D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574155AbjLHQyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 11:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjLHQyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 11:54:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B1122
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 08:54:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9764C433C7;
        Fri,  8 Dec 2023 16:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702054450;
        bh=rP/BoOBw5Wi94QQViNnTX6vvAn+7yt+JtMx5Ri2ncHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gKbjRSiLzKZGNfUhMQYIhifZWczNaZ9Eq9Y/tEFab9uHQVOGKz6HA/NHsmKfb4+F0
         ziNTw7QEuFW3K1TVs+9ymfmioHfwlGaVZyDlztuDUlQkwOIqD8xt9R6GK+EOu/hedI
         ClP8X+Mn4Hd8nHmb2plwGYUzPBX1w3eEUBWE5PoZ2Ct4LJT1mvPAZzxmR6omMexi+E
         j4gojDtzEboOoouSbEhJR7yc53+v7J3Sw08YnRlXOQBURkjDHHNDs/VBLZP4dhEb1U
         lKlhHNJT1rGCTRI3HPGWVnHEu/ov/1ssZpmNGReWp8NGD9cHvl7T5aPoKtxFpPxbd9
         kRujdfw9HwrBA==
Date:   Fri, 8 Dec 2023 10:54:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/3] PCI/AER: Clean up logging
Message-ID: <20231208165408.GA796794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206224231.732765-1-helgaas@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc Jonathan]

On Wed, Dec 06, 2023 at 04:42:28PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Clean up some minor AER logging issues:
> 
>   - Log as "Correctable errors", not "Corrected errors"
> 
>   - Decode the Requester ID when we couldn't find detail error info
> 
> Bjorn Helgaas (3):
>   PCI/AER: Use 'Correctable' and 'Uncorrectable' spec terms for errors
>   PCI/AER: Decode Requester ID when no error info found
>   PCI/AER: Use explicit register sizes for struct members
> 
>  drivers/pci/pcie/aer.c | 19 ++++++++++++-------
>  include/linux/aer.h    |  8 ++++----
>  2 files changed, 16 insertions(+), 11 deletions(-)

Applied to pci/aer for v6.8.  Thanks, Jonathan, for your time in
taking a look.
