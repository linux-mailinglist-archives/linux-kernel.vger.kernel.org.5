Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7C4779F0A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjHLKgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLKgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBC819A3;
        Sat, 12 Aug 2023 03:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE806339E;
        Sat, 12 Aug 2023 10:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B26C433C8;
        Sat, 12 Aug 2023 10:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691836575;
        bh=LxpNbGRxgvMb0WU3z01+dc2gxsruBj7n+I1al66HDeQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPyNN1E/07nmj3XLXiJ9kmfw6IQFcUhTSidbNZ6fVHVbBXPAHzt0pF/fC4GdiLCp/
         MyIgrYaSeR0RK3EniJIpFE1/7GlaL1GQozgZhGH31WunTyZeR/g23cKZ+TFPpA1bEw
         gt8QAIx3rPswWdxLuOBz4cLWnjUHsfoQ6qjfm1bo=
Date:   Sat, 12 Aug 2023 12:36:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Mike Tipton <quic_mdtipton@quicinc.com>, rafael@kernel.org,
        corbet@lwn.net, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_viveka@quicinc.com, peterz@infradead.org,
        quic_pkondeti@quicinc.com
Subject: Re: [PATCH v3 1/3] debugfs: Add write support to debugfs_create_str()
Message-ID: <2023081256-fastness-marine-609f@gregkh>
References: <20230807142914.12480-1-quic_mdtipton@quicinc.com>
 <20230807142914.12480-2-quic_mdtipton@quicinc.com>
 <58ea6863-53cd-228b-1474-f67b0bb134f0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ea6863-53cd-228b-1474-f67b0bb134f0@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:46:34AM +0300, Georgi Djakov wrote:
> On 7.08.23 17:29, Mike Tipton wrote:
> > Currently, debugfs_create_str() only supports reading strings from
> > debugfs. Add support for writing them as well.
> > 
> > Based on original implementation by Peter Zijlstra [0]. Write support
> > was present in the initial patch version, but dropped in v2 due to lack
> > of users. We have a user now, so reintroduce it.
> > 
> > [0] https://lore.kernel.org/all/YF3Hv5zXb%2F6lauzs@hirez.programming.kicks-ass.net/
> > 
> 
> Hi Greg,
> 
> Looks like the original code was reviewed two years ago (not sure if it
> counts). But in any case, i need an ack from you to apply this.
> 
> There is no build dependency with the rest of the patches (but there is a
> functional one). It should be also fine if you apply it directly, if you
> prefer so?

Feel free for this to go with the code that uses it:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
