Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0D07CD621
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbjJRINg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJRINe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:13:34 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E9BB6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GpetY+lN0kNSU4kScIjhhgCa5RGP7XMD9CtalAfPG4Q=;
  b=ocVAA5tUSH9a/yZ5RdQNI6jlCZofdNcSgxu2dgyGH6cWFWdfNoM24QdC
   o8p2RnuOK3AJRzsqhh9Efd5ehBMqHulh/z/OXt3I8qcNG3gR/5cg4MCSU
   K8h2C2pBFa5C8l+jsqFym/Sj+XuBSV3AX3XPbs/mbkQXJlXgowLSIN45o
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="131832249"
Received: from dhcp-138-246-3-50.dynamic.eduroam.mwn.de (HELO hadrien) ([138.246.3.50])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 10:13:28 +0200
Date:   Wed, 18 Oct 2023 10:13:28 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Calvince Otieno <calvncce@gmail.com>
cc:     gustavo@embeddedor.com, outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: fix coding style - remove
 CamelCasing
In-Reply-To: <CADFX3OQbXXaa1z+4-tOhidb2w_XH9sYB0x1_yLZ69yDy_1Nwpw@mail.gmail.com>
Message-ID: <baa4e15-6c4c-a2ae-259a-f6cae6de837f@inria.fr>
References: <ZS+HyqwvyVyfzGXs@lab-ubuntu> <cb55a015-4c2b-b72-dcd-af7f8c7380@inria.fr> <CADFX3OQbXXaa1z+4-tOhidb2w_XH9sYB0x1_yLZ69yDy_1Nwpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> As description states, checkpatch recommendation

This comment should be just under my text, that you are responding to, not
at the end of the patch.

CamelCase is not just the mixture of uppercase and lowercase letters.  It
means that the things with upper and lowercase letters are real words,
LikeThis.  In the case of this driver, the lowercase letter was not part
of an English word, so one can be suspicious that it has some other
meaning.  Checkpatch doesn't know what are real English words, so it makes
the suggestions whenever there is a mixture of uppercase and lowercase
letters.

julia
