Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AA97D3BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjJWQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:15:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6CFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Zv2+IMv5QjgWNIZfmiP8JXuwptZ+k/yxRQqqvsz/ZTU=; b=id06ygssdLze4HYMJBRV27JmCL
        Pwcx/UXXOzHPabzNVGTldZVcFVD+TUVKhJ6IcMIvDobWgLgjvmp12BaC4vO5+ZYPRBkTwfMk2Fz04
        HTZKunTRqKfv42dUTcpYNrhVyKaSHSz4b0u0r5Am/zt/zeZRzplVykx1AEWMlJG+7v5LNFGiSHpYT
        mgKRB8BfC/pMVxyfDhzAmfwr5EvFQihIjtW/gkSa+KrGgzl0uGgBmI0ZLqtvSS1xpv68TkrxRgwyX
        L8pfZ6eXlPbLaQZLTQd+9NKa5kSUcwpphnhG6VBG6j1seBnTkTn6y4r1LgeWEweAGwugNCV3cW0xh
        lDmgijQg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1quxaB-007nYG-1m;
        Mon, 23 Oct 2023 16:15:11 +0000
Date:   Mon, 23 Oct 2023 09:15:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <ZTacD4tWZHrzhmQT@bombadil.infradead.org>
References: <1696482420-1329-1-git-send-email-quic_mojha@quicinc.com>
 <ZTF+QLjm8ceL9a00@bombadil.infradead.org>
 <a0c294e1-f76a-6382-ee0f-f1d75ac9d781@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0c294e1-f76a-6382-ee0f-f1d75ac9d781@quicinc.com>
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

On Mon, Oct 23, 2023 at 06:11:18PM +0530, Mukesh Ojha wrote:
> However, if you think we should rename this
> 'only_kill_custom' to something like its inverse 'kill_all' and reverse the
> below check to be more meaningful now ?
> 
>    		if (kill_all || !fw_priv->need_uevent)

This seems like a better approach to make the intent clear and avoid
future confusion.

  Luis
