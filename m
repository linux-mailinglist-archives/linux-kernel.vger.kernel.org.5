Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5911A7E0738
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjKCROE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjKCROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:14:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2B0D47
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:14:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF03C433C8;
        Fri,  3 Nov 2023 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699031640;
        bh=i1/OCP6nHwLYZipGp9hjEQ3J+qcqL4DAmtnlCVaSDqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s5to2z2eyOIQrYaKX3IjmVMzsSpkh2bZkXp3Sqv27KBCY6mmo/R2twyhRcxqpzpyj
         H5dGKPKcwqvbFQJ/mi8MtB/CwI7mhPLMOxKJoi+z/1xm20XxplGjR5FdYtzqk7OWaq
         y5ayxEyYL2pzmNy+JuvGsE4mTJXsQ1wklVC6G81wYR/TwD0mfOqx9QCVx87MsD8HHQ
         kvRA7K0lIi/+FJdbogUsko5plKqmEzYPTZP07RIsz2FUETDojmrh55pZxy2u6JwbG+
         NZvWx/NLyX9qjon10RPbalzWtg16ebUfqwHp4av1NLDDSNKiffldCjRVCGVOySt/wq
         wrZrczhJZcWRQ==
Date:   Fri, 3 Nov 2023 17:13:54 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next] i40e: Remove AQ register definitions for VF
 types
Message-ID: <20231103171354.GE714036@kernel.org>
References: <20231026083822.2622930-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026083822.2622930-1-ivecera@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:38:22AM +0200, Ivan Vecera wrote:
> The i40e driver does not handle its VF device types so there
> is no need to keep AdminQ register definitions for such
> device types. Remove them.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks, another nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

