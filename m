Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBAC7DBC51
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjJ3PDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3PDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:03:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDBC9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:03:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109FFC433C9;
        Mon, 30 Oct 2023 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698678224;
        bh=/e6WeDGwbz91KGCx8dhoEfJpZYov52rFu9fCRmp3ib4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dqXyfFex6wMM2LHMiBfmkII0cvESFJLAVuUBiAEXyZ4UjfVPDOE+JklAcPytp+hPJ
         aEVaROX3XQyIiIchGyXXhiWgRX2aFxNzkGB52Y0tNyrATvTeWVZVv6p0WfH3mimK05
         oiiDAPqAdD+B6z289BSBbhWAWgd+W/x19NrCkazOJtUSxMY4E+NEdcVzyO3odjSJDF
         ez6AK4bwFm4XPhYBTLXPWwjYAbdtBssnPivAef95mpRZYcib+OOdACnedIatxQHmic
         saRG2yTBvDSkq0FuwqA/xgZ9rnPg7G7f63ryZxOal6tzKndilyh4W9fzVbt4b6VAsq
         eYNRUZ1ddGEbg==
Message-ID: <45595f8b-eaf7-85ba-ed13-54197b08edb6@kernel.org>
Date:   Mon, 30 Oct 2023 23:03:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] erofs: get rid of ROOT_NID()
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231026021627.23284-1-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 10:16, Ferry Meng wrote:
> Let's open code this helper for simplicity.
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>
