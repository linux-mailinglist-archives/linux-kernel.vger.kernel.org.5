Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82817C73A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379620AbjJLRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378915AbjJLRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:03:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA0D6;
        Thu, 12 Oct 2023 10:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gkmLsGjV2f0W15bZiquisA3+eebGMiFMyy8eh2lGTTU=; b=tgz3lfJKJAKbfAetX7/cXWgPSl
        Y5td+/opo905sVfVSYodiIZbwCI4OSaWHJTfjQdIz+oytgulU0aTW/DLvT1u28+QR7D98fWF6KXio
        fT3T4IJlhrVY4srIoexXGqAIRDga3ZqlzFzqthR6e9rv42BbmS5jeme2WEPzgGAOxWfPR4lx+I45c
        sAFydbtWGzw4UWHz+DornX7GUKjs1meDwtdzHnPywyrJCD6XhV+tjWXphNHNOWxvv6MlL7KYZjtLZ
        fYHBjcNIA9BbZFTj3G2pFg/+TBoXSFb4RWLohg2Y6FplZSUEZptdkxYe+7YuzNtGxbE4Gic+pPhPa
        +tekPbUg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qqz6C-001Tff-2e;
        Thu, 12 Oct 2023 17:03:48 +0000
Date:   Thu, 12 Oct 2023 10:03:48 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joey Jiao <quic_jiangenj@quicinc.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] module: Add CONFIG_MODULE_DISABLE_INIT_FREE option
Message-ID: <ZSgm9BK4oeJz3wx1@bombadil.infradead.org>
References: <20231012014012.9030-1-quic_jiangenj@quicinc.com>
 <ZSgj02JtR+Hkc5qz@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSgj02JtR+Hkc5qz@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 09:50:27AM -0700, Luis Chamberlain wrote:
> > In the kernel, selecting the CONFIG_MODULE_DISABLE_INIT_FREE
> > option disables the asynchronous freeing of init sections.
> 
> No it does not.

I take it back, your patch effectively only does this.

  Luis
