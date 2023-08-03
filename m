Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9C76E7E8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjHCMIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjHCMIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA082D5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C13CA61D6A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 12:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B80C433C8;
        Thu,  3 Aug 2023 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691064517;
        bh=jMfkuSljeC1MmRBLH3M+5Zxeay+VmMKCSTJBTFXNkLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gG2Se5Pbifb4P8fUNKQGqTGXzR2qHyEf/HPRqORf99evMR6MnBLebJ4Yag4MIkQ68
         pbyEgUkQIM/V92t5I4emcTwyKI9+Zf1sOFWnmuHS1dIFQcngGa7yBpWnowtueFQXGr
         tPvfbdnc6LV3wKQqQo5mgSHjJc9F92mE6GQAnApIzijqhcKUBkL6yc9HdTkVZdVUPY
         yKhZpo1Op/W/vLggkgZE5JMhVhalf8urx+8OHGnlu+nKh+8zASLkHz6PYNUUUa3Ycy
         Jg05gjrpRCPe6M5lJV46hAPZoDLOH7oAua0bqoot7AiAn0uNmh9+IvI3ilyA5E/K7W
         Aib4ZRWdwTTXw==
Date:   Thu, 3 Aug 2023 14:08:32 +0200
From:   Simon Horman <horms@kernel.org>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: bpf_struct_ops: Remove unnecessary
 initial values of variables
Message-ID: <ZMuYwD4JojLx0D7M@kernel.org>
References: <20230804175929.2867-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804175929.2867-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 05, 2023 at 01:59:29AM +0800, Li kunyu wrote:
> err and tlinks is assigned first, so it does not need to initialize the
> assignment.
> 
> Signed-off-by: Li kunyu <kunyu@nfschina.com>

Reviewed-by: Simon Horman <horms@kernel.org>

