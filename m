Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DA27CBF95
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjJQJjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjJQJi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:38:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD005FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:38:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF5BC433C8;
        Tue, 17 Oct 2023 09:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697535536;
        bh=q5zeQh7ro2KARanVykv+WJlniZIPzo8eTIj5c61IbSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JtAKlHrfihWpLZuYmTMsv3Yh3Ex/Z29hqW3E7PCXH6l7+6D2nGKPXtpnTLBKc+ZFN
         mohjJ3oiy31ZIPnQsELDRF94QxZiTfOymc2OcGVf1e87/xMDpAbKBc5KSRDVYtJ2eJ
         PiLhN+JPDaKTNRXisra7A8RGu4lYfWaSbXbJ1UtUyBm1O9PAwhooT4Rdi8+K7BYT7N
         YMakNmAutTZplQqh23xSFWiOwCRMZfk/s3uMc5pexvyqKMzB8z4k7XbqEh+aJacaim
         3U4raGDHbqQHLQGQbiBiGzxmYRUKt9xN4t55GMgRqYkTWr/2fi4MGWxcI9r8DBRHLT
         L/D+UTTja6jiA==
Date:   Tue, 17 Oct 2023 11:38:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Shinas Rasheed <srasheed@marvell.com>
Cc:     linux-kernel@vger.kernel.org, pabeni@redhat.com,
        davem@davemloft.net, edumazet@google.com, egallen@redhat.com,
        hgani@marvell.com, kuba@kernel.org, mschmidt@redhat.com,
        netdev@vger.kernel.org, sedara@marvell.com, vburru@marvell.com,
        vimleshk@marvell.com
Subject: Re: [net-next PATCH v3] octeon_ep: pack hardware structure
Message-ID: <20231017093851.GW1751252@kernel.org>
References: <20231016092051.2306831-1-srasheed@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016092051.2306831-1-srasheed@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 02:20:51AM -0700, Shinas Rasheed wrote:
> Clean up structure defines related to hardware data to be
> attributed 'packed' in the code, as padding is not allowed
> by hardware.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V3:
>   - Updated changelog to indicate this is a cleanup

Thanks, the patch description now matches my understanding
of the intent of the patch.

Reviewed-by: Simon Horman <horms@kernel.org>
