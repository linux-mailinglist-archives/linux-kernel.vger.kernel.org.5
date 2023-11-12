Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8107D7E8E08
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 03:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjKLCua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 21:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 21:50:29 -0500
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6629C30EB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 18:50:26 -0800 (PST)
Date:   Sat, 11 Nov 2023 21:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699757424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRg0nYM3PYFyskGveZfOcBXNBJBHuLwIvGKuNCf3fWo=;
        b=cNrNMyttGdaomXUb45n01GUa2GSuog7uLlSmz0nLiFxXM6VlC+kMajpUiGYcHuIO6n+V3o
        1Mtc4d7FOzUGA1I7beXqeCpNdK1mC0oJK9VNdnNJDfZED8fCypv/xqIxAe2u6qLvvUErhn
        +VPhYSHb8kGSk/NUKK35Ol1Ovuixegc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Daniel J Blueman <daniel@quora.org>
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Fix potential sleeping during mount
Message-ID: <20231112025021.jcc6etc5jbqanm6z@moria.home.lan>
References: <20231112003841.20186-1-daniel@quora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112003841.20186-1-daniel@quora.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 12:38:41AM +0000, Daniel J Blueman wrote:
> During mount, bcachefs mount option processing may sleep while allocating a string buffer.
> 
> Fix this by reference counting in order to take the atomic path.
> 
> Signed-off-by: Daniel J Blueman <daniel@quora.org>

Thanks, applied
