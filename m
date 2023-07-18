Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1839875862A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGRUia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGRUi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:38:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C9EC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 13:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B96160DFA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 20:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68808C433C8;
        Tue, 18 Jul 2023 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689712707;
        bh=k0PounCfLuAZPM9E0vlfC9GUV2WhU2Rz0BjcWP0QwFQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u48RxaSeBEEnMV2TkHa8sVNbmPXk70JYdBrDRUKsyCybPeAw/k/0SZrUBZJCDuce9
         WrGgXR7H3sHFD8czIqDln14EXzXgMKDEryNMmoc5uCdRM3xJqF7+jiz3kYym3j3LQH
         ab01MVo2XuasrbgGruTzE4qi6ciBEJ0+uIQS/UWxx8ToRGOhhapTGPFcKRdLqqVcmw
         8E8j+3gjN007C3bFE6ATvRoZ1Cxz0jH4PLA5dFiJY84CrgXq3eAkWTnhRNt4yFE7/j
         sZUSl6KXPJzAjOrBmmtN5wh9fhoncn1io1kKxf78ir/KS9iRPDCyffBVOd2RB+Voaq
         1xBLsigoDC52w==
Date:   Tue, 18 Jul 2023 13:38:26 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH V2 0/3] octeontx2-af: Fix issues with NPC field hash
 extract
Message-ID: <20230718133826.09db812c@kernel.org>
In-Reply-To: <20230714071141.2428144-1-sumang@marvell.com>
References: <20230714071141.2428144-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 12:41:38 +0530 Suman Ghosh wrote:
> This patchset fixes the issues with NPC field hash extract. This feature is
> supported only for CN10KB variant of CN10K series of silicons. This features
> helps to hash reduce 128 bit IPv6 source/destination address to 32 bit(also
> configurable) which can save 96 bit and can be used to store other key information
> during packet filtering.

For better or worse these patches seem to have already been merged
in May. Why are you resending this?
