Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D248107A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378169AbjLMB2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378145AbjLMB2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:28:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28957A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:28:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF7C433C7;
        Wed, 13 Dec 2023 01:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702430934;
        bh=WHT7yhKML4b47HIYKO+zlfH79QBE5JY7QcP0BwiA0S8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uAlEUEW5DH1jtd23uEK97RhH1sMDjeaXr/+8cvWEY7H8DWnBRu9WYK4z+LquCqduC
         d5yOoh2A5t8B8EMIWYb/+gZFCeW5rcboH2p7gSXO7k25GkeuobI4SUO/xfBnDhwaT8
         fUZiN3mFTu1WTUG2y7Qcl9x7bDatbIycB9nt/X2REgZt3O28IeY5TyBq656pRLqcKe
         icG6X4V1+maL9YYYzcb/kUaOEQmH86ymexTx4y3DT7GOKfxEHKID7v/k+vrJNQWZxC
         cPxMaWP0rOWZdesc5wteOUYZpT0C/rtvPIDjL/xrl/6+iqFuJ+l4wQ6VzP4crWZvvv
         ywikPVplcPtzg==
Message-ID: <9dc77c35-bcb3-4a87-9926-36a0fa205d17@kernel.org>
Date:   Wed, 13 Dec 2023 09:28:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: fix to check return value of
 f2fs_recover_xattr_data
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
        ke.wang@unisoc.com
References: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/12 10:15, Zhiguo Niu wrote:
> Should check return value of f2fs_recover_xattr_data in
> __f2fs_setxattr rather than doing invalid retry if error happen.
> 
> Also just do set_page_dirty in f2fs_recover_xattr_data when
> page is changed really.
> 
> Fixes: 50a472bbc79f ("f2fs: do not return EFSCORRUPTED, but try to run online repair")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
