Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14DA7FE199
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjK2VNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjK2VM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:12:58 -0500
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59883D69
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:13:00 -0800 (PST)
Date:   Wed, 29 Nov 2023 16:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701292378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6B/ppfbw4nVXEGkOzTBY61+qsKBAI4aamGlzoAAChk=;
        b=g08wS+LcBoeVtI3QYrYcOsZQXBygvg5pMvS+dVnu6jxoEA+GXUqudxD23qKR5gzB8//Lxi
        F2IVANic5JJvOm5/Jl4BTG4DtwivVoETi48bAzvTDApA5+M7Oxdc1uQ8TMh60nvJ7DFYFg
        bJrkjK7Fhs33eiTginub9jRpgc4v2fI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] bcachefs: Replace zero-length arrays with
 flexible-array members
Message-ID: <20231129211254.45yu4ghc2wg5d4w5@moria.home.lan>
References: <ZWYv/ywR/qxUhVSU@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWYv/ywR/qxUhVSU@work>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 12:22:55PM -0600, Gustavo A. R. Silva wrote:
> Fake flexible arrays (zero-length and one-element arrays) are
> deprecated, and should be replaced by flexible-array members.
> 
> So, replace zero-length arrays with flexible-array members
> in multiple structures.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

There are some ZLAs I hadn't converted because they led to new warnings
- in particular, array of flexible members.

I don't think that applies to any of the ones you changed
(replicas_delta_list, maybe?) - but it's something we need to figure
out if we're getting serious about this.
