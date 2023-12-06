Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5F807C13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379609AbjLFXIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379561AbjLFXIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:08:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A76DD4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:08:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A01C433C7;
        Wed,  6 Dec 2023 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904121;
        bh=AO1ty7D6PaKp6YDUkB6GcaoW3ZWSgt+tWyq663+Pm1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YeM3t9qF4gO99MzKrXKOOaZSPdSn/RA80k5Anw846HM1ng+H7TvW6Ve27idk2Wcl7
         QkAxlobS+pcETYJbQSJF3epD1OzwL7IhBfgbyRsfsG+7pqfPgwRB3Lzt6mXP145rd1
         4omKqqli/+EuDT1yh/2YZT9p+LEVINP7aqySAzp2uwqubJCBolDIVQnXih1pn8z2Nm
         Py+n5MRhtqs2zPi5NVB3qWIbpGPjlPZvC6MpSmtFCvLWPnTD5hDZpvy39W8NHI7rrn
         J45fhSVhQtZWWq5HloDYZkuHBw4pWR9N1NHlrhuwT2Py9Zln+XS7nR/zP0Mnqcs9W/
         u3Cc7xlccykqg==
Date:   Wed, 6 Dec 2023 17:08:40 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     LeoLiu-oc <LeoLiu-oc@zhaoxin.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, bhelgaas@google.com,
        robert.moore@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        acpica-devel@lists.linux.dev, CobeChen@zhaoxin.com,
        TonyWWang@zhaoxin.com, ErosZhang@zhaoxin.com, LeoLiu@zhaoxin.com
Subject: Re: [PATCH 3/3] PCI/ACPI: Add pci_acpi_program_hest_aer_params()
Message-ID: <20231206230840.GA733691@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115091612.580685-4-LeoLiu-oc@zhaoxin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 05:16:12PM +0800, LeoLiu-oc wrote:
> From: leoliu-oc <leoliu-oc@zhaoxin.com>
> 
> Call the func pci_acpi_program_hest_aer_params() for every PCIe device.
> Extracting register value from HEST PCIe AER structures and programming
> them into AER Capabilities are implemented in this function.
> The implementation of the function is an effective supplement to _HPP/_HPX
> method when the Firmware does not support the _HPP/_HPX method and can be
> specially configured for the AER register of the specific device.

Rewrap into a single paragraph or add blank lines between.

If this is needed to make some machine work correctly, please include
that information here.

Based on Rafael's comment about getting the actbl1.h change merged via
ACPICA first, I assume this entire series is will wait for that ACPICA
update.

Bjorn
