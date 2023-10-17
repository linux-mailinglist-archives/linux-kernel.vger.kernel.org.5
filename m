Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B78D7CC751
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbjJQPV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344304AbjJQPVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:21:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D04FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:21:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64D4C433C8;
        Tue, 17 Oct 2023 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697556083;
        bh=qbYVXv4lkClIrB/LA3B8Jyjx9weJj4eJIR8Mx8PZSYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jqRAq7CIsOinTEsGUuo+mqcv9B0r2CXjADfQ4alGoVBKPa9EXx6j7ii9pwS8T5GPG
         qkbsJP+Z4OSLjbPKwb8wVfJPScrt+g7RY9OnASGqa0oLI+nZudKHO17RTLro2tvQgi
         0rKV89mkA2GAyutB0nvGmPm/sRzYunUVmCvxjSQIxxi4Fvi2/kq+rYObzQ6B2faq0W
         5VM7d3/Nepn29SFzYmUMnxK4hFoZJkLRap/mNlicUsVCy22af19XxgBqmnRwefoykE
         mbRrJNDRlnAkV3oOsPz2oFC+BUxqabo6WQYZwfoWk971qZN2ZdO9WZULka4eDX0liy
         8MCb7vl6Iybsg==
Date:   Tue, 17 Oct 2023 08:21:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Message-ID: <20231017082120.1d1246f6@kernel.org>
In-Reply-To: <b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
References: <20231013170755.2367410-1-ivecera@redhat.com>
        <20231013170755.2367410-4-ivecera@redhat.com>
        <20231016075619.02d1dd27@kernel.org>
        <b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
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

On Tue, 17 Oct 2023 11:56:20 +0200 Ivan Vecera wrote:
> > Your board reports "fw.psid 9.30", this may not be right,
> > PSID is more of a board+customer ID, IIUC. 9.30 looks like
> > a version, not an ID.  
> 
> Maybe plain 'fw' should be used for this '9.30' as this is a version
> of the whole software package provided by Intel for these adapters
> (e.g. 
> https://www.intel.com/content/www/us/en/download/18190/non-volatile-memory-nvm-update-utility-for-intel-ethernet-network-adapter-700-series.html).
> 
> Thoughts?

Hm, that could be better, yes.

Jake, any guidance?

> > UNDI means PXE. Is that whave "combo image" means for Intel?  
> 
> Combo image version (aka CIVD) is reported by nvmupdate tool and this
> should be version of OROM that contains PXE, EFI images that each of
> them can have specific version but this CIVD should be overall OROM 
> version for this combination of PXE and EFI. I hope I'm right.

Sounds good then!
