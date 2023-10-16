Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8497CAC94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjJPO4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbjJPO4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:56:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3791EB4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:56:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E9BC433C7;
        Mon, 16 Oct 2023 14:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697468180;
        bh=WUnDHVUOqfcPj5bVg+fqz9I2iqfRHmXakB6J7g0FSl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tBaHa4rN2f9ZyQl8PO3D969/xIInxobp0Agmgswj4NYeEzKJt+Yd7gKTjQ85y4/ps
         vONoeTQn9sA1D7eJw0BeGNIDBFDXBgu+cuyXsm0PM88sEj5UgAictN722B3haxDhad
         I8nV4q4exbAqN6Mf1a7NbrUxI+lkf7ptzG8ZcLVnkXBn+UcNjHyo7wQMy4+E8reMGR
         oLr7pUPkemFg0Z9yIifcwLdr2ubw6+/6+4vQ10oomAedeksnDJYLfQRhLIGPWjrmHz
         RKO7CgX/X464Ldl5bpLeK06sAMOI2ULsNx8CFVejQ6OH5HgMjjZE1lWyIMSt7+VHKy
         4jbKvne1+vUEw==
Date:   Mon, 16 Oct 2023 07:56:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Message-ID: <20231016075619.02d1dd27@kernel.org>
In-Reply-To: <20231013170755.2367410-4-ivecera@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
        <20231013170755.2367410-4-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 19:07:53 +0200 Ivan Vecera wrote:
>  "serial_number" -> The PCI DSN of the adapter
>  "fw.mgmt" -> The version of the firmware
>  "fw.mgmt.api" -> The API version of interface exposed over the AdminQ
>  "fw.psid" -> The version of the NVM image

Your board reports "fw.psid 9.30", this may not be right,
PSID is more of a board+customer ID, IIUC. 9.30 looks like
a version, not an ID.

>  "fw.bundle_id" -> Unique identifier for the combined flash image
>  "fw.undi" -> The combo image version

UNDI means PXE. Is that whave "combo image" means for Intel?
