Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2260580F91F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377585AbjLLVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377557AbjLLVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:23:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB3A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:23:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D30C433C9;
        Tue, 12 Dec 2023 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702416205;
        bh=/ixDf/FMAeVQ+/FH3AsNSPZ9BcC9ELGE9aI1dGNMoIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iigFE0sX/7WKAGE22E7MrW/4c+wXyqluQ6d6vh1soqeCaAKuY8p3R2ZL7ifRCIHzU
         2z4n+o5thjK/+Sg3bN2ZegIK7cLBE/OG49Ee78lgIU1iyMjeMuZ3YDx3v29LPMKYKb
         jph+hciZcuNVcxbCRZKjqmUB3Tnm9az5BwCWdw4bkMGLH/bFwWxGZCeL7xWbJ05kqA
         gdcFiURxTcS4OuKVKRJgZgMSLa09fp9rCGzOdQE6q7UM7WzF/bNodABI+VNg9gxP+m
         ckV1V0bh4Kz7bxLcvxjWzPbwinGk51fT1aYaeZ5G0T5adHKkVNXzTTtk1pC9B83dPw
         55lJ4EVvwkHGg==
Date:   Tue, 12 Dec 2023 15:23:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Terry Bowman <Terry.Bowman@amd.com>
Cc:     linux-pci@vger.kernel.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Robert Richter <rrichter@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/3] PCI/AER: Use 'Correctable' and 'Uncorrectable' spec
 terms for errors
Message-ID: <20231212212323.GA1021034@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace772f1-475a-4d20-9bf3-3b9901d48dd7@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 09:00:24AM -0600, Terry Bowman wrote:
> Hi Bjorn,
> 
> Will help prevent confusion. LGTM. 

Thanks a lot for taking a look at these!  I'd like to give you credit
in the log, e.g., "Reviewed-by: Terry Bowman <Terry.Bowman@amd.com>",
but I'm OCD enough that I don't want to translate "LGTM" into that all
by myself.

If you want that credit (and, I guess, the privilege of being cc'd
when we find that these patches break something :)), just reply again
with that actual "Reviewed-by:" text in it.

Bjorn
