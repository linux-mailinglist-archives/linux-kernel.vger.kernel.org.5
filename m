Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB467B83CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjJDPkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242925AbjJDPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:40:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D2998
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:40:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B18FC433C7;
        Wed,  4 Oct 2023 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696434012;
        bh=W9nN7QRuZVUT7tpRXvZ9PJAQeaIUegBNlFb+DkivbT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lGAY65533YzFiIQlo1Kaur5TW8121s9xQ+sEAsBEhsDF5rfuL6VUBmtOeQn46xzap
         IZOB4FAtvmIxfaRNsGxczGeF38nUCCKdMFGJIoj5nBUf2Dzov8ceRkKr1IPKawnWqP
         eKe05FXP6uEZhY+XJVXSwdWyRdNRCc35HmXyye8PgJspR8hlkW1yFgLgSejD4O3fhN
         3OV0wQQRSId34PQCvU9jvXWdzFMRKP5Br/AAZz2MyPgMiCQ2z6ricnZp52BM5nHQAU
         0GSKvUseb7yDzUEa4sbCXOQ4RdcV/2p5dFcf11PjLEAC3jfUyS1bXceUmLjPy5dj1Z
         BDBfjBnrA/9GQ==
Date:   Wed, 4 Oct 2023 08:40:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        <netdev@vger.kernel.org>
Subject: Re: [linus:master] [connector/cn_proc]  2aa1f7a1f4:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20231004084011.7aeef442@kernel.org>
In-Reply-To: <202309201456.84c19e27-oliver.sang@intel.com>
References: <202309201456.84c19e27-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 14:51:32 +0800 kernel test robot wrote:
> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 2aa1f7a1f47ce8dac7593af605aaa859b3cf3bb1 ("connector/cn_proc: Add filtering to fix some bugs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Anjali, have you had the chance to look into this?
