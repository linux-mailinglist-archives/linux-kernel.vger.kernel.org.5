Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F47FE2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjK2WHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2WG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:06:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F4A8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:07:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06ABC433C8;
        Wed, 29 Nov 2023 22:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701295626;
        bh=hj3Te/T9hGa3/9yOQDI/Wfga2BG1FCvCpS7ExpBlbhg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZlzoi4VdWfJ4plvIIb7UsnQhTWYD+aOcZa570957vdpgs6B3NpmXMefMn/Z9NIU2
         wEFFP40rOzJRAxuW6DaizBLUseDEj7H9NalWrUz8dxUy6W1iKqDpF5peHUjHBq3zPW
         RiNm1A2aWKqLt+3nN2mUmDJO/cGdsQr77BRAlWo8=
Date:   Wed, 29 Nov 2023 14:07:05 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc: make struct proc_dir_entry::name const
Message-Id: <20231129140705.c1a7faa8f49572f5a50d2416@linux-foundation.org>
In-Reply-To: <d724d33e-7c0d-422b-8d23-3d677cc414fe@p183>
References: <d724d33e-7c0d-422b-8d23-3d677cc414fe@p183>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2023 12:46:57 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Multiply ::name into "mut_name" and "name" which is "const char*".
> 
> PDE's name must not be mutated on live PDE, hint modules they should not
> do it.

Do any modules do this?  If so, we just broke them.  If not, why bother
with this change?


